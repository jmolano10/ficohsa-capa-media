(:: pragma bea:local-element-parameter parameter="$dEBTOR1" type="ns0:consultaRecaudoMultiple/AGREEMENTS/AGREEMENT/DEBTORS/DEBTOR" location="../xsd/sjConsultaRecaudoMultipleTypesPA.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaRecaudo" location="../../../../Resources/ConsultaRecaudo/xsd/consultaRecaudoTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/sjConsultaRecaudoMultipleTypes";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaRecaudoTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/BusinessServices/SJS/consultaRecaudoMultiplePA/xq/sjConsRecaudoPAIn/";

declare function xf:sjConsRecaudoPAIn($agreementId as xs:string,
    $dEBTOR1 as element())
    as element(ns1:consultaRecaudo) {
        <ns1:consultaRecaudo>
            <CONTRACT_ID>{ $agreementId }</CONTRACT_ID>
            <DEBTOR_CODE>{ data($dEBTOR1/CODE) }</DEBTOR_CODE>
            <CURRENCY>{ data($dEBTOR1/CURRENCY) }</CURRENCY>
            <BILL_AMOUNT>{ data($dEBTOR1/BILL_INFO/AMOUNT) }</BILL_AMOUNT>
            <BILL_DATE>{ data($dEBTOR1/BILL_INFO/DATE) }</BILL_DATE>
            <BILL_RETURN_TYPE>{ data($dEBTOR1/BILL_INFO/RETURN_TYPE) }</BILL_RETURN_TYPE>
            {
                for $EXTENDED_COLLECTION in $dEBTOR1/EXTENDED_COLLECTION
                return
                    <EXTENDED_COLLECTION_YES_NO>{ data($EXTENDED_COLLECTION) }</EXTENDED_COLLECTION_YES_NO>
            }
            {
                for $ADDITIONAL_INFO in $dEBTOR1/ADDITIONAL_INFO
                return
                    <ADDITIONAL_INFO>
                        {
                            for $DATA in $ADDITIONAL_INFO/DATA
                            return
                                <DATA>{ data($DATA) }</DATA>
                        }
                    </ADDITIONAL_INFO>
            }
        </ns1:consultaRecaudo>
};

declare variable $agreementId as xs:string external;
declare variable $dEBTOR1 as element() external;

xf:sjConsRecaudoPAIn($agreementId,
    $dEBTOR1)
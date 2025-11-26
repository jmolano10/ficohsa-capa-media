(:: pragma bea:local-element-parameter parameter="$dEBTOR1" type="ns1:consultaRecaudoMultiple/AGREEMENTS/AGREEMENT/DEBTORS/DEBTOR" location="../../../../Resources/ConsultaRecaudoMultiple/xsd/consultaRecaudoMultipleTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultaRecaudo" location="../../../../Resources/ConsultaRecaudo/xsd/consultaRecaudoTypes.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaRecaudoMultipleTypes";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaRecaudoTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/BusinessServices/SJS/consultaRecaudoMultiple/xq/consRecaudoIn/";

declare function xf:consRecaudoIn($agreementId as xs:string,
    $dEBTOR1 as element(),
    $localCurrency as xs:string)
    as element(ns0:consultaRecaudo) {
        <ns0:consultaRecaudo>
            <CONTRACT_ID>{ $agreementId }</CONTRACT_ID>
            <DEBTOR_CODE>{ data($dEBTOR1/CODE) }</DEBTOR_CODE>
            <CURRENCY>
            { 
            	if (fn:string($dEBTOR1/CURRENCY/text()) != "") then (
            		data($dEBTOR1/CURRENCY)
            	) else (
            		$localCurrency
            	)
            }</CURRENCY>
            <BILL_AMOUNT>{ fn:string($dEBTOR1/BILL_INFO/AMOUNT/text()) }</BILL_AMOUNT>
            <BILL_DATE>{ fn:string($dEBTOR1/BILL_INFO/DATE/text()) }</BILL_DATE>
            <BILL_RETURN_TYPE>{ fn:string($dEBTOR1/BILL_INFO/RETURN_TYPE/text()) }</BILL_RETURN_TYPE>
            {
                for $EXTENDED_COLLECTION in $dEBTOR1/EXTENDED_COLLECTION
                return
                    <EXTENDED_COLLECTION_YES_NO>{ data($EXTENDED_COLLECTION) }</EXTENDED_COLLECTION_YES_NO>
            }
            {
                for $ADDITIONAL_INFO in $dEBTOR1/ADDITIONAL_INFO
                return
                    <ADDITIONAL_INFO>{ $ADDITIONAL_INFO/@* , $ADDITIONAL_INFO/node() }</ADDITIONAL_INFO>
            }
        </ns0:consultaRecaudo>
};

declare variable $agreementId as xs:string external;
declare variable $dEBTOR1 as element() external;
declare variable $localCurrency as xs:string external;

xf:consRecaudoIn($agreementId,
    $dEBTOR1,
    $localCurrency)
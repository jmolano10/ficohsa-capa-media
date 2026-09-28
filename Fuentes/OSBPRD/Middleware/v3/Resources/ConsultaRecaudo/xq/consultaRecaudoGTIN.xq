(:: pragma bea:global-element-parameter parameter="$consultaRecaudo1" element="ns0:consultaRecaudo" location="../../../../Business_Resources/recaudos/consultaRecaudo/consultaRecaudoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/ABKGT/ConsultaRecaudo/xsd/ConsultaRecaudo_sp.xsd" ::)

declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/ConsultaRecaudo";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaRecaudoTypes";
declare namespace xf = "http://tempuri.org/Middleware/v3/Resources/ConsultaRecaudo/xq/consultaRecaudoGTIN/";

declare function xf:consultaRecaudoGTIN($consultaRecaudo1 as element(ns0:consultaRecaudo))
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:PV_CONTRACT_ID>{ data($consultaRecaudo1/CONTRACT_ID) }</ns1:PV_CONTRACT_ID>
            <ns1:PV_DEBTOR_CODE>{ data($consultaRecaudo1/DEBTOR_CODE) }</ns1:PV_DEBTOR_CODE>
            <ns1:PV_CURRENCY>{ data($consultaRecaudo1/CURRENCY) }</ns1:PV_CURRENCY>
            {
                for $BILL_AMOUNT in $consultaRecaudo1/BILL_AMOUNT
                return
                    <ns1:PV_BILL_AMOUNT>{ data($BILL_AMOUNT) }</ns1:PV_BILL_AMOUNT>
            }
            {
                for $BILL_DATE in $consultaRecaudo1/BILL_DATE
                return
                    <ns1:PV_BILL_DATE>{ data($BILL_DATE) }</ns1:PV_BILL_DATE>
            }
            {
                for $BILL_RETURN_TYPE in $consultaRecaudo1/BILL_RETURN_TYPE
                return
                    <ns1:PV_BILL_RETURN_TYPE>{ data($BILL_RETURN_TYPE) }</ns1:PV_BILL_RETURN_TYPE>
            }
            {
                for $EXTENDED_COLLECTION_YES_NO in $consultaRecaudo1/EXTENDED_COLLECTION_YES_NO
                return
                    <ns1:PV_EXTENDED_COLLECTION_Y_N>{ data($EXTENDED_COLLECTION_YES_NO) }</ns1:PV_EXTENDED_COLLECTION_Y_N>
            }
            {
                for $ADDITIONAL_INFO in $consultaRecaudo1/ADDITIONAL_INFO
                return
                    <ns1:PV_DATA>
                        {
                            for $DATA in $ADDITIONAL_INFO/DATA
                            return
                                <ns1:PV_DATA_ITEM>{ data($DATA) }</ns1:PV_DATA_ITEM>
                        }
                    </ns1:PV_DATA>
            }
        </ns1:InputParameters>
};

declare variable $consultaRecaudo1 as element(ns0:consultaRecaudo) external;

xf:consultaRecaudoGTIN($consultaRecaudo1)
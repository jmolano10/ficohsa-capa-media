xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$outputParameters1" element="ns1:OutputParameters" location="../../../BusinessServices/ABKPA/transferenciasACH/xsd/transferenciasACH_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns0:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/transferenciasACH";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/abanksPA/transferenciasACH/xq/transferenciasACHHeaderOut/";

declare function xf:transferenciasACHHeaderOut($outputParameters1 as element(ns1:OutputParameters))
    as element(ns0:ResponseHeader) {
        <ns0:ResponseHeader>
            {
                for $TRANSACTION_ID in $outputParameters1/ns1:TRANSACTION_ID
                return
                    <transactionId>{ data($TRANSACTION_ID) }</transactionId>
            }
            {
                for $ERROR_CODE in $outputParameters1/ns1:ERROR_CODE
                return
                    <successIndicator>{ data($ERROR_CODE) }</successIndicator>
            }
            {
                for $ERROR_MESSAGE in $outputParameters1/ns1:ERROR_MESSAGE
                return
                    <messages>{ data($ERROR_MESSAGE) }</messages>
            }
            {
                for $VALUE_DATE in $outputParameters1/ns1:VALUE_DATE
                return
                    <valueDate>{ data($VALUE_DATE) }</valueDate>
            }
        </ns0:ResponseHeader>
};

declare variable $outputParameters1 as element(ns1:OutputParameters) external;

xf:transferenciasACHHeaderOut($outputParameters1)
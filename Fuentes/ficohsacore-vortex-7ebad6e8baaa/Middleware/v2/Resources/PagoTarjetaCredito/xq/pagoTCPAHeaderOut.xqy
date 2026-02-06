xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$outputParameters1" element="ns1:OutputParameters" location="../../../BusinessServices/ABKPA/pagoTarjetaCredito/xsd/pagoTarjetaCredito_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns0:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/pagoTarjetaCredito";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/abanksPA/pagoTarjetaCredito/xq/pagoTarjetaCreditoHeaderOut/";

declare function xf:pagoTarjetaCreditoHeaderOut($outputParameters1 as element(ns1:OutputParameters))
    as element(ns0:ResponseHeader) {
        <ns0:ResponseHeader>
            {
                for $REFERENCE_NO in $outputParameters1/ns1:REFERENCE_NO
                return
                    <transactionId>{ data($REFERENCE_NO) }</transactionId>
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
                for $DATETIME in $outputParameters1/ns1:DATETIME
                return
                    <valueDate>{ substring(data($DATETIME), 1, 8) }</valueDate>
            }
        </ns0:ResponseHeader>
};

declare variable $outputParameters1 as element(ns1:OutputParameters) external;

xf:pagoTarjetaCreditoHeaderOut($outputParameters1)
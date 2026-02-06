xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns1:OutputParameters" location="../../../BusinessServices/ABKPA/pagoTarjetaCredito/xsd/pagoTarjetaCredito_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns0:ResponseHeader" location="../../../../v2/Resources/esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/pagoTarjetaCredito";
declare namespace xf = "http://tempuri.org/Middleware/v3/Resources/PagoTarjetaCredito/xq/pagoTCPAHeaderOut/";

declare function xf:pagoTCPAHeaderOut($outputParameters as element(ns1:OutputParameters))
    as element(ns0:ResponseHeader) {
        <ns0:ResponseHeader>
        	{
                for $REFERENCE_NO in $outputParameters/ns1:PN_NUMEROREFERENCIA
                return
                    <transactionId>{ data($REFERENCE_NO) }</transactionId>
            }
            {
                for $ERROR_CODE in $outputParameters/ns1:PV_ERRORCODE
                return
                    <successIndicator>{ data($ERROR_CODE) }</successIndicator>
            }
            {
                for $ERROR_MESSAGE in $outputParameters/ns1:PV_ERRORMESSAGE
                return
                    <messages>{ data($ERROR_MESSAGE) }</messages>
            }
            {
                for $DATETIME in $outputParameters/ns1:PV_DATETIME
                return
                    <valueDate>{ substring(data($DATETIME), 1, 8) }</valueDate>
            }
        </ns0:ResponseHeader>
};

declare variable $outputParameters as element(ns1:OutputParameters) external;

xf:pagoTCPAHeaderOut($outputParameters)
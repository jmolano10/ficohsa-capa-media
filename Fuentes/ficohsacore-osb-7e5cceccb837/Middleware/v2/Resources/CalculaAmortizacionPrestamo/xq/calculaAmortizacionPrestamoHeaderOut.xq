(:: pragma bea:global-element-parameter parameter="$outputParameters1" element="ns1:OutputParameters" location="../../../BusinessServices/PWS/calculaAmortizacionPrestamo/xsd/calculaAmortizacionPrestamo_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns0:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/calculaAmortizacionPrestamo";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/CalculaAmortizacionPrestamo/xq/calculaAmortizacionPrestamoHeaderOut/";

declare function xf:calculaAmortizacionPrestamoHeaderOut($outputParameters1 as element(ns1:OutputParameters))
    as element(ns0:ResponseHeader) {
        <ns0:ResponseHeader>
            {
                for $RETURN_CODE in $outputParameters1/ns1:RETURN_CODE
                return
                    <successIndicator>{ data($RETURN_CODE) }</successIndicator>
            }
            {
                for $RETURN_MESSAGE in $outputParameters1/ns1:RETURN_MESSAGE
                return
                    <messages>{ data($RETURN_MESSAGE) }</messages>
            }
        </ns0:ResponseHeader>
};

declare variable $outputParameters1 as element(ns1:OutputParameters) external;

xf:calculaAmortizacionPrestamoHeaderOut($outputParameters1)

(:: pragma bea:global-element-parameter parameter="$outputParameters1" element="ns1:OutputParameters" location="../../../BusinessServices/ABKGT/consultaDetallesCuenta/xsd/consultaDetallesCuenta_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns0:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/ConsultaDetallesCuenta";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/abanksGT/consultaDetallesCuenta/xq/consultaDetallesCuentaHeaderOut/";

declare function xf:consultaDetallesCuentaHeaderOut($outputParameters1 as element(ns1:OutputParameters))
    as element(ns0:ResponseHeader) {
        <ns0:ResponseHeader>
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
        </ns0:ResponseHeader>
};

declare variable $outputParameters1 as element(ns1:OutputParameters) external;

xf:consultaDetallesCuentaHeaderOut($outputParameters1)
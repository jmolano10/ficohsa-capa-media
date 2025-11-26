(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns1:OutputParameters" location="../../../BusinessServices/ABKGT/consultaDetalladaMovimientosCuenta/xsd/consultaDetalladaMovimientosCuenta_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns0:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaDetalladaMovimientosCuenta";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaMovimientosCuenta/xq/consultaMovimientosCuentaAbanksGTHeaderOut/";

declare function xf:consultaMovimientosCuentaAbanksGTHeaderOut($outputParameters as element(ns1:OutputParameters))
    as element(ns0:ResponseHeader) {
        <ns0:ResponseHeader>
            {
                for $PV_CODIGOERROR in $outputParameters/ns1:PV_CODIGOERROR
                return
                    <successIndicator>{ data($PV_CODIGOERROR) }</successIndicator>
            }
            {
                for $PV_MENSAJEERROR in $outputParameters/ns1:PV_MENSAJEERROR
                return
                    <messages>{ data($PV_MENSAJEERROR) }</messages>
            }
        </ns0:ResponseHeader>
};

declare variable $outputParameters as element(ns1:OutputParameters) external;

xf:consultaMovimientosCuentaAbanksGTHeaderOut($outputParameters)
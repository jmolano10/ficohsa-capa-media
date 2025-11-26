(:: pragma bea:global-element-parameter parameter="$outputParameters1" element="ns0:OutputParameters" location="../../../BusinessServices/INTFC/consultaDetalladaMovimientosCuenta/xsd/consultaDetalladaMovimientosCuenta_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaDetalladaMovimientosCuenta";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaMovimientosCuenta/xq/consultaMovimientosCuentaMixtoHeaderOut/";

declare function xf:consultaMovimientosCuentaMixtoHeaderOut($outputParameters1 as element(ns0:OutputParameters))
    as element(ns1:ResponseHeader) {
        <ns1:ResponseHeader>
            {
                for $PV_CODIGOERROR in $outputParameters1/ns0:PV_CODIGOERROR
                return
                    <successIndicator>{ data($PV_CODIGOERROR) }</successIndicator>
            }
            {
                for $PV_MENSAJEERROR in $outputParameters1/ns0:PV_MENSAJEERROR
                return
                    <messages>{ data($PV_MENSAJEERROR) }</messages>
            }
        </ns1:ResponseHeader>
};

declare variable $outputParameters1 as element(ns0:OutputParameters) external;

xf:consultaMovimientosCuentaMixtoHeaderOut($outputParameters1)

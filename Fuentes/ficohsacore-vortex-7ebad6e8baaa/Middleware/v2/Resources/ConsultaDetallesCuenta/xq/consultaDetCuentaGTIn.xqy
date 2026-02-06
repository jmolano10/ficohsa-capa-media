xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaDetallesCuenta" element="ns0:consultaDetallesCuenta" location="../xsd/consultaDetallesCuentaTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/ABKGT/consultaDetallesCuenta/xsd/consultaDetallesCuenta_sp.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultasType";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/ConsultaDetallesCuenta";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaDetallesCuenta/xq/consultaDetCuentaGTIn/";

declare function xf:consultaDetCuentaGTIn($consultaDetallesCuenta as element(ns0:consultaDetallesCuenta))
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:ACCOUNT_NUMBER>{ data($consultaDetallesCuenta/ACCOUNT_NUMBER) }</ns1:ACCOUNT_NUMBER>
        </ns1:InputParameters>
};

declare variable $consultaDetallesCuenta as element(ns0:consultaDetallesCuenta) external;

xf:consultaDetCuentaGTIn($consultaDetallesCuenta)
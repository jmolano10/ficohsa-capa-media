(:: pragma bea:global-element-parameter parameter="$consultaMovimientosCuenta1" element="ns0:consultaMovimientosCuenta" location="../../../../Business_Resources/ConsultasCuenta/Resources/consultasGeneralesCuentasTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/ABKPA/consultaMovimientosCuentaHoy/xsd/consultaMovimientosCuentaHoy_sp.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultasType";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaMovimientosCuentaHoy";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/abanksPA/consultaMovimientosCuentaHoy/xq/consultaMovimientosCuentaHoyIn/";

declare function xf:consultaMovimientosCuentaHoyIn($consultaMovimientosCuenta1 as element(ns0:consultaMovimientosCuenta))
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:ACCOUNT_NUMBER>{ data($consultaMovimientosCuenta1/ACCOUNT_NUMBER) }</ns1:ACCOUNT_NUMBER>
        </ns1:InputParameters>
};

declare variable $consultaMovimientosCuenta1 as element(ns0:consultaMovimientosCuenta) external;

xf:consultaMovimientosCuentaHoyIn($consultaMovimientosCuenta1)
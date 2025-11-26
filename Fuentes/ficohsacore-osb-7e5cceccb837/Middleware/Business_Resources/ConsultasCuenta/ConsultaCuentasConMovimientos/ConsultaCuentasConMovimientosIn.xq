(:: pragma bea:global-element-parameter parameter="$consultaCuentasConMovimientos1" element="ns0:consultaCuentasConMovimientos" location="consultaCuentasConMovimientosTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../Resources/ConsultaCuentasConMovimientos/xsd/ConsultaCuentasConMovimientos_sp.xsd" ::)

declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/ConsultaCuentasConMovimientos";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaCuentasConMovimientosTypes";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/ConsultasCuenta/ConsultaCuentasConMovimientos/ConsultaCuentasConMovimientosIn/";

declare function xf:ConsultaCuentasConMovimientosIn($consultaCuentasConMovimientos1 as element(ns0:consultaCuentasConMovimientos))
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:PV_HORA_INICIAL>{ data($consultaCuentasConMovimientos1/START_TIME) }</ns1:PV_HORA_INICIAL>
            <ns1:PV_HORA_FINAL>{ data($consultaCuentasConMovimientos1/END_TIME) }</ns1:PV_HORA_FINAL>
            <ns1:PV_CANTIDAD>{ data($consultaCuentasConMovimientos1/MAX_ACCOUNTS) }</ns1:PV_CANTIDAD>
            <ns1:PV_POSICION_INICIAL>{ data($consultaCuentasConMovimientos1/INITIAL_POSITION) }</ns1:PV_POSICION_INICIAL>
        </ns1:InputParameters>
};

declare variable $consultaCuentasConMovimientos1 as element(ns0:consultaCuentasConMovimientos) external;

xf:ConsultaCuentasConMovimientosIn($consultaCuentasConMovimientos1)
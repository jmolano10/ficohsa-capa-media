(:: pragma bea:global-element-parameter parameter="$consultaMovimientosCuenta1" element="ns0:consultaMovimientosCuenta" location="../../../../Business_Resources/ConsultasCuenta/Resources/consultasGeneralesCuentasTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/ABKGT/consultaMovimientosCuenta/xsd/consultaMovimientosCuenta_sp.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultasType";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaMovimientosCuenta";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/abanksGT/consultaMovimientosCuenta/xq/consultaMovimientosCuentaIn/";

declare function xf:consultaMovimientosCuentaIn($consultaMovimientosCuenta1 as element(ns0:consultaMovimientosCuenta),
	$beginDate as xs:string,
    $endDate as xs:string)
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:ACCOUNT_NUMBER>{ data($consultaMovimientosCuenta1/ACCOUNT_NUMBER) }</ns1:ACCOUNT_NUMBER>
            <ns1:BEGIN_DATE>{ data($beginDate) }</ns1:BEGIN_DATE>
            <ns1:END_DATE>{ data($endDate) }</ns1:END_DATE>
        </ns1:InputParameters>
};

declare variable $consultaMovimientosCuenta1 as element(ns0:consultaMovimientosCuenta) external;
declare variable $beginDate as xs:string external;
declare variable $endDate as xs:string external;

xf:consultaMovimientosCuentaIn($consultaMovimientosCuenta1,
	$beginDate,
    $endDate)
(:: pragma bea:global-element-return element="ns0:consultaMovimientosCuenta" location="../Resources/consultasGeneralesCuentasTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultasType";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/ConsultasCuenta/ConsultaUltimosNMovimientosCuenta/ConsultaUltimosNMovimientosCuentaIn/";

declare function xf:ConsultaUltimosNMovimientosCuentaIn($accountNumber as xs:string,
    $sysdate as xs:string)
    as element(ns0:consultaMovimientosCuenta) {
        <ns0:consultaMovimientosCuenta>
			<ACCOUNT_NUMBER>{$accountNumber}</ACCOUNT_NUMBER>
			<BEGIN_DATE>{concat(substring($sysdate, 1, 6), "01")}</BEGIN_DATE>
			<END_DATE>{$sysdate}</END_DATE>
			<ENTRY_RANGE>FREE_RANGE</ENTRY_RANGE>
        </ns0:consultaMovimientosCuenta>
};

declare variable $accountNumber as xs:string external;
declare variable $sysdate as xs:string external;

xf:ConsultaUltimosNMovimientosCuentaIn($accountNumber,
    $sysdate)
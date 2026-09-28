(:: pragma bea:global-element-parameter parameter="$consultaUltimosNMovimientosCuenta1" element="ns1:consultaUltimosNMovimientosCuenta" location="../xsd/consultasUltimosNMovimientosCuentaTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultaMovimientosCuenta" location="../../ConsultaMovimientosCuenta/xsd/consultasGeneralesCuentasTypes.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultasUltimosNMovimientosTypes";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultasType";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaUltimosNMovimientosCuenta/xq/ConsultaUltimosNMovimientosCuentaIn/";

declare function xf:ConsultaUltimosNMovimientosCuentaIn($consultaUltimosNMovimientosCuenta1 as element(ns1:consultaUltimosNMovimientosCuenta),$sysdate as xs:string)
    as element(ns0:consultaMovimientosCuenta) {
        <ns0:consultaMovimientosCuenta>
            <ACCOUNT_NUMBER>{data($consultaUltimosNMovimientosCuenta1/ACCOUNT_NUMBER)}</ACCOUNT_NUMBER>
			<BEGIN_DATE>{concat(substring($sysdate, 1, 6), "01")}</BEGIN_DATE>
			<END_DATE>{$sysdate}</END_DATE>
			<ENTRY_RANGE>FREE_RANGE</ENTRY_RANGE>
			<PAGING_INFO>
				<PAGING>NO</PAGING>
				<INITIAL_RECORD>1</INITIAL_RECORD>
				<RECORD_COUNT>1000000</RECORD_COUNT>
				<TICKET></TICKET>
			</PAGING_INFO>
        </ns0:consultaMovimientosCuenta>
};

declare variable $consultaUltimosNMovimientosCuenta1 as element(ns1:consultaUltimosNMovimientosCuenta) external;
declare variable $sysdate as xs:string external;

xf:ConsultaUltimosNMovimientosCuentaIn($consultaUltimosNMovimientosCuenta1,$sysdate)
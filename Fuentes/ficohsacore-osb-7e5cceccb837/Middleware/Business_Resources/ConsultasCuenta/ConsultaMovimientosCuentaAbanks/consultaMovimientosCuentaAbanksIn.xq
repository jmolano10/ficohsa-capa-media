(:: pragma bea:global-element-parameter parameter="$consultaMovimientosCuenta" element="ns0:consultaMovimientosCuenta" location="../Resources/consultasGeneralesCuentasTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../Resources/ConsultaMovimientosCuenta/xsd/ORA_BANK_OSB_K_CONSULTAMOVSCUENTA_TOPLEVEL-24OSB_CON_MOVS_CTA.xsd" ::)

declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/ORA_BANK/OSB_K_CONSULTAMOVSCUENTA/TOPLEVEL-24OSB_CON_MOVS_CTA/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultasType";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/ConsultasCuenta/ConsultaMovimientosCuentaAbanks/consultaMovimientosCuentaAbanksIn/";

declare function xf:consultaMovimientosCuentaAbanksIn($consultaMovimientosCuenta as element(ns0:consultaMovimientosCuenta),
$fechaSalidaT24 as xs:string)
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:ACCOUNT_NUMBER>{ data($consultaMovimientosCuenta/ACCOUNT_NUMBER) }</ns1:ACCOUNT_NUMBER>
            <ns1:BEGIN_DATE>{ data($consultaMovimientosCuenta/BEGIN_DATE) }</ns1:BEGIN_DATE>
            {
            	if (data($consultaMovimientosCuenta/END_DATE) < data($fechaSalidaT24)) then (
            		<ns1:END_DATE>{ data($consultaMovimientosCuenta/END_DATE) }</ns1:END_DATE>
             	)else(
             		<ns1:END_DATE>{ concat(substring(data($consultaMovimientosCuenta/END_DATE), 1, 7),1) }</ns1:END_DATE>
             	)
            }
        </ns1:InputParameters>
};

declare variable $consultaMovimientosCuenta as element(ns0:consultaMovimientosCuenta) external;
declare variable $fechaSalidaT24 as xs:string external;

xf:consultaMovimientosCuentaAbanksIn($consultaMovimientosCuenta,
										$fechaSalidaT24)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/TransaccionesAsincronas/DB/RegistrarUUID/xsd/registrarUUID_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/registrarUUID";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/GenerarIDUnico/xq/registrarUUID/";

declare function xf:registrarUUID($uuid as xs:string,
    $pais as xs:string)
    as element(ns0:InputParameters) {
     let $fechaSistema := fn:current-dateTime()
	            return (
        <ns0:InputParameters>
            <ns0:PV_UUID>{ $uuid }</ns0:PV_UUID>
            <ns0:PN_CODIGO_CANAL>{ 1 }</ns0:PN_CODIGO_CANAL>
            <ns0:PN_CODIGO_ESTADO>{ 1}</ns0:PN_CODIGO_ESTADO>
            <ns0:PV_PAIS>{ $pais }</ns0:PV_PAIS>
            <ns0:PD_FECHA_GENERACION_OSB>{ $fechaSistema }</ns0:PD_FECHA_GENERACION_OSB>
        </ns0:InputParameters>
        )
};

declare variable $uuid as xs:string external;
declare variable $pais as xs:string external;

xf:registrarUUID($uuid,
    $pais)

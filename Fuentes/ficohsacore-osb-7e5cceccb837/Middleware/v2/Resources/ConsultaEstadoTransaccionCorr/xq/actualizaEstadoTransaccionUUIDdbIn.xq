(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/TransaccionesAsincronas/DB/ActualizarEstadoTransaccionConsulta/xsd/actualizarEstadoTransaccionUUID_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/actualizarEstadoTransaccionUUID";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaEstadoTransaccionCorr/xq/actualizaEstadoTransaccionUUIDdbIn/";

declare function xf:actualizaEstadoTransaccionUUIDdbIn($UUID as xs:string,
    $tipo as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:PV_UUID>{ $UUID }</ns0:PV_UUID>
            <ns0:PN_TIPO_ESTADO>{ $tipo }</ns0:PN_TIPO_ESTADO>
        </ns0:InputParameters>
};

declare variable $UUID as xs:string external;
declare variable $tipo as xs:string external;

xf:actualizaEstadoTransaccionUUIDdbIn($UUID,
    $tipo)

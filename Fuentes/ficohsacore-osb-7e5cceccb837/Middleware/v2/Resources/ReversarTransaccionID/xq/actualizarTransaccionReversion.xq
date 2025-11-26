(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/TransaccionesAsincronas/DB/ActualizarEstadoTransaccionConsulta/xsd/actualizarEstadoTransaccionUUID_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/actualizarEstadoTransaccionUUID";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ReversarTransaccionID/xq/actualizarTransaccionReversion/";

declare function xf:actualizarTransaccionReversion($uuid as xs:string,
    $estado as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:PV_UUID>{ $uuid }</ns0:PV_UUID>
            <ns0:PN_TIPO_ESTADO>{ $estado }</ns0:PN_TIPO_ESTADO>
        </ns0:InputParameters>
};

declare variable $uuid as xs:string external;
declare variable $estado as xs:string external;

xf:actualizarTransaccionReversion($uuid,
    $estado)

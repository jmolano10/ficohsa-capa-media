(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/TransaccionesAsincronas/DB/ValidarEstadoTransaccion/xsd/validarEstadoTransaccion_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/validarEstadoTransaccion";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ReversarTransaccionID/xq/consultaEstadoTransaccionRevIn/";

declare function xf:consultaEstadoTransaccionRevIn($uuid as xs:string,
    $tipoconsulta as xs:string,
    $codigoestado as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:PV_UUID>{ $uuid }</ns0:PV_UUID>
            <ns0:PN_TIPO_CONSULTA>{ $tipoconsulta }</ns0:PN_TIPO_CONSULTA>
            <ns0:PN_CODIGO_ESTADO>{ $codigoestado }</ns0:PN_CODIGO_ESTADO>
        </ns0:InputParameters>
};

declare variable $uuid as xs:string external;
declare variable $tipoconsulta as xs:string external;
declare variable $codigoestado as xs:string external;

xf:consultaEstadoTransaccionRevIn($uuid,
    $tipoconsulta,
    $codigoestado)

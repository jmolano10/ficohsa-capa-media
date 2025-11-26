(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/TransaccionesAsincronas/DB/ActualizarTransaccionCore/xsd/actualizaTrxCore_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/actualizaTrxCore";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ProcesarTransaccionCore/xq/actualizarTrxCoreIn/";

declare function xf:actualizarTrxCoreIn($UUID as xs:string,
    $RefT24 as xs:string,
    $responseStatus as xs:string,
    $mensaje as xs:string,
    $tipoTransaccion as xs:integer)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:PV_UUID>{ $UUID }</ns0:PV_UUID>
            <ns0:PV_REFT24>{ $RefT24 }</ns0:PV_REFT24>
            <ns0:PV_RESPONSE_STATUS>{ $responseStatus }</ns0:PV_RESPONSE_STATUS>
            <ns0:PV_MESSAGES>{ $mensaje }</ns0:PV_MESSAGES>
            <ns0:PN_TIPO_TRX>{ $tipoTransaccion }</ns0:PN_TIPO_TRX>
        </ns0:InputParameters>
};

declare variable $UUID as xs:string external;
declare variable $RefT24 as xs:string external;
declare variable $responseStatus as xs:string external;
declare variable $mensaje as xs:string external;
declare variable $tipoTransaccion as xs:integer external;

xf:actualizarTrxCoreIn($UUID,
    $RefT24,
    $responseStatus,
    $mensaje,
    $tipoTransaccion)

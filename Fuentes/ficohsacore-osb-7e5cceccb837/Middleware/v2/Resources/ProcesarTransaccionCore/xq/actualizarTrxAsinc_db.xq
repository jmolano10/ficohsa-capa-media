(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/TransaccionesAsincronas/DB/ActualizarTransaccionCore/xsd/actualizaTrxCore_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/actualizaTrxCore";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ProcesarTransaccionCore/xq/actualizarTrxAsinc_db/";

declare function xf:actualizarTrxAsinc_db($UUID as xs:string,
    $refT24 as xs:string,
    $resEstatus as xs:string,
    $message as xs:string,
    $messagesFTTFS as xs:string,
    $tipoTrx as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:PV_UUID>{ $UUID }</ns0:PV_UUID>
            <ns0:PV_REFT24>{ $refT24 }</ns0:PV_REFT24>
            <ns0:PV_RESPONSE_STATUS>{ $resEstatus }</ns0:PV_RESPONSE_STATUS>
            <ns0:PV_MESSAGES>{ $message }</ns0:PV_MESSAGES>
            <ns0:PV_MESSAGES_FT>{ $messagesFTTFS }</ns0:PV_MESSAGES_FT>
            <ns0:PN_TIPO_TRX>{ $tipoTrx }</ns0:PN_TIPO_TRX>
        </ns0:InputParameters>
};

declare variable $UUID as xs:string external;
declare variable $refT24 as xs:string external;
declare variable $resEstatus as xs:string external;
declare variable $message as xs:string external;
declare variable $messagesFTTFS as xs:string external;
declare variable $tipoTrx as xs:string external;

xf:actualizarTrxAsinc_db($UUID,
    $refT24,
    $resEstatus,
    $message,
    $messagesFTTFS,
    $tipoTrx)

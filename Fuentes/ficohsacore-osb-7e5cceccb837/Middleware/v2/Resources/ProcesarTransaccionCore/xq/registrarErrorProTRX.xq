(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/TransaccionesAsincronas/DB/RegistrarErrorCB/xsd/registrarTransaccionError_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/registrarTransaccionError";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ProcesarTransaccionCore/xq/registrarErrorProTRX/";

declare function xf:registrarErrorProTRX($uuid as xs:string,
    $etapa as xs:string,
    $descripcionError as xs:string,
    $msrequest as xs:string,
    $msresponse as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:PV_UUID>{ $uuid }</ns0:PV_UUID>
            <ns0:PN_ETAPA>{ $etapa }</ns0:PN_ETAPA>
            <ns0:PV_DESC_ERROR>{ $descripcionError }</ns0:PV_DESC_ERROR>
            <ns0:PC_REQUEST>{ $msrequest }</ns0:PC_REQUEST>
            <ns0:PC_RESPONSE>{ $msresponse }</ns0:PC_RESPONSE>
        </ns0:InputParameters>
};

declare variable $uuid as xs:string external;
declare variable $etapa as xs:string external;
declare variable $descripcionError as xs:string external;
declare variable $msrequest as xs:string external;
declare variable $msresponse as xs:string external;

xf:registrarErrorProTRX($uuid,
    $etapa,
    $descripcionError,
    $msrequest,
    $msresponse)

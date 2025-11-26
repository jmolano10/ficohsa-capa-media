(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../../v3/BusinessServices/ControlAtomicidad/xsd/ControlAtomicidad_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/ControlAtomicidad";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/NotificaEstadoChequeVirtual/xq/controlAtomicidadIn/";

declare function xf:controlAtomicidadIn($vUuidBitacora as xs:string,
    $vAlterId as xs:string,
    $vUriId as xs:string,
    $vRequestHeader as xs:string,
    $vRequestBody as xs:string,
    $vEstado as xs:decimal)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:V_UUID_BITACORA>{ $vUuidBitacora }</ns0:V_UUID_BITACORA>
            <ns0:V_ALTER_ID>{ $vAlterId }</ns0:V_ALTER_ID>
            <ns0:V_URI_ID>{ $vUriId }</ns0:V_URI_ID>
            <ns0:V_REQUEST_HEADER>{ $vRequestHeader }</ns0:V_REQUEST_HEADER>
            <ns0:V_REQUEST_BODY>{ $vRequestBody }</ns0:V_REQUEST_BODY>
            <ns0:V_ESTADO>{ $vEstado }</ns0:V_ESTADO>
        </ns0:InputParameters>
};

declare variable $vUuidBitacora as xs:string external;
declare variable $vAlterId as xs:string external;
declare variable $vUriId as xs:string external;
declare variable $vRequestHeader as xs:string external;
declare variable $vRequestBody as xs:string external;
declare variable $vEstado as xs:decimal external;

xf:controlAtomicidadIn($vUuidBitacora,
    $vAlterId,
    $vUriId,
    $vRequestHeader,
    $vRequestBody,
    $vEstado)

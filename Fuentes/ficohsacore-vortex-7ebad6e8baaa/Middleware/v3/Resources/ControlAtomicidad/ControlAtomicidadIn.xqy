xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$OriginalHeader" element="ns0:RequestHeader" location="../../../v2/Resources/esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$OriginalBody" element="ns2:pagoTarjetaCredito" location="../PagoTarjetaCredito/xsd/pagoTarjetaCreditoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../BusinessServices/ControlAtomicidad/xsd/ControlAtomicidad_sp.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/pagoTarjetaCreditoTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/ControlAtomicidad";
declare namespace xf = "http://tempuri.org/Middleware/v3/Resources/ControlAtomicidad/ControlAtomicidadIn/";

declare function xf:ControlAtomicidadIn($OriginalHeader as element(ns0:RequestHeader),
    $OriginalBody as element(ns2:pagoTarjetaCredito),
    $V_UUID_BITACORA as xs:string,
    $V_ALTER_ID as xs:string,
    $V_URI_ID as xs:string)
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:V_UUID_BITACORA>{ $V_UUID_BITACORA }</ns1:V_UUID_BITACORA>
            <ns1:V_ALTER_ID>{ $V_ALTER_ID }</ns1:V_ALTER_ID>
            <ns1:V_URI_ID>{ $V_URI_ID }</ns1:V_URI_ID>
            <ns1:V_REQUEST_HEADER>{ fn:string($OriginalHeader) }</ns1:V_REQUEST_HEADER>
            <ns1:V_REQUEST_BODY>{ fn:string($OriginalBody) }</ns1:V_REQUEST_BODY>
            <ns1:V_ESTADO>1</ns1:V_ESTADO>
        </ns1:InputParameters>
};

declare variable $OriginalHeader as element(ns0:RequestHeader) external;
declare variable $OriginalBody as element(ns2:pagoTarjetaCredito) external;
declare variable $V_UUID_BITACORA as xs:string external;
declare variable $V_ALTER_ID as xs:string external;
declare variable $V_URI_ID as xs:string external;

xf:ControlAtomicidadIn($OriginalHeader,
    $OriginalBody,
    $V_UUID_BITACORA,
    $V_ALTER_ID,
    $V_URI_ID)
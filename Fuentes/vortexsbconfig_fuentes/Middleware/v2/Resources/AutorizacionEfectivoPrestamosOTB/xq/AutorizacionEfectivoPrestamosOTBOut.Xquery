<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$manualAuthResponse" element="ns1:ManualAuthResponse" location="../../../BusinessServices/VisionPlus/visionPlus/xsd/XMLSchema_769155616.xsd" ::)
(:: pragma bea:global-element-return element="ns0:AutorizacionEfectivoPrestamosOTBResponse" location="../xsd/AutorizacionEfectivoPrestamosOTBTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/AutorizacionEfectivoPrestamosOTBTypes";
declare namespace ns1 = "http://www.procesa.com/fdcs";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/AutorizacionEfectivoPrestamosOTB/xq/AutorizacionEfectivoPrestamosOTBOut/";

declare function xf:AutorizacionEfectivoPrestamosOTBOut($manualAuthResponse as element(ns1:ManualAuthResponse))
    as element(ns0:AutorizacionEfectivoPrestamosOTBResponse) {
        <ns0:AutorizacionEfectivoPrestamosOTBResponse>
            <ACTION_CODE>{ data($manualAuthResponse/OFXRSO-ACTION) }</ACTION_CODE>
            <ACTION_REASON_CODE>{ data($manualAuthResponse/OFXRSO-ACTION-REASON) }</ACTION_REASON_CODE>
            <REASON_DESCRIPCION>{ data($manualAuthResponse/OFXRSO-REASON-DESC) }</REASON_DESCRIPCION>
            <AUTH_CODE>{ data($manualAuthResponse/OFXRSO-AUTH-CODE) }</AUTH_CODE>
        </ns0:AutorizacionEfectivoPrestamosOTBResponse>
};

declare variable $manualAuthResponse as element(ns1:ManualAuthResponse) external;

xf:AutorizacionEfectivoPrestamosOTBOut($manualAuthResponse)]]></con:xquery>
    <con:dependency location="../../../BusinessServices/VisionPlus/visionPlus/xsd/XMLSchema_769155616.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/VisionPlus/visionPlus/xsd/XMLSchema_769155616"/>
    </con:dependency>
    <con:dependency location="../xsd/AutorizacionEfectivoPrestamosOTBTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/AutorizacionEfectivoPrestamosOTB/xsd/AutorizacionEfectivoPrestamosOTBTypes"/>
    </con:dependency>
</con:xqueryEntry>
xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://www.ficohsa.com.hn/middleware.services/procesaMensajeGenericoEnviadoSwitchTypes";
(:: import schema at "../Schemas/procesaMensajeGenericoEnviadoSwitchTypes.xsd" ::)
declare namespace ns2="https://www.ficohsa.com/honduras/card";
(:: import schema at "../Schemas/CustomizeDebitCardPinTypes.xsd" ::)

declare variable $SwitchToCustomizeDebitCardPin as element() (:: schema-element(ns1:procesaMensajeGenericoEnviadoSwitchResponse) ::) external;
declare variable $globalId as xs:string external;
declare variable $responseService as xs:string external;

declare function local:funcSwitchToCustomizeDebitCardPin($SwitchToCustomizeDebitCardPin as element() (:: schema-element(ns1:procesaMensajeGenericoEnviadoSwitchResponse) ::),
                                                          $globalId as xs:string,
                                                          $responseService as xs:string) as element() (:: schema-element(ns2:customizeDebitCardPinResponse) ::) {
    <ns2:customizeDebitCardPinResponse>
        <StatusInfo>
            <Status>{fn:data($responseService)}</Status>
            <DateTime>{fn:substring(fn:string(fn:current-dateTime()),0,20)}</DateTime>
            <GlobalId>{fn:data($globalId)}</GlobalId>
        </StatusInfo>
    </ns2:customizeDebitCardPinResponse>
};

local:funcSwitchToCustomizeDebitCardPin($SwitchToCustomizeDebitCardPin, $globalId, $responseService)

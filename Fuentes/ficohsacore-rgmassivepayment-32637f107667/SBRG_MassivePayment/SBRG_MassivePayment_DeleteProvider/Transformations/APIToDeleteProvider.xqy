xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="https://www.ficohsa.com/regional/massivePayment";
(:: import schema at "../Schemas/DeleteProviderTypes.xsd" ::)

declare variable $globalId as xs:string external;

declare function local:func(
    $globalId as xs:string
    ) as element() (:: schema-element(ns1:deleteProviderResponse) ::) {
    <ns1:deleteProviderResponse>
        <StatusInfo>
            <Status>Success</Status>
            <ValueDate>{fn:substring(fn:string(fn:current-dateTime()),0,11)}</ValueDate>
            <DateTime>{fn:substring(fn:string(fn:current-dateTime()),0,20)}</DateTime>
            <GlobalId>{fn:data($globalId)}</GlobalId>
        </StatusInfo>
    </ns1:deleteProviderResponse>
};

local:func($globalId)
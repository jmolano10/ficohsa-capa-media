xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://www.ficohsa.com.hn/middleware.services/digitalizacionExpedienteTypes";
(:: import schema at "../../../../../../MWBanking/Documents/RequestorServices/XSD/digitalizacionExpedienteTypes.xsd" ::)

declare namespace xq="http://www.w3.org/2005/xquery-local-functions";

declare namespace com = "http://www.ficohsa.com.hn/middleware.services/commonTypes";

declare variable $uuid as xs:string external;

declare function xq:createfileOut($uuid as xs:string) as element() (:: schema-element(ns1:creaExpedienteResponse) ::) {
    <ns1:creaExpedienteResponse>
        <ns1:StatusInfo>
            <com:Status>Success</com:Status>
            <com:ValueDate>{fn:substring(fn:string(fn:current-dateTime()),0,11)}</com:ValueDate>
            <com:DateTime>{fn:substring(fn:string(fn:current-dateTime()),0,20)}</com:DateTime>
            <com:GlobalId>{$uuid}</com:GlobalId>
        </ns1:StatusInfo>
    </ns1:creaExpedienteResponse>
};

xq:createfileOut($uuid)
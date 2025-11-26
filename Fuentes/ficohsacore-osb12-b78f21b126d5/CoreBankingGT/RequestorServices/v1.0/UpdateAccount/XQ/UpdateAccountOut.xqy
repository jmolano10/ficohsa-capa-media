xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://www.ficohsa.com.hn/middleware.services/updateAccountTypes";
(:: import schema at "../../../../../MWBanking/Accounts/RequestorServices/XSD/updateAccountTypes.xsd" ::)

declare namespace com = "http://www.ficohsa.com.hn/middleware.services/commonTypes";

declare variable $uuid as xs:string external;

declare function local:func($uuid as xs:string) as element() (:: schema-element(ns1:updateAccountResponse) ::) {
    <ns1:updateAccountResponse>
        <ns1:StatusInfo>
            <com:Status>Success</com:Status>
            <com:ValueDate>{fn:substring(fn:string(fn:current-dateTime()),0,11)}</com:ValueDate>
            <com:DateTime>{fn:substring(fn:string(fn:current-dateTime()),0,20)}</com:DateTime>
            <com:GlobalId>{fn:data($uuid)}</com:GlobalId>
        </ns1:StatusInfo>
    </ns1:updateAccountResponse>
};

local:func($uuid)
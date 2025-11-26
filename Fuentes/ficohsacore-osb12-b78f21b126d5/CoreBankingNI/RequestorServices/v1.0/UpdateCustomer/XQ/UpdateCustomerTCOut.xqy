xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://www.ficohsa.com.hn/middleware.services/updateCustomerTypesNI";
(:: import schema at "../../../../../MWBanking/Customers/RequestorServices/XSD/updateCustomerNI.xsd" ::)

declare namespace com = "http://www.ficohsa.com.hn/middleware.services/commonTypes";

declare variable $uuid as xs:string external;
declare variable $customerId as xs:string external;

declare function local:func($uuid as xs:string, $customerId as xs:string) as element() (:: schema-element(ns1:updateCustomerResponse) ::) {
    <ns1:updateCustomerResponse>
        <ns1:StatusInfo>
            <com:Status>Success</com:Status>
            <com:TransactionId>{fn:data($customerId)}</com:TransactionId>
            <com:ValueDate>{fn:substring(fn:string(fn:current-dateTime()),0,11)}</com:ValueDate>
            <com:DateTime>{fn:substring(fn:string(fn:current-dateTime()),0,20)}</com:DateTime>
            <com:GlobalId>{fn:data($uuid)}</com:GlobalId>
        </ns1:StatusInfo>
    </ns1:updateCustomerResponse>
};

local:func($uuid, $customerId)
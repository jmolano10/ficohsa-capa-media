xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="http://www.ficohsa.com.hn/middleware.services/customerTypes";
(:: import schema at "../../../../../../MWBanking/Customers/RequestorServices/XSD/customersTypes.xsd" ::)

declare namespace com = "http://www.ficohsa.com.hn/middleware.services/commonTypes";

declare variable $uuid as xs:string external;
declare variable $CustomerId as xs:string external;

declare function local:func($uuid as xs:string,$CustomerId as xs:string) as element() (:: schema-element(ns2:createCustomerResponse) ::) {
    <ns2:createCustomerResponse>
        <StatusInfo>
            <com:Status>Success</com:Status>
            <com:ValueDate>{fn:substring(fn:string(fn:current-dateTime()),0,11)}</com:ValueDate>
            <com:DateTime>{fn:substring(fn:string(fn:current-dateTime()),0,20)}</com:DateTime>
            <com:GlobalId>{fn:data($uuid)}</com:GlobalId>
        </StatusInfo>
        <ns2:CustomerId>{fn:data($CustomerId)}</ns2:CustomerId>
    </ns2:createCustomerResponse>
};

local:func($uuid, $CustomerId)
xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="http://www.ficohsa.com.hn/middleware.services/customerTypes";
(:: import schema at "../../../../../../MWBanking/Customers/RequestorServices/XSD/customersTypes.xsd" ::)

declare namespace ns1="http://www.ficohsa.com/midleware.services/unityFormOut";

declare namespace com = "http://www.ficohsa.com.hn/middleware.services/commonTypes";

declare variable $uuid as xs:string external;

declare function ns1:unityFormOut($uuid as xs:string) as element() (:: schema-element(ns2:unityFormResponse) ::) {
    <ns2:unityFormResponse>
        <ns2:StatusInfo>
            <com:Status>Success</com:Status>
            <com:ValueDate>{fn:substring(fn:string(fn:current-dateTime()),0,11)}</com:ValueDate>
            <com:DateTime>{fn:substring(fn:string(fn:current-dateTime()),0,20)}</com:DateTime>
            <com:GlobalId>{fn:data($uuid)}</com:GlobalId>
        </ns2:StatusInfo>
        <ns2:UnityFormResult>
            <ns2:Code>0</ns2:Code>
            <ns2:Description></ns2:Description>
            <ns2:Result>83274</ns2:Result>
        </ns2:UnityFormResult>
    </ns2:unityFormResponse>
};

ns1:unityFormOut($uuid)

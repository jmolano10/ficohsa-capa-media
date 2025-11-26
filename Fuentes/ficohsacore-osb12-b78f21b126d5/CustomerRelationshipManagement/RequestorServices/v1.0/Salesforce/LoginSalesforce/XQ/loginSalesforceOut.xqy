xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://www.ficohsa.com.hn/middleware.services/loginSalesForceTypes";
(:: import schema at "../XSD/LoginSalesforceTypes.xsd" ::)

declare namespace ns2="http://www.ficohsa.com/midleware.services/loginSalesforceOut";

declare namespace com = "http://www.ficohsa.com.hn/middleware.services/commonTypes";

declare variable $sessionId as xs:string external;
declare variable $username as xs:string external;
declare variable $password as xs:string external;
declare variable $uuid as xs:string external;

declare function ns2:loginSalesforceOut($sessionId as xs:string, 
                                        $username as xs:string, 
                                        $password as xs:string, 
                                        $uuid as xs:string) 
                                        as element() (:: schema-element(ns1:loginSalesforceResponse) ::) {
    <ns1:loginSalesforceResponse>
        <ns1:StatusInfo>
            <com:Status>Success</com:Status>
            <com:ValueDate>{fn:substring(fn:string(fn:current-dateTime()),0,11)}</com:ValueDate>
            <com:DateTime>{fn:substring(fn:string(fn:current-dateTime()),0,20)}</com:DateTime>
            <com:GlobalId>{fn:data($uuid)}</com:GlobalId>
        </ns1:StatusInfo>
        <ns1:SalesforceInfo>
            <ns1:Username>{fn:data($username)}</ns1:Username>
            <ns1:Password>{fn:data($password)}</ns1:Password>
            <ns1:Session>{fn:data($sessionId)}</ns1:Session>
        </ns1:SalesforceInfo>
    </ns1:loginSalesforceResponse>
};

ns2:loginSalesforceOut($sessionId, $username, $password, $uuid)

xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="http://www.ficohsa.com.hn/middleware.services/messagingTypes";
(:: import schema at "../../../../../MWBanking/Messaging/RequestorServices/XSD/messagingTypes.xsd" ::)

declare namespace ns1="http://www.ficohsa.com/midleware.services/sendSMSOut";

declare namespace com = "http://www.ficohsa.com.hn/middleware.services/commonTypes";

declare variable $uuid as xs:string external;


declare function ns1:sendSMSOut($uuid as xs:string) as element() (:: schema-element(ns2:sendSMSResponse) ::) {
    <ns2:sendSMSResponse>
        <ns2:StatusInfo>
            <com:Status>Success</com:Status>
            <com:ValueDate>{fn:substring(fn:string(fn:current-dateTime()),0,11)}</com:ValueDate>
            <com:DateTime>{fn:substring(fn:string(fn:current-dateTime()),0,20)}</com:DateTime>
            <com:GlobalId>{fn:data($uuid)}</com:GlobalId>
        </ns2:StatusInfo>
    </ns2:sendSMSResponse>
};

ns1:sendSMSOut($uuid)

xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="http://www.ficohsa.com.hn/middleware.services/createBankingUser";
(:: import schema at "../../../../../../MWBanking/Users/RequestorServices/XSD/createBankingUser.xsd" ::)

declare namespace ns1="http://www.ficohsa.com/midleware.services/CreateBankingUserOUT";
declare namespace ns3 = "urn:tailored.icbanking.services.administration.general";

declare namespace com = "http://www.ficohsa.com.hn/middleware.services/commonTypes";

declare variable $uuid as xs:string external;
declare variable $userName as xs:string external;

declare function ns1:createBankingUserOUT($uuid as xs:string, $userName as xs:string) as element() (:: schema-element(ns2:createBankingUserResponse) ::) {
    <ns2:createBankingUserResponse>
        <ns2:StatusInfo>
            <com:Status>Success</com:Status>
            <com:ValueDate>{fn:substring(fn:string(fn:current-dateTime()),0,11)}</com:ValueDate>
            <com:DateTime>{fn:substring(fn:string(fn:current-dateTime()),0,20)}</com:DateTime>
            <com:GlobalId>{fn:data($uuid)}</com:GlobalId>
        </ns2:StatusInfo>
        <ns2:UserName>{fn:data($userName)}</ns2:UserName>
    </ns2:createBankingUserResponse>
};

ns1:createBankingUserOUT($uuid, $userName)

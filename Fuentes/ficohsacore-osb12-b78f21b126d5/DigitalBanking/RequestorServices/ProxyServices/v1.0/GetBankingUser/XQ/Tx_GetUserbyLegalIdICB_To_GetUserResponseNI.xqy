xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="http://www.ficohsa.com.hn/middleware.services/getUser";
(:: import schema at "../../../../../../MWBanking/Users/RequestorServices/XSD/getUser.xsd" ::)
declare namespace ns1="urn:tailored.icbanking.services.administration.users";
(:: import schema at "../XSD/ValidateUserICBMessageGTOut.xsd" ::)

declare namespace xq="http://www.w3.org/2005/xquery-local-functions";

declare namespace com = "http://www.ficohsa.com.hn/middleware.services/commonTypes";
declare variable $uuid as xs:string external;
declare variable $legalId as xs:string external;
declare variable $getUSerResponse as element() (:: schema-element(ns1:GetUserByDocumentNumberMessageOut) ::) external;

declare function xq:Tx_GetUserbyLegalIdICB_To_GetUserResponse($getUSerResponse as element() (:: schema-element(ns1:GetUserByDocumentNumberMessageOut) ::),$uuid as xs:string, $legalId as xs:string) as element() (:: schema-element(ns2:getUserResponse) ::) {
    <ns2:getUserResponse>
        <ns2:StatusInfo>
            <com:Status>Success</com:Status>
            <com:ValueDate>{fn:substring(fn:string(fn:current-dateTime()),0,11)}</com:ValueDate>
            <com:DateTime>{fn:substring(fn:string(fn:current-dateTime()),0,20)}</com:DateTime>
            <com:GlobalId>{fn:data($uuid)}</com:GlobalId>
        </ns2:StatusInfo>
        <ns2:UserDetails>
            <ns2:LegalId>{fn:data($legalId)}</ns2:LegalId>
            {
                if ($getUSerResponse/ns1:Username)
                then <ns2:UserName>{fn:data($getUSerResponse/ns1:Username)}</ns2:UserName>
                else ()
            }
        </ns2:UserDetails>
    </ns2:getUserResponse>
};

xq:Tx_GetUserbyLegalIdICB_To_GetUserResponse($getUSerResponse,$uuid,$legalId)
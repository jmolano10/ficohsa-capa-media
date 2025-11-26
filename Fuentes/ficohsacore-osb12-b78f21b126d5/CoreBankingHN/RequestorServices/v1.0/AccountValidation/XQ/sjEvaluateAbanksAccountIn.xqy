xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://www.ficohsa.com.hn/middleware.services/sjEvaluateAbanksAccountTypes";
(:: import schema at "../../../../../MWBanking/Accounts/RequestorServices/XSD/sjEvaluateAbanksAccountTypes.xsd" ::)

declare variable $accountNumber as xs:string external;
declare variable $uuid as xs:string external;

declare function local:func($accountNumber as xs:string, $uuid as xs:string) as element() (:: schema-element(ns1:sjEvaluateAbanksAccountRequest) ::) {
    <ns1:sjEvaluateAbanksAccountRequest>
        <ns1:AccountId>{fn:data($accountNumber)}</ns1:AccountId>
        <ns1:Uuid>{fn:data($uuid)}</ns1:Uuid>
    </ns1:sjEvaluateAbanksAccountRequest>
};

local:func($accountNumber, $uuid)
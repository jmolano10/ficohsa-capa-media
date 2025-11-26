xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="http://www.ficohsa.com.hn/middleware.services/accountsTypes";
(:: import schema at "../../../../../MWBanking/Accounts/RequestorServices/XSD/accountsTypes.xsd" ::)
declare namespace ns1="http://xmlns.oracle.com/pcbpel/adapter/db/sp/ConnectionCobisNI";
(:: import schema at "../../../../ProviderServices/XSD/CreateAccount/CreateAccountNI_sp.xsd" ::)

declare namespace com = "http://www.ficohsa.com.hn/middleware.services/commonTypes";

declare variable $response as element() (:: schema-element(ns1:OutputParameters) ::) external;
declare variable $uuid as xs:string external;

declare function local:func($response as element() (:: schema-element(ns1:OutputParameters) ::),$uuid as xs:string) as element() (:: schema-element(ns2:createAccountResponse) ::) {
    <ns2:createAccountResponse>
        <ns2:StatusInfo>
            <com:Status>Success</com:Status>
            <com:ValueDate>{fn:substring(fn:string(fn:current-dateTime()),0,11)}</com:ValueDate>
            <com:DateTime>{fn:substring(fn:string(fn:current-dateTime()),0,20)}</com:DateTime>
            <com:GlobalId>{$uuid}</com:GlobalId>
        </ns2:StatusInfo>
        {
            if ($response/ns1:o_num_cuenta)
            then <ns2:AccountNumber>{fn:data($response/ns1:o_num_cuenta)}</ns2:AccountNumber>
            else ()
        }
    </ns2:createAccountResponse>
};

local:func($response, $uuid)
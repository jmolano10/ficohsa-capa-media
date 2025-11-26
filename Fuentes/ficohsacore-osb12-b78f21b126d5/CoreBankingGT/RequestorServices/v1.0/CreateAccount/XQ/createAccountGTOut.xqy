xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="http://www.ficohsa.com.hn/middleware.services/accountsTypes";
(:: import schema at "../../../../../MWBanking/Accounts/RequestorServices/XSD/accountsTypes.xsd" ::)
declare namespace ns1="http://xmlns.oracle.com/pcbpel/adapter/db/sp/CreateAccountGT_BS";
(:: import schema at "../../../../ProviderServices/XSD/CreateAccount/CreateAccountGT_BS_sp.xsd" ::)

declare namespace xq="http://www.w3.org/2005/xquery-local-functions";

declare namespace com = "http://www.ficohsa.com.hn/middleware.services/commonTypes";

declare variable $outputParameters as element() (:: schema-element(ns1:OutputParameters) ::) external;
declare variable $uuid as xs:string external;

declare function xq:createAccountGTOut($outputParameters as element() (:: schema-element(ns1:OutputParameters) ::), 
                                       $uuid as xs:string) 
                                       as element() (:: schema-element(ns2:createAccountResponse) ::) {
    <ns2:createAccountResponse>
        <ns2:StatusInfo>
            <com:Status>Success</com:Status>
            <com:ValueDate>{fn:substring(fn:string(fn:current-dateTime()),0,11)}</com:ValueDate>
            <com:DateTime>{fn:substring(fn:string(fn:current-dateTime()),0,20)}</com:DateTime>
            <com:GlobalId>{fn:data($uuid)}</com:GlobalId>
        </ns2:StatusInfo>
        {
            if ($outputParameters/ns1:PV_NUMERO_CUENTA)
            then <ns2:AccountNumber>{fn:data($outputParameters/ns1:PV_NUMERO_CUENTA)}</ns2:AccountNumber>
            else ()
        }
    </ns2:createAccountResponse>
};

xq:createAccountGTOut($outputParameters, $uuid)
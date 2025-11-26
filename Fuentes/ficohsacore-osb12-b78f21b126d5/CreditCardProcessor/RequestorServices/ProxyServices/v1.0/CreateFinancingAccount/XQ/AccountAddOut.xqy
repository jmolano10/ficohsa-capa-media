xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="http://www.ficohsa.com.hn/middleware.services/creditCardsTypes";
(:: import schema at "../../../../../../MWBanking/CreditCards/RequestorServices/XSD/creditCardsTypes.xsd" ::)
declare namespace ns1="http://www.procesa.com/fdcs";
(:: import schema at "../../../../../ProviderServices/XSD/visionPlus/XMLSchema_769155616.xsd" ::)

declare namespace com = "http://www.ficohsa.com.hn/middleware.services/commonTypes";

declare variable $uuid as xs:string external;
declare variable $AccountAddResponse as element() (:: schema-element(ns1:AccountAddResponse) ::) external;

declare function local:func($uuid as xs:string, 
                            $AccountAddResponse as element() (:: schema-element(ns1:AccountAddResponse) ::)) 
                            as element() (:: schema-element(ns2:createFinancingAccountResponse) ::) {
    <ns2:createFinancingAccountResponse>
        <ns2:StatusInfo>
            <com:Status>Success</com:Status>
            <com:ValueDate>{fn:substring(fn:string(fn:current-dateTime()),0,11)}</com:ValueDate>
            <com:DateTime>{fn:substring(fn:string(fn:current-dateTime()),0,20)}</com:DateTime>
            <com:GlobalId>{fn:data($uuid)}</com:GlobalId>
        </ns2:StatusInfo>
        <ns2:AccountNumber>{fn:data($AccountAddResponse/ARXAAO-ACCOUNT-NBR)}</ns2:AccountNumber>
    </ns2:createFinancingAccountResponse>
};

local:func($uuid, $AccountAddResponse)
xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="http://www.ficohsa.com.hn/middleware.services/customerTypes";
(:: import schema at "../../../../../../MWBanking/Customers/RequestorServices/XSD/customersTypes.xsd" ::)
declare namespace ns1="http://www.procesa.com/fdcs";
(:: import schema at "../../../../../../CreditCardProcessor/ProviderServices/XSD/visionPlus/XMLSchema_769155616.xsd" ::)

declare namespace com = "http://www.ficohsa.com.hn/middleware.services/commonTypes";

declare variable $uuid as xs:string external;
declare variable $CustomerAddL8V2Response as element() (:: schema-element(ns1:CustomerAddL8V2Response) ::) external;

declare function local:func($uuid as xs:string, $CustomerAddL8V2Response as element() (:: schema-element(ns1:CustomerAddL8V2Response) ::)) as element() (:: schema-element(ns2:createCustomerResponse) ::) {
    <ns2:createCustomerResponse>
        <StatusInfo>
            <com:Status>Success</com:Status>
            <com:ValueDate>{fn:substring(fn:string(fn:current-dateTime()),0,11)}</com:ValueDate>
            <com:DateTime>{fn:substring(fn:string(fn:current-dateTime()),0,20)}</com:DateTime>
            <com:GlobalId>{fn:data($uuid)}</com:GlobalId>
        </StatusInfo>
        <ns2:CustomerId>{fn:data($CustomerAddL8V2Response/AZXNAO-CUST-NBR)}</ns2:CustomerId>
    </ns2:createCustomerResponse>
};

local:func($uuid, $CustomerAddL8V2Response)

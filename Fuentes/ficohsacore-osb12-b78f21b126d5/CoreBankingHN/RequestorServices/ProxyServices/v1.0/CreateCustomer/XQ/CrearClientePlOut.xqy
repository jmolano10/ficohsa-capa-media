xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://www.ficohsa.com.hn/middleware.services/customerTypesHN";
(:: import schema at "../../../../../../MWBanking/Customers/RequestorServices/XSD/createCustomerHN.xsd" ::)

declare namespace xq="http://www.w3.org/2005/xquery-local-functions";

declare namespace com = "http://www.ficohsa.com.hn/middleware.services/commonTypes";

declare variable $uuid as xs:string external;
declare variable $request as element() (:: schema-element(ns1:createCustomerRequest) ::) external;

declare function xq:CrearClientePlOut($uuid as xs:string, 
                                      $request as element() (:: schema-element(ns1:createCustomerRequest) ::)) 
                                      as element() (:: schema-element(ns1:createCustomerResponse) ::) {
    <ns1:createCustomerResponse>
        <ns1:GlobalId></ns1:GlobalId>
        <ns1:StatusInfo>
            <com:Status>Success</com:Status>
            <com:TransactionId></com:TransactionId>
            <com:ValueDate>{fn:substring(fn:string(fn:current-dateTime()),0,11)}</com:ValueDate>
            <com:DateTime>{fn:substring(fn:string(fn:current-dateTime()),0,20)}</com:DateTime>
            <com:GlobalId>{fn:data($uuid)}</com:GlobalId>
        </ns1:StatusInfo>
        {
            if ($request/ns1:CustomerId)
            then <ns1:CustomerId>{fn:data($request/ns1:CustomerId)}</ns1:CustomerId>
            else ()
        }
        <ns1:CustomerName>{fn:concat(fn:data($request/ns1:CustomerInfo/ns1:GivenNames),' ',fn:data($request/ns1:CustomerInfo/ns1:FamilyNames))}</ns1:CustomerName>
    </ns1:createCustomerResponse>
};

xq:CrearClientePlOut($uuid, $request)
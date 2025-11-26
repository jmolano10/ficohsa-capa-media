xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://www.ficohsa.com.hn/middleware.services/customerTypes";
(:: import schema at "../../../../../../MWBanking/Customers/RequestorServices/XSD/customersTypes.xsd" ::)

declare namespace xq="http://www.w3.org/2005/xquery-local-functions";

declare namespace com = "http://www.ficohsa.com.hn/middleware.services/commonTypes";

declare variable $result as xs:string external;
declare variable $uuid as xs:string external;
declare variable $queryDocumentResponse as element() (:: schema-element(ns1:documentQueryResponse) ::) external;

declare function xq:Tx_QueryDocumentResponseError($result as xs:string, 
                                                  $uuid as xs:string, 
                                                  $queryDocumentResponse as element() (:: schema-element(ns1:documentQueryResponse) ::)) 
                                                  as element() (:: schema-element(ns1:documentQueryResponse) ::) {
    <ns1:documentQueryResponse>
        <ns1:ErrorInfo>
            <com:Code>400</com:Code>
            <com:Description>{fn:data($result)}</com:Description>
            <com:ShortDescription>{fn:data($result)}</com:ShortDescription>
            <com:DateTime>{fn:substring(fn:string(fn:current-dateTime()),0,20)}</com:DateTime>
            <com:GlobalId>{fn:data($uuid)}</com:GlobalId>
            <com:Details>
                <com:SystemId>2</com:SystemId>
                <com:SystemStatus>Error</com:SystemStatus>
                <com:MessageId>Error</com:MessageId>
                <com:Messages>{fn:data($result)}</com:Messages>
            </com:Details>
        </ns1:ErrorInfo>
    </ns1:documentQueryResponse>
};

xq:Tx_QueryDocumentResponseError($result, $uuid, $queryDocumentResponse)
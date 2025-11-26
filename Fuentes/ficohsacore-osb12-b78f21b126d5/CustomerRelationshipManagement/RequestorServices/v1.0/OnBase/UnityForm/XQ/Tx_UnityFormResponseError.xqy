xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://onbase.ficohsa.com";
(:: import schema at "../../../../../ProviderServices/v1.0/OnBase/XSD/onbaseTypes.xsd" ::)
declare namespace ns2="http://www.ficohsa.com.hn/middleware.services/customerTypes";
(:: import schema at "../../../../../../MWBanking/Customers/RequestorServices/XSD/customersTypes.xsd" ::)

declare namespace xq="http://www.w3.org/2005/xquery-local-functions";

declare namespace com = "http://www.ficohsa.com.hn/middleware.services/commonTypes";

declare variable $uuid as xs:string external;
declare variable $result as xs:string external;
declare variable $unityFormResponse as element() (:: schema-element(ns1:UnityFormResponse) ::) external;

declare function xq:Tx_UnityFormResponseError($uuid as xs:string, 
                                              $result as xs:string, 
                                              $unityFormResponse as element() (:: schema-element(ns1:UnityFormResponse) ::)) 
                                              as element() (:: schema-element(ns2:unityFormResponse) ::) {
    <ns2:unityFormResponse>
        <ns2:ErrorInfo>
            <com:Code>400</com:Code>
            <com:Error>{fn:data($result)}</com:Error>
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
        </ns2:ErrorInfo>
    </ns2:unityFormResponse>
};

xq:Tx_UnityFormResponseError($uuid, $result, $unityFormResponse)

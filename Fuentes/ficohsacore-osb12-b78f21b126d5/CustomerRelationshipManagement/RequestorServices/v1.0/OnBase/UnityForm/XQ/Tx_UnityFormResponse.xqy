xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://onbase.ficohsa.com";
(:: import schema at "../../../../../ProviderServices/v1.0/OnBase/XSD/onbaseTypes.xsd" ::)
declare namespace ns2="http://www.ficohsa.com.hn/middleware.services/customerTypes";
(:: import schema at "../../../../../../MWBanking/Customers/RequestorServices/XSD/customersTypes.xsd" ::)

declare namespace xq="http://www.w3.org/2005/xquery-local-functions";

declare namespace com = "http://www.ficohsa.com.hn/middleware.services/commonTypes";

declare variable $unityFormResp as element() (:: schema-element(ns1:UnityFormResponse) ::) external;
declare variable $uuid as xs:string external;

declare function xq:Tx_UnityFormResponse($uuid as xs:string, $unityFormResp as element() (:: schema-element(ns1:UnityFormResponse) ::)) as element() (:: schema-element(ns2:unityFormResponse) ::) {
    <ns2:unityFormResponse>
        <ns2:StatusInfo>
            <com:Status>Success</com:Status>
            <com:ValueDate>{fn:substring(fn:string(fn:current-dateTime()),0,11)}</com:ValueDate>
            <com:DateTime>{fn:substring(fn:string(fn:current-dateTime()),0,20)}</com:DateTime>
            <com:GlobalId>{$uuid}</com:GlobalId>
        </ns2:StatusInfo>
        <ns2:UnityFormResult>
            <ns2:Form>
                <ns2:DocumentHandle>{fn:data($unityFormResp/ns1:Form/ns1:DocumentHandle)}</ns2:DocumentHandle>
                <ns2:Keywords>
                    <ns2:Name>{fn:data($unityFormResp/ns1:Form/ns1:Keywords/ns1:Name)}</ns2:Name>
                    <ns2:Value>{fn:data($unityFormResp/ns1:Form/ns1:Keywords/ns1:Value)}</ns2:Value></ns2:Keywords>
                <ns2:DocPopUrl>{fn:data($unityFormResp/ns1:Form/ns1:DocPopUrl)}</ns2:DocPopUrl>
            </ns2:Form>
            <ns2:Code>{fn:data($unityFormResp/ns1:Code)}</ns2:Code>
            <ns2:Description>{fn:data($unityFormResp/ns1:Description)}</ns2:Description>
            <ns2:Result>{fn:data($unityFormResp/ns1:Result)}</ns2:Result>
        </ns2:UnityFormResult>
    </ns2:unityFormResponse>
};

xq:Tx_UnityFormResponse($uuid,$unityFormResp)

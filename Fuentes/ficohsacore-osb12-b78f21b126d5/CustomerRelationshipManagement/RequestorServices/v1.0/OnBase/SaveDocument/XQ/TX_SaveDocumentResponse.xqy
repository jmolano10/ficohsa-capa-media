xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="http://onbase.ficohsa.com";
(:: import schema at "../../../../../ProviderServices/v1.0/OnBase/XSD/onbaseTypes.xsd" ::)
declare namespace ns3="http://www.ficohsa.com.hn/middleware.services/customerTypes";
(:: import schema at "../../../../../../MWBanking/Customers/RequestorServices/XSD/customersTypes.xsd" ::)

declare namespace ns1="http://www.w3.org/middleware.services/tx_SaveDocumentResponse";
declare namespace com = "http://www.ficohsa.com.hn/middleware.services/commonTypes";
declare variable $uuid as xs:string external;

declare variable $saveDocumentResponse as element() (:: schema-element(ns2:SaveDocumentResponse) ::) external;

declare function ns1:tx_SaveDocumentResponse($uuid as xs:string, $saveDocumentResponse as element() (:: schema-element(ns2:SaveDocumentResponse) ::)) as element() (:: schema-element(ns3:documentResponse) ::) {
    <ns3:documentResponse>
        <ns3:StatusInfo>
            <com:Status>Success</com:Status>
            <com:ValueDate>{fn:substring(fn:string(fn:current-dateTime()),0,11)}</com:ValueDate>
            <com:DateTime>{fn:substring(fn:string(fn:current-dateTime()),0,20)}</com:DateTime>
            <com:GlobalId>{$uuid}</com:GlobalId>
        </ns3:StatusInfo>
        <ns3:DocumentResult>
            <ns3:Documents>
                <ns3:DocumentHandler>{fn:data($saveDocumentResponse/ns2:Documents/ns2:DocumentHandle)}</ns3:DocumentHandler>
            </ns3:Documents>
            <ns3:Code>0</ns3:Code>
            <ns3:Description></ns3:Description>
            <ns3:Result></ns3:Result>
        </ns3:DocumentResult>
    </ns3:documentResponse>
};

ns1:tx_SaveDocumentResponse($uuid, $saveDocumentResponse)

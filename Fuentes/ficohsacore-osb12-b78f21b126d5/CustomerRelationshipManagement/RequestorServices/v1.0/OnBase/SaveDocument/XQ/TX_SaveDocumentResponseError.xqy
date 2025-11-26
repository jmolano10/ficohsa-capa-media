xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="http://onbase.ficohsa.com";
(:: import schema at "../../../../../ProviderServices/v1.0/OnBase/XSD/onbaseTypes.xsd" ::)
declare namespace ns3="http://www.ficohsa.com.hn/middleware.services/customerTypes";
(:: import schema at "../../../../../../MWBanking/Customers/RequestorServices/XSD/customersTypes.xsd" ::)

declare namespace ns1="http://www.w3.org/middleware.services/tx_SaveDocumentResponse";
declare namespace com = "http://www.ficohsa.com.hn/middleware.services/commonTypes";

declare variable $saveDocumentResponse as element() (:: schema-element(ns2:SaveDocumentResponse) ::) external;
declare variable $uuid as xs:string external;
declare variable $result as xs:string external;

declare function ns1:tx_SaveDocumentResponse($result as xs:string, $uuid as xs:string, $saveDocumentResponse as element() (:: schema-element(ns2:SaveDocumentResponse) ::)) as element() (:: schema-element(ns3:documentResponse) ::) {
    <ns3:documentResponse>
        <ns3:ErrorInfo>
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
        </ns3:ErrorInfo>
    </ns3:documentResponse>
};

ns1:tx_SaveDocumentResponse($result, $uuid, $saveDocumentResponse)

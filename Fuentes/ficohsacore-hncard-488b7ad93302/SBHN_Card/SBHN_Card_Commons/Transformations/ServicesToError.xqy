xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="https://www.ficohsa.com/regional/constants";
(:: import schema at "../Resources/SBRG_Constants_Commons/Schemas/ErrorMappingRegional.xsd" ::)

declare variable $service as xs:string external;
declare variable $systemApplication as xs:string external;
declare variable $errorMessage as xs:string external;
declare variable $errorCode as xs:string external;
declare variable $language as xs:string external;

declare function local:funcServicesToError($service as xs:string, 
                                           $systemApplication as xs:string, 
                                           $errorMessage as xs:string, 
                                           $errorCode as xs:string, 
                                           $language as xs:string) 
                                           as element() (:: schema-element(ns1:errorMappingRegionalInput) ::) {
    <ns1:errorMappingRegionalInput>
        <ns1:service>{fn:data($service)}</ns1:service>
        <ns1:systemApplication>{fn:data($systemApplication)}</ns1:systemApplication>
        <ns1:errorMessage>{fn:data($errorMessage)}</ns1:errorMessage>
        <ns1:errorCode>{fn:data($errorCode)}</ns1:errorCode>
        <ns1:language>{fn:data($language)}</ns1:language>
    </ns1:errorMappingRegionalInput>
};

local:funcServicesToError($service, $systemApplication, $errorMessage, $errorCode, $language)
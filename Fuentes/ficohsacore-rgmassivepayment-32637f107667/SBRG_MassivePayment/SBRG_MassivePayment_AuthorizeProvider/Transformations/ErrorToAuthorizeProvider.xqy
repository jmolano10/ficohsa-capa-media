xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="https://www.ficohsa.com/regional/constants";
(:: import schema at "../../SBRG_MassivePayment_Commons/Resources/SBRG_Constants_Commons/Schemas/ErrorMappingRegional.xsd" ::)
declare namespace ns2="https://www.ficohsa.com/regional/massivePayment";
(:: import schema at "../Schemas/AuthorizeProviderTypes.xsd" ::)

declare variable $responseError as element() (:: schema-element(ns1:errorMappingRegionalOutput) ::) external;
declare variable $state as xs:string external;
declare variable $codeError as xs:string external;
declare variable $messageError as xs:string external;
declare variable $targetSystem as xs:string external;
declare variable $globalId as xs:string external;

declare function local:authorizeProvider(
    $responseError as element() (:: schema-element(ns1:errorMappingRegionalOutput) ::), 
    $state as xs:string, 
    $codeError as xs:string, 
    $messageError as xs:string, 
    $targetSystem as xs:string, 
    $globalId as xs:string
    ) as element() (:: schema-element(ns2:authorizeProviderResponse) ::) {
    <ns2:authorizeProviderResponse>
        <StatusInfo>
            <Status>{fn:data($state)}</Status>
            <ValueDate>{fn:substring(fn:string(fn:current-dateTime()),0,11)}</ValueDate>
            <DateTime>{fn:substring(fn:string(fn:current-dateTime()),0,20)}</DateTime>
            <GlobalId>{fn:data($globalId)}</GlobalId>
        </StatusInfo>
        <ErrorInfo>
            <Code>{fn:data($responseError/ns1:code)}</Code>
            <Error>{fn:data($responseError/ns1:error)}</Error>
            <Description>{fn:data($responseError/ns1:description)}</Description>
            <ShortDescription>{fn:data($responseError/ns1:shortDescription)}</ShortDescription>
            <DateTime>{fn:substring(fn:string(fn:current-dateTime()),0,20)}</DateTime>
            <GlobalId>{fn:data($globalId)}</GlobalId>
            <Details>
                <SystemId>{fn:data($targetSystem)}</SystemId>
                <SystemStatus>{fn:data($state)}</SystemStatus>
                <MessageId>{fn:data($codeError)}</MessageId>
                <Messages>{fn:data($messageError)}</Messages>
            </Details>
        </ErrorInfo>
    </ns2:authorizeProviderResponse>
};

local:authorizeProvider($responseError, $state, $codeError, $messageError, $targetSystem, $globalId)
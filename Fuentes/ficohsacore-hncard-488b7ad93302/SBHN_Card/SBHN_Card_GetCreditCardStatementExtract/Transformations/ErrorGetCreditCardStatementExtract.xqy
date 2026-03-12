xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="https://www.ficohsa.com/regional/card";
(:: import schema at "../Schemas/GetCreditCardStatementExtractTypes.xsd" ::)
declare namespace ns1="https://www.ficohsa.com/regional/constants";
(:: import schema at "../../SBHN_Card_Commons/Resources/SBRG_Constants_Commons/Schemas/ErrorMappingRegional.xsd" ::)

declare variable $MapeoErrorOutput as element() (:: schema-element(ns1:errorMappingRegionalOutput) ::) external;
declare variable $StatusService as xs:string external;
declare variable $GlobalId as xs:string external;
declare variable $TargetSystem as xs:string external;
declare variable $CodeError as xs:string external;
declare variable $MessageError as xs:string external;

declare function local:funcErrorGetCreditCardStatementExtract($MapeoErrorOutput as element() (:: schema-element(ns1:errorMappingRegionalOutput) ::), 
                                                              $StatusService as xs:string, 
                                                              $GlobalId as xs:string, 
                                                              $TargetSystem as xs:string, 
                                                              $CodeError as xs:string, 
                                                              $MessageError as xs:string) 
                                                              as element() (:: schema-element(ns2:getCreditCardStatementExtractResponse) ::) {
    <ns2:getCreditCardStatementExtractResponse>
        <StatusInfo>
            <Status>{fn:data($StatusService)}</Status>
            <TransactionId></TransactionId>
            <ValueDate>{fn:substring(fn:string(fn:current-dateTime()),0,11)}</ValueDate>            
            <DateTime>{fn:substring(fn:string(fn:current-dateTime()),0,20)}</DateTime>
            <GlobalId>{fn:data($GlobalId)}</GlobalId>
        </StatusInfo>
        <ErrorInfo>
            <Code>{fn:data($MapeoErrorOutput/ns1:code)}</Code>
            <Error>{fn:data($MapeoErrorOutput/ns1:error)}</Error>
            <Description>{fn:data($MapeoErrorOutput/ns1:description)}</Description>
            <ShortDescription>{fn:data($MapeoErrorOutput/ns1:shortDescription)}</ShortDescription>
            <DateTime>{fn:substring(fn:string(fn:current-dateTime()),0,20)}</DateTime>
            <GlobalId>{fn:data($GlobalId)}</GlobalId>
            <Details>
                <SystemId>{fn:data($TargetSystem)}</SystemId>
                <SystemStatus>{fn:data($StatusService)}</SystemStatus>
                <MessageId>{fn:data($CodeError)}</MessageId>
                <Messages>{fn:data($MessageError)}</Messages>
            </Details>
        </ErrorInfo>
    </ns2:getCreditCardStatementExtractResponse>
};

local:funcErrorGetCreditCardStatementExtract($MapeoErrorOutput, $StatusService, $GlobalId, $TargetSystem, $CodeError, $MessageError)
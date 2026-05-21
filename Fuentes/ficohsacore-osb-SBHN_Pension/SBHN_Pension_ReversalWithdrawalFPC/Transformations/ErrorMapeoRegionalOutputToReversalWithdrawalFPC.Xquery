<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="https://www.ficohsa.com/regional/constants";
(:: import schema at "../../SBHN_Pension_Commons/Resources/SBRG_Constants_Commons/Schemas/ErrorMappingRegional.xsd" ::)
declare namespace ns2="https://www.ficohsa.com/regional/pension";
(:: import schema at "../Schemas/ReversalWithdrawalFPCTypes.xsd" ::)

declare variable $ErrorMapeoRegionalOutput as element() (:: schema-element(ns1:errorMappingRegionalOutput) ::) external;
declare variable $StatusService as xs:string external;
declare variable $ErrorCode as xs:string external;
declare variable $ErrorMessage as xs:string external;
declare variable $TarguetSystem as xs:string external;
declare variable $GlobalId as xs:string external;

declare function local:funcErrorMapeoRegionalOutputToReversalWithdrawalFPC($ErrorMapeoRegionalOutput as element() (:: schema-element(ns1:errorMappingRegionalOutput) ::), 
                                                                           $StatusService as xs:string, 
                                                                           $ErrorCode as xs:string, 
                                                                           $ErrorMessage as xs:string, 
                                                                           $TarguetSystem as xs:string, 
                                                                           $GlobalId as xs:string) 
                                                                           as element() (:: schema-element(ns2:ReversalWithdrawalFPCResponse) ::) {
    <ns2:ReversalWithdrawalFPCResponse>
        <StatusInfo>
            <Status>{fn:data($StatusService)}</Status>
            <TransactionId></TransactionId>
            <ValueDate>{fn:substring(fn:string(fn:current-dateTime()),0,11)}</ValueDate>
            <DateTime>{fn:substring(fn:string(fn:current-dateTime()),0,20)}</DateTime>
            <GlobalId>{fn:data($GlobalId)}</GlobalId>
        </StatusInfo>
        <ErrorInfo>
            <Code>{fn:data($ErrorMapeoRegionalOutput/ns1:code)}</Code>
            <Error>{fn:data($ErrorMapeoRegionalOutput/ns1:error)}</Error>
            <Description>{fn:data($ErrorMapeoRegionalOutput/ns1:description)}</Description>
            <ShortDescription>{fn:data($ErrorMapeoRegionalOutput/ns1:shortDescription)}</ShortDescription>
            <DateTime>{fn:substring(fn:string(fn:current-dateTime()),0,20)}</DateTime>
            <GlobalId>{fn:data($GlobalId)}</GlobalId>
            <Details>
                <SystemId>{fn:data($TarguetSystem)}</SystemId>
                <SystemStatus>{fn:data($StatusService)}</SystemStatus>
                <MessageId>{fn:data($ErrorCode)}</MessageId>
                <Messages>{fn:data($ErrorMessage)}</Messages>
            </Details>
        </ErrorInfo>
    </ns2:ReversalWithdrawalFPCResponse>
};

local:funcErrorMapeoRegionalOutputToReversalWithdrawalFPC($ErrorMapeoRegionalOutput, $StatusService, $ErrorCode, $ErrorMessage, $TarguetSystem, $GlobalId)]]></con:xquery>
    <con:dependencies>
        <con:importSchema location="../../SBHN_Pension_Commons/Resources/SBRG_Constants_Commons/Schemas/ErrorMappingRegional.xsd">
            <con:schema ref="SBHN_Pension_Commons/Resources/SBRG_Constants_Commons/Schemas/ErrorMappingRegional"/>
        </con:importSchema>
        <con:importSchema location="../Schemas/ReversalWithdrawalFPCTypes.xsd">
            <con:schema ref="SBHN_Pension_ReversalWithdrawalFPC/Schemas/ReversalWithdrawalFPCTypes"/>
        </con:importSchema>
    </con:dependencies>
</con:xqueryEntry>
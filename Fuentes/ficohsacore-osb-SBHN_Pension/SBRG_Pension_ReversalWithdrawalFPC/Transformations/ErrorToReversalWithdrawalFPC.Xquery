<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="https://www.ficohsa.com/regional/constants";
(:: import schema at "../../SBRG_Pension_Commons/Resources/SBRG_Constants_Commons/Schemas/ErrorMappingRegional.xsd" ::)
declare namespace ns2="https://www.ficohsa.com/regional/pension";
(:: import schema at "../Schemas/ReversalWithdrawalFPCTypes.xsd" ::)

declare variable $MapeoErroresOutput as element() (:: schema-element(ns1:errorMappingRegionalOutput) ::) external;
declare variable $StatusService as xs:string external;
declare variable $GlobalId as xs:string external;
declare variable $TarguetSystem as xs:string external;
declare variable $CodeErrorService as xs:string external;
declare variable $MessageErrorService as xs:string external;

declare function local:funcErrorToReversalWithdrawalFPC($MapeoErroresOutput as element() (:: schema-element(ns1:errorMappingRegionalOutput) ::), 
                                                        $StatusService as xs:string, 
                                                        $GlobalId as xs:string, 
                                                        $TarguetSystem as xs:string, 
                                                        $CodeErrorService as xs:string, 
                                                        $MessageErrorService as xs:string) as element() (:: schema-element(ns2:ReversalWithdrawalFPCResponse) ::) {
                                                        
       <ns2:ReversalWithdrawalFPCResponse>
          <StatusInfo>
            <Status>{fn:data($StatusService)}</Status>
            <TransactionId></TransactionId>
            <ValueDate>{fn:substring(fn:string(fn:current-dateTime()),0,11)}</ValueDate>
            <DateTime>{fn:substring(fn:string(fn:current-dateTime()),0,20)}</DateTime>
            <GlobalId>{fn:data($GlobalId)}</GlobalId>
        </StatusInfo>
        <ErrorInfo>
            <Code>{fn:data($MapeoErroresOutput/ns1:code)}</Code>
            <Error>{fn:data($MapeoErroresOutput/ns1:error)}</Error>
            <Description>{fn:data($MapeoErroresOutput/ns1:description)}</Description>
            <ShortDescription>{fn:data($MapeoErroresOutput/ns1:shortDescription)}</ShortDescription>
            <DateTime>{fn:substring(fn:string(fn:current-dateTime()),0,20)}</DateTime>
            <GlobalId>{fn:data($GlobalId)}</GlobalId>
            <Details>
                <SystemId>{fn:data($TarguetSystem)}</SystemId>
                <SystemStatus>{fn:data($StatusService)}</SystemStatus>
                <MessageId>{fn:data($CodeErrorService)}</MessageId>
                <Messages>{fn:data($MessageErrorService)}</Messages>
            </Details>
        </ErrorInfo>
               </ns2:ReversalWithdrawalFPCResponse>                                          
    
};

local:funcErrorToReversalWithdrawalFPC($MapeoErroresOutput, $StatusService, $GlobalId, $TarguetSystem, $CodeErrorService, $MessageErrorService)]]></con:xquery>
    <con:dependencies>
        <con:importSchema location="../../SBRG_Pension_Commons/Resources/SBRG_Constants_Commons/Schemas/ErrorMappingRegional.xsd">
            <con:schema ref="SBRG_Pension_Commons/Resources/SBRG_Constants_Commons/Schemas/ErrorMappingRegional"/>
        </con:importSchema>
        <con:importSchema location="../Schemas/ReversalWithdrawalFPCTypes.xsd">
            <con:schema ref="SBRG_Pension_ReversalWithdrawalFPC/Schemas/ReversalWithdrawalFPCTypes"/>
        </con:importSchema>
    </con:dependencies>
</con:xqueryEntry>
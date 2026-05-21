<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="https://www.ficohsa.com/regional/constants";
(:: import schema at "../../SBHN_Pension_Commons/Resources/SBRG_Constants_Commons/Schemas/ErrorMappingRegional.xsd" ::)
declare namespace ns2="https://www.ficohsa.com/regional/pension";
(:: import schema at "../Schemas/PaymentWithdrawalFPCTypes.xsd" ::)

declare variable $response as element() (:: schema-element(ns1:errorMappingRegionalOutput) ::) external;
declare variable $errorCode as xs:string external;
declare variable $errorMessage as xs:string external;
declare variable $targetSystem as xs:string external;
declare variable $status as xs:string external;
declare variable $globalId as xs:string external;

declare function local:func($response as element() (:: schema-element(ns1:errorMappingRegionalOutput) ::), 
                            $errorCode as xs:string, 
                            $errorMessage as xs:string, 
                            $targetSystem as xs:string, 
                            $status as xs:string, 
                            $globalId as xs:string) 
                            as element() (:: schema-element(ns2:paymentWithdrawalFPCResponse) ::) {
    <ns2:paymentWithdrawalFPCResponse>
        <StatusInfo>
            <Status>{fn:data($status)}</Status>
            <TransactionId></TransactionId>
            <ValueDate>{fn:substring(fn:string(fn:current-dateTime()),0,11)}</ValueDate>
            <DateTime>{fn:substring(fn:string(fn:current-dateTime()),0,20)}</DateTime>
            <GlobalId>{fn:data($globalId)}</GlobalId>
        </StatusInfo>
        <ErrorInfo>
            <Code>{fn:data($response/ns1:code)}</Code>
            <Error>{fn:data($response/ns1:error)}</Error>
            <Description>{fn:data($response/ns1:description)}</Description>
            <ShortDescription>{fn:data($response/ns1:shortDescription)}</ShortDescription>
            <DateTime>{fn:substring(fn:string(fn:current-dateTime()),0,20)}</DateTime>
            <GlobalId>{fn:data($globalId)}</GlobalId>
            <Details>
                <SystemId>{fn:data($targetSystem)}</SystemId>
                <SystemStatus>{fn:data($status)}</SystemStatus>
                <MessageId>{fn:data($errorCode)}</MessageId>
                <Messages>{fn:data($errorMessage)}</Messages>
            </Details>
        </ErrorInfo>
    </ns2:paymentWithdrawalFPCResponse>
};

local:func($response, $errorCode, $errorMessage, $targetSystem, $status, $globalId)]]></con:xquery>
    <con:dependencies>
        <con:importSchema location="../../SBHN_Pension_Commons/Resources/SBRG_Constants_Commons/Schemas/ErrorMappingRegional.xsd">
            <con:schema ref="SBHN_Pension_Commons/Resources/SBRG_Constants_Commons/Schemas/ErrorMappingRegional"/>
        </con:importSchema>
        <con:importSchema location="../Schemas/PaymentWithdrawalFPCTypes.xsd">
            <con:schema ref="SBHN_Pension_PaymentWithdrawalFPC/Schemas/PaymentWithdrawalFPCTypes"/>
        </con:importSchema>
    </con:dependencies>
</con:xqueryEntry>
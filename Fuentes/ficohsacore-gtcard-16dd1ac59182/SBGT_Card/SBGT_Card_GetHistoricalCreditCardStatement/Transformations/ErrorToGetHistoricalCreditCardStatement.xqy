xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="https://www.ficohsa.com/regional/card";
(:: import schema at "../../SBGT_Card_Commons/Schemas/CardInquiryTypes.xsd" ::)

declare namespace ns1="https://www.ficohsa.com/regional/constants";
(:: import schema at "../../SBGT_Card_Commons/Resources/SBRG_Constants_Commons/Schemas/ErrorMappingRegional.xsd" ::)

declare variable $responseError as element() (:: schema-element(ns1:errorMappingRegionalOutput) ::) external;
declare variable $codeError as xs:string external;
declare variable $messageError as xs:string external;
declare variable $targetSystem as xs:string external;
declare variable $status as xs:string external;
declare variable $globalId as xs:string external;

declare function local:func($responseError as element() (:: schema-element(ns1:errorMappingRegionalOutput) ::),
 $codeError as xs:string, 
                                                    $messageError as xs:string, 
                                                    $targetSystem as xs:string, 
                                                    $status as xs:string, 
                                                    $globalId as xs:string) as element()  (:: schema-element(ns2:getHistoricalCreditCardStatementReponse) ::) {
    <ns1:getHistoricalCreditCardStatementReponse>
     <StatusInfo>
            <Status>{fn:data($status)}</Status>
            <TransactionId></TransactionId>
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
                <SystemStatus>{fn:data($status)}</SystemStatus>
                <MessageId>{fn:data($codeError)}</MessageId>
                <Messages>{fn:data($messageError)}</Messages>
            </Details>
        </ErrorInfo>
    </ns1:getHistoricalCreditCardStatementReponse>
};

local:func($responseError, $codeError, $messageError, $targetSystem, $status, $globalId)
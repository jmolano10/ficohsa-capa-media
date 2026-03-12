xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="https://www.ficohsa.com/honduras/card";
(:: import schema at "../Schemas/CustomizeDebitCardPinTypes.xsd" ::)
declare namespace ns1="https://www.ficohsa.com/regional/constants";
(:: import schema at "../../SBHN_Card_Commons/Resources/SBRG_Constants_Commons/Schemas/ErrorMappingRegional.xsd" ::)

declare variable $ErrorToCustomizeDebitCardPin as element() (:: schema-element(ns1:errorMappingRegionalOutput) ::) external;
declare variable $codeError as xs:string external;
declare variable $messageError as xs:string external;
declare variable $targetSystem as xs:string external;
declare variable $status as xs:string external;
declare variable $globalId as xs:string external;

declare function local:funcErrorToCustomizeDebitCardPin($ErrorToCustomizeDebitCardPin as element() (:: schema-element(ns1:errorMappingRegionalOutput) ::),
                                                      $codeError as xs:string, 
                                            $messageError as xs:string, 
                                            $targetSystem as xs:string, 
                                            $status as xs:string, 
                                            $globalId as xs:string) as element() (:: schema-element(ns2:customizeDebitCardPinResponse) ::) {
    <ns2:customizeDebitCardPinResponse>
      <StatusInfo>
            <Status>{fn:data($status)}</Status>
            <TransactionId></TransactionId>
            <ValueDate>{fn:substring(fn:string(fn:current-dateTime()),0,11)}</ValueDate>
            <DateTime>{fn:substring(fn:string(fn:current-dateTime()),0,20)}</DateTime>
            <GlobalId>{fn:data($globalId)}</GlobalId>
        </StatusInfo>
        <ErrorInfo>
            <Code>{fn:data($ErrorToCustomizeDebitCardPin/ns1:code)}</Code>
            <Error>{fn:data($ErrorToCustomizeDebitCardPin/ns1:error)}</Error>
            <Description>{fn:data($ErrorToCustomizeDebitCardPin/ns1:description)}</Description>
            <ShortDescription>{fn:data($ErrorToCustomizeDebitCardPin/ns1:shortDescription)}</ShortDescription>
            <DateTime>{fn:substring(fn:string(fn:current-dateTime()),0,20)}</DateTime>
            <GlobalId>{fn:data($globalId)}</GlobalId>
            <Details>
                <SystemId>{fn:data($targetSystem)}</SystemId>
                <SystemStatus>{fn:data($status)}</SystemStatus>
                <MessageId>{fn:data($codeError)}</MessageId>
                <Messages>{fn:data($messageError)}</Messages>
            </Details>
        </ErrorInfo>
    </ns2:customizeDebitCardPinResponse>
};

local:funcErrorToCustomizeDebitCardPin($ErrorToCustomizeDebitCardPin, $codeError, $messageError, $targetSystem, $status, $globalId)

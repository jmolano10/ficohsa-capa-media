xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="https://www.ficohsa.com/regional/utility/logging";
(:: import schema at "../Resources/SBRG_Logging_Commons/Schemas/LoggingRegional.xsd" ::)

declare variable $GlobalId as xs:string external;
declare variable $service as xs:string external;
declare variable $version as xs:string external;
declare variable $channel as xs:string external;
declare variable $messageType as xs:string external;
declare variable $targetSystem as xs:string external;
declare variable $endpoint as xs:string external;
declare variable $method as xs:string external;
declare variable $operation as xs:string external;
declare variable $sourceBank as xs:string external;
declare variable $destinationBank as xs:string external;
declare variable $parameters as xs:string external;
declare variable $user as xs:string external;
declare variable $state as xs:string external;
declare variable $codeError as xs:string external;
declare variable $messageError as xs:string external;
declare variable $errorFlowName as xs:string external;
declare variable $key as xs:string external;
declare variable $value as xs:string external;
declare variable $body as element(*) external;
declare variable $errorDetails as xs:string external;

declare function local:funcServiceToLog($GlobalId as xs:string, 
                                        $service as xs:string, 
                                        $version as xs:string, 
                                        $channel as xs:string, 
                                        $messageType as xs:string, 
                                        $targetSystem as xs:string, 
                                        $endpoint as xs:string, 
                                        $method as xs:string, 
                                        $operation as xs:string, 
                                        $sourceBank as xs:string, 
                                        $destinationBank as xs:string, 
                                        $parameters as xs:string, 
                                        $user as xs:string, 
                                        $state as xs:string, 
                                        $codeError as xs:string, 
                                        $messageError as xs:string, 
                                        $errorFlowName as xs:string, 
                                        $key as xs:string, 
                                        $value as xs:string, 
                                        $body as element(*),
                                        $errorDetails as xs:string) 
                                        as element() (:: schema-element(ns1:LoggingInput) ::) {
    <ns1:LoggingInput>
        <ns1:GlobalId>{fn:data($GlobalId)}</ns1:GlobalId>
        <ns1:service>{fn:data($service)}</ns1:service>
        <ns1:version>{fn:data($version)}</ns1:version>
        <ns1:channel>{fn:data($channel)}</ns1:channel>
        <ns1:messageType>{fn:data($messageType)}</ns1:messageType>
        <ns1:targetSystem>{fn:data($targetSystem)}</ns1:targetSystem>
        <ns1:endpoint>{fn:data($endpoint)}</ns1:endpoint>
        <ns1:method>{fn:data($method)}</ns1:method>
        <ns1:operation>{fn:data($operation)}</ns1:operation>
        <ns1:sourceBank>{fn:data($sourceBank)}</ns1:sourceBank>
        <ns1:destinationBank>{fn:data($destinationBank)}</ns1:destinationBank>
        <ns1:parameters>{fn-bea:serialize($parameters)}</ns1:parameters>
        <ns1:user>{fn:data($user)}</ns1:user>
        <ns1:state>{fn:data($state)}</ns1:state>
        <ns1:codeError>{fn:data($codeError)}</ns1:codeError>
        <ns1:messageError>{fn:data($messageError)}</ns1:messageError>
        <ns1:errorFlowName>{fn:data($errorFlowName)}</ns1:errorFlowName>
        <ns1:errorDetails>{fn:data($errorDetails)}</ns1:errorDetails>
        <ns1:Timestamp>{fn:substring(fn:string(fn:current-dateTime()),0,20)}</ns1:Timestamp>
        <ns1:details>
            <ns1:key>{fn:data($key)}</ns1:key>
            <ns1:value>{fn:data($value)}</ns1:value>
        </ns1:details>
        <ns1:body>{fn-bea:serialize($body)}</ns1:body>
    </ns1:LoggingInput>
};

local:funcServiceToLog($GlobalId, $service, $version, $channel, $messageType, $targetSystem, $endpoint, $method, $operation, $sourceBank, $destinationBank, $parameters, $user, $state, $codeError, $messageError, $errorFlowName, $key, $value, $body, $errorDetails)
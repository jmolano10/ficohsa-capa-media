xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="http://www.ficohsa.com.hn/middleware.services/commonTypes";
(:: import schema at "../XSD/CommonTypes.xsd" ::)
declare namespace ns1="http://xmlns.oracle.com/pcbpel/adapter/db/sp/GetErrorMessages_BS";
(:: import schema at "../MiddlewareDB/ProviderServices/XSD/GetErrorMessages_BS_sp.xsd" ::)

declare namespace xq="http://www.w3.org/2005/xquery-local-functions";

declare variable $errorMapResponse as element() (:: schema-element(ns1:OutputParameters) ::) external;
declare variable $globalId as xs:string external;
declare variable $errorCode as xs:string external;
declare variable $description as xs:string external;
declare variable $shortDescription as xs:string external;
declare variable $systemId as xs:string external;
declare variable $systemStatus as xs:string external;
declare variable $messageId as xs:string external;
declare variable $messages as xs:string external;
declare variable $code as xs:string external;

declare function xq:Tx_ErrorMap_To_GetAccountDetailsResponse($errorMapResponse as element() (:: schema-element(ns1:OutputParameters) ::), 
                                                             $globalId as xs:string, 
                                                             $errorCode as xs:string, 
                                                             $description as xs:string, 
                                                             $shortDescription as xs:string, 
                                                             $systemId as xs:string, 
                                                             $systemStatus as xs:string, 
                                                             $messageId as xs:string, 
                                                             $code as xs:string,
                                                             $messages as xs:string) 
                                                             as element() (:: schema-element(ns2:ErrorInfo) ::) {
    <ns2:ErrorInfo>
        {
            if ($errorMapResponse/ns1:PN_CODIGO_ERROR_HTTP)
            then <ns2:Code>{fn:data($errorMapResponse/ns1:PN_CODIGO_ERROR_HTTP)}</ns2:Code>
            else ()
        }
        {
            if ($errorMapResponse/ns1:PV_ERROR_MAPEO)
            then <ns2:Error>{fn:data($errorMapResponse/ns1:PV_ERROR_MAPEO)}</ns2:Error>
            else ()
        }
        {
            if ($errorMapResponse/ns1:PV_DESCRIPCION_MAPEO)
            then <ns2:Description>{fn:data($errorMapResponse/ns1:PV_DESCRIPCION_MAPEO)}</ns2:Description>
            else ()
        }
        {
            if ($errorMapResponse/ns1:PV_DESCRIPCION_CORTA_MAPEO)
            then <ns2:ShortDescription>{fn:data($errorMapResponse/ns1:PV_DESCRIPCION_CORTA_MAPEO)}</ns2:ShortDescription>
            else ()
        }
        <ns2:DateTime>{fn:substring(fn:string(fn:current-dateTime()),0,20)}</ns2:DateTime>
        <ns2:GlobalId>{fn:data($globalId)}</ns2:GlobalId>
        <ns2:Details>
            <ns2:SystemId>{fn:data($systemId)}</ns2:SystemId>
            <ns2:SystemStatus>{fn:data($systemStatus)}</ns2:SystemStatus>
            <ns2:MessageId>{fn:data($messageId)}</ns2:MessageId>
            <ns2:Messages>{fn:data($messages)}</ns2:Messages>
        </ns2:Details>
    </ns2:ErrorInfo>
};

xq:Tx_ErrorMap_To_GetAccountDetailsResponse($errorMapResponse, $globalId, $errorCode, $description, $shortDescription, $systemId, $systemStatus, $messageId,$code, $messages)
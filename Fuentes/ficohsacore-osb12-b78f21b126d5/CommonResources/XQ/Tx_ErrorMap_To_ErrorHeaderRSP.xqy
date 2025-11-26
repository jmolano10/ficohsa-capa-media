xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns3="http://www.ficohsa.com.hn/middleware.services/commonTypes";
(:: import schema at "../XSD/CommonTypes.xsd" ::)
declare namespace ns2="http://xmlns.oracle.com/pcbpel/adapter/db/sp/GetErrorMessages_BS";
(:: import schema at "../MiddlewareDB/ProviderServices/XSD/GetErrorMessages_BS_sp.xsd" ::)

declare namespace ns1="http://www.ficohsa.com/midleware.services/tx_ErrorMap_To_ErrorHeaderRSP";

declare variable $errorMapResponse as element() (:: schema-element(ns2:OutputParameters) ::) external;
declare variable $globalId as xs:string external;

declare function ns1:tx_ErrorMap_To_ErrorHeaderRSP($errorMapResponse as element() (:: schema-element(ns2:OutputParameters) ::), 
                                                   $globalId as xs:string) 
                                                   as element() (:: schema-element(ns3:ResponseHeader) ::) {
    <ns3:ResponseHeader>
        <ns3:TransactionId>{fn:data($globalId)}</ns3:TransactionId>
        {
            if ($errorMapResponse/ns2:PV_ERROR_MAPEO)
            then <ns3:MessageId>{fn:data($errorMapResponse/ns2:PV_ERROR_MAPEO)}</ns3:MessageId>
            else ()
        }
        <ns3:SuccessIndicator>Error</ns3:SuccessIndicator>
        {
            if ($errorMapResponse/ns2:PV_DESCRIPCION_MAPEO)
            then <ns3:Messages>{fn:data($errorMapResponse/ns2:PV_DESCRIPCION_MAPEO)}</ns3:Messages>
            else ()
        }
        <ns3:ValueDate>{fn:substring(fn:string(fn:current-dateTime()),0,20)}</ns3:ValueDate>
    </ns3:ResponseHeader>
};

ns1:tx_ErrorMap_To_ErrorHeaderRSP($errorMapResponse, $globalId)
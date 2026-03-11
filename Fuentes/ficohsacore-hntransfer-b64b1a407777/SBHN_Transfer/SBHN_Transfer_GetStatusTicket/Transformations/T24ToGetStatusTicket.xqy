xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="T24WebServicesImpl";
(:: import schema at "../Schemas/ObtenerTicket.xsd" ::)
declare namespace ns2="https://www.ficohsa.com/regional/transfer";
(:: import schema at "../Schemas/GetStatusTicketTypes.xsd" ::)

declare variable $coreResponse as element() (:: schema-element(ns1:getStatusTicketResponse) ::) external;
declare variable $globalId as xs:string external;

declare function local:funcT24ToGetStatusTicket($coreResponse as element() (:: schema-element(ns1:getStatusTicketResponse) ::),
                                                $globalId as xs:string) as element() (:: schema-element(ns2:getStatusTicketResponse) ::) {
    <ns2:getStatusTicketResponse>
        <StatusInfo>
            {
                if ($coreResponse/Status/successIndicator)
                then <Status>{fn:data($coreResponse/Status/successIndicator)}</Status>
                else ()
            }
            <ValueDate>{fn:substring(fn:string(fn:current-dateTime()),0,11)}</ValueDate>
            <DateTime>{fn:substring(fn:string(fn:current-dateTime()),0,20)}</DateTime>
            <GlobalId>{fn:data($globalId)}</GlobalId>
        </StatusInfo>
        <IdTicket>{fn:data($coreResponse/FICOTRACKINGNUMBERWSType/gFICOTRACKINGNUMBERWSDetailType/mFICOTRACKINGNUMBERWSDetailType/ID)}</IdTicket>
        <Status>{fn:data($coreResponse/FICOTRACKINGNUMBERWSType/gFICOTRACKINGNUMBERWSDetailType/mFICOTRACKINGNUMBERWSDetailType/STATUS)}</Status>
        <ReferenceControl>{fn:data($coreResponse/FICOTRACKINGNUMBERWSType/gFICOTRACKINGNUMBERWSDetailType/mFICOTRACKINGNUMBERWSDetailType/REFCONTROL)}</ReferenceControl>
        <Date>{fn:data($coreResponse/FICOTRACKINGNUMBERWSType/gFICOTRACKINGNUMBERWSDetailType/mFICOTRACKINGNUMBERWSDetailType/REGDATE)}</Date>
    </ns2:getStatusTicketResponse>
};

local:funcT24ToGetStatusTicket($coreResponse, $globalId)

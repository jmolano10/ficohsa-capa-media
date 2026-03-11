xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="T24WebServicesImpl";
(:: import schema at "../Schemas/ObtenerTicket.xsd" ::)
declare namespace ns2="https://www.ficohsa.com/regional/transfer";
(:: import schema at "../Schemas/GetTicketTypes.xsd" ::)

declare variable $coreResponse as element() (:: schema-element(ns1:getTicketResponse) ::) external;
declare variable $globalId as xs:string external;

declare function local:funcT24ToGetTicket($coreResponse as element() (:: schema-element(ns1:getTicketResponse) ::),
                                          $globalId as xs:string) as element() (:: schema-element(ns2:getTicketResponse) ::) {
    <ns2:getTicketResponse>
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
        <IdTicket>{fn:data($coreResponse/WSQRYTICKETType/gWSQRYTICKETDetailType/mWSQRYTICKETDetailType/TICKET)}</IdTicket>
        <ReferenceControl>{fn:data($coreResponse/WSQRYTICKETType/gWSQRYTICKETDetailType/mWSQRYTICKETDetailType/FT)}</ReferenceControl>
        <Date>{fn:data($coreResponse/WSQRYTICKETType/gWSQRYTICKETDetailType/mWSQRYTICKETDetailType/DATE)}</Date>
    </ns2:getTicketResponse>
};

local:funcT24ToGetTicket($coreResponse, $globalId)

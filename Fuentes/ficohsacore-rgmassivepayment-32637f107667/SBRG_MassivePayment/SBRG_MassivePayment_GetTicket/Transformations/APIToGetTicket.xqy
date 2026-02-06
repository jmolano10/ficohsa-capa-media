xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="https://www.ficohsa.com/regional/massivePayment/apiPagosMasivosTypes";
(:: import schema at "../../SBRG_MassivePayment_Commons/Schemas/APIPagosMasivosTypes.xsd" ::)
declare namespace ns2="https://www.ficohsa.com/regional/massivePayment";
(:: import schema at "../Schemas/GetTicketTypes.xsd" ::)

declare variable $responseService as element() (:: schema-element(ns1:ObtenerTicketResponse) ::) external;
declare variable $globalId as xs:string external;

declare function local:func(
    $responseService as element() (:: schema-element(ns1:ObtenerTicketResponse) ::),
    $globalId as xs:string
    ) as element() (:: schema-element(ns2:getTicketResponse) ::) {
    <ns2:getTicketResponse>
        <StatusInfo>
            <Status>Success</Status>
            <ValueDate>{fn:substring(fn:string(fn:current-dateTime()),0,11)}</ValueDate>
            <DateTime>{fn:substring(fn:string(fn:current-dateTime()),0,20)}</DateTime>
            <GlobalId>{fn:data($globalId)}</GlobalId>
        </StatusInfo>
        <Ticket>{fn:data($responseService/numeroTicket)}</Ticket>
    </ns2:getTicketResponse>
};

local:func($responseService, $globalId)
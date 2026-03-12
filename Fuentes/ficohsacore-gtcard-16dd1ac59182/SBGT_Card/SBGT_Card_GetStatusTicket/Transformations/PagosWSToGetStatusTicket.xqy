xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://xmlns.oracle.com/pcbpel/adapter/db/sp/DBGetStatusTicketAdapter";
(:: import schema at "../Schemas/DBGetStatusTicketAdapter_sp.xsd" ::)
declare namespace ns2="https://www.ficohsa.com/regional/card";
(:: import schema at "../Schemas/GetStatusTicketTypes.xsd" ::)

declare variable $PagosWS as element() (:: schema-element(ns1:OutputParameters) ::) external;
declare variable $globalId as xs:string external;
declare function local:funcPagosWSToGetStatusTicket($PagosWS as element() (:: schema-element(ns1:OutputParameters) ::),
                                                    $globalId as xs:string) as element() (:: schema-element(ns2:getStatusTicketResponse) ::) {
    <ns2:getStatusTicketResponse>
        <StatusInfo>
        {
                if ($PagosWS/PV_SUCCESSINDICATOR)
                then <Status>{fn:data($PagosWS/PV_SUCCESSINDICATOR)}</Status>
                else ()
            }
            <ValueDate>{fn:substring(fn:string(fn:current-dateTime()),0,11)}</ValueDate>
            <DateTime>{fn:substring(fn:string(fn:current-dateTime()),0,20)}</DateTime>
            <GlobalId>{fn:data($globalId)}</GlobalId>
        </StatusInfo>
        <ns2:Status>{fn:data($PagosWS/PV_ESTADO_TICKET)}</ns2:Status>
    </ns2:getStatusTicketResponse>
};

local:funcPagosWSToGetStatusTicket($PagosWS, $globalId)
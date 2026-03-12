xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="http://xmlns.oracle.com/pcbpel/adapter/db/sp/DBConsultaTicketAdapter";
(:: import schema at "../Schemas/DBConsultaTicketAdapter_sp.xsd" ::)
declare namespace ns1="https://www.ficohsa.com/regional/card";
(:: import schema at "../Schemas/GetStatusTicketTypes.xsd" ::)

declare variable $input as element() (:: schema-element(ns1:getStatusTicket) ::) external;

declare function local:funcGetStatusTransferToConsultaTicket($input as element() (:: schema-element(ns1:getStatusTicket) ::)) as element() (:: schema-element(ns2:InputParameters) ::) {
    <ns2:InputParameters>
        <ns2:PV_TICKET>{fn:data($input/Ticket)}</ns2:PV_TICKET>
    </ns2:InputParameters>
};

local:funcGetStatusTransferToConsultaTicket($input)
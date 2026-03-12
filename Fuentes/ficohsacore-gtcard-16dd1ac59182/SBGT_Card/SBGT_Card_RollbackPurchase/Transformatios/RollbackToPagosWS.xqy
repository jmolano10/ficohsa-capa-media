xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="http://xmlns.oracle.com/pcbpel/adapter/db/sp/DBGetStatusTicketAdapter";
(:: import schema at "../Schemas/DBGetStatusTicketAdapter_sp.xsd" ::)
declare namespace ns1="https://www.ficohsa.com/regional/card";
(:: import schema at "../Schemas/RollbackPurchaseTypes.xsd" ::)

declare variable $Rollback as element() (:: schema-element(ns1:getStatusTicket) ::) external;

declare function local:funcRollbackToPagosWS($Rollback as element() (:: schema-element(ns1:getStatusTicket) ::)) as element() (:: schema-element(ns2:InputParameters) ::) {
    <ns2:InputParameters>
        <PV_TICKET>{fn:data($Rollback/Ticket)}</PV_TICKET>
    </ns2:InputParameters>
};

local:funcRollbackToPagosWS($Rollback)
xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="http://xmlns.oracle.com/pcbpel/adapter/db/sp/DBActTicketAdapter";
(:: import schema at "../Schemas/DBActTicketAdapter_sp.xsd" ::)
declare namespace ns1="https://www.ficohsa.com/regional/card";
(:: import schema at "../Schemas/RollbackPurchaseTypes.xsd" ::)

declare variable $RollbackPurchase as element() (:: schema-element(ns1:getStatusTicket) ::) external;
declare variable $statusTicket as xs:string external;

declare function local:funcRollbackPurchaseToActTicket($RollbackPurchase as element() (:: schema-element(ns1:getStatusTicket) ::),
                                                $statusTicket as xs:string) as element() (:: schema-element(ns2:InputParameters) ::) {
    <ns2:InputParameters>
        <PV_TICKET>{fn:data($RollbackPurchase/Ticket)}</PV_TICKET>
        <PV_ESTADO_TICKET>{fn:data($statusTicket)}</PV_ESTADO_TICKET>
    </ns2:InputParameters>
};

local:funcRollbackPurchaseToActTicket($RollbackPurchase, $statusTicket)
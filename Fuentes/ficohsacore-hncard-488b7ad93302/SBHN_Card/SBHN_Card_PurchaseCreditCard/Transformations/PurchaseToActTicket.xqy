xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="http://xmlns.oracle.com/pcbpel/adapter/db/sp/DBActBrokerTicketAdapter";
(:: import schema at "../Schemas/DBActBrokerTicketAdapter_sp.xsd" ::)
declare namespace ns1="https://www.ficohsa.com/regional/card";
(:: import schema at "../Schemas/PurchaseCreditCardTypes.xsd" ::)

declare variable $input as element() (:: schema-element(ns1:purchaseCreditCard) ::) external;
declare variable $statusTicket as xs:string external;

declare function local:funcPurchaseToActTicket($input as element() (:: schema-element(ns1:purchaseCreditCard) ::),
                                              $statusTicket as xs:string) as element() (:: schema-element(ns2:InputParameters) ::) {
    <ns2:InputParameters>
        <ns2:PV_TICKET>{fn:data($input/Ticket)}</ns2:PV_TICKET>
        <ns2:PV_ESTADO_TICKET>{fn:data($statusTicket)}</ns2:PV_ESTADO_TICKET>
    </ns2:InputParameters>
};

local:funcPurchaseToActTicket($input, $statusTicket)
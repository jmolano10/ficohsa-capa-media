xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="http://xmlns.oracle.com/pcbpel/adapter/db/sp/DBActTicketAdapter";
(:: import schema at "../Schemas/DBActTicketAdapter_sp.xsd" ::)
declare namespace ns1="https://www.ficohsa.com/regional/card";
(:: import schema at "../Schemas/PurchaseCreditCardTypes.xsd" ::)

declare variable $PurchaseCreditCard as element() (:: schema-element(ns1:purchaseCreditCard) ::) external;
declare variable $statusTicket as xs:string external;
declare variable $numeroAutorizacion as xs:string external;

declare function local:funcPurchaseToActTicket($PurchaseCreditCard as element() (:: schema-element(ns1:purchaseCreditCard) ::),
                                                $statusTicket as xs:string,
                                                $numeroAutorizacion as xs:string) as element() (:: schema-element(ns2:InputParameters) ::) {
    <ns2:InputParameters>
        <PV_TICKET>{fn:data($PurchaseCreditCard/Ticket)}</PV_TICKET>
        <PV_ESTADO_TICKET>{fn:data($statusTicket)}</PV_ESTADO_TICKET>
        <PV_NUMEROAUTORIZACION>{fn:data($numeroAutorizacion)}</PV_NUMEROAUTORIZACION>
    </ns2:InputParameters>
};

local:funcPurchaseToActTicket($PurchaseCreditCard,$statusTicket,$numeroAutorizacion)
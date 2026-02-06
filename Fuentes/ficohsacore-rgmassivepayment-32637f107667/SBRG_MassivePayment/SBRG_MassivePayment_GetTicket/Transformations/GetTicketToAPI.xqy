xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="https://www.ficohsa.com/regional/massivePayment/apiPagosMasivosTypes";
(:: import schema at "../../SBRG_MassivePayment_Commons/Schemas/APIPagosMasivosTypes.xsd" ::)
declare namespace ns1="https://www.ficohsa.com/regional/massivePayment";
(:: import schema at "../Schemas/GetTicketTypes.xsd" ::)

declare variable $getTicket as element() (:: schema-element(ns1:getTicket) ::) external;

declare function local:func(
    $getTicket as element() (:: schema-element(ns1:getTicket) ::)
    ) as element() (:: schema-element(ns2:ObtenerTicket) ::) {
    <ns2:ObtenerTicket>
        <requestHeader>
            <sourceBank>{fn:data($getTicket/GeneralInfo/SourceBank)}</sourceBank>
            <destinationBank>{fn:data($getTicket/GeneralInfo/DestinationBank)}</destinationBank>
            <customerId>{fn:data($getTicket/CustomerId)}</customerId>
            <userName>{fn:data($getTicket/GeneralInfo/ApplicationId)}</userName>
        </requestHeader>
    </ns2:ObtenerTicket>
};

local:func($getTicket)
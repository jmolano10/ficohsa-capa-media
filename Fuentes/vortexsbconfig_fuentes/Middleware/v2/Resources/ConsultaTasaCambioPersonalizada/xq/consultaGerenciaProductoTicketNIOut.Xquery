<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$opConsultaTicketRespuesta1" element="ns2:opConsultaTicketRespuesta" location="../../../BusinessServices/CTS/gerenciaProductoTicket/xsd/services.xsd" ::)
(:: pragma bea:global-element-return element="ns4:consultaTasaCambioPersonalizadaResponse" location="../xsd/consultaTasaCambioPersonalizadaTypes.xsd" ::)

declare namespace ns2 = "http://service.srvaplcobisticket.ecobis.cobiscorp";
declare namespace ns1 = "http://dto.srvaplcobisentidades.ecobis.cobiscorp";
declare namespace ns4 = "http://www.ficohsa.com.hn/middleware.services/consultaTasaCambioPersonalizadaTypes";
declare namespace ns3 = "http://dto2.commons.ecobis.cobiscorp";
declare namespace ns0 = "http://dto2.sdf.cts.cobis.cobiscorp.com";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaTasaCambioPersonalizada/xq/ConsultaTasaCambioPersonalizadaNIOut/";

declare function xf:ConsultaTasaCambioPersonalizadaNIOut($opConsultaTicketRespuesta1 as element(ns2:opConsultaTicketRespuesta))
    as element(ns4:consultaTasaCambioPersonalizadaResponse) {
        <ns4:consultaTasaCambioPersonalizadaResponse>
            <ns4:BUY_RATE>{ (xs:decimal($opConsultaTicketRespuesta1/ns1:tasaCambio)) }</ns4:BUY_RATE>
            <ns4:SELL_RATE>{ (xs:decimal($opConsultaTicketRespuesta1/ns1:tasaCambio)) }</ns4:SELL_RATE>
        </ns4:consultaTasaCambioPersonalizadaResponse>
};

declare variable $opConsultaTicketRespuesta1 as element(ns2:opConsultaTicketRespuesta) external;

xf:ConsultaTasaCambioPersonalizadaNIOut($opConsultaTicketRespuesta1)]]></con:xquery>
    <con:dependency location="../../../BusinessServices/CTS/gerenciaProductoTicket/xsd/services.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/CTS/gerenciaProductoTicket/xsd/services"/>
    </con:dependency>
    <con:dependency location="../xsd/consultaTasaCambioPersonalizadaTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/ConsultaTasaCambioPersonalizada/xsd/consultaTasaCambioPersonalizadaTypes"/>
    </con:dependency>
</con:xqueryEntry>
(:: pragma bea:global-element-parameter parameter="$consultaTasaCambioPersonalizada1" element="ns2:consultaTasaCambioPersonalizada" location="../xsd/consultaTasaCambioPersonalizadaTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:opConsultaTicketSolicitud" location="../../../BusinessServices/CTS/gerenciaProductoTicket/xsd/services.xsd" ::)

declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/consultaTasaCambioPersonalizadaTypes";
declare namespace ns1 = "http://service.srvaplcobisticket.ecobis.cobiscorp";
declare namespace ns0 = "http://dto.srvaplcobisentidades.ecobis.cobiscorp";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaTasaCambioPersonalizada/xq/consultaTasaCambioPersonalizadaNI_GerenciaProductoTicket/";

declare function xf:consultaTasaCambioPersonalizadaNI_GerenciaProductoTicket($consultaTasaCambioPersonalizada1 as element(ns2:consultaTasaCambioPersonalizada))
    as element(ns1:opConsultaTicketSolicitud) {
        <ns1:opConsultaTicketSolicitud>
            <ns0:contextoTransaccional>
                <ns0:codCanalOriginador>{ xs:int($consultaTasaCambioPersonalizada1/ns2:TRANSACTION_INFORMATION/ns2:CHANNEL) }</ns0:codCanalOriginador>
            </ns0:contextoTransaccional>
            <ns0:canal>{ xs:int($consultaTasaCambioPersonalizada1/ns2:TRANSACTION_INFORMATION/ns2:CHANNEL) }</ns0:canal>
            <ns0:operacion>V</ns0:operacion>
            <ns0:codigoTicket>{ data($consultaTasaCambioPersonalizada1/ns2:RATE_INFORMATION/ns2:AUTHORIZATION_TICKET) }</ns0:codigoTicket>
            <ns0:monedaOrg>{ data($consultaTasaCambioPersonalizada1/ns2:RATE_INFORMATION/ns2:SOURCE_CURRENCY) }</ns0:monedaOrg>
            <ns0:monedaDst>{ data($consultaTasaCambioPersonalizada1/ns2:RATE_INFORMATION/ns2:TARGET_CURRENCY) }</ns0:monedaDst>
            <ns0:cuentaOrg>{ data($consultaTasaCambioPersonalizada1/ns2:ACCOUNT/ns2:DEBIT_ACCOUNT) }</ns0:cuentaOrg>
            <ns0:cuentaDst>{ data($consultaTasaCambioPersonalizada1/ns2:ACCOUNT/ns2:CREDIT_ACCOUNT) }</ns0:cuentaDst>
            <ns0:montoTran>{ data($consultaTasaCambioPersonalizada1/ns2:TRANSACTION_INFORMATION/ns2:AMOUNT) }</ns0:montoTran>
            <ns0:monedaTran>{ data($consultaTasaCambioPersonalizada1/ns2:RATE_INFORMATION/ns2:TRANSACTION_CURRENCY) }</ns0:monedaTran>
        </ns1:opConsultaTicketSolicitud>
};

declare variable $consultaTasaCambioPersonalizada1 as element(ns2:consultaTasaCambioPersonalizada) external;

xf:consultaTasaCambioPersonalizadaNI_GerenciaProductoTicket($consultaTasaCambioPersonalizada1)
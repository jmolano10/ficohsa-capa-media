(:: pragma bea:global-element-parameter parameter="$sjConsultaTipoTarjeta" element="ns2:sjConsultaTipoTarjeta" location="../xsd/sjConsultaTipoTarjetaNI.xsd" ::)
(:: pragma bea:global-element-return element="ns0:opConsultaTarjetaDebitoSolicitud" location="../../../CTS/ConsultaDatosTarjetaDebito/xsd/services.xsd" ::)

declare namespace ns0 = "http://service.srvaplcobistarjetadebito.ecobis.cobiscorp";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/sjConsultaTipoTarjetaNI";
declare namespace ns1 = "http://dto.srvaplcobistarjetadebito.ecobis.cobiscorp";
declare namespace xf = "http://tempuri.org/Middleware/v2/BusinessServices/SJS/consultaTipoTarjetaNI/xq/sjOpConsultaTarjetaDebitoNIIn/";

declare function xf:sjOpConsultaTarjetaDebitoNIIn($sjConsultaTipoTarjeta as element(ns2:sjConsultaTipoTarjeta))
    as element(ns0:opConsultaTarjetaDebitoSolicitud) {
        <ns0:opConsultaTarjetaDebitoSolicitud>
            <ns1:contextoTransaccional>
                <ns1:codCanalOriginador>1</ns1:codCanalOriginador>
            </ns1:contextoTransaccional>
            <ns1:tarjetaDebito>{ data($sjConsultaTipoTarjeta/ns2:CARD_NUMBER) }</ns1:tarjetaDebito>
        </ns0:opConsultaTarjetaDebitoSolicitud>
};

declare variable $sjConsultaTipoTarjeta as element(ns2:sjConsultaTipoTarjeta) external;

xf:sjOpConsultaTarjetaDebitoNIIn($sjConsultaTipoTarjeta)
xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaSaldosTarjetaCredito" element="ns0:consultaSaldosTarjetaCredito" location="../../../../Business_Resources/tarjetaCredito/ConsultaSaldosTarjetaCredito/consultaSaldosTarjetaCreditoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns2:opConsultaSaldosTarjetaCreditoSolicitud" location="../../../BusinessServices/CTS/tarjetaCredito/xsd/services.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaSaldosTarjetaCreditoTypes";
declare namespace ns2 = "http://service.srvaplcobistarjetacredito.ecobis.cobiscorp";
declare namespace ns1 = "http://dto.srvaplcobisentidades.ecobis.cobiscorp";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaSaldosTarjetaCredito/xq/consultaSaldoTCNIIn/";

declare function xf:consultaSaldoTCNIIn($consultaSaldosTarjetaCredito as element(ns0:consultaSaldosTarjetaCredito))
    as element(ns2:opConsultaSaldosTarjetaCreditoSolicitud) {
        <ns2:opConsultaSaldosTarjetaCreditoSolicitud>
            <ns1:contextoTransaccional>
                <ns1:codCanalOriginador>1</ns1:codCanalOriginador>
            </ns1:contextoTransaccional>
            <ns1:valTarjetaCredito>
                <ns1:valNumeroTC>
                    <ns1:codTipoProducto>{ data($consultaSaldosTarjetaCredito/CARD_NUMBER) }</ns1:codTipoProducto>
                </ns1:valNumeroTC>
            </ns1:valTarjetaCredito>
        </ns2:opConsultaSaldosTarjetaCreditoSolicitud>
};

declare variable $consultaSaldosTarjetaCredito as element(ns0:consultaSaldosTarjetaCredito) external;

xf:consultaSaldoTCNIIn($consultaSaldosTarjetaCredito)
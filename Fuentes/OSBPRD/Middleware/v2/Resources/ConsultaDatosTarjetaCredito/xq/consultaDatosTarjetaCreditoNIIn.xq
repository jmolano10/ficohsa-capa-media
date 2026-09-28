(:: pragma bea:global-element-parameter parameter="$consultaDatosTarjetaCredito" element="ns1:consultaDatosTarjetaCredito" location="../../../../Business_Resources/tarjetaCredito/ConsultaDatosTarjetaCredito/consultaDatosTarjetaCreditoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns2:opConsultaDatosTarjetaCreditoSolicitud" location="../../../BusinessServices/CTS/tarjetaCredito/xsd/services.xsd" ::)

declare namespace ns0 = "http://dto.srvaplcobisentidades.ecobis.cobiscorp";
declare namespace ns2 = "http://service.srvaplcobistarjetacredito.ecobis.cobiscorp";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaDatosTarjetaCreditoTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaDatosTarjetaCredito/xq/consultaDatosTarjetaCreditoNIIn/";

declare function xf:consultaDatosTarjetaCreditoNIIn($consultaDatosTarjetaCredito as element(ns1:consultaDatosTarjetaCredito))
    as element(ns2:opConsultaDatosTarjetaCreditoSolicitud) {
        <ns2:opConsultaDatosTarjetaCreditoSolicitud>
            <ns0:contextoTransaccional>
                <ns0:codCanalOriginador>1</ns0:codCanalOriginador>
            </ns0:contextoTransaccional>
            <ns0:tarjetaCredito>
                <ns0:valNumeroTC>
                    <ns0:codTipoProducto>{ data($consultaDatosTarjetaCredito/CARD_NUMBER) }</ns0:codTipoProducto>
                </ns0:valNumeroTC>
            </ns0:tarjetaCredito>
        </ns2:opConsultaDatosTarjetaCreditoSolicitud>
};

declare variable $consultaDatosTarjetaCredito as element(ns1:consultaDatosTarjetaCredito) external;

xf:consultaDatosTarjetaCreditoNIIn($consultaDatosTarjetaCredito)
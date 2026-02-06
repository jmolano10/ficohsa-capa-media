xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaDetalleBloqueosTD1" element="ns2:consultaDetalleBloqueosTD" location="../../../../Business_Resources/tarjetasDebito/ConsultaDetalleBloqueosTD/consultaDetalleBloqueosTDTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:opConsultaFlotanteSolicitud" location="../../../BusinessServices/CTS/cuenta/xsd/services.xsd" ::)

declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/consultaDetalleBloqueosTDTypes";
declare namespace ns1 = "http://service.srvaplcobiscuenta.ecobis.cobiscorp";
declare namespace ns0 = "http://dto.srvaplcobisentidades.ecobis.cobiscorp";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaDetalleBloqueosTD/xq/consultaDetalleBloqueosTDNIIn/";

declare function xf:consultaDetalleBloqueosTDNIIn($consultaDetalleBloqueosTD1 as element(ns2:consultaDetalleBloqueosTD))
    as element(ns1:opConsultaFlotanteSolicitud) {
        <ns1:opConsultaFlotanteSolicitud>
            <ns0:contextoTransaccional>
                <ns0:codCanalOriginador>1</ns0:codCanalOriginador>
            </ns0:contextoTransaccional>
            <ns0:cuenta>
                <ns0:codCuentaHabiente>{ data($consultaDetalleBloqueosTD1/ACCOUNT_NUMBER) }</ns0:codCuentaHabiente>
            </ns0:cuenta>
        </ns1:opConsultaFlotanteSolicitud>
};

declare variable $consultaDetalleBloqueosTD1 as element(ns2:consultaDetalleBloqueosTD) external;

xf:consultaDetalleBloqueosTDNIIn($consultaDetalleBloqueosTD1)
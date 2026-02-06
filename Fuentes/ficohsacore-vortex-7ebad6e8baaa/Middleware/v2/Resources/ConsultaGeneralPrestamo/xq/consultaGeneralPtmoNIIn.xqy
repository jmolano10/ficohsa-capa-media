xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaGeneralPrestamo" element="ns1:consultaGeneralPrestamo" location="../xsd/consultaGeneralPrestamoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns2:opConsultaPrestamoSolicitud" location="../../../BusinessServices/CTS/prestamo/xsd/services.xsd" ::)

declare namespace ns2 = "http://service.srvaplcobisprestamo.ecobis.cobiscorp";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaGeneralPrestamoTypes";
declare namespace ns0 = "http://dto.srvaplcobisentidades.ecobis.cobiscorp";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaGeneralPrestamo/xq/consultaGeneralPtmoNIIn/";

declare function xf:consultaGeneralPtmoNIIn($consultaGeneralPrestamo as element(ns1:consultaGeneralPrestamo))
    as element(ns2:opConsultaPrestamoSolicitud) {
        <ns2:opConsultaPrestamoSolicitud>
            <ns0:prestamo>
                <ns0:producto>
                    <ns0:valNumeroProducto>{ data($consultaGeneralPrestamo/LOAN_ID) }</ns0:valNumeroProducto>
                </ns0:producto>
            </ns0:prestamo>
            <ns0:contextoTransaccional>
                <ns0:codCanalOriginador>1</ns0:codCanalOriginador>
            </ns0:contextoTransaccional>
        </ns2:opConsultaPrestamoSolicitud>
};

declare variable $consultaGeneralPrestamo as element(ns1:consultaGeneralPrestamo) external;

xf:consultaGeneralPtmoNIIn($consultaGeneralPrestamo)
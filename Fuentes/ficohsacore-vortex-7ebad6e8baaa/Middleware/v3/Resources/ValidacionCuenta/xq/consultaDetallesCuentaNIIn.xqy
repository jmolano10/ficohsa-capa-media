xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$validacionCuenta" element="ns2:validacionCuenta" location="../xsd/validacionCuentaType.xsd" ::)
(:: pragma bea:global-element-return element="ns0:opConsultaDetalleCuentaSolicitud" location="../../../../v2/BusinessServices/CTS/cuenta/xsd/services.xsd" ::)

declare namespace ns0 = "http://service.srvaplcobiscuenta.ecobis.cobiscorp";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/validacionCuentaType";
declare namespace ns1 = "http://dto.srvaplcobisentidades.ecobis.cobiscorp";
declare namespace xf = "http://tempuri.org/Middleware/v3/Resources/ValidacionCuenta/xq/consultaDetallesCuentaNIIn/";

declare function xf:consultaDetallesCuentaNIIn($validacionCuenta as element(ns2:validacionCuenta))
    as element(ns0:opConsultaDetalleCuentaSolicitud) {
        <ns0:opConsultaDetalleCuentaSolicitud>
            <ns1:contextoTransaccional>
                <ns1:codCanalOriginador>1</ns1:codCanalOriginador>
            </ns1:contextoTransaccional>
            <ns1:numCuenta>
                <ns1:codCuentaHabiente>{ data($validacionCuenta/ACCOUNT_NUMBER) }</ns1:codCuentaHabiente>
            </ns1:numCuenta>
        </ns0:opConsultaDetalleCuentaSolicitud>
};

declare variable $validacionCuenta as element(ns2:validacionCuenta) external;

xf:consultaDetallesCuentaNIIn($validacionCuenta)
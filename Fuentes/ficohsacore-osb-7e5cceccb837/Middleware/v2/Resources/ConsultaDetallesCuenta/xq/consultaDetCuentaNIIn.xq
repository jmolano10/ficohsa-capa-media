(:: pragma bea:global-element-parameter parameter="$consultaDetallesCuenta1" element="ns1:consultaDetallesCuenta" location="../xsd/consultaDetallesCuentaTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns2:opConsultaDetalleCuentaSolicitud" location="../../../BusinessServices/CTS/cuenta/xsd/services.xsd" ::)

declare namespace ns2 = "http://service.srvaplcobiscuenta.ecobis.cobiscorp";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultasType";
declare namespace ns0 = "http://dto.srvaplcobisentidades.ecobis.cobiscorp";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaDetallesCuenta/xq/consultaDetCuentaNIIn1/";

declare function xf:consultaDetCuentaNIIn1($consultaDetallesCuenta1 as element(ns1:consultaDetallesCuenta))
    as element(ns2:opConsultaDetalleCuentaSolicitud) {
        <ns2:opConsultaDetalleCuentaSolicitud>
            <ns0:contextoTransaccional>
                <ns0:codCanalOriginador>1</ns0:codCanalOriginador>
            </ns0:contextoTransaccional>
            <ns0:numCuenta>
                <ns0:codCuentaHabiente>{ data($consultaDetallesCuenta1/ACCOUNT_NUMBER) }</ns0:codCuentaHabiente>
            </ns0:numCuenta>
        </ns2:opConsultaDetalleCuentaSolicitud>
};

declare variable $consultaDetallesCuenta1 as element(ns1:consultaDetallesCuenta) external;

xf:consultaDetCuentaNIIn1($consultaDetallesCuenta1)
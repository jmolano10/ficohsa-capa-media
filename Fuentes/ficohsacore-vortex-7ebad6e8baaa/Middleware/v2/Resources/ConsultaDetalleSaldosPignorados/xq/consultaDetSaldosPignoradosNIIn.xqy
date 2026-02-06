xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaDetalleSaldosPignorados1" element="ns2:consultaDetalleSaldosPignorados" location="../xsd/consultaDetalleSaldosPignoradosTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:opBuscarSaldoReservadoSolicitud" location="../../../BusinessServices/CTS/cuenta/xsd/services.xsd" ::)

declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/consultaDetalleSaldosPignoradosTypes";
declare namespace ns1 = "http://service.srvaplcobiscuenta.ecobis.cobiscorp";
declare namespace ns0 = "http://dto.srvaplcobisentidades.ecobis.cobiscorp";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaDetalleSaldosPignorados/xq/consultaDetSaldosPignoradosNIIn/";

declare function xf:consultaDetSaldosPignoradosNIIn($consultaDetalleSaldosPignorados1 as element(ns2:consultaDetalleSaldosPignorados))
    as element(ns1:opBuscarSaldoReservadoSolicitud) {
        <ns1:opBuscarSaldoReservadoSolicitud>
            <ns0:contextoTransaccional>
                <ns0:codCanalOriginador>1</ns0:codCanalOriginador>
            </ns0:contextoTransaccional>
            <ns0:numCuenta>
                <ns0:codCuentaHabiente>{ data($consultaDetalleSaldosPignorados1/ACCOUNT_NUMBER) }</ns0:codCuentaHabiente>
            </ns0:numCuenta>
            <ns0:consecutivo>
                <ns0:valUltimoRegistroEntero>0</ns0:valUltimoRegistroEntero>
            </ns0:consecutivo>
        </ns1:opBuscarSaldoReservadoSolicitud>
};

declare variable $consultaDetalleSaldosPignorados1 as element(ns2:consultaDetalleSaldosPignorados) external;

xf:consultaDetSaldosPignoradosNIIn($consultaDetalleSaldosPignorados1)
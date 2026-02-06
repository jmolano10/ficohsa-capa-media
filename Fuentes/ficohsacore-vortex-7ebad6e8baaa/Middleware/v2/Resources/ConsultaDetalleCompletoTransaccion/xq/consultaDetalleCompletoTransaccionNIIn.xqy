xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaDetalleCompletoTransaccion" element="ns0:consultaDetalleCompletoTransaccion" location="../xsd/consultaDetalleCompletoTransaccionTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns2:opConsultarDetalleTransaccionSolicitud" location="../../../BusinessServices/CTS/transacciones/xsd/services.xsd" ::)

declare namespace ns2 = "http://service.srvaplcobistransacciones.ecobis.cobiscorp";
declare namespace ns1 = "http://dto.srvaplcobisentidades.ecobis.cobiscorp";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaDetalleCompletoTransaccionTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaDetalleCompletoTransaccion/xq/consultaDetalleCompletoTransaccionNIIn/";

declare function xf:consultaDetalleCompletoTransaccionNIIn($consultaDetalleCompletoTransaccion as element(ns0:consultaDetalleCompletoTransaccion))
    as element(ns2:opConsultarDetalleTransaccionSolicitud) {
        <ns2:opConsultarDetalleTransaccionSolicitud>
            <ns1:contextoTransaccional>
                <ns1:codCanalOriginador>1</ns1:codCanalOriginador>
            </ns1:contextoTransaccional>
            <ns1:transaccion>
                <ns1:cuentaDebito>
                    {
                        for $ACCOUNT_NUMBER in $consultaDetalleCompletoTransaccion/ACCOUNT_NUMBER
                        return
                            <ns1:codCuentaHabiente>{ data($ACCOUNT_NUMBER) }</ns1:codCuentaHabiente>
                    }
                </ns1:cuentaDebito>
                <ns1:valNumAprobacionCore>{ data($consultaDetalleCompletoTransaccion/TRANSACTION_REFERENCE) }</ns1:valNumAprobacionCore>
            </ns1:transaccion>
        </ns2:opConsultarDetalleTransaccionSolicitud>
};

declare variable $consultaDetalleCompletoTransaccion as element(ns0:consultaDetalleCompletoTransaccion) external;

xf:consultaDetalleCompletoTransaccionNIIn($consultaDetalleCompletoTransaccion)
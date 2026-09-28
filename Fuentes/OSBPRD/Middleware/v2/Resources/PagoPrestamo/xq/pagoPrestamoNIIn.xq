(:: pragma bea:global-element-parameter parameter="$pagoPrestamo" element="ns1:pagoPrestamo" location="../xsd/pagoPrestamoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns2:opPagarPrestamoSolicitud" location="../../../BusinessServices/CTS/prestamo/xsd/services.xsd" ::)

declare namespace ns2 = "http://service.srvaplcobisprestamo.ecobis.cobiscorp";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/pagoPrestamoTypes";
declare namespace ns0 = "http://dto.srvaplcobisentidades.ecobis.cobiscorp";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/PagoPrestamo/xq/pagoPrestamoNIIn/";

declare function xf:pagoPrestamoNIIn($pagoPrestamo as element(ns1:pagoPrestamo))
    as element(ns2:opPagarPrestamoSolicitud) {
        <ns2:opPagarPrestamoSolicitud>
            <ns0:contextoTransaccional>
                {
                    for $INTERFACE_REFERENCE_NO in $pagoPrestamo/INTERFACE_REFERENCE_NO
                    return
                        <ns0:identificadorTransaccional>{ data($INTERFACE_REFERENCE_NO) }</ns0:identificadorTransaccional>
                }
                <ns0:codCanalOriginador>1</ns0:codCanalOriginador>
                <ns0:ipConsumidor>OMNICANAL</ns0:ipConsumidor>
            </ns0:contextoTransaccional>
            <ns0:transaccion>
                <ns0:valMonto>{ data($pagoPrestamo/PAYMENT_AMOUNT) }</ns0:valMonto>
            </ns0:transaccion>
            <ns0:prestamo>
                <ns0:producto>
                    <ns0:valNumeroProducto>{ data($pagoPrestamo/LOAN_NUMBER) }</ns0:valNumeroProducto>
                </ns0:producto>
            </ns0:prestamo>
            <ns0:cuenta>
                {
                    for $DEBIT_ACCOUNT in $pagoPrestamo/DEBIT_ACCOUNT
                    return
                        <ns0:codCuentaHabiente>{ data($DEBIT_ACCOUNT) }</ns0:codCuentaHabiente>
                }
            </ns0:cuenta>
            <ns0:oficina>
                <ns0:codOficina>1</ns0:codOficina>
            </ns0:oficina>
            <ns0:moneda>
                <ns0:multimoneda>N</ns0:multimoneda>
            </ns0:moneda>
            <ns0:canal>
                <ns0:servicio>10</ns0:servicio>
            </ns0:canal>
        </ns2:opPagarPrestamoSolicitud>
        
};

declare variable $pagoPrestamo as element(ns1:pagoPrestamo) external;

xf:pagoPrestamoNIIn($pagoPrestamo)
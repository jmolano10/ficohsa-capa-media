(:: pragma bea:global-element-return element="ns1:opConsultaPrestamoSolicitud" location="../../../BusinessServices/CTS/prestamo/xsd/services.xsd" ::)

declare namespace ns1 = "http://service.srvaplcobisprestamo.ecobis.cobiscorp";
declare namespace ns0 = "http://dto.srvaplcobisentidades.ecobis.cobiscorp";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaMovimientosPagoPrestamo/xq/consultaMovGralPrestamoNIIn/";

declare function xf:consultaMovGralPrestamoNIIn($loanID as xs:string)
    as element(ns1:opConsultaPrestamoSolicitud) {
        <ns1:opConsultaPrestamoSolicitud>
            <ns0:prestamo>
                <ns0:producto>
                    <ns0:valNumeroProducto>{ data($loanID) }</ns0:valNumeroProducto>
                </ns0:producto>
            </ns0:prestamo>
            <ns0:contextoTransaccional>
             	<ns0:codCanalOriginador>1</ns0:codCanalOriginador>
         	</ns0:contextoTransaccional>
        </ns1:opConsultaPrestamoSolicitud>        
};

declare variable $loanID as xs:string external;

xf:consultaMovGralPrestamoNIIn($loanID)
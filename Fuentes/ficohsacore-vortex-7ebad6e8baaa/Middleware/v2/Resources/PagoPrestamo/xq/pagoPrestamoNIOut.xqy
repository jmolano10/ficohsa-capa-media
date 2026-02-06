xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$opPagarPrestamoRespuesta" element="ns2:opPagarPrestamoRespuesta" location="../../../BusinessServices/CTS/prestamo/xsd/services.xsd" ::)
(:: pragma bea:global-element-return element="ns0:pagoPrestamoResponse" location="../xsd/pagoPrestamoTypes.xsd" ::)

declare namespace ns2 = "http://service.srvaplcobisprestamo.ecobis.cobiscorp";
declare namespace ns1 = "http://dto.srvaplcobisentidades.ecobis.cobiscorp";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/pagoPrestamoTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/PagoPrestamo/xq/pagoPrestamoNIOut/";

declare function convertirFecha($date as xs:string) 
	as xs:string {
		fn-bea:date-to-string-with-format("yyyyMMdd",fn-bea:date-from-string-with-format("yyyy-MM-dd",$date))	
};

declare function xf:pagoPrestamoNIOut($opPagarPrestamoRespuesta as element(ns2:opPagarPrestamoRespuesta))
    as element(ns0:pagoPrestamoResponse) {
        <ns0:pagoPrestamoResponse>
            <DATE_TIME>
                {
                    if (data($opPagarPrestamoRespuesta/ns1:pagoPrestamo/ns1:transaccion/ns1:fecAplicacion) != "") then
                        (convertirFecha(data($opPagarPrestamoRespuesta/ns1:pagoPrestamo/ns1:transaccion/ns1:fecAplicacion)))
                    else 
                        ""
                }
			</DATE_TIME>
            {
                for $valNumeroProducto in $opPagarPrestamoRespuesta/ns1:pagoPrestamo/ns1:prestamo/ns1:producto/ns1:valNumeroProducto
                return
                    <LOAN_NUMBER>{ data($valNumeroProducto) }</LOAN_NUMBER>
            }
            <DUE_ID></DUE_ID>
            <PAYMENT_AMOUNT>{ data($opPagarPrestamoRespuesta/ns1:pagoPrestamo/ns1:transaccion/ns1:valMonto) }</PAYMENT_AMOUNT>
        </ns0:pagoPrestamoResponse>
};

declare variable $opPagarPrestamoRespuesta as element(ns2:opPagarPrestamoRespuesta) external;

xf:pagoPrestamoNIOut($opPagarPrestamoRespuesta)
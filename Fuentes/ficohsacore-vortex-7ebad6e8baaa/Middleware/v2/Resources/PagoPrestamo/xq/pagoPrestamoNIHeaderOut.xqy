xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$opPagarPrestamoRespuesta" element="ns1:opPagarPrestamoRespuesta" location="../../../BusinessServices/CTS/prestamo/xsd/services.xsd" ::)
(:: pragma bea:global-element-return element="ns2:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns0 = "http://dto.srvaplcobisentidades.ecobis.cobiscorp";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://service.srvaplcobisprestamo.ecobis.cobiscorp";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/PagoPrestamo/xq/pagoPrestamoNIHeaderOut/";

declare function convertirStringFechaString($stringDate as xs:string?)
	as xs:string {
		if (fn-bea:trim($stringDate) != '') then 
			let $date := fn-bea:date-from-string-with-format("yyyy-MM-dd", $stringDate)
			return fn-bea:date-to-string-with-format("yyyyMMdd", $date)  
		else ("")
};

declare function xf:pagoPrestamoNIHeaderOut($opPagarPrestamoRespuesta as element(ns1:opPagarPrestamoRespuesta))
    as element(ns2:ResponseHeader) {
        <ns2:ResponseHeader>        
	        {	          
	            let $transaccion := fn:string($opPagarPrestamoRespuesta/ns0:pagoPrestamo/ns0:transaccion/ns0:valNumAprobacionCore/text())
            	return
	            	if($transaccion != '') then(
	            		<transactionId>{ $transaccion }</transactionId> 
	            	) else()
            }
            {
                if(fn:string($opPagarPrestamoRespuesta/ns0:pagoPrestamo/ns0:transaccion/ns0:fecAplicacion/text())) then (
                	<valueDate>{ convertirStringFechaString(data($opPagarPrestamoRespuesta/ns0:pagoPrestamo/ns0:transaccion/ns0:fecAplicacion)) }</valueDate>
                ) else ()
            }
            {
            	let $successIndicator := fn:string($opPagarPrestamoRespuesta/ns0:contextoRespuesta/ns0:codTipoRespuesta/text())
            	let $message := fn:string($opPagarPrestamoRespuesta/ns0:contextoRespuesta/ns0:valDescripcionRespuesta/text())
            	return( 
	            	if ($successIndicator  = "0") then (
	            		<successIndicator>Success</successIndicator>
	            	) else (
	            		<successIndicator>{ $successIndicator }</successIndicator>,
	            		<messages>{ $message }</messages>
	            	)
	            )
	        }       
        </ns2:ResponseHeader>
};

declare variable $opPagarPrestamoRespuesta as element(ns1:opPagarPrestamoRespuesta) external;

xf:pagoPrestamoNIHeaderOut($opPagarPrestamoRespuesta)
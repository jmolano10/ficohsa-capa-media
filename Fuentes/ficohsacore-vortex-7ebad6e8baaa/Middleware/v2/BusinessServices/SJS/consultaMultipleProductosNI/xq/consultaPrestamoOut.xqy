xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$opConsultaPrestamoRespuesta" element="ns4:opConsultaPrestamoRespuesta" location="../../../CTS/prestamo/xsd/services.xsd" ::)
(:: pragma bea:local-element-return type="ns2:sjConsultaMultipleProductosNIResponse/ns2:LIABILITIES/ns2:LIABILITY" location="../xsd/sjConsultaMultipleProductosNI.xsd" ::)

declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/sjConsultaMultipleProductosNI";
declare namespace ns1 = "http://dto.srvaplcobisentidades.ecobis.cobiscorp";
declare namespace ns4 = "http://service.srvaplcobisprestamo.ecobis.cobiscorp";
declare namespace ns3 = "http://dto2.commons.ecobis.cobiscorp";
declare namespace ns0 = "http://dto2.sdf.cts.cobis.cobiscorp.com";
declare namespace xf = "http://tempuri.org/Middleware/v2/BusinessServices/SJS/consultaMultipleProductosNI/xq/consultaPrestamoOut/";

declare function numIsNull($item as item()?) as xs:double {
	if ( fn:string($item/text()) != '' ) then (
		round-half-to-even( data($item), 2 )
	) else ("0.0")
};

declare function xf:consultaPrestamoOut($productID as xs:string,
    $opConsultaPrestamoRespuesta as element(ns4:opConsultaPrestamoRespuesta))
    as element() {
        <ns2:LIABILITY>
            <ns2:ID>{ $productID }</ns2:ID>
            {
            	let $successIndicator := data($opConsultaPrestamoRespuesta/ns1:contextoRespuesta/ns1:codTipoRespuesta)
            	return
        		if($successIndicator = '0' or $successIndicator = 'SUCCESS')then(
        			if(count($opConsultaPrestamoRespuesta/ns1:prestamo) > 0) then (
	        			for $nombreCompleto in $opConsultaPrestamoRespuesta/ns1:prestamo/ns1:cliente/ns1:nombreCompleto
	        			return(
	        				<ns2:PRODUCT_NAME>{ data($nombreCompleto) }</ns2:PRODUCT_NAME>
	        			),
	        				<ns2:BALANCES>
				                <ns2:BALANCE>
				                    <ns2:CURRENCY>{ data($opConsultaPrestamoRespuesta/ns1:prestamo/ns1:moneda/ns1:valTipoMoneda) }</ns2:CURRENCY>
				                    <ns2:PRINCIPAL>{ numIsNull($opConsultaPrestamoRespuesta/ns1:prestamo/ns1:valCapProxPago) }</ns2:PRINCIPAL>
				                    <ns2:INT_COMM>{ numIsNull($opConsultaPrestamoRespuesta/ns1:prestamo/ns1:valSeguroProxPago) + numIsNull($opConsultaPrestamoRespuesta/ns1:prestamo/ns1:valIntProxPago) }</ns2:INT_COMM>
				                    <ns2:TOTAL>{ numIsNull($opConsultaPrestamoRespuesta/ns1:prestamo/ns1:valTotProxPago) }</ns2:TOTAL>
				                </ns2:BALANCE>
				            </ns2:BALANCES>,
				            
			            	let $diaDePago := $opConsultaPrestamoRespuesta/ns1:prestamo/ns1:diaDePago
			            	return
			            	if(data($diaDePago) != "")then(
			            		<ns2:NEXT_PAYMENT_DATE>{fn-bea:date-from-string-with-format('yyyy-MM-dd', data($diaDePago))}</ns2:NEXT_PAYMENT_DATE>
			            	)else(),
			            	
			            	<ns2:TSTANDING_TOTAL>{ numIsNull($opConsultaPrestamoRespuesta/ns1:prestamo/ns1:valTotProxPago) }</ns2:TSTANDING_TOTAL>,
			            	<ns2:CANCELATION_TOTAL>{ numIsNull($opConsultaPrestamoRespuesta/ns1:prestamo/ns1:valDeudaTotal) }</ns2:CANCELATION_TOTAL>,
				            <ns2:TOTAL_AMOUNT>0.0</ns2:TOTAL_AMOUNT>,				            
				            <ns2:TYPE>PTM</ns2:TYPE>,
				            
				            let $fecAprobacion := $opConsultaPrestamoRespuesta/ns1:prestamo/ns1:fecAprobacion
				            return
				            if(data($fecAprobacion) != "")then(
				            	<ns2:OPENING_DATE>{fn-bea:date-from-dateTime(fn:adjust-dateTime-to-timezone(data($fecAprobacion), ()))}</ns2:OPENING_DATE>
				            )else(
				            	<ns2:OPENING_DATE>{ fn:adjust-date-to-timezone(fn:current-date(), ()) }</ns2:OPENING_DATE>
				            ),
				            
				            <ns2:SOURCE_BANK>NI01</ns2:SOURCE_BANK>,
				            <ns2:SUCCESS_INDICATOR>SUCCESS</ns2:SUCCESS_INDICATOR>
        			) else (
        				<ns2:TYPE>PTM</ns2:TYPE>,
	        			<ns2:SOURCE_BANK>NI01</ns2:SOURCE_BANK>,
				        <ns2:SUCCESS_INDICATOR>NO RECORDS</ns2:SUCCESS_INDICATOR>,
				        <ns2:ERROR_MESSAGE>PRODUCTO NO ENCONTRADO</ns2:ERROR_MESSAGE>
        			)
        		)else(
	        			<ns2:TYPE>PTM</ns2:TYPE>,
	        			<ns2:SOURCE_BANK>NI01</ns2:SOURCE_BANK>,
				        <ns2:SUCCESS_INDICATOR>ERROR</ns2:SUCCESS_INDICATOR>,
					    for $valDescripcionRespuesta in $opConsultaPrestamoRespuesta/ns1:contextoRespuesta/ns1:valDescripcionRespuesta
	                	return(   
					        <ns2:ERROR_MESSAGE>{ data($valDescripcionRespuesta) }</ns2:ERROR_MESSAGE>
				        )
        		)
            }
        </ns2:LIABILITY>
};

declare variable $productID as xs:string external;
declare variable $opConsultaPrestamoRespuesta as element(ns4:opConsultaPrestamoRespuesta) external;

xf:consultaPrestamoOut($productID,
    $opConsultaPrestamoRespuesta)
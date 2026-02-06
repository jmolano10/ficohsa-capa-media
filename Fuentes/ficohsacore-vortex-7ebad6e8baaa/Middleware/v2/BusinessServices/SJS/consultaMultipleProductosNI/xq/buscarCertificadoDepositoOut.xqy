xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$opBuscarCertificadoDPFRespuesta" element="ns2:opBuscarCertificadoDPFRespuesta" location="../../../CTS/deposito/xsd/services.xsd" ::)
(:: pragma bea:local-element-return type="ns1:sjConsultaMultipleProductosNIResponse/ns1:ASSETS/ns1:ASSET" location="../xsd/sjConsultaMultipleProductosNI.xsd" ::)

declare namespace ns2 = "http://service.srvaplcobiscertificadodeposito.ecobis.cobiscorp";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/sjConsultaMultipleProductosNI";
declare namespace ns0 = "http://dto.srvaplcobisentidades.ecobis.cobiscorp";
declare namespace xf = "http://tempuri.org/Middleware/v2/BusinessServices/SJS/consultaMultipleProductosNI/xq/buscarCertificadoDepositoOut/";

declare function numIsNull($item as item()?) as xs:decimal {
	if (fn:string($item/text()) != '' ) then (
		round-half-to-even( xs:decimal(data($item)), 2 )
	) else (0.0)
};

declare function xf:buscarCertificadoDepositoOut($opBuscarCertificadoDPFRespuesta as element(ns2:opBuscarCertificadoDPFRespuesta),
    $productID as xs:string)
    as element() {
        <ns1:ASSET>
        	<ns1:ID>{ $productID }</ns1:ID>
        	{
	        	let $successIndicator := data($opBuscarCertificadoDPFRespuesta/ns0:contextoRespuesta/ns0:codTipoRespuesta)
	            	return
	            	if($successIndicator = '0' or $successIndicator = 'SUCCESS')then(
	                	if(count($opBuscarCertificadoDPFRespuesta/ns0:cdt) > 0) then (
		                	for $clienteDepositante in $opBuscarCertificadoDPFRespuesta/ns0:cdt/ns0:clienteDepositante
		                	return(
		                		<ns1:PRODUCT_NAME>{ data($clienteDepositante) }</ns1:PRODUCT_NAME>
		                	),
		                	for $codTipoMoneda in $opBuscarCertificadoDPFRespuesta/ns0:cdt/ns0:moneda/ns0:codTipoMoneda
		                	return(
		                		<ns1:CURRENCY>{ data($codTipoMoneda) }</ns1:CURRENCY>
		                	),
		                	<ns1:RESERVE_BALANCE>0.0</ns1:RESERVE_BALANCE>,
		                    <ns1:LOCKED_BALANCE>0.0</ns1:LOCKED_BALANCE>,
		                    <ns1:VISA_FLOATING_BALANCE>0.0</ns1:VISA_FLOATING_BALANCE>,
		                	<ns1:INTEREST_BALANCE>{ numIsNull($opBuscarCertificadoDPFRespuesta/ns0:cdt/ns0:valInteresDevengado) }</ns1:INTEREST_BALANCE>,
		                	<ns1:TOTAL_BALANCE>
		                	{ 
		                		numIsNull($opBuscarCertificadoDPFRespuesta/ns0:cdt/ns0:valMonto) 
		                		+
		                		numIsNull($opBuscarCertificadoDPFRespuesta/ns0:cdt/ns0:valInteresDevengado)
		                	}
		                	</ns1:TOTAL_BALANCE>,
			            	<ns1:AVAILABLE_BALANCE>{ numIsNull($opBuscarCertificadoDPFRespuesta/ns0:cdt/ns0:valMonto) }</ns1:AVAILABLE_BALANCE>,
		                	for $fechaApertura in $opBuscarCertificadoDPFRespuesta/ns0:cdt/ns0:fecApertura
		                	return(
		                		if(data($fechaApertura) != "")then(
		                			<ns1:OPENING_DATE>{ fn-bea:date-from-dateTime(fn:adjust-dateTime-to-timezone(data($fechaApertura), ())) }</ns1:OPENING_DATE>
		                		)else(
		                			<ns1:OPENING_DATE>{ fn:adjust-date-to-timezone(fn:current-date(), ()) }</ns1:OPENING_DATE>
		                		)	
		                	),
			            <ns1:TYPE>DEP</ns1:TYPE>,
			            <ns1:SOURCE_BANK>NI01</ns1:SOURCE_BANK>,
			            <ns1:SUCCESS_INDICATOR>SUCCESS</ns1:SUCCESS_INDICATOR>         
			            )else (
			            	<ns1:TYPE>DEP</ns1:TYPE>,
				            <ns1:SOURCE_BANK>NI01</ns1:SOURCE_BANK>,
				            <ns1:SUCCESS_INDICATOR>NO RECORDS</ns1:SUCCESS_INDICATOR>,
				            <ns1:ERROR_MESSAGE>PRODUCTO NO ENCONTRADO</ns1:ERROR_MESSAGE>
			            )
	            	) else(
	            		<ns1:TYPE>DEP</ns1:TYPE>,
			            <ns1:SOURCE_BANK>NI01</ns1:SOURCE_BANK>,
			            <ns1:SUCCESS_INDICATOR>ERROR</ns1:SUCCESS_INDICATOR>,
				        for $valDescripcionRespuesta in $opBuscarCertificadoDPFRespuesta/ns0:contextoRespuesta/ns0:valDescripcionRespuesta
			            return(
				            <ns1:ERROR_MESSAGE>{ data($valDescripcionRespuesta) }</ns1:ERROR_MESSAGE>
			            ) 
	            	)
           		} 
        </ns1:ASSET>
};

declare variable $opBuscarCertificadoDPFRespuesta as element(ns2:opBuscarCertificadoDPFRespuesta) external;
declare variable $productID as xs:string external;

xf:buscarCertificadoDepositoOut($opBuscarCertificadoDPFRespuesta,
    $productID)
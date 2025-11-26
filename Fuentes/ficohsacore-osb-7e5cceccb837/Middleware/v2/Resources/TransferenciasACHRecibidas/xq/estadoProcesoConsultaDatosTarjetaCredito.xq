(:: pragma  type="xs:anyType" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/TransferenciasACHRecibidas/xq/estadoProcesoConsultaDatosTarjetaCredito/";

declare function xf:estadoProcesoConsultaDatosTarjetaCredito($successIndicator as xs:string,
	$cardStatus as xs:string, 
	$messages as xs:string)
    as element(*) {
    	<VALIDACION_PROCESO>
    		{
				if($successIndicator = 'SUCCESS') then(
					
					if($cardStatus = '20 - TARJETA NORMAL' or $cardStatus = '22 - TARJETA CON ORDEN DE NO RENOVAR' or $cardStatus = '25 - TARJETA CON PROBLEMAS' or $cardStatus = '29 - TARJETA DADA DE BAJA') then(
					
						<ESTADO_PROCESO>SUCCESS</ESTADO_PROCESO>, 
						<VALIDACION_MENSAJE></VALIDACION_MENSAJE>, 
						<CODIGO_ERROR_PROCESO></CODIGO_ERROR_PROCESO>, 
						<MENSAJE_ERROR_PROCESO></MENSAJE_ERROR_PROCESO>
						
					)else(
						
						<ESTADO_PROCESO>ERROR</ESTADO_PROCESO>, 
						<VALIDACION_MENSAJE>{ fn:concat('OSB-E002 ERROR',': ',$messages) }</VALIDACION_MENSAJE>, 
						<CODIGO_ERROR_PROCESO>OSB-E002</CODIGO_ERROR_PROCESO>, 
						<MENSAJE_ERROR_PROCESO>{ fn:concat('ERROR',': ',$messages) }</MENSAJE_ERROR_PROCESO>
					
					)
						
				)else if($successIndicator = 'NO RECORDS') then(
				
					<ESTADO_PROCESO>REJECTED</ESTADO_PROCESO>, 
					<VALIDACION_MENSAJE>OSB-R03 Cuenta Inexistente</VALIDACION_MENSAJE>, 
					<CODIGO_ERROR_PROCESO>OSB-R03</CODIGO_ERROR_PROCESO>, 
					<MENSAJE_ERROR_PROCESO>Cuenta Inexistente</MENSAJE_ERROR_PROCESO> 
					
				)else if($successIndicator = 'BEA-380000' or $successIndicator = 'BEA-380002') then(
				
					<ESTADO_PROCESO>PENDING</ESTADO_PROCESO>, 
					<VALIDACION_MENSAJE>{ fn:concat('OSB-E001 ',$successIndicator,' - Excepcion de TimeOut') }</VALIDACION_MENSAJE>, 
					<CODIGO_ERROR_PROCESO>OSB-E001</CODIGO_ERROR_PROCESO>, 
					<MENSAJE_ERROR_PROCESO>{ fn:concat($successIndicator,' - Excepcion de TimeOut') }</MENSAJE_ERROR_PROCESO> 
					
				)else(
				
					<ESTADO_PROCESO>ERROR</ESTADO_PROCESO>, 
					<VALIDACION_MENSAJE>{ fn:concat('OSB-E002 ',$successIndicator,': ',$messages) }</VALIDACION_MENSAJE>, 
					<CODIGO_ERROR_PROCESO>OSB-E002</CODIGO_ERROR_PROCESO>, 
					<MENSAJE_ERROR_PROCESO>{ fn:concat($successIndicator,': ',$messages) }</MENSAJE_ERROR_PROCESO> 
			
				)
    		}
    	</VALIDACION_PROCESO>
};

declare variable $successIndicator as xs:string external;
declare variable $cardStatus as xs:string external;
declare variable $messages as xs:string external;

xf:estadoProcesoConsultaDatosTarjetaCredito($successIndicator,
	$cardStatus,
	$messages)
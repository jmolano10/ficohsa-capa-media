(:: pragma  type="xs:anyType" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/TransferenciasACHRecibidas/xq/estadoProcesoConsultaSaldosTarjetaCredito/";

declare function xf:estadoProcesoConsultaSaldosTarjetaCredito($successIndicator as xs:string,
	$messages as xs:string)
    as element(*) {
    	<VALIDACION_PROCESO>
    		{
				if($successIndicator = 'SUCCESS') then(
					
					<ESTADO_PROCESO>SUCCESS</ESTADO_PROCESO>, 
					<VALIDACION_MENSAJE></VALIDACION_MENSAJE>, 
					<CODIGO_ERROR_PROCESO></CODIGO_ERROR_PROCESO>, 
					<MENSAJE_ERROR_PROCESO></MENSAJE_ERROR_PROCESO>
						
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
declare variable $messages as xs:string external;

xf:estadoProcesoConsultaSaldosTarjetaCredito($successIndicator,
	$messages)
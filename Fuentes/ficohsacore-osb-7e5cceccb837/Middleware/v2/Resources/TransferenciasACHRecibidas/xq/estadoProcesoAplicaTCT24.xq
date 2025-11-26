(:: pragma  type="xs:anyType" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/TransferenciasACHRecibidas/xq/estadoProcesoAplicaTCT24/";

declare function xf:estadoProcesoAplicaTCT24($successIndicator as xs:string,
	$messages as xs:string)
    as element(*) {
        <VALIDACION_PROCESO>
    		{
    			if($successIndicator = '0') then(
    			
    				<ESTADO_PROCESO>SUCCESS</ESTADO_PROCESO>, 
					<VALIDACION_MENSAJE></VALIDACION_MENSAJE>, 
					<CODIGO_ERROR_PROCESO></CODIGO_ERROR_PROCESO>, 
					<MENSAJE_ERROR_PROCESO></MENSAJE_ERROR_PROCESO>
						
    			)else if($successIndicator = 'BEA-380000' or $successIndicator = 'BEA-380002') then(
				
					<ESTADO_PROCESO>PENDING</ESTADO_PROCESO>, 
					<VALIDACION_MENSAJE>OSB-E007 Registro no creado</VALIDACION_MENSAJE>, 
					<CODIGO_ERROR_PROCESO>OSB-E007</CODIGO_ERROR_PROCESO>, 
					<MENSAJE_ERROR_PROCESO>Registro no creado</MENSAJE_ERROR_PROCESO> 
				
				)else if(string(number($successIndicator)) != 'NaN') then(
				
					<ESTADO_PROCESO>ERROR</ESTADO_PROCESO>, 
					<VALIDACION_MENSAJE>{ fn:concat('DBM-E002 ', $successIndicator, ' - ', $messages) }</VALIDACION_MENSAJE>, 
					<CODIGO_ERROR_PROCESO>DBM-E002</CODIGO_ERROR_PROCESO>, 
					<MENSAJE_ERROR_PROCESO>{ fn:concat($successIndicator, ' - ', $messages) }</MENSAJE_ERROR_PROCESO> 
			
				)else(
    				
    				<ESTADO_PROCESO>ERROR</ESTADO_PROCESO>, 
					<VALIDACION_MENSAJE>{ fn:concat('OSB-E008 ',$successIndicator,': ',$messages) }</VALIDACION_MENSAJE>, 
					<CODIGO_ERROR_PROCESO>OSB-E008</CODIGO_ERROR_PROCESO>, 
					<MENSAJE_ERROR_PROCESO>{ fn:concat($successIndicator,': ',$messages) }</MENSAJE_ERROR_PROCESO>
					
    			)	
    		}
    	</VALIDACION_PROCESO>
};

declare variable $successIndicator as xs:string external;
declare variable $messages as xs:string external;

xf:estadoProcesoAplicaTCT24($successIndicator,
	$messages)
(:: pragma  type="xs:anyType" ::)
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/TransferenciasACH/xq/estadoProcesoRegistrarACHEnviados/";

declare function xf:estadoProcesoRegistrarACHEnviados($successIndicator as xs:string,
	$messages as xs:string)
    as element(*){
    	<VALIDACION_PROCESO>
    		{
    			if($successIndicator = 'SUCCESS') then(
    			
    				<ESTADO_PROCESO>SUCCESS</ESTADO_PROCESO>, 
					<VALIDACION_MENSAJE></VALIDACION_MENSAJE>, 
					<CODIGO_ERROR_PROCESO></CODIGO_ERROR_PROCESO>, 
					<MENSAJE_ERROR_PROCESO></MENSAJE_ERROR_PROCESO>
						
    			)else if($successIndicator = 'TWSERROR') then(
				
					<ESTADO_PROCESO>ERROR</ESTADO_PROCESO>, 
					<VALIDACION_MENSAJE>{ fn:concat('TWS-E003 ', $messages) }</VALIDACION_MENSAJE>, 
					<CODIGO_ERROR_PROCESO>TWS-E003</CODIGO_ERROR_PROCESO>, 
					<MENSAJE_ERROR_PROCESO>{ $messages }</MENSAJE_ERROR_PROCESO> 
					
				)else if($successIndicator = 'T24ERROR') then(
				
					<ESTADO_PROCESO>ERROR</ESTADO_PROCESO>, 
					<VALIDACION_MENSAJE>{ fn:concat('T24-E003 ', $messages) }</VALIDACION_MENSAJE>, 
					<CODIGO_ERROR_PROCESO>T24-E003</CODIGO_ERROR_PROCESO>, 
					<MENSAJE_ERROR_PROCESO>{ $messages }</MENSAJE_ERROR_PROCESO> 
					
				)else(
				
					<ESTADO_PROCESO>ERROR</ESTADO_PROCESO>, 
					<VALIDACION_MENSAJE>{ fn:concat('OSB-E012 ',$successIndicator,': ',$messages) }</VALIDACION_MENSAJE>, 
					<CODIGO_ERROR_PROCESO>OSB-E012</CODIGO_ERROR_PROCESO>, 
					<MENSAJE_ERROR_PROCESO>{ fn:concat($successIndicator,': ',$messages) }</MENSAJE_ERROR_PROCESO> 
			
				)
    		}
    	</VALIDACION_PROCESO> 
   
};

declare variable $successIndicator as xs:string external;
declare variable $messages as xs:string external;

xf:estadoProcesoRegistrarACHEnviados($successIndicator,
    $messages)
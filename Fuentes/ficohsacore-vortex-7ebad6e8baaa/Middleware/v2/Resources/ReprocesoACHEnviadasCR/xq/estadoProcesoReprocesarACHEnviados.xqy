xquery version "2004-draft";
(:: pragma  type="xs:anyType" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ReprocesoACHEnviadasCR/xq/estadoProcesoReprocesarACHEnviados/";

declare function xf:estadoProcesoReprocesarACHEnviados($successIndicator as xs:string,
	$messages as xs:string)
    as element(*) {
        <VALIDACION_PROCESO>
    		{
    			if($successIndicator = 'SUCCESS') then(
    			
    				<ESTADO_PROCESO>SUCCESS</ESTADO_PROCESO>, 
					<VALIDACION_MENSAJE></VALIDACION_MENSAJE>, 
					<CODIGO_ERROR_PROCESO></CODIGO_ERROR_PROCESO>, 
					<MENSAJE_ERROR_PROCESO></MENSAJE_ERROR_PROCESO>
						
    			)else if($successIndicator = 'TWSERROR') then(
				
					<ESTADO_PROCESO>PENDING</ESTADO_PROCESO>, 
					<VALIDACION_MENSAJE>{ fn:concat('TWS-E005 ', $messages) }</VALIDACION_MENSAJE>, 
					<CODIGO_ERROR_PROCESO>TWS-E005</CODIGO_ERROR_PROCESO>, 
					<MENSAJE_ERROR_PROCESO>{ $messages }</MENSAJE_ERROR_PROCESO> 
					
				)else if($successIndicator = 'T24ERROR') then(
				
					<ESTADO_PROCESO>ERROR</ESTADO_PROCESO>, 
					<VALIDACION_MENSAJE>{ fn:concat('T24-E005 ', $messages) }</VALIDACION_MENSAJE>, 
					<CODIGO_ERROR_PROCESO>T24-E005</CODIGO_ERROR_PROCESO>, 
					<MENSAJE_ERROR_PROCESO>{ $messages }</MENSAJE_ERROR_PROCESO> 
					
				)else if($successIndicator = 'BEA-380000' or $successIndicator = 'BEA-380002') then(
				
					<ESTADO_PROCESO>PENDING</ESTADO_PROCESO>, 
					<VALIDACION_MENSAJE>{ fn:concat('OSB-E019 ',$successIndicator,' - Excepcion de TimeOut') }</VALIDACION_MENSAJE>, 
					<CODIGO_ERROR_PROCESO>OSB-E019</CODIGO_ERROR_PROCESO>, 
					<MENSAJE_ERROR_PROCESO>{ fn:concat($successIndicator,' - Excepcion de TimeOut') }</MENSAJE_ERROR_PROCESO> 
					
				)else(
				
					<ESTADO_PROCESO>ERROR</ESTADO_PROCESO>, 
					<VALIDACION_MENSAJE>{ fn:concat('OSB-E020 ',$successIndicator,': ',$messages) }</VALIDACION_MENSAJE>, 
					<CODIGO_ERROR_PROCESO>OSB-E020</CODIGO_ERROR_PROCESO>, 
					<MENSAJE_ERROR_PROCESO>{ fn:concat($successIndicator,': ',$messages) }</MENSAJE_ERROR_PROCESO> 
			
				)
    		}
    	</VALIDACION_PROCESO>
};

declare variable $successIndicator as xs:string external;
declare variable $messages as xs:string external;

xf:estadoProcesoReprocesarACHEnviados($successIndicator,
    $messages)
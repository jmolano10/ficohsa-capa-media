xquery version "2004-draft";
(:: pragma  type="xs:anyType" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/TransferenciasACH/xq/estadoProcesoProcesamientoLBTR/";

declare function xf:estadoProcesoProcesamientoLBTR($successIndicator as xs:string,
	$messages as xs:string)
    as element(*) {
        <VALIDACION_PROCESO>
    		{
    			if($successIndicator = 'SUCCESS') then(
    			
    				<ESTADO_PROCESO>SUCCESS</ESTADO_PROCESO>, 
					<VALIDACION_MENSAJE></VALIDACION_MENSAJE>, 
					<CODIGO_ERROR_PROCESO></CODIGO_ERROR_PROCESO>, 
					<MENSAJE_ERROR_PROCESO></MENSAJE_ERROR_PROCESO>
						
    			)else if($successIndicator = 'ERROR') then(
    				
    				<ESTADO_PROCESO>ERROR</ESTADO_PROCESO>, 
					<VALIDACION_MENSAJE>{ fn:concat('DBM-E003 ',  $messages) }</VALIDACION_MENSAJE>, 
					<CODIGO_ERROR_PROCESO>DBM-E003</CODIGO_ERROR_PROCESO>, 
					<MENSAJE_ERROR_PROCESO>{ $messages }</MENSAJE_ERROR_PROCESO>
					 
	    		)else if($successIndicator = 'BEA-380000' or $successIndicator = 'BEA-380002') then(
				
					<ESTADO_PROCESO>PENDING</ESTADO_PROCESO>, 
					<VALIDACION_MENSAJE>{ fn:concat('OSB-E015 ',$successIndicator,' - Excepcion de TimeOut') }</VALIDACION_MENSAJE>, 
					<CODIGO_ERROR_PROCESO>OSB-E015</CODIGO_ERROR_PROCESO>, 
					<MENSAJE_ERROR_PROCESO>{ fn:concat($successIndicator,' - Excepcion de TimeOut') }</MENSAJE_ERROR_PROCESO> 
					
				)else(
	    		
	    			<ESTADO_PROCESO>ERROR</ESTADO_PROCESO>, 
					<VALIDACION_MENSAJE>{ fn:concat('OSB-E016 ',$successIndicator,': ',$messages) }</VALIDACION_MENSAJE>, 
					<CODIGO_ERROR_PROCESO>OSB-E016</CODIGO_ERROR_PROCESO>, 
					<MENSAJE_ERROR_PROCESO>{ fn:concat($successIndicator,': ',$messages) }</MENSAJE_ERROR_PROCESO>
					
	    		)	
    		}
    	</VALIDACION_PROCESO>
};

declare variable $successIndicator as xs:string external;
declare variable $messages as xs:string external;

xf:estadoProcesoProcesamientoLBTR($successIndicator,
	$messages)
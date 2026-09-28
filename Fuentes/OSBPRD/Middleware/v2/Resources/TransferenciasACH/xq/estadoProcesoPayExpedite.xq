(:: pragma  type="xs:anyType" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/TransferenciasACH/xq/estadoProcesoPayExpedite/";

declare function xf:estadoProcesoPayExpedite($successIndicator as xs:string,
	$reasonCode as xs:string,
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
					
					if($reasonCode = '1005') then(
						
						<ESTADO_PROCESO>ERROR</ESTADO_PROCESO>, 
						<VALIDACION_MENSAJE>{ fn:concat('PXP-E0003 ', $messages) }</VALIDACION_MENSAJE>, 
						<CODIGO_ERROR_PROCESO>PXP-E0003</CODIGO_ERROR_PROCESO>, 
						<MENSAJE_ERROR_PROCESO>{ $messages }</MENSAJE_ERROR_PROCESO> 
						
					)else if($reasonCode = 'O031') then(
					
						<ESTADO_PROCESO>PENDING</ESTADO_PROCESO>, 
						<VALIDACION_MENSAJE>{ fn:concat('PXP-E0004 ', $messages) }</VALIDACION_MENSAJE>, 
						<CODIGO_ERROR_PROCESO>PXP-E0004</CODIGO_ERROR_PROCESO>, 
						<MENSAJE_ERROR_PROCESO>{ $messages }</MENSAJE_ERROR_PROCESO>
						
					)else if($reasonCode = 'O032') then(
					
						<ESTADO_PROCESO>PENDING</ESTADO_PROCESO>, 
						<VALIDACION_MENSAJE>{ fn:concat('PXP-E0005 ', $messages) }</VALIDACION_MENSAJE>, 
						<CODIGO_ERROR_PROCESO>PXP-E0005</CODIGO_ERROR_PROCESO>, 
						<MENSAJE_ERROR_PROCESO>{ $messages }</MENSAJE_ERROR_PROCESO>
						
					)else if($reasonCode = 'O033') then(
					
						<ESTADO_PROCESO>PENDING</ESTADO_PROCESO>, 
						<VALIDACION_MENSAJE>{ fn:concat('PXP-E0006 ', $messages) }</VALIDACION_MENSAJE>, 
						<CODIGO_ERROR_PROCESO>PXP-E0006</CODIGO_ERROR_PROCESO>, 
						<MENSAJE_ERROR_PROCESO>{ $messages }</MENSAJE_ERROR_PROCESO>
						
					)else(
					
						<ESTADO_PROCESO>ERROR</ESTADO_PROCESO>, 
						<VALIDACION_MENSAJE>{ fn:concat('PXP-E0001 ', $messages) }</VALIDACION_MENSAJE>, 
						<CODIGO_ERROR_PROCESO>PXP-E0001</CODIGO_ERROR_PROCESO>, 
						<MENSAJE_ERROR_PROCESO>{ $messages }</MENSAJE_ERROR_PROCESO> 
					
					)
					
				)else if($successIndicator = 'PENDING') then(
				
					<ESTADO_PROCESO>PENDING</ESTADO_PROCESO>, 
					<VALIDACION_MENSAJE>{ fn:concat('PXP-E0002 ', $messages) }</VALIDACION_MENSAJE>, 
					<CODIGO_ERROR_PROCESO>PXP-E0002</CODIGO_ERROR_PROCESO>, 
					<MENSAJE_ERROR_PROCESO>{ $messages }</MENSAJE_ERROR_PROCESO> 
					
				)else if($successIndicator = 'BEA-380000' or $successIndicator = 'BEA-380002') then(
				
					<ESTADO_PROCESO>PENDING</ESTADO_PROCESO>, 
					<VALIDACION_MENSAJE>{ fn:concat('OSB-E017 ',$successIndicator,' - Excepcion de TimeOut') }</VALIDACION_MENSAJE>, 
					<CODIGO_ERROR_PROCESO>OSB-E017</CODIGO_ERROR_PROCESO>, 
					<MENSAJE_ERROR_PROCESO>{ fn:concat($successIndicator,' Excepcion de TimeOut') } </MENSAJE_ERROR_PROCESO> 
					
				)else(
				
					<ESTADO_PROCESO>ERROR</ESTADO_PROCESO>, 
					<VALIDACION_MENSAJE>{ fn:concat('OSB-E018 ',$successIndicator,': ',$messages) }</VALIDACION_MENSAJE>, 
					<CODIGO_ERROR_PROCESO>OSB-E018</CODIGO_ERROR_PROCESO>, 
					<MENSAJE_ERROR_PROCESO>{ fn:concat($successIndicator,': ',$messages) }</MENSAJE_ERROR_PROCESO> 
			
				)
    		}
    	</VALIDACION_PROCESO>
};

declare variable $successIndicator as xs:string external;
declare variable $reasonCode as xs:string external;
declare variable $messages as xs:string external;


xf:estadoProcesoPayExpedite($successIndicator, 
	$reasonCode,
	$messages)
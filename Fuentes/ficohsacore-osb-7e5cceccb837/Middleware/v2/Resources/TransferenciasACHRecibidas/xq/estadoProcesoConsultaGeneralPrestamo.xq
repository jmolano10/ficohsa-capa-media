xquery version "1.0" encoding "Cp1252";
(:: pragma  type="xs:anyType" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/TransferenciasACHRecibidas/xq/estadoProcesoConsultaGeneralPrestamo/";

declare function xf:estadoProcesoConsultaGeneralPrestamo($successIndicator as xs:string,
	$loanStatus as xs:string, 
	$messages as xs:string,
	$currencyRequest as xs:string,
	$loanCurrency as xs:string)
    as element(*) {
    	<VALIDACION_PROCESO>
    		{
    			if($successIndicator = 'ERROR') then(
    			
    				if(contains($messages, "No se pudo obtener la moneda del prestamo")) then(
    					<ESTADO_PROCESO>REJECTED</ESTADO_PROCESO>, 
						<VALIDACION_MENSAJE>OSB-R03 No se pudo obtener la moneda del prestamo</VALIDACION_MENSAJE>, 
						<CODIGO_ERROR_PROCESO>OSB-R03</CODIGO_ERROR_PROCESO>, 
						<MENSAJE_ERROR_PROCESO>No se pudo obtener la moneda del prestamo</MENSAJE_ERROR_PROCESO> 
    				)
    				
    				else(
    					<ESTADO_PROCESO>REJECTED</ESTADO_PROCESO>, 
						<VALIDACION_MENSAJE>OSB-R03 Numero de prestamo no existe</VALIDACION_MENSAJE>, 
						<CODIGO_ERROR_PROCESO>OSB-R03</CODIGO_ERROR_PROCESO>, 
						<MENSAJE_ERROR_PROCESO>Numero de prestamo no existe</MENSAJE_ERROR_PROCESO> 
    				)
					
				)else if($successIndicator = 'SUCCESS') then(
					
					if($loanStatus = 'ACTIVE' and $currencyRequest = $loanCurrency ) then(
						
						<ESTADO_PROCESO>SUCCESS</ESTADO_PROCESO>, 
						<VALIDACION_MENSAJE></VALIDACION_MENSAJE>, 
						<CODIGO_ERROR_PROCESO></CODIGO_ERROR_PROCESO>, 
						<MENSAJE_ERROR_PROCESO></MENSAJE_ERROR_PROCESO>
						
					)else if($loanStatus = 'ACTIVE' and $currencyRequest != $loanCurrency) then(
					
						<ESTADO_PROCESO>REJECTED</ESTADO_PROCESO>, 
						<VALIDACION_MENSAJE>1006-La moneda de la cuenta local y la Txn son distintas</VALIDACION_MENSAJE>, 
						<CODIGO_ERROR_PROCESO>1006</CODIGO_ERROR_PROCESO>, 
						<MENSAJE_ERROR_PROCESO>La moneda de la cuenta local y la Txn son distintas</MENSAJE_ERROR_PROCESO>
						
					)else if($loanStatus = 'CANCELLED') then(
					
						<ESTADO_PROCESO>REJECTED</ESTADO_PROCESO>, 
						<VALIDACION_MENSAJE>OSB-R02 Cuenta Cerrada</VALIDACION_MENSAJE>, 
						<CODIGO_ERROR_PROCESO>OSB-R02</CODIGO_ERROR_PROCESO>, 
						<MENSAJE_ERROR_PROCESO>Cuenta Cerrada</MENSAJE_ERROR_PROCESO>
						
					)else if($loanStatus = 'INVALID') then(
						
						<ESTADO_PROCESO>REJECTED</ESTADO_PROCESO>, 
						<VALIDACION_MENSAJE>OSB-R31 Error del Sistema</VALIDACION_MENSAJE>, 
						<CODIGO_ERROR_PROCESO>OSB-R31</CODIGO_ERROR_PROCESO>, 
						<MENSAJE_ERROR_PROCESO>Error del Sistema</MENSAJE_ERROR_PROCESO>					
					
					)else(
						
						<ESTADO_PROCESO>ERROR</ESTADO_PROCESO>, 
						<VALIDACION_MENSAJE>{ fn:concat('OSB-E002 ERROR',': ',$messages) }</VALIDACION_MENSAJE>, 
						<CODIGO_ERROR_PROCESO>OSB-E002</CODIGO_ERROR_PROCESO>, 
						<MENSAJE_ERROR_PROCESO>{ fn:concat('ERROR',': ',$messages) }</MENSAJE_ERROR_PROCESO>
					
					)
					 
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
declare variable $loanStatus as xs:string external;
declare variable $messages as xs:string external;
declare variable $currencyRequest as xs:string external;
declare variable $loanCurrency as xs:string external;

xf:estadoProcesoConsultaGeneralPrestamo($successIndicator,
	$loanStatus,
	$messages,
	$currencyRequest,
	$loanCurrency)
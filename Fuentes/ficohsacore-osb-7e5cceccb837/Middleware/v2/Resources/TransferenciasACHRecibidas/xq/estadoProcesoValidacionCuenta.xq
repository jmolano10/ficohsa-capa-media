xquery version "1.0" encoding "Cp1252";
(:: pragma  type="xs:anyType" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/TransferenciasACHRecibidas/xq/estadoProcesoValidacionCuenta/";

declare function xf:estadoProcesoValidacionCuenta($successIndicator as xs:string,
	$accountStatus as xs:string, 
	$messages as xs:string)
    as element(*) {
    	<VALIDACION_PROCESO>
    		{
				if($accountStatus = ('ACTIVE','INACTIVE', 'BLOCKED DEBIT')) then(
				
					<ESTADO_PROCESO>SUCCESS</ESTADO_PROCESO>, 
					<VALIDACION_MENSAJE></VALIDACION_MENSAJE>, 
					<CODIGO_ERROR_PROCESO></CODIGO_ERROR_PROCESO>, 
					<MENSAJE_ERROR_PROCESO></MENSAJE_ERROR_PROCESO> 
					
				)else if($successIndicator = 'ERROR') then(
				
					<ESTADO_PROCESO>REJECTED</ESTADO_PROCESO>, 
					<VALIDACION_MENSAJE>OSB-R31 Error del Sistema</VALIDACION_MENSAJE>, 
					<CODIGO_ERROR_PROCESO>OSB-R31</CODIGO_ERROR_PROCESO>, 
					<MENSAJE_ERROR_PROCESO>Error del Sistema</MENSAJE_ERROR_PROCESO> 
					
				)else if($successIndicator = 'NO RECORDS') then(
				
					<ESTADO_PROCESO>REJECTED</ESTADO_PROCESO>, 
					<VALIDACION_MENSAJE>OSB-R03 Cuenta Inexistente</VALIDACION_MENSAJE>, 
					<CODIGO_ERROR_PROCESO>OSB-R03</CODIGO_ERROR_PROCESO>, 
					<MENSAJE_ERROR_PROCESO>Cuenta Inexistente</MENSAJE_ERROR_PROCESO> 
					
				)else if($successIndicator = 'SUCCESS') then(
					
					if($accountStatus = 'CANCELLED') then(
				
						<ESTADO_PROCESO>REJECTED</ESTADO_PROCESO>, 
						<VALIDACION_MENSAJE>OSB-R02 Cuenta Cerrada</VALIDACION_MENSAJE>, 
						<CODIGO_ERROR_PROCESO>OSB-R02</CODIGO_ERROR_PROCESO>, 
						<MENSAJE_ERROR_PROCESO>Cuenta Cerrada</MENSAJE_ERROR_PROCESO> 
					
					)else if($accountStatus = 'BLOCKED CREDIT' or $accountStatus = 'BLOCKED ALL') then(
				
						<ESTADO_PROCESO>REJECTED</ESTADO_PROCESO>, 
						<VALIDACION_MENSAJE>OSB-R16 Cuenta Bloqueada</VALIDACION_MENSAJE>, 
						<CODIGO_ERROR_PROCESO>OSB-R16</CODIGO_ERROR_PROCESO>, 
						<MENSAJE_ERROR_PROCESO>Cuenta Bloqueada</MENSAJE_ERROR_PROCESO> 
					
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
declare variable $accountStatus as xs:string external;
declare variable $messages as xs:string external;

xf:estadoProcesoValidacionCuenta($successIndicator,
	$accountStatus, 
	$messages)
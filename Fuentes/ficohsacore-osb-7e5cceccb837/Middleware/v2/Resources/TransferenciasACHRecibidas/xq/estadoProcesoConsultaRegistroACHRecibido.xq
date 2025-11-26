(:: pragma  type="xs:anyType" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/TransferenciasACHRecibidas/xq/estadoProcesoConsultaRegistroACHRecibido/";

declare function xf:estadoProcesoConsultaRegistroACHRecibido($successIndicator as xs:string,
	$zeroRecords as xs:string, 
	$messages as xs:string,
	$txnStatus as xs:string,
	$idRejection as xs:string)
    as element(*) {
    	<VALIDACION_PROCESO>
    		{
				if($successIndicator = 'SUCCESS') then(
					
					if($zeroRecords = '0 RECORDS RETURNED') then(
					
						<ESTADO_PROCESO>PENDING</ESTADO_PROCESO>, 
						<VALIDACION_MENSAJE>T24-001A Registro no creado</VALIDACION_MENSAJE>, 
						<CODIGO_ERROR_PROCESO>T24-001A</CODIGO_ERROR_PROCESO>, 
						<MENSAJE_ERROR_PROCESO>Registro no creado</MENSAJE_ERROR_PROCESO>
						
					)else if($txnStatus = 'PENDING') then(
					
						<ESTADO_PROCESO>PENDING</ESTADO_PROCESO>, 
						<VALIDACION_MENSAJE>T24-001B Registro pendiente de finalizar</VALIDACION_MENSAJE>, 
						<CODIGO_ERROR_PROCESO>T24-001B</CODIGO_ERROR_PROCESO>, 
						<MENSAJE_ERROR_PROCESO>Registro pendiente de finalizar</MENSAJE_ERROR_PROCESO>
					
					)else if($txnStatus = 'REJECTED' or fn:upper-case($idRejection) = 'R31 - RECHAZOS ESPECIALES') then(
						
						<ESTADO_PROCESO>REJECTED</ESTADO_PROCESO>, 
						<VALIDACION_MENSAJE>
							{ 
								if(fn:upper-case($idRejection) = 'R31 - RECHAZOS ESPECIALES') then(
									fn:concat('T24-', fn:substring($idRejection, 1, 3), ' ', fn:substring($idRejection, 7))
								)else(
									$idRejection
								)
								 
							}
						</VALIDACION_MENSAJE>, 
						<CODIGO_ERROR_PROCESO>
							{  
								if(fn:upper-case($idRejection) = 'R31 - RECHAZOS ESPECIALES') then(
									fn:concat('T24', '-', fn:substring($idRejection, 1, 3))
								)else(
									fn:concat(fn:substring($idRejection, 1, 3), '-', fn:substring($idRejection, 5, 2))
								)
								 
							}
						</CODIGO_ERROR_PROCESO>,  
						<MENSAJE_ERROR_PROCESO>
							{ 
								if(fn:upper-case($idRejection) = 'R31 - RECHAZOS ESPECIALES') then(
									fn:concat('T24', '-', fn:substring($idRejection, 1, 3), ' ', fn:substring($idRejection, 7))
								)else(
									fn:concat(fn:concat(fn:substring($idRejection, 1, 3), '-', fn:substring($idRejection, 5, 2)), ' ', fn:tokenize($idRejection, '-')[2])
								)
								 
							}
						</MENSAJE_ERROR_PROCESO>
					
					)else if($txnStatus = ('SUCCESS', '')) then(
					
						<ESTADO_PROCESO>SUCCESS</ESTADO_PROCESO>, 
						<VALIDACION_MENSAJE></VALIDACION_MENSAJE>, 
						<CODIGO_ERROR_PROCESO></CODIGO_ERROR_PROCESO>, 
						<MENSAJE_ERROR_PROCESO></MENSAJE_ERROR_PROCESO>
						
					)else(
					
						<ESTADO_PROCESO>ERROR</ESTADO_PROCESO>, 
						<VALIDACION_MENSAJE>{ fn:concat('OSB-E006 ERROR',': ',$messages) }</VALIDACION_MENSAJE>, 
						<CODIGO_ERROR_PROCESO>OSB-E006</CODIGO_ERROR_PROCESO>, 
						<MENSAJE_ERROR_PROCESO>{ fn:concat('ERROR',': ',$messages) }</MENSAJE_ERROR_PROCESO>
						 
					)	
				)else if($successIndicator = 'TWSERROR') then(
				
					<ESTADO_PROCESO>PENDING</ESTADO_PROCESO>, 
					<VALIDACION_MENSAJE>{ fn:concat('TWS-E001 ', $messages) }</VALIDACION_MENSAJE>, 
					<CODIGO_ERROR_PROCESO>TWS-E001</CODIGO_ERROR_PROCESO>, 
					<MENSAJE_ERROR_PROCESO>{ $messages }</MENSAJE_ERROR_PROCESO> 
					
				)else if($successIndicator = 'T24ERROR') then(
				
					<ESTADO_PROCESO>ERROR</ESTADO_PROCESO>, 
					<VALIDACION_MENSAJE>{ fn:concat('T24-E002 ', $messages) }</VALIDACION_MENSAJE>, 
					<CODIGO_ERROR_PROCESO>T24-E002</CODIGO_ERROR_PROCESO>, 
					<MENSAJE_ERROR_PROCESO>{ $messages }</MENSAJE_ERROR_PROCESO> 
					
				)else if($successIndicator = 'BEA-380000' or $successIndicator = 'BEA-380002') then(
				
					<ESTADO_PROCESO>PENDING</ESTADO_PROCESO>, 
					<VALIDACION_MENSAJE>{ fn:concat('OSB-E005 ', $successIndicator, ' - Excepcion de TimeOut') }</VALIDACION_MENSAJE>, 
					<CODIGO_ERROR_PROCESO>OSB-E005</CODIGO_ERROR_PROCESO>, 
					<MENSAJE_ERROR_PROCESO>{ fn:concat($successIndicator,' - Excepcion de TimeOut') }</MENSAJE_ERROR_PROCESO> 
					
				)else(
				
					<ESTADO_PROCESO>ERROR</ESTADO_PROCESO>, 
					<VALIDACION_MENSAJE>{ fn:concat('OSB-E006 ',$successIndicator,': ',$messages) }</VALIDACION_MENSAJE>, 
					<CODIGO_ERROR_PROCESO>OSB-E006</CODIGO_ERROR_PROCESO>, 
					<MENSAJE_ERROR_PROCESO>{ fn:concat($successIndicator,': ',$messages) }</MENSAJE_ERROR_PROCESO> 
			
				)
    		}
    	</VALIDACION_PROCESO>
};

declare variable $successIndicator as xs:string external;
declare variable $zeroRecords as xs:string external;
declare variable $messages as xs:string external;
declare variable $txnStatus as xs:string external;
declare variable $idRejection as xs:string external;

xf:estadoProcesoConsultaRegistroACHRecibido($successIndicator,
	$zeroRecords, 
	$messages,
	$txnStatus,
	$idRejection)
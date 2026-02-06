xquery version "2004-draft";
(:: pragma  type="xs:anyType" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/TransferenciasACH/xq/estadoProcesoConsultaConfirmacionACHEnviado/";

declare function xf:estadoProcesoConsultaConfirmacionACHEnviado($successIndicator as xs:string,
	$zeroRecords as xs:string, 
	$messages as xs:string,
	$txnStatus as xs:string,
	$idRejection as xs:string,
	$respTransACH as xs:string,
	$idTxnT24 as xs:string)
    as element(*) {
        <VALIDACION_PROCESO>
    		{
				if($successIndicator = 'SUCCESS') then(
					
					if($zeroRecords != '') then(
					
						<ESTADO_PROCESO>PENDING</ESTADO_PROCESO>, 
						<VALIDACION_MENSAJE>T24-002A Registro no creado</VALIDACION_MENSAJE>, 
						<CODIGO_ERROR_PROCESO>T24-002A</CODIGO_ERROR_PROCESO>, 
						<MENSAJE_ERROR_PROCESO>Registro no creado</MENSAJE_ERROR_PROCESO>
						
					)else if($txnStatus = 'PENDING') then(
					
						<ESTADO_PROCESO>PENDING</ESTADO_PROCESO>, 
						<VALIDACION_MENSAJE>T24-002B Registro pendiente de finalizar</VALIDACION_MENSAJE>, 
						<CODIGO_ERROR_PROCESO>T24-002B</CODIGO_ERROR_PROCESO>, 
						<MENSAJE_ERROR_PROCESO>Registro pendiente de finalizar</MENSAJE_ERROR_PROCESO>
					
					)else if($txnStatus = ('REJECTED','ERROR') and $respTransACH != 'SUCCESS') then(
						
						if(fn:upper-case($idRejection) = 'R31 - RECHAZOS ESPECIALES') then(
							
							<ESTADO_PROCESO>ERROR</ESTADO_PROCESO>, 
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
						
						)else(
							
							<ESTADO_PROCESO>SUCCESS</ESTADO_PROCESO>, 
							<VALIDACION_MENSAJE></VALIDACION_MENSAJE>, 
							<CODIGO_ERROR_PROCESO></CODIGO_ERROR_PROCESO>, 
							<MENSAJE_ERROR_PROCESO></MENSAJE_ERROR_PROCESO>
							
						)
						
					
					)else if($respTransACH != 'SUCCESS' and $txnStatus = 'SUCCESS') then(
					
						<ESTADO_PROCESO>PENDING</ESTADO_PROCESO>, 
						<VALIDACION_MENSAJE>T24-002D Transaccion de rechazo no finalizada</VALIDACION_MENSAJE>, 
						<CODIGO_ERROR_PROCESO>T24-002D</CODIGO_ERROR_PROCESO>, 
						<MENSAJE_ERROR_PROCESO>Transaccion de rechazo no finalizada</MENSAJE_ERROR_PROCESO>
						
					)else if(fn:upper-case($idRejection) = 'R31 - RECHAZOS ESPECIALES' or ($txnStatus = 'REJECTED' and $respTransACH = 'SUCCESS')) then(
						
						<ESTADO_PROCESO>ERROR</ESTADO_PROCESO>, 
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
						
					)else if($respTransACH = 'SUCCESS' and $txnStatus = 'SUCCESS') then(
						
						if($idTxnT24 != '') then(
							
							<ESTADO_PROCESO>SUCCESS</ESTADO_PROCESO>, 
							<VALIDACION_MENSAJE></VALIDACION_MENSAJE>, 
							<CODIGO_ERROR_PROCESO></CODIGO_ERROR_PROCESO>, 
							<MENSAJE_ERROR_PROCESO></MENSAJE_ERROR_PROCESO>
						
						)else(
							
							<ESTADO_PROCESO>PENDING</ESTADO_PROCESO>, 
							<VALIDACION_MENSAJE>T24-002C Transaccion no finalizada</VALIDACION_MENSAJE>, 
							<CODIGO_ERROR_PROCESO>T24-002C</CODIGO_ERROR_PROCESO>, 
							<MENSAJE_ERROR_PROCESO>Transaccion no finalizada</MENSAJE_ERROR_PROCESO>
						
						)
					
					)else(
					
						<ESTADO_PROCESO>ERROR</ESTADO_PROCESO>, 
						<VALIDACION_MENSAJE>{ fn:concat('OSB-E006 ERROR',': ',$messages) }</VALIDACION_MENSAJE>, 
						<CODIGO_ERROR_PROCESO>OSB-E006</CODIGO_ERROR_PROCESO>, 
						<MENSAJE_ERROR_PROCESO>{ fn:concat('ERROR',': ',$messages) }</MENSAJE_ERROR_PROCESO>
						 
					)	
				)else if($successIndicator = 'TWSERROR') then(
				
					<ESTADO_PROCESO>PENDING</ESTADO_PROCESO>, 
					<VALIDACION_MENSAJE>{ fn:concat('TWS-E004 ', $messages) }</VALIDACION_MENSAJE>, 
					<CODIGO_ERROR_PROCESO>TWS-E004</CODIGO_ERROR_PROCESO>, 
					<MENSAJE_ERROR_PROCESO>{ $messages }</MENSAJE_ERROR_PROCESO> 
					
				)else if($successIndicator = 'T24ERROR') then(
				
					<ESTADO_PROCESO>PENDING</ESTADO_PROCESO>, 
					<VALIDACION_MENSAJE>{ fn:concat('T24-E004 ', $messages) }</VALIDACION_MENSAJE>, 
					<CODIGO_ERROR_PROCESO>T24-E004</CODIGO_ERROR_PROCESO>, 
					<MENSAJE_ERROR_PROCESO>{ $messages }</MENSAJE_ERROR_PROCESO> 
					
				)else(
				
					<ESTADO_PROCESO>PENDING</ESTADO_PROCESO>, 
					<VALIDACION_MENSAJE>{ fn:concat('OSB-E014 ',$successIndicator,': ',$messages) }</VALIDACION_MENSAJE>, 
					<CODIGO_ERROR_PROCESO>OSB-E014</CODIGO_ERROR_PROCESO>, 
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
declare variable $respTransACH as xs:string external;
declare variable $idTxnT24 as xs:string external;

xf:estadoProcesoConsultaConfirmacionACHEnviado($successIndicator,
	$zeroRecords, 
	$messages,
	$txnStatus,
	$idRejection,
	$respTransACH,
	$idTxnT24)
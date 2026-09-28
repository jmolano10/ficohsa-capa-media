(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns1:OutputParameters" location="../../../../v2/BusinessServices/ProcesosGT/conMaestroSaldos/xsd/ConsultaMaestroSaldosTarjetaCredito_sp.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$sjConsultaMaestraSaldosTarjetaCreditoResponse" element="ns2:sjConsultaMaestraSaldosTarjetaCreditoResponse" location="../../../BusinessServices/SJS/ConsultaMaestraSaldosTarjetaCredito/xsd/sjConsultaMaestraSaldosTarjetaCreditoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/CLIENTDATA/registraMaestraSaldosTC/xsd/registraMaestraSaldosTC_sp.xsd" ::)

declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/sjConsultaMaestraSaldosTarjetaCreditoTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/ConsultaMaestroSaldosTarjetaCredito";
declare namespace ns3 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaMaestraSaldosTC";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/registraMaestraSaldosTC";
declare namespace xf = "http://tempuri.org/Middleware/v3/Resources/ConsultaMaestraSaldosTarjetaCredito/xq/registraMestroSaldosTCGTIn/";

(: Se encarga de convertir un date a string en formato "DD/MM/YYYY" :)
declare function date-to-string($fecha as xs:string) as xs:string
{
	concat( substring($fecha, 9, 2), '/', substring($fecha, 6, 2), '/', substring($fecha, 1, 4) )
};

declare function xf:registraMestroSaldosTCGTIn($outputParameters as element(ns1:OutputParameters),
    $sjConsultaMaestraSaldosTarjetaCreditoResponse as element(ns2:sjConsultaMaestraSaldosTarjetaCreditoResponse),
    $valSaldoActualPuntos as xs:string?,
    $cardNumer as xs:string,
    $countryCode as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
			<ns0:PV_CODIGO_PAIS>{ $countryCode }</ns0:PV_CODIGO_PAIS>
            <ns0:PT_MAESTRA_SALDOS_TC>
                <ns0:PT_MAESTRA_SALDOS_TC_ITEM>
                    <ns0:CARD_NUMBER>{ $cardNumer }</ns0:CARD_NUMBER>
                      {
	                	for  $rows in $outputParameters/ns1:RowSet/ns1:Row[1]
						where $rows/ns1:Column[@name = 'TipoOrg'] = 'BASE'
							let $institutionId := string($rows/ns1:Column[@name = 'org']/text())
						return 	
			        		<ns0:INSTITUTION_ID>{$institutionId}</ns0:INSTITUTION_ID>,
						for $pais in string($outputParameters/ns1:RowSet/ns1:Row[1]/ns1:Column[@name = 'pais']/text())
						return 
							<ns0:COUNTRY_CODE>{$pais}</ns0:COUNTRY_CODE>,
			        	for $nombreTitular in string($outputParameters/ns1:RowSet/ns1:Row[1]/ns1:Column[@name = 'nombre_1']/text())
						return 	
			        		<ns0:CARD_HOLDER_NAME>{$nombreTitular}</ns0:CARD_HOLDER_NAME>,
			        	for $fechaNacimiento in $outputParameters/ns1:RowSet/ns1:Row[1]/ns1:Column[@name = 'fec_nac']
						return
							if(string($fechaNacimiento/text()) != '')then(
								<ns0:BIRTHDATE>{fn-bea:dateTime-to-string-with-format('dd/MM/yyyy',data($fechaNacimiento))}</ns0:BIRTHDATE>        		
			        		)else(),
			        	for $codTipoProducto in string($outputParameters/ns1:RowSet/ns1:Row[1]/ns1:Column[@name = 'numtarjeta']/text())
						return 	
			        		<ns0:PRODUCT_TYPE_CODE>{$codTipoProducto}</ns0:PRODUCT_TYPE_CODE>,
			        		<ns0:REGISTERED_SIGNATURES>0</ns0:REGISTERED_SIGNATURES>,
			        	for $valPlan in string($outputParameters/ns1:RowSet/ns1:Row[1]/ns1:Column[@name = 'logo']/text())
						return 	
			        		<ns0:LOGO>{$valPlan}</ns0:LOGO>,
			        		<ns0:BLOCK_CODE></ns0:BLOCK_CODE>,
			        		<ns0:ACTIVE_IDENTIFIER></ns0:ACTIVE_IDENTIFIER>,
			        	for $valIndicador in string($outputParameters/ns1:RowSet/ns1:Row[1]/ns1:Column[@name = 'cardholder_type']/text())
						return 	
			        		<ns0:CARD_HOLDER_TYPE>{$valIndicador}</ns0:CARD_HOLDER_TYPE>,
			        	
			        	let $fechaMaximaPago := $outputParameters/ns1:RowSet/ns1:Row[1]/ns1:Column[@name = 'fecpagodue']
			        	return 
			        	if ($fechaMaximaPago != '') then (
							<ns0:MAX_PAYMENT_DATE>{ date-to-string($fechaMaximaPago) }</ns0:MAX_PAYMENT_DATE>
		    			) else if (data($sjConsultaMaestraSaldosTarjetaCreditoResponse/MAX_PAYMENT_DATE) != '') then (
		    				<ns0:MAX_PAYMENT_DATE>{ data($sjConsultaMaestraSaldosTarjetaCreditoResponse/MAX_PAYMENT_DATE) }</ns0:MAX_PAYMENT_DATE>
		    			) else (),
			        	 let $valfechaCorte := string($sjConsultaMaestraSaldosTarjetaCreditoResponse/CUTOFF_DATE/text())
						 return
						 	if($valfechaCorte != '')then(
						 		<ns0:CUTOFF_DATE>{ $valfechaCorte }</ns0:CUTOFF_DATE>	
						 	)else(),
						 	
						 <ns0:CREDIT_CARD_BALANCE_INFO>
						 {
						 	 fn-bea:serialize(
						 	 	for $rowconSaldosCTS at $i in $outputParameters/ns1:RowSet/ns1:Row
        	 					let $org := data($rowconSaldosCTS/ns1:Column[upper-case(@name) = 'ORG'])
        	 					let $currencyCode := data($rowconSaldosCTS/ns1:Column[upper-case(@name) = 'MONEDA'])
						 	 	let $sjConsultaMaestraSaldosTarjetaCredito :=  $sjConsultaMaestraSaldosTarjetaCreditoResponse/CREDIT_CARD_BALANCE_INFO[ORG = $org]
						 	 	return(
						 	 		<CREDIT_CARD_BALANCE_INFO>
					        		{
					        			for $org in string($rowconSaldosCTS/ns1:Column[@name = 'org']/text())
					        			return
					        				<ORG>{ $org }</ORG>
					        	 	}
					        	 	{
					        	 		for $valSimboloMoneda in string($rowconSaldosCTS/ns1:Column[@name = 'moneda']/text())
					        	 		return
					        	 			<CURRENCY>{ $valSimboloMoneda }</CURRENCY>
					        	 	}
					        	 	{
					        	 		for $valCodigoBloqueo1 in string($sjConsultaMaestraSaldosTarjetaCredito/BLOCK_CODE_1/text())
					        	 		return
					        	 			<BLOCK_CODE_1>{ $valCodigoBloqueo1 }</BLOCK_CODE_1>
					        	 	}
					        	 	<BLOCK_CODE_2>{ data($sjConsultaMaestraSaldosTarjetaCredito/BLOCK_CODE_2) }</BLOCK_CODE_2>
					        	 	<CREDIT_LIMIT>{ data($sjConsultaMaestraSaldosTarjetaCredito/CREDIT_LIMIT) }</CREDIT_LIMIT>
					        	 			
					        	 	{
					        	 		for $valSaldoActual in string($rowconSaldosCTS/ns1:Column[@name = 'billed_bal']/text())
					        	 		return
					        	 			if($valSaldoActual != '')then(
					        	 				<CURRENT_BALANCE>{ $valSaldoActual }</CURRENT_BALANCE>
					        	 			)else()
					        	 	}
		        	 				<PURCHASE_AVAILABLE_AMOUNT>{ data($sjConsultaMaestraSaldosTarjetaCredito/PURCHASE_AVAILABLE_AMOUNT) }</PURCHASE_AVAILABLE_AMOUNT>
		        	 				<AVAILABLE_WITHDRAWAL>{ data($sjConsultaMaestraSaldosTarjetaCredito/AVAILABLE_WITHDRAWAL) }</AVAILABLE_WITHDRAWAL>
					        	 	{
					        	 		for $valSaldoCorte in string($rowconSaldosCTS/ns1:Column[@name = 'totbalactual']/text())
					        	 		return        	 			    
					        	 			if($valSaldoCorte != '')then(
					        	 				<CUTOFF_BALANCE>{ $valSaldoCorte }</CUTOFF_BALANCE>
					        	 			)else()
					        	 	}
									<MIN_PAYMENT>{ data($sjConsultaMaestraSaldosTarjetaCredito/MIN_PAYMENT) }</MIN_PAYMENT>,
					        	    <LAST_CUTOFF_DATE>{ data($sjConsultaMaestraSaldosTarjetaCredito/LAST_CUTOFF_DATE) }</LAST_CUTOFF_DATE>,
					        	 	<LAST_CUTOFF_PAYMENT>{ data($sjConsultaMaestraSaldosTarjetaCredito/LAST_CUTOFF_PAYMENT) }</LAST_CUTOFF_PAYMENT>,
					        	 	<CICLE_DUE>{ data($sjConsultaMaestraSaldosTarjetaCredito/CICLE_DUE) }</CICLE_DUE>,
					        	 	{
					        	 		for $valTotalVencido in   string($rowconSaldosCTS/ns1:Column[@name = 'cantotaldue']/text())
					        	 		return
					        	 			if($valTotalVencido != '')then(
					        	 				<OVERDUE_BALANCE>{ $valTotalVencido }</OVERDUE_BALANCE>
					        	 			)else()	
					        	 	}        	 		
				        	 		<RETAINED_BALANCE>0</RETAINED_BALANCE>
				        	 		<DISPUTED_BALANCE>0</DISPUTED_BALANCE>
				        	 		<TOTAL_DEBIT>0</TOTAL_DEBIT>
				        	 		<TOTAL_CREDIT>0</TOTAL_CREDIT>
				        	 		<OVERDRAFT_LIMIT>0</OVERDRAFT_LIMIT>,
				        	 		<TOTAL_OVERDUE_BALANCE>{ data($sjConsultaMaestraSaldosTarjetaCredito/TOTAL_OVERDUE_BALANCE) }</TOTAL_OVERDUE_BALANCE>
						        	 	<EXTRA_FINANCING_INFO>
						        	   	{
						        	 		for $valDisponible in string($rowconSaldosCTS/ns1:Column[@name = 'monto_Oferta']/text())
						        	 		return
						        	 			if($valDisponible != '')then(
					        	 					<AVAILABLE_AMOUNT>{ $valDisponible }</AVAILABLE_AMOUNT>
					        	 				)else()		
						        	 	}
						        	 	{
						        	 		for $valFechaVencimiento in $rowconSaldosCTS/ns1:Column[@name = 'fecha_vigencia']
						        	 		return
						        	 			if(string($valFechaVencimiento/text()) != '')then(
					        	 					<EXPIRATION_DATE>{fn-bea:dateTime-to-string-with-format('dd/MM/yyyy',data($valFechaVencimiento))}</EXPIRATION_DATE>
					        	 				)else()
						        	 	}
						        	 	{
						        	 		for $valEstado in string($rowconSaldosCTS/ns1:Column[@name = 'EstadoOferta']/text())
						        	 		return
					        	 				<STATUS>{ $valEstado }</STATUS>
						        	 	}
						        	 	{
						        	 		for $tipoOferta in string($rowconSaldosCTS/ns1:Column[@name = 'TipoOferta']/text())
						        	 		return
					        	 				<OFFER_TYPE>{ $tipoOferta }</OFFER_TYPE> 
						        	 	}				 				
						        	 	</EXTRA_FINANCING_INFO>  		
					        		</CREDIT_CARD_BALANCE_INFO>  
						 	 	)
						 	 )
						}
						 </ns0:CREDIT_CARD_BALANCE_INFO>,
						 <ns0:CREDIT_CARD_POINTS_INFO>
						 {
						 	fn-bea:serialize(
						 		<CREDIT_CARD_POINTS_INFO>
						        	{
						        		if($valSaldoActualPuntos != '')then(
						        	 		<CURRENT_BALANCE>{$valSaldoActualPuntos}</CURRENT_BALANCE>
						        	 	)else()	
						        	}		
						        	{
							        	 for $valSaldoAnterior in string($outputParameters/ns1:RowSet/ns1:Row[1]/ns1:Column[@name = 'ptosgan_aaf']/text())
							        	 return
							        	 	if($valSaldoAnterior != '')then(
							        	 		<PREVIOUS_BALANCE>{$valSaldoAnterior}</PREVIOUS_BALANCE>
							        	 	)else()
							        }
								        <EARNED_POINTS>0</EARNED_POINTS>
								        <USED_POINTS>0</USED_POINTS>
								        <OVERDUE_POINTS>0</OVERDUE_POINTS>
						        </CREDIT_CARD_POINTS_INFO>
						 	)
						 }
						 </ns0:CREDIT_CARD_POINTS_INFO>,
						 	for $valPagoContado in xs:decimal($outputParameters/ns1:RowSet/ns1:Row[1]/ns1:Column[@name = 'amt_access_chks_1'])
				        	let $org := data($outputParameters/ns1:RowSet/ns1:Row[1]/ns1:Column[upper-case(@name) = 'ORG'])
				        	let $valSaldoActual := xs:decimal($outputParameters/ns1:RowSet/ns1:Row[1]/ns1:Column[@name = 'billed_bal'])
	                		let $totalPayment := xs:decimal($sjConsultaMaestraSaldosTarjetaCreditoResponse/TOTAL_PAYMENT)
	                		let $valPagoContadoTotal :=  $valPagoContado - $totalPayment
	                		return(
	                			<ns0:TOTAL_PAYMENT>{ $valPagoContadoTotal }</ns0:TOTAL_PAYMENT>
	                		)
	                }	
                </ns0:PT_MAESTRA_SALDOS_TC_ITEM>
            </ns0:PT_MAESTRA_SALDOS_TC>
        </ns0:InputParameters>
};

declare variable $outputParameters as element(ns1:OutputParameters) external;
declare variable $sjConsultaMaestraSaldosTarjetaCreditoResponse as element(ns2:sjConsultaMaestraSaldosTarjetaCreditoResponse) external;
declare variable $valSaldoActualPuntos as xs:string? external;
declare variable $cardNumer as xs:string external;
declare variable $countryCode as xs:string external;

xf:registraMestroSaldosTCGTIn($outputParameters,
    $sjConsultaMaestraSaldosTarjetaCreditoResponse,
    $valSaldoActualPuntos,
    $cardNumer,
    $countryCode)
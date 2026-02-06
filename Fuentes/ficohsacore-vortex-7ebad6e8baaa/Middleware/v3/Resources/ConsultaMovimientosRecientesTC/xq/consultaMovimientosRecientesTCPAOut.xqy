xquery version "2004-draft" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$conTransaccionesActualesResponse" element="ns4:OutputParameters" location="../../../../v2/BusinessServices/ProcesosPA/conTransaccionesActuales/xsd/conTransaccionesActuales_sp.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$conDatoTarjetaResponse" element="ns2:OutputParameters" location="../../../../v2/BusinessServices/ProcesosPA/conDatoTarjeta/xsd/conDatoTarjeta_sp.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$accountInquiryL8VLResponse" element="ns0:AccountInquiryL8VLResponse" location="../../../../v2/BusinessServices/VisionPlusPA/vmx/wsdl/VMX.wsdl" ::)
(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns1:OutputParameters" location="../../../../v2/BusinessServices/CLIENTDATA/consultaMovimientosRecientesTC/xsd/consultaMovimientosRecientesTC_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns3:consultaMovimientosRecientesTCReponse" location="../xsd/consultaMovimientosRecientesTCTypes.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v3/Resources/ConsultaMovimientosRecientesTC/xq/consultaMovimientosRecientesTCPAOut/";
declare namespace ns2 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/conDatoTarjeta";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaMovimientosRecientesTC";
declare namespace ns4 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/conTransaccionesActuales";
declare namespace ns3 = "http://www.ficohsa.com.hn/middleware.services/consultaMovimientosRecientesTCTypes";
declare namespace ns0 = "http://www.procesa.com/fdcs";

declare function xf:consultaMovimientosRecientesTCPAOut($conTransaccionesActualesResponse as element(ns4:OutputParameters),
    $conDatoTarjetaResponse as element(ns2:OutputParameters),
    $accountInquiryL8VLResponse as element(ns0:AccountInquiryL8VLResponse),
    $outputParameters as element(ns1:OutputParameters))
    as element(ns3:consultaMovimientosRecientesTCReponse) {
        <ns3:consultaMovimientosRecientesTCReponse>
	        {
	        	if(not(empty($outputParameters/ns1:PT_MOVIMIENTOS_RECIENTES_TC/ns1:PT_MOVIMIENTOS_RECIENTES_TC_ITEM[1]/ns1:OWNER_NAME)))then(
	                for $OWNER_NAME in $outputParameters/ns1:PT_MOVIMIENTOS_RECIENTES_TC/ns1:PT_MOVIMIENTOS_RECIENTES_TC_ITEM[1]/ns1:OWNER_NAME
	                return
	                    <OWNER_NAME>{ data($OWNER_NAME) }</OWNER_NAME>,
	                for $CARD_NUMBER in $outputParameters/ns1:PT_MOVIMIENTOS_RECIENTES_TC/ns1:PT_MOVIMIENTOS_RECIENTES_TC_ITEM[1]/ns1:CARD_NUMBER
	                return
	                    <CARD_NUMBER>{ data($CARD_NUMBER) }</CARD_NUMBER>,
	                for $CREDIT_LIMIT in $outputParameters/ns1:PT_MOVIMIENTOS_RECIENTES_TC/ns1:PT_MOVIMIENTOS_RECIENTES_TC_ITEM[1]/ns1:CREDIT_LIMIT
	                return
	                    <CREDIT_LIMIT>{ data($CREDIT_LIMIT) }</CREDIT_LIMIT>,
	                for $CREDIT_LIMIT_CCY in $outputParameters/ns1:PT_MOVIMIENTOS_RECIENTES_TC/ns1:PT_MOVIMIENTOS_RECIENTES_TC_ITEM[1]/ns1:CREDIT_LIMIT_CCY
	                return
	                    <CREDIT_LIMIT_CCY>{ data($CREDIT_LIMIT_CCY) }</CREDIT_LIMIT_CCY>,
	                for $PREVIOUS_BALANCE_LCY in $outputParameters/ns1:PT_MOVIMIENTOS_RECIENTES_TC/ns1:PT_MOVIMIENTOS_RECIENTES_TC_ITEM[1]/ns1:PREVIOUS_BALANCE_LCY
	                return
	                    <PREVIOUS_BALANCE_LCY>{ data($PREVIOUS_BALANCE_LCY) }</PREVIOUS_BALANCE_LCY>,
		            let $MOVEMENTS := fn-bea:inlinedXML($outputParameters/ns1:PT_MOVIMIENTOS_RECIENTES_TC/ns1:PT_MOVIMIENTOS_RECIENTES_TC_ITEM[1]/ns1:MOVEMENTS)
		            for $MOVIMIENTOS_RECIENTES in $MOVEMENTS
		            return( 
			            <MOVIMIENTOS_RECIENTES>
			                  <CARD_NUMBER>{ data($MOVIMIENTOS_RECIENTES/CARD_NUMBER) }</CARD_NUMBER>
			                  <CARD_HOLDER_NAME>{ data($MOVIMIENTOS_RECIENTES/CARD_HOLDER_NAME) }</CARD_HOLDER_NAME>
			            	 {
			            		 for $DETALLE_MOVIMIENTOS in $MOVIMIENTOS_RECIENTES/DETALLE_MOVIMIENTOS
			            		 return(
			            		 	<DETALLE_MOVIMIENTOS>
			            		 		<TRANSACTION_DATE>{ data($DETALLE_MOVIMIENTOS/TRANSACTION_DATE) }</TRANSACTION_DATE>
			            		 		<TRANSACTION_ID>{ data($DETALLE_MOVIMIENTOS/TRANSACTION_ID) }</TRANSACTION_ID>
			            		 		<AUTH_NUMBER>{ data($DETALLE_MOVIMIENTOS/AUTH_NUMBER) }</AUTH_NUMBER>
			            		 		<DESCRIPTION>{ data($DETALLE_MOVIMIENTOS/DESCRIPTION) }</DESCRIPTION>
			            		 		<AMOUNT>{ data($DETALLE_MOVIMIENTOS/AMOUNT) }</AMOUNT>
			            		 		<ORG>{ data($DETALLE_MOVIMIENTOS/ORG) }</ORG>
			            		 		<CURRENCY>{ data($DETALLE_MOVIMIENTOS/CURRENCY) }</CURRENCY>
			            		 		<ORIGINAL_AMOUNT>{ data($DETALLE_MOVIMIENTOS/ORIGINAL_AMOUNT) }</ORIGINAL_AMOUNT>
			            		 		<ORIGINAL_CURRENCY>{ data($DETALLE_MOVIMIENTOS/ORIGINAL_CURRENCY) }</ORIGINAL_CURRENCY>
			            		 		<TYPE_OF_TRANSACTION>{ data($DETALLE_MOVIMIENTOS/TYPE_OF_TRANSACTION) }</TYPE_OF_TRANSACTION>
			            		 		<TRANSACTION_CODE>{ data($DETALLE_MOVIMIENTOS/TRANSACTION_CODE) }</TRANSACTION_CODE>
                                        <PLAN_NUMBER>{ data($DETALLE_MOVIMIENTOS/PLAN_NUMBER) }</PLAN_NUMBER>
			            		 	</DETALLE_MOVIMIENTOS>
			            		 )
			            	 }
			            </MOVIMIENTOS_RECIENTES>
		            )
		        )else(
		            let $firstRow := $conDatoTarjetaResponse/ns2:RowSet/ns2:Row[1]
	        		return(
	        			for $nombreCuenta in $firstRow/ns2:Column[ @name='account_name' ]
		        		return
		        			<OWNER_NAME>{ data($nombreCuenta) }</OWNER_NAME>,
		        			
		        		for $numeroTarjeta in $firstRow/ns2:Column[ @name='numtarjeta' ]
		        		return
		        			<CARD_NUMBER>{ data($numeroTarjeta) }</CARD_NUMBER>
	        		),
		        	let $localRow := $conDatoTarjetaResponse/ns2:RowSet/ns2:Row[ ns2:Column[@name='CodMoneda']/text() = 'USD']
		        	let $localOrg := string($localRow/ns2:Column[ @name='org' ]/text())
		        	return(
	        			for $limiteCredito in $accountInquiryL8VLResponse/AZXAIO-CRLIM
	        			return
				        	if($limiteCredito != '')then(
	    						<CREDIT_LIMIT>{ data($limiteCredito) }</CREDIT_LIMIT>
	    					)else(),
	    				for $moneda in $accountInquiryL8VLResponse/AZXAIO-ORG
				        return
				        	if($moneda != '')then(
	    						<CREDIT_LIMIT_CCY>{ data($moneda) }</CREDIT_LIMIT_CCY>
	    					)else(),
	    				for $localBalancePrevio in $accountInquiryL8VLResponse/AZXAIO-LAST-CRLIM
				        return
				        	if($localBalancePrevio != '')then(
	    						<PREVIOUS_BALANCE_LCY>{ data($localBalancePrevio) }</PREVIOUS_BALANCE_LCY>
	    					)else()
		        	),
		        	for $numeroTarjeta in distinct-values($conTransaccionesActualesResponse/ns4:RowSet/ns4:Row/ns4:Column[ @name='numtarjeta' ])
		        	return
		        	<MOVIMIENTOS_RECIENTES>
		        	{
		        			<CARD_NUMBER>{ data($numeroTarjeta)}</CARD_NUMBER>,
		        			let $movs := $conTransaccionesActualesResponse/ns4:RowSet/ns4:Row[ ns4:Column[ @name='numtarjeta' ]/text() = $numeroTarjeta ]
		        			return(
		        				<CARD_HOLDER_NAME>{ data($movs[1]/ns4:Column[ @name='cardholder_name' ]) }</CARD_HOLDER_NAME>,
			        			for $mov in $movs
			        			return
			        			<DETALLE_MOVIMIENTOS>
								{
									for $transactionDate in $mov/ns4:Column[ @name='fecefectiva' ]
									return
										<TRANSACTION_DATE>{ fn-bea:dateTime-to-string-with-format('yyyyMMdd', data($transactionDate)) }</TRANSACTION_DATE>
								}
										<TRANSACTION_ID>{ data($mov/ns4:Column[ @name='NumRef' ]) }</TRANSACTION_ID>
										
								{
									for $auth_number in $mov/ns4:Column[ @name='codauth' ]
									return
										<AUTH_NUMBER>{data($auth_number)}</AUTH_NUMBER>
								}		
								{
									for $descripcion in $mov/ns4:Column[ @name='descripcion' ]
									return
										<DESCRIPTION>{data($descripcion)}</DESCRIPTION>
								}	
								{
									for $monto in $mov/ns4:Column[ @name='monto' ]
									return
										if($monto != '')then(
											<AMOUNT>{data($monto)}</AMOUNT>
										)else()
								}		
								{
									for $org in $mov/ns4:Column[ @name='org' ]
									return
										<ORG>{data($org)}</ORG>
								}	
								{
									for $moneda in $mov/ns4:Column[ @name='CodMoneda' ]
									return
										<CURRENCY>{data($moneda)}</CURRENCY>
								}
								{
									for $montoOriginal in $mov/ns4:Column[ @name='MontoOriginal' ]
									return
										<ORIGINAL_AMOUNT>{data($montoOriginal)}</ORIGINAL_AMOUNT>
								}
								{
									for $originalCurrency in $mov/ns4:Column[ @name='MonedaOriginal' ]
									return
										<ORIGINAL_CURRENCY>{data($originalCurrency)}</ORIGINAL_CURRENCY>
								}
								{
									for $transactionType in $mov/ns4:Column[ @name='TipoTransaccion' ]
									return
										<TYPE_OF_TRANSACTION>{data($transactionType)}</TYPE_OF_TRANSACTION>
								}
								{
									for $transactionCode in $mov/ns4:Column[ @name='codtxn' ]
									return
										<TRANSACTION_CODE>{data($transactionCode)}</TRANSACTION_CODE>
								}
								{
									for $planNumber in $mov/ns4:Column[ @name='NumPlan' ]
									return
										<PLAN_NUMBER>{data($planNumber)}</PLAN_NUMBER>
								}
								
			        			</DETALLE_MOVIMIENTOS>
		        		)
		        	}
	        		</MOVIMIENTOS_RECIENTES>
	        	)
	        }
        </ns3:consultaMovimientosRecientesTCReponse>
};

declare variable $conTransaccionesActualesResponse as element(ns4:OutputParameters) external;
declare variable $conDatoTarjetaResponse as element(ns2:OutputParameters) external;
declare variable $accountInquiryL8VLResponse as element(ns0:AccountInquiryL8VLResponse) external;
declare variable $outputParameters as element(ns1:OutputParameters) external;

xf:consultaMovimientosRecientesTCPAOut($conTransaccionesActualesResponse,
    $conDatoTarjetaResponse,
    $accountInquiryL8VLResponse,
    $outputParameters)
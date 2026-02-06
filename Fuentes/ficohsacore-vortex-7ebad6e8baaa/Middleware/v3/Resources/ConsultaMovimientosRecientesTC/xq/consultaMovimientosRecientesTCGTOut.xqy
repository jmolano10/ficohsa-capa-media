xquery version "2004-draft";
(:: pragma  parameter="$resultGroup" type="anyType" ::)
(:: pragma bea:global-element-parameter parameter="$conTransaccionesActualesResponse" element="ns2:OutputParameters" location="../../../../v2/BusinessServices/MasterDataGT/conTransaccionesActuales/xsd/conTransaccionesActuales_sp.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$conDatoTarjetaResponse" element="ns1:OutputParameters" location="../../../../v2/BusinessServices/MasterDataGT/conDatoTarjeta/xsd/conDatoTarjeta_sp.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns4:OutputParameters" location="../../../BusinessServices/CLIENTDATA/consultaMovimientosRecientesTC/xsd/consultaMovimientosRecientesTC_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultaMovimientosRecientesTCReponse" location="../xsd/consultaMovimientosRecientesTCTypes.xsd" ::)

declare namespace ns2 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/conTransaccionesActuales";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/conDatoTarjeta";
declare namespace ns4 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaMovimientosRecientesTC";
declare namespace ns3 = "http://www.procesa.com/fdcs";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaMovimientosRecientesTCTypes";
declare namespace xf = "http://tempuri.org/Middleware/v3/Resources/ConsultaMovimientosRecientesTC/xq/consultaMovimientosRecientesTCGTOut/";

declare function xf:consultaMovimientosRecientesTCGTOut($resultGroup as element(*)?,
    $conTransaccionesActualesResponse as element(ns2:OutputParameters)?,
    $conDatoTarjetaResponse as element(ns1:OutputParameters)?,
    $outputParameters as element(ns4:OutputParameters)?)
    as element(ns0:consultaMovimientosRecientesTCReponse) {
        <ns0:consultaMovimientosRecientesTCReponse>
            {
            	if(not(empty($outputParameters/ns4:PT_MOVIMIENTOS_RECIENTES_TC/ns4:PT_MOVIMIENTOS_RECIENTES_TC_ITEM[1]/ns4:OWNER_NAME)))then(
	                for $OWNER_NAME in $outputParameters/ns4:PT_MOVIMIENTOS_RECIENTES_TC/ns4:PT_MOVIMIENTOS_RECIENTES_TC_ITEM[1]/ns4:OWNER_NAME
	                return
	                    <OWNER_NAME>{ data($OWNER_NAME) }</OWNER_NAME>,
	                for $CARD_NUMBER in $outputParameters/ns4:PT_MOVIMIENTOS_RECIENTES_TC/ns4:PT_MOVIMIENTOS_RECIENTES_TC_ITEM[1]/ns4:CARD_NUMBER
	                return
	                    <CARD_NUMBER>{ data($CARD_NUMBER) }</CARD_NUMBER>,
	                for $CREDIT_LIMIT in $outputParameters/ns4:PT_MOVIMIENTOS_RECIENTES_TC/ns4:PT_MOVIMIENTOS_RECIENTES_TC_ITEM[1]/ns4:CREDIT_LIMIT
	                return
	                    <CREDIT_LIMIT>{ data($CREDIT_LIMIT) }</CREDIT_LIMIT>,
	                for $CREDIT_LIMIT_CCY in $outputParameters/ns4:PT_MOVIMIENTOS_RECIENTES_TC/ns4:PT_MOVIMIENTOS_RECIENTES_TC_ITEM[1]/ns4:CREDIT_LIMIT_CCY
	                return
	                    <CREDIT_LIMIT_CCY>{ data($CREDIT_LIMIT_CCY) }</CREDIT_LIMIT_CCY>,
	                for $PREVIOUS_BALANCE_LCY in $outputParameters/ns4:PT_MOVIMIENTOS_RECIENTES_TC/ns4:PT_MOVIMIENTOS_RECIENTES_TC_ITEM[1]/ns4:PREVIOUS_BALANCE_LCY
	                return
	                    <PREVIOUS_BALANCE_LCY>{ data($PREVIOUS_BALANCE_LCY) }</PREVIOUS_BALANCE_LCY>,
	                for $PREVIOUS_BALANCE_FCY in $outputParameters/ns4:PT_MOVIMIENTOS_RECIENTES_TC/ns4:PT_MOVIMIENTOS_RECIENTES_TC_ITEM[1]/ns4:PREVIOUS_BALANCE_FCY
	                return
	                    <PREVIOUS_BALANCE_FCY>{ data($PREVIOUS_BALANCE_FCY) }</PREVIOUS_BALANCE_FCY>,
		            let $MOVEMENTS := fn-bea:inlinedXML($outputParameters/ns4:PT_MOVIMIENTOS_RECIENTES_TC/ns4:PT_MOVIMIENTOS_RECIENTES_TC_ITEM[1]/ns4:MOVEMENTS)
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
	        		let $firstRow := $conDatoTarjetaResponse/ns1:RowSet/ns1:Row[1]
	        		return(
	        			for $nombreCuenta in $firstRow/ns1:Column[ @name='account_name' ]
	        			return
	        				<OWNER_NAME>{ data($nombreCuenta) }</OWNER_NAME>,
	        				
	        			for $numeroTarjeta in $firstRow/ns1:Column[ @name='numtarjeta' ]
	        			return
	        				<CARD_NUMBER>{ data($numeroTarjeta) }</CARD_NUMBER>
	        		),
	        		let $localRow := $conDatoTarjetaResponse/ns1:RowSet/ns1:Row[ ns1:Column[@name='CodMoneda']/text() = 'GTQ' ]
	        		let $foreignRow := $conDatoTarjetaResponse/ns1:RowSet/ns1:Row[ ns1:Column[@name='CodMoneda']/text() = 'USD' ]
	        		let $localOrg := string($localRow/ns1:Column[ @name='org' ]/text())
	        		let $foreignOrg := string($foreignRow/ns1:Column[ @name='org' ]/text())
	        		let $localAccountInquiryL8VLRSP := $resultGroup/ACCOUNT_INQUIRY_RESPONSES/ns3:AccountInquiryL8VLResponse[ AZXAIO-ORG = $localOrg ]
	        		let $foreignAccountInquiryL8VLRSP := $resultGroup/ACCOUNT_INQUIRY_RESPONSES/ns3:AccountInquiryL8VLResponse[ AZXAIO-ORG = $foreignOrg ]
	        		return(
	        			if(count($localAccountInquiryL8VLRSP) > 0 and count($foreignAccountInquiryL8VLRSP) > 0 ) then (
	        				for $limiteCredito in $foreignAccountInquiryL8VLRSP/AZXAIO-CRLIM
					        return
					        	if($limiteCredito != '')then(
	        						<CREDIT_LIMIT>{ data($limiteCredito) }</CREDIT_LIMIT>
	        					)else(),
	        				for $moneda in $foreignAccountInquiryL8VLRSP/AZXAIO-ORG
					        return
					     		if($moneda != '')then(
	        						<CREDIT_LIMIT_CCY>{ data($moneda) }</CREDIT_LIMIT_CCY>
	        					)else(),        				
	        				for $localBalancePrevio in $localAccountInquiryL8VLRSP/AZXAIO-LAST-CRLIM
					        return
					        	if($localBalancePrevio != '')then(
	        						<PREVIOUS_BALANCE_LCY>{ data($localBalancePrevio) }</PREVIOUS_BALANCE_LCY>	
	        					)else(),
	        				for $foreignBalancePrevio in $foreignAccountInquiryL8VLRSP/AZXAIO-LAST-CRLIM
					        return
					        	if($foreignBalancePrevio  !='')then(
	        						<PREVIOUS_BALANCE_FCY>{ data($foreignBalancePrevio) }</PREVIOUS_BALANCE_FCY>
	        					)else()	
	        			)else if(count($foreignAccountInquiryL8VLRSP)) then(
	        				for $limiteCredito in $foreignAccountInquiryL8VLRSP/AZXAIO-CRLIM
					        return
					        	if($limiteCredito != '')then(
	        						<CREDIT_LIMIT>{ data($limiteCredito) }</CREDIT_LIMIT>
	        					)else(),
	        				for $moneda in $foreignAccountInquiryL8VLRSP/AZXAIO-ORG
					        return
					        	if($moneda != '')then(
	        						<CREDIT_LIMIT_CCY>{ data($moneda) }</CREDIT_LIMIT_CCY>
	        					)else(),
	        				for $foreignBalancePrevio in $foreignAccountInquiryL8VLRSP/AZXAIO-LAST-CRLIM
					        return
					        	if($foreignBalancePrevio != '')then(
	        						<PREVIOUS_BALANCE_FCY>{ data($foreignBalancePrevio) }</PREVIOUS_BALANCE_FCY>
	        					)else()
						)else if(count($localAccountInquiryL8VLRSP)) then(
	        				for $limiteCredito in $foreignAccountInquiryL8VLRSP/AZXAIO-CRLIM
					        return
					        	if($limiteCredito != '')then(
	        						<CREDIT_LIMIT>{ data($limiteCredito) }</CREDIT_LIMIT>
	        					)else(),
	        				for $moneda in $localAccountInquiryL8VLRSP/AZXAIO-ORG
					        return
					        	if($moneda != '')then(
	        						<CREDIT_LIMIT_CCY>{ data($moneda) }</CREDIT_LIMIT_CCY>
	        					)else(),
	        				for $localBalancePrevio in $localAccountInquiryL8VLRSP/AZXAIO-LAST-CRLIM
					        return
					        	if($localBalancePrevio != '')then(
	        						<PREVIOUS_BALANCE_LCY>{ data($localBalancePrevio) }</PREVIOUS_BALANCE_LCY>
	        					)else()
	        			)else()
	    			),
	        		for $numeroTarjeta in distinct-values($conTransaccionesActualesResponse/ns2:RowSet/ns2:Row/ns2:Column[ @name='numtarjeta' ])
	        		return
	    			<MOVIMIENTOS_RECIENTES>
	    			{
    					<CARD_NUMBER>{ data($numeroTarjeta) }</CARD_NUMBER>,
    					let $movs := $conTransaccionesActualesResponse/ns2:RowSet/ns2:Row[ ns2:Column[ @name='numtarjeta' ]/text() = $numeroTarjeta ]
    					return(
    						<CARD_HOLDER_NAME>{ data($movs[1]/ns2:Column[ @name='cardholder_name' ]) }</CARD_HOLDER_NAME>,		
						for $mov in $movs
				        return
	        				<DETALLE_MOVIMIENTOS>
							{
								for $transactionDate in $mov/ns2:Column[ @name='fecefectiva' ]
								return
									<TRANSACTION_DATE>{ fn-bea:dateTime-to-string-with-format('yyyyMMdd', data($transactionDate)) }</TRANSACTION_DATE>
							}
									<TRANSACTION_ID>{ data($mov/ns2:Column[ @name='NumRef' ]) }</TRANSACTION_ID>
							{
								for $auth_number in $mov/ns2:Column[ @name='codauth' ]
								return
									<AUTH_NUMBER>{data($auth_number)}</AUTH_NUMBER>
							}
							{
								for $descripcion in $mov/ns2:Column[ @name='descripcion' ]
								return
									<DESCRIPTION>{data($descripcion)}</DESCRIPTION>
							}
							{
								for $monto in $mov/ns2:Column[ @name='monto' ]
								return
			        				if($monto != '')then(
										<AMOUNT>{data($monto)}</AMOUNT>
			        				)else()
							}
							{
								for $org in $mov/ns2:Column[ @name='org' ]
								return
									<ORG>{data($org)}</ORG>
							}
							{
								for $moneda in $mov/ns2:Column[ @name='CodMoneda' ]
								return
									<CURRENCY>{data($moneda)}</CURRENCY>
							}
							{
								for $montoOriginal in $mov/ns2:Column[ @name='MontoOriginal' ]
								return
									<ORIGINAL_AMOUNT>{data($montoOriginal)}</ORIGINAL_AMOUNT>
							}
							{
								for $originalCurrency in $mov/ns2:Column[ @name='MonedaOriginal' ]
								return
									<ORIGINAL_CURRENCY>{data($originalCurrency)}</ORIGINAL_CURRENCY>
							}
							{
								for $transactionType in $mov/ns2:Column[ @name='TipoTransaccion' ]
								return
									<TYPE_OF_TRANSACTION>{data($transactionType)}</TYPE_OF_TRANSACTION>
							}
							{
									for $transactionCode in $mov/ns2:Column[ @name='codtxn' ]
									return
										<TRANSACTION_CODE>{data($transactionCode)}</TRANSACTION_CODE>
								}
								{
									for $planNumber in $mov/ns2:Column[ @name='NumPlan' ]
									return
										<PLAN_NUMBER>{data($planNumber)}</PLAN_NUMBER>
								}
	        				</DETALLE_MOVIMIENTOS>
	        			)
	        		}
	    			</MOVIMIENTOS_RECIENTES>
		        )
            }
        </ns0:consultaMovimientosRecientesTCReponse>
};

declare variable $resultGroup as element(*)? external;
declare variable $conTransaccionesActualesResponse as element(ns2:OutputParameters)? external;
declare variable $conDatoTarjetaResponse as element(ns1:OutputParameters)? external;
declare variable $outputParameters as element(ns4:OutputParameters)? external;

xf:consultaMovimientosRecientesTCGTOut($resultGroup,
    $conTransaccionesActualesResponse,
    $conDatoTarjetaResponse,
    $outputParameters)
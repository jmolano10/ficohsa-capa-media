(:: pragma  parameter="$resultGroup" type="anyType" ::)
(:: pragma bea:global-element-parameter parameter="$conTransaccionesActualesResponse" element="ns2:OutputParameters" location="../../../../v2/BusinessServices/ProcesosPA/conTransaccionesActuales/xsd/conTransaccionesActuales_sp.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$conDatoTarjetaResponse" element="ns0:OutputParameters" location="../../../../v2/BusinessServices/ProcesosPA/conDatoTarjeta/xsd/conDatoTarjeta_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/CLIENTDATA/registraMovimientosRecientesTC/xsd/registraMovimientosRecientesTC_sp.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$accountInquiryVAResponse" element="ns3:AccountInquiryVAResponse" location="../../../../v2/BusinessServices/VisionPlusPA/vmx/wsdl/VMX.wsdl" ::)

declare namespace ns2 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/conTransaccionesActuales";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/registraMovimientosRecientesTC";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/conDatoTarjeta";
declare namespace xf = "http://tempuri.org/Middleware/v3/Resources/ConsultaMovimientosRecientesTC/xq/registraMovimientosRecientesTCIn/";
declare namespace ns3 = "http://www.procesa.com/fdcs";

declare function xf:registraMovimientosRecientesTCPAIn($accountInquiryVAResponse as element(ns3:AccountInquiryVAResponse),
    $conTransaccionesActualesResponse as element(ns2:OutputParameters),
    $conDatoTarjetaResponse as element(ns0:OutputParameters),
	$countryCode as xs:string)
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:PT_MOVIMIENTOS_RECIENTES_TC>
                <ns1:PT_MOVIMIENTOS_RECIENTES_TC_ITEM>
               		{
		        		let $firstRow := $conDatoTarjetaResponse/ns0:RowSet/ns0:Row[1]
		        		return(
		        			for $numeroTarjeta in $firstRow/ns0:Column[ @name='numtarjeta' ]
		        			return(
	        					<ns1:CARD_NUMBER>{ data($numeroTarjeta) }</ns1:CARD_NUMBER>
        					),
		        			for $nombreCuenta in $firstRow/ns0:Column[ @name='account_name' ]
		        			return(
        						<ns1:OWNER_NAME>{ data($nombreCuenta) }</ns1:OWNER_NAME>
        					)
        				)
        			}
        			{
		        	let $localRow := $conDatoTarjetaResponse/ns1:RowSet/ns1:Row[ ns1:Column[@name='CodMoneda']/text() = 'USD']
		        	let $localOrg := string($localRow/ns1:Column[ @name='org' ]/text())
		        	return(
	        			for $limiteCredito in $accountInquiryVAResponse/ARXAIO-CRLIM
	        			return
				        	if($limiteCredito != '')then(
	    						<ns1:CREDIT_LIMIT>{ data($limiteCredito) }</ns1:CREDIT_LIMIT>
	    					)else(),
	    				for $moneda in $accountInquiryVAResponse/ARXAIO-ORG
				        return
				        	if($moneda != '')then(
	    						<ns1:CREDIT_LIMIT_CCY>{ data($moneda) }</ns1:CREDIT_LIMIT_CCY>
	    					)else(),
	    				for $localBalancePrevio in $accountInquiryVAResponse/ARXAIO-LAST-CRLIM
				        return
				        	if($localBalancePrevio != '')then(
	    						<ns1:PREVIOUS_BALANCE_LCY>{ data($localBalancePrevio) }</ns1:PREVIOUS_BALANCE_LCY>
	    					)else()
		        	) 
	        	}
					<ns1:MOVEMENTS>{
						fn-bea:serialize(
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
        						      	        <TRANSACTION_CODE>{ data($transactionCode) }</TRANSACTION_CODE>
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
					</ns1:MOVEMENTS>
                </ns1:PT_MOVIMIENTOS_RECIENTES_TC_ITEM>
            </ns1:PT_MOVIMIENTOS_RECIENTES_TC>
			 <ns1:PV_COUNTRY_CODE>{ data($countryCode) }</ns1:PV_COUNTRY_CODE>
        </ns1:InputParameters>
};


declare variable $accountInquiryVAResponse as element(ns3:AccountInquiryVAResponse) external;
declare variable $conTransaccionesActualesResponse as element(ns2:OutputParameters) external;
declare variable $conDatoTarjetaResponse as element(ns0:OutputParameters) external;
declare variable $countryCode as xs:string external;
xf:registraMovimientosRecientesTCPAIn($accountInquiryVAResponse,
    $conTransaccionesActualesResponse,
    $conDatoTarjetaResponse,
	$countryCode)
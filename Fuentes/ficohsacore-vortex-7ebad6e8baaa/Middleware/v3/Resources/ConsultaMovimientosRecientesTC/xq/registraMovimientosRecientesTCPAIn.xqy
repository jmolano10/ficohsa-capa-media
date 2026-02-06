xquery version "2004-draft" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$accountInquiryL8VLResponse" element="ns0:AccountInquiryL8VLResponse" location="../../../../v2/BusinessServices/VisionPlusPA/vmx/wsdl/VMX.wsdl" ::)
(:: pragma bea:global-element-parameter parameter="$conTransaccionesActualesResponse" element="ns3:OutputParameters" location="../../../../v2/BusinessServices/ProcesosPA/conTransaccionesActuales/xsd/conTransaccionesActuales_sp.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$conDatoTarjetaResponse" element="ns1:OutputParameters" location="../../../../v2/BusinessServices/ProcesosPA/conDatoTarjeta/xsd/conDatoTarjeta_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns2:InputParameters" location="../../../../v2/BusinessServices/CLIENTDATA/registraMovimientosRecientesTC/xsd/registraMovimientosRecientesTC_sp.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v3/Resources/ConsultaMovimientosRecientesTC/xq/registraMovimientosRecientesTCPAIn/";
declare namespace ns2 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/registraMovimientosRecientesTC";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/conDatoTarjeta";
declare namespace ns3 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/conTransaccionesActuales";
declare namespace ns0 = "http://www.procesa.com/fdcs";

declare function xf:registraMovimientosRecientesTCPAIn($accountInquiryL8VLResponse as element(ns0:AccountInquiryL8VLResponse),
    $conTransaccionesActualesResponse as element(ns3:OutputParameters),
    $conDatoTarjetaResponse as element(ns1:OutputParameters),
    $countryCode as xs:string)
    as element(ns2:InputParameters) {
    <ns2:InputParameters>
            <ns2:PT_MOVIMIENTOS_RECIENTES_TC>
                <ns2:PT_MOVIMIENTOS_RECIENTES_TC_ITEM>
               		{
		        		let $firstRow := $conDatoTarjetaResponse/ns1:RowSet/ns1:Row[1]
		        		return(
		        			for $numeroTarjeta in $firstRow/ns1:Column[ @name='numtarjeta' ]
		        			return(
	        					<ns2:CARD_NUMBER>{ data($numeroTarjeta) }</ns2:CARD_NUMBER>
        					),
		        			for $nombreCuenta in $firstRow/ns1:Column[ @name='account_name' ]
		        			return(
        						<ns2:OWNER_NAME>{ data($nombreCuenta) }</ns2:OWNER_NAME>
        					)
        				)
        			}
        			{
		        	let $localRow := $conDatoTarjetaResponse/ns2:RowSet/ns2:Row[ ns2:Column[@name='CodMoneda']/text() = 'USD']
		        	let $localOrg := string($localRow/ns2:Column[ @name='org' ]/text())
		        	return(
	        			for $limiteCredito in $accountInquiryL8VLResponse/AZXAIO-CRLIM
	        			return
				        	if($limiteCredito != '')then(
	    						<ns2:CREDIT_LIMIT>{ data($limiteCredito) }</ns2:CREDIT_LIMIT>
	    					)else(),
	    				for $moneda in $accountInquiryL8VLResponse/AZXAIO-ORG
				        return
				        	if($moneda != '')then(
	    						<ns2:CREDIT_LIMIT_CCY>{ data($moneda) }</ns2:CREDIT_LIMIT_CCY>
	    					)else(),
	    				for $localBalancePrevio in $accountInquiryL8VLResponse/AZXAIO-LAST-CRLIM
				        return
				        	if($localBalancePrevio != '')then(
	    						<ns2:PREVIOUS_BALANCE_LCY>{ data($localBalancePrevio) }</ns2:PREVIOUS_BALANCE_LCY>
	    					)else()
		        	) 
	        	}
					<ns2:MOVEMENTS>{
						fn-bea:serialize(
							for $numeroTarjeta in distinct-values($conTransaccionesActualesResponse/ns3:RowSet/ns3:Row/ns3:Column[ @name='numtarjeta' ])
			        		return
			    			<MOVIMIENTOS_RECIENTES>
			    			{
		    					<CARD_NUMBER>{ data($numeroTarjeta) }</CARD_NUMBER>,
		    					let $movs := $conTransaccionesActualesResponse/ns3:RowSet/ns3:Row[ ns3:Column[ @name='numtarjeta' ]/text() = $numeroTarjeta ]
		    					return(
		    						<CARD_HOLDER_NAME>{ data($movs[1]/ns3:Column[ @name='cardholder_name' ]) }</CARD_HOLDER_NAME>,
									for $mov in $movs
							        return
					        			<DETALLE_MOVIMIENTOS>
										{
											for $transactionDate in $mov/ns3:Column[ @name='fecefectiva' ]
											return
												<TRANSACTION_DATE>{ fn-bea:dateTime-to-string-with-format('yyyyMMdd', data($transactionDate)) }</TRANSACTION_DATE>
										}
												<TRANSACTION_ID>{ data($mov/ns3:Column[ @name='NumRef' ]) }</TRANSACTION_ID>
										{
											for $auth_number in $mov/ns3:Column[ @name='codauth' ]
											return
												<AUTH_NUMBER>{data($auth_number)}</AUTH_NUMBER>
										}
										{
											for $descripcion in $mov/ns3:Column[ @name='descripcion' ]
											return
												<DESCRIPTION>{data($descripcion)}</DESCRIPTION>
										}
										{
											for $monto in $mov/ns3:Column[ @name='monto' ]
											return
						        				if($monto != '')then(
													<AMOUNT>{data($monto)}</AMOUNT>
						        				)else()
										}
										{
											for $org in $mov/ns3:Column[ @name='org' ]
											return
												<ORG>{data($org)}</ORG>
										}
										{
											for $moneda in $mov/ns3:Column[ @name='CodMoneda' ]
											return
												<CURRENCY>{data($moneda)}</CURRENCY>
										}
										{
											for $montoOriginal in $mov/ns3:Column[ @name='MontoOriginal' ]
											return
												<ORIGINAL_AMOUNT>{data($montoOriginal)}</ORIGINAL_AMOUNT>
										}
										{
											for $originalCurrency in $mov/ns3:Column[ @name='MonedaOriginal' ]
											return
												<ORIGINAL_CURRENCY>{data($originalCurrency)}</ORIGINAL_CURRENCY>
										}
										{
											for $transactionType in $mov/ns3:Column[ @name='TipoTransaccion' ]
											return
												<TYPE_OF_TRANSACTION>{data($transactionType)}</TYPE_OF_TRANSACTION>
										}
										{
        						            for $transactionCode in $mov/ns3:Column[ @name='codtxn' ]
        						            return
        						      	        <TRANSACTION_CODE>{ data($transactionCode) }</TRANSACTION_CODE>
        					            }
                                        {
                                            for $planNumber in $mov/ns3:Column[ @name='NumPlan' ]
                                            return
                                                <PLAN_NUMBER>{data($planNumber)}</PLAN_NUMBER>
                                        }
			        					</DETALLE_MOVIMIENTOS>
	        						)
	        				}
	    					</MOVIMIENTOS_RECIENTES>
						)
					}
					</ns2:MOVEMENTS>
                </ns2:PT_MOVIMIENTOS_RECIENTES_TC_ITEM>
            </ns2:PT_MOVIMIENTOS_RECIENTES_TC>
			 <ns2:PV_COUNTRY_CODE>{ data($countryCode) }</ns2:PV_COUNTRY_CODE>
        </ns2:InputParameters>
};

declare variable $accountInquiryL8VLResponse as element(ns0:AccountInquiryL8VLResponse) external;
declare variable $conTransaccionesActualesResponse as element(ns3:OutputParameters) external;
declare variable $conDatoTarjetaResponse as element(ns1:OutputParameters) external;
declare variable $countryCode as xs:string external;

xf:registraMovimientosRecientesTCPAIn($accountInquiryL8VLResponse,
    $conTransaccionesActualesResponse,
    $conDatoTarjetaResponse,
    $countryCode)
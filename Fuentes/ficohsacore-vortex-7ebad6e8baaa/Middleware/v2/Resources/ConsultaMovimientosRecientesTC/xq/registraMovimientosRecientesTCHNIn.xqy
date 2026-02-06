xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$conDatoTarjeta" element="ns0:OutputParameters" location="../../../BusinessServices/ProcesosHN/conDatoTarjeta/xsd/conDatoTarjeta_sp.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$conTransaccionesActuales" element="ns2:OutputParameters" location="../../../BusinessServices/ProcesosHN/conTransaccionesActuales/xsd/conTransaccionesActuales_sp.xsd" ::)
(:: pragma  parameter="$resultGroup" type="anyType" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/CLIENTDATA/registraMovimientosRecientesTC/xsd/registraMovimientosRecientesTC_sp.xsd" ::)

declare namespace ns2 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/conTransaccionesActuales";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/registraMovimientosRecientesTC";
declare namespace ns3 = "http://www.procesa.com/fdcs";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/conDatoTarjeta";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaMovimientosRecientesTC/xq/registraMovimientosRecientesTCHNIn/";

declare function xf:registraMovimientosRecientesTCHNIn($conDatoTarjeta as element(ns0:OutputParameters),
    $conTransaccionesActuales as element(ns2:OutputParameters),
    $resultGroup as element(*),
    $countryCode as xs:string)
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:PT_MOVIMIENTOS_RECIENTES_TC>
                <ns1:PT_MOVIMIENTOS_RECIENTES_TC_ITEM>
                 {
		        	let $firstRow := $conDatoTarjeta/ns0:RowSet/ns0:Row[1]
		        	return(
		        		for $ownerName in $firstRow/ns0:Column[@name = 'account_name']
		        		return
		        			<ns1:OWNER_NAME>{ data($ownerName) }</ns1:OWNER_NAME>,
		        		
		        		for $cardNumber in $firstRow/ns0:Column[@name = 'numtarjeta']
			        	return
			        		<ns1:CARD_NUMBER>{ data($cardNumber) }</ns1:CARD_NUMBER>
		        	)
		        }
                {
		        	let $localRow := $conDatoTarjeta/ns0:RowSet/ns0:Row[ ns0:Column[@name = 'CodMoneda']/text() = 'HNL']
		        	let $foreignRow := $conDatoTarjeta/ns0:RowSet/ns0:Row[ ns0:Column[@name = 'CodMoneda']/text() = 'USD']
		        	let $localOrg := string($localRow/ns0:Column[@name = 'org']/text())
		        	let $foreignOrg := string($foreignRow/ns0:Column[@name = 'org']/text())
		        	let $localAccountInquiryL8VLRSP := $resultGroup/ACCOUNT_INQUIRY_RESPONSES/ns3:AccountInquiryL8VLResponse[AZXAIO-ORG = $localOrg]
		        	let $foreignAccountInquiryRSP := $resultGroup/ACCOUNT_INQUIRY_RESPONSES/ns3:AccountInquiryL8VLResponse[AZXAIO-ORG = $foreignOrg]
		        	return(
		        		if(count($localAccountInquiryL8VLRSP) > 0 and count($foreignAccountInquiryRSP) > 0 ) then (
		        				
		        			for $creditLimit in $foreignAccountInquiryRSP/AZXAIO-CRLIM
						    return
						        <ns1:CREDIT_LIMIT>{ data($creditLimit) }</ns1:CREDIT_LIMIT>,
						        
						   	<ns1:CREDIT_LIMIT_CCY>USD</ns1:CREDIT_LIMIT_CCY>,
						        
						    for $localPreviousBalance in $localAccountInquiryL8VLRSP/AZXAIO-LAST-CRLIM
						    return
						        <ns1:PREVIOUS_BALANCE_LCY>{ data($localPreviousBalance) }</ns1:PREVIOUS_BALANCE_LCY>,
						        
						    for $foreignPreviousBalance in $foreignAccountInquiryRSP/AZXAIO-LAST-CRLIM
						    return
						        <ns1:PREVIOUS_BALANCE_FCY>{ data($foreignPreviousBalance) }</ns1:PREVIOUS_BALANCE_FCY>
						            
		        		)else if(count($foreignAccountInquiryRSP) > 0)then (
		        				
		        			for $creditLimit in $foreignAccountInquiryRSP/AZXAIO-CRLIM
						    return
						        <ns1:CREDIT_LIMIT>{ data($creditLimit) }</ns1:CREDIT_LIMIT>,
						        
						    <ns1:CREDIT_LIMIT_CCY>USD</ns1:CREDIT_LIMIT_CCY>,
						        
						    for $foreignPreviousBalance in $foreignAccountInquiryRSP/AZXAIO-LAST-CRLIM
						    return
						        <ns1:PREVIOUS_BALANCE_FCY>{ data($foreignPreviousBalance) }</ns1:PREVIOUS_BALANCE_FCY>
						            
		        		)else if(count($localAccountInquiryL8VLRSP) > 0 )then (
		        			
		        			for $creditLimit in $localAccountInquiryL8VLRSP/AZXAIO-CRLIM
						    return
						        <ns1:CREDIT_LIMIT>{ data($creditLimit) }</ns1:CREDIT_LIMIT>,
						        
						    <ns1:CREDIT_LIMIT_CCY>HNL</ns1:CREDIT_LIMIT_CCY>,
						        
						    for $localPreviousBalance in $localAccountInquiryL8VLRSP/AZXAIO-LAST-CRLIM
						    return
						        <ns1:PREVIOUS_BALANCE_LCY>{ data($localPreviousBalance) }</ns1:PREVIOUS_BALANCE_LCY>
						            
		        		)else()   		
		        	)
		        }  
		        <ns1:MOVEMENTS_DETAIL>
		        {
		        	fn-bea:serialize(
			        	for $cardNumber in distinct-values($conTransaccionesActuales/ns2:RowSet/ns2:Row/ns2:Column[@name = 'numtarjeta'])
			        	return
				        	<consultaMovimientosRecientesTCTarjetasAdicionales>
				        	{	        			
			        			<CARD_NUMBER>{ data($cardNumber) }</CARD_NUMBER>,
			        			let $movs := $conTransaccionesActuales/ns2:RowSet/ns2:Row[ ns2:Column[@name = 'numtarjeta']/text() = $cardNumber]
			        			return(
			        				<CARD_HOLDER_NAME>{ data($movs[1]/ns2:Column[@name = 'cardholder_name']) }</CARD_HOLDER_NAME>,
						        	<consultaMovimientosRecientesTCRegistroTarjetasAdicionales>
						        	{
						        		for $mov in $movs
						        		return
							        		<consultaMovimientosRecientesTCDetalleTarjeta>
							        		{
							        			for $transactionDate in $mov/ns2:Column[@name = 'fecefectiva']
							        			return
							        				<TRANSACTION_DATE>{ fn-bea:dateTime-to-string-with-format('yyyyMMdd', data($transactionDate)) }</TRANSACTION_DATE>
							        		}
							        		{
							        			for $description in $mov/ns2:Column[@name = 'descripcion']
							        			return
							        				<DESCRIPTION>{ data($description) }</DESCRIPTION>
							        		}
							        		{
							        			for $amount in $mov/ns2:Column[@name = 'monto']
							        			return
							        				<AMOUNT>{ data($amount) }</AMOUNT>
							        		}
							        		{
							        			for $currency in $mov/ns2:Column[@name = 'CodMoneda']
							        			return
							        				<CURRENCY>{ data($currency) }</CURRENCY>
							        		}
							        		{
							        			for $originalAmount in $mov/ns2:Column[@name = 'MontoOriginal']
							        			return
							        				<ORIGINAL_AMOUNT>{ data($originalAmount) }</ORIGINAL_AMOUNT>				        					}
							        		{
							        			for $originalCurrency in $mov/ns2:Column[@name = 'MonedaOriginal']
							        			return
							        				<ORIGINAL_CURRENCY>{ data($originalCurrency) }</ORIGINAL_CURRENCY>
							        		}
							        		{
							        			for $transactionType in $mov/ns2:Column[@name = 'TipoTransaccion']
							        			return
							        				<TYPE_OF_TRANSACTION>{ data($transactionType) }</TYPE_OF_TRANSACTION>
							        		}
								        	</consultaMovimientosRecientesTCDetalleTarjeta>
						        		}
						        		</consultaMovimientosRecientesTCRegistroTarjetasAdicionales>
						        	)
					        	}
					        	</consultaMovimientosRecientesTCTarjetasAdicionales>
       			 		 )
		        	}   
		        	</ns1:MOVEMENTS_DETAIL>  
                </ns1:PT_MOVIMIENTOS_RECIENTES_TC_ITEM>
            </ns1:PT_MOVIMIENTOS_RECIENTES_TC>
            <ns1:PV_COUNTRY_CODE>{ $countryCode }</ns1:PV_COUNTRY_CODE>
        </ns1:InputParameters>
};

declare variable $conDatoTarjeta as element(ns0:OutputParameters) external;
declare variable $conTransaccionesActuales as element(ns2:OutputParameters) external;
declare variable $resultGroup as element(*) external;
declare variable $countryCode as xs:string external;

xf:registraMovimientosRecientesTCHNIn($conDatoTarjeta,
    $conTransaccionesActuales,
    $resultGroup,
    $countryCode)
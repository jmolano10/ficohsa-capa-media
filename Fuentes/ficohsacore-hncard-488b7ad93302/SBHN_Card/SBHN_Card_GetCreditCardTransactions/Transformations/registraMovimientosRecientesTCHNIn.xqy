xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/conTransaccionesActuales_v2";
(:: import schema at "../Schemas/conTransaccionesActuales_v2_sp.xsd" ::)

declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/registraMovimientosRecientesTC";
(:: import schema at "../Schemas/registraMovimientosRecientesTC_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/conDatoTarjetaBS";
(:: import schema at "../Schemas/conDatoTarjetaBS_sp.xsd" ::)

declare namespace ns3 = "http://www.procesa.com/fdcs";

declare variable $conDatoTarjeta as element() (:: schema-element(ns0:OutputParameters) ::) external;
declare variable $conTransaccionesActuales as element() (:: schema-element(ns2:OutputParameters) ::) external;
declare variable $resultGroup as element(*) external;
declare variable $countryCode as xs:string external;

declare function local:registraMovimientosRecientesTCHNIn($conDatoTarjeta as element()(:: schema-element(ns0:OutputParameters) ::),
    $conTransaccionesActuales as element() (:: schema-element(ns2:OutputParameters) ::),
    $resultGroup as element(*),
    $countryCode as xs:string)
    as element() (:: schema-element(ns1:InputParameters) ::) {
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
			        	let $localRow := $conDatoTarjeta/ns0:RowSet/ns0:Row[ ns0:Column[@name = 'CodMoneda']/text() = 'GTQ']
			        	let $foreignRow := $conDatoTarjeta/ns0:RowSet/ns0:Row[ ns0:Column[@name = 'CodMoneda']/text() = 'USD']
			        	let $localOrg := string($localRow/ns0:Column[@name = 'org']/text())
			        	let $foreignOrg := string($foreignRow/ns0:Column[@name = 'org']/text())
			        	let $localAccoutnInquiryRSP := $resultGroup/ACCOUNT_INQUIRY_RESPONSES/ns3:AccountInquiryVAResponse[ARXAIO-ORG = $localOrg]
			        	let $foreignAccoutnInquiryRSP := $resultGroup/ACCOUNT_INQUIRY_RESPONSES/ns3:AccountInquiryVAResponse[ARXAIO-ORG = $foreignOrg]
			        	return(
			        		if(count($localAccoutnInquiryRSP) > 0 and count($foreignAccoutnInquiryRSP) > 0 ) then (
			        				
			        			for $creditLimit in $foreignAccoutnInquiryRSP/ARXAIO-CRLIM
							    return
							        <ns1:CREDIT_LIMIT>{ data($creditLimit) }</ns1:CREDIT_LIMIT>,
							        
							   	<ns1:CREDIT_LIMIT_CCY>USD</ns1:CREDIT_LIMIT_CCY>,
							        
							    for $localPreviousBalance in $localAccoutnInquiryRSP/ARXAIO-LAST-CRLIM
							    return
							        <ns1:PREVIOUS_BALANCE_LCY>{ data($localPreviousBalance) }</ns1:PREVIOUS_BALANCE_LCY>,
							        
							    for $foreignPreviousBalance in $foreignAccoutnInquiryRSP/ARXAIO-LAST-CRLIM
							    return
							        <ns1:PREVIOUS_BALANCE_FCY>{ data($foreignPreviousBalance) }</ns1:PREVIOUS_BALANCE_FCY>
							            
			        		)else if(count($foreignAccoutnInquiryRSP) > 0)then (
			        				
			        			for $creditLimit in $foreignAccoutnInquiryRSP/ARXAIO-CRLIM
							    return
							        <ns1:CREDIT_LIMIT>{ data($creditLimit) }</ns1:CREDIT_LIMIT>,
							        
							    <ns1:CREDIT_LIMIT_CCY>USD</ns1:CREDIT_LIMIT_CCY>,
							        
							    for $foreignPreviousBalance in $foreignAccoutnInquiryRSP/ARXAIO-LAST-CRLIM
							    return
							        <ns1:PREVIOUS_BALANCE_FCY>{ data($foreignPreviousBalance) }</ns1:PREVIOUS_BALANCE_FCY>
							            
			        		)else if(count($localAccoutnInquiryRSP) > 0 )then (
			        			
			        			for $creditLimit in $localAccoutnInquiryRSP/ARXAIO-CRLIM
							    return
							        <ns1:CREDIT_LIMIT>{ data($creditLimit) }</ns1:CREDIT_LIMIT>,
							        
							    <ns1:CREDIT_LIMIT_CCY>GTQ</ns1:CREDIT_LIMIT_CCY>,
							        
							    for $localPreviousBalance in $localAccoutnInquiryRSP/ARXAIO-LAST-CRLIM
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
							        				<TRANSACTION_DATE>{data($transactionDate) }</TRANSACTION_DATE>
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


local:registraMovimientosRecientesTCHNIn($conDatoTarjeta,
    $conTransaccionesActuales,
    $resultGroup,
    $countryCode)
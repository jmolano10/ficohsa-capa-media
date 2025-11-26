xquery version "1.0" encoding "Cp1252";
(:: pragma  parameter="$resultGroup" type="xs:anyType" ::)
(:: pragma bea:global-element-parameter parameter="$conDatoTarjeta" element="ns0:OutputParameters" location="../../../BusinessServices/MasterDataGT/conDatoTarjeta/xsd/conDatoTarjeta_sp.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$conTransaccionesActuales" element="ns2:OutputParameters" location="../../../BusinessServices/ProcesosGT/conTransaccionesActuales/xsd/conTransaccionesActuales_v2_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaMovimientosRecientesTCResponse" location="../../../../Business_Resources/tarjetaCredito/ConsultaMovimientosRecientesTC/consultaMovimientosRecientesTCTypes.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns4:OutputParameters" location="../../../BusinessServices/CLIENTDATA/consultaMovimientosRecientesTC/xsd/consultaMovimientosRecientesTC_sp.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaMovimientosRecientesTC/xq/consultaMovsRecientesTCGTOut/";
declare namespace ns2 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/conTransaccionesActuales_v2";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaMovimientosRecientesTCTypes";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/conDatoTarjeta";
declare namespace ns3 = "http://www.procesa.com/fdcs";
declare namespace ns4 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaMovimientosRecientesTC";

declare function xf:consultaMovsRecientesTCGTOut($resultGroup as element(*)?, $conDatoTarjeta as element(ns0:OutputParameters)?,
    $conTransaccionesActuales as element(ns2:OutputParameters)?, 
     $outputParameters as element(ns4:OutputParameters)?)
    as element(ns1:consultaMovimientosRecientesTCResponse) {
        <ns1:consultaMovimientosRecientesTCResponse>
        {
        	if(not(empty($outputParameters/ns4:PT_MOVIMIENTOS_RECIENTES_TC/ns4:PT_MOVIMIENTOS_RECIENTES_TC_ITEM[1]))) then (
	    		let $ITEM := $outputParameters/ns4:PT_MOVIMIENTOS_RECIENTES_TC/ns4:PT_MOVIMIENTOS_RECIENTES_TC_ITEM[1]
	   			return(
	   				<OWNER_NAME>{ data($ITEM/ns4:OWNER_NAME) }</OWNER_NAME>,
	   				<CARD_NUMBER>{ data($ITEM/ns4:CARD_NUMBER) }</CARD_NUMBER>,
	   				<CREDIT_LIMIT>{ data($ITEM/ns4:CREDIT_LIMIT) }</CREDIT_LIMIT>,
	   				<CREDIT_LIMIT_CCY>{ data($ITEM/ns4:CREDIT_LIMIT_CCY) }</CREDIT_LIMIT_CCY>,
	   				<PREVIOUS_BALANCE_LCY>{ data($ITEM/ns4:PREVIOUS_BALANCE_LCY) }</PREVIOUS_BALANCE_LCY>,
	   				<PREVIOUS_BALANCE_FCY>{ data($ITEM/ns4:PREVIOUS_BALANCE_FCY) }</PREVIOUS_BALANCE_FCY>,
	            	let $ADDITIONAL_CARDS := fn-bea:inlinedXML($ITEM/ns4:MOVEMENTS_DETAIL)
	                for $CARDITEMS in $ADDITIONAL_CARDS
	                return(
			            <ns1:consultaMovimientosRecientesTCTarjetasAdicionales>
			              	<CARD_NUMBER>{ data($CARDITEMS/CARD_NUMBER) }</CARD_NUMBER> 
			              	<CARD_HOLDER_NAME>{ data($CARDITEMS/CARD_HOLDER_NAME) }</CARD_HOLDER_NAME>
			              	<ns1:consultaMovimientosRecientesTCRegistroTarjetasAdicionales>
			              	
			              		{	
			              			for $MOVIMIENTOS in $CARDITEMS/consultaMovimientosRecientesTCRegistroTarjetasAdicionales/consultaMovimientosRecientesTCDetalleTarjeta
			              			return(
					              		<ns1:consultaMovimientosRecientesTCDetalleTarjeta>
					              			<TRANSACTION_DATE>{ data($MOVIMIENTOS/TRANSACTION_DATE) }</TRANSACTION_DATE>
					              			<DESCRIPTION>{ data($MOVIMIENTOS/DESCRIPTION) }</DESCRIPTION>
					              			<AMOUNT>{ data($MOVIMIENTOS/AMOUNT) }</AMOUNT>
					              			<CURRENCY>{ data($MOVIMIENTOS/AMOUNT) }</CURRENCY>
					              			<ORIGINAL_AMOUNT>{ data($MOVIMIENTOS/ORIGINAL_AMOUNT) }</ORIGINAL_AMOUNT>
					              			<ORIGINAL_CURRENCY>{ data($MOVIMIENTOS/ORIGINAL_CURRENCY) }</ORIGINAL_CURRENCY>
					              			<TYPE_OF_TRANSACTION>{ data($MOVIMIENTOS/TYPE_OF_TRANSACTION) }</TYPE_OF_TRANSACTION>
					              		</ns1:consultaMovimientosRecientesTCDetalleTarjeta>
				              		)
			              		}
			              	</ns1:consultaMovimientosRecientesTCRegistroTarjetasAdicionales>
			            </ns1:consultaMovimientosRecientesTCTarjetasAdicionales>
		              )
	          	 )
	         )else(
	        	let $firstRow := $conDatoTarjeta/ns0:RowSet/ns0:Row[1]
	        	return(
	        		for $ownerName in $firstRow/ns0:Column[@name = 'account_name']
	        		return
	        			<OWNER_NAME>{ data($ownerName) }</OWNER_NAME>,
	        		
	        		for $cardNumber in $firstRow/ns0:Column[@name = 'numtarjeta']
		        	return
		        		<CARD_NUMBER>{ data($cardNumber) }</CARD_NUMBER>
	        	),
	        	let $localRow := $conDatoTarjeta/ns0:RowSet/ns0:Row[ ns0:Column[@name = 'CodMoneda']/text() = 'GTQ']
	        	let $foreignRow := $conDatoTarjeta/ns0:RowSet/ns0:Row[ ns0:Column[@name = 'CodMoneda']/text() = 'USD']
	        	let $localOrg := string($localRow/ns0:Column[@name = 'org']/text())
	        	let $foreignOrg := string($foreignRow/ns0:Column[@name = 'org']/text())
	        	let $localAccountInquiryL8VLRSP := $resultGroup/ACCOUNT_INQUIRY_RESPONSES/ns3:AccountInquiryL8VLResponse[AZXAIO-ORG = $localOrg]
	        	let $foreignAccountInquiryL8VLRSP := $resultGroup/ACCOUNT_INQUIRY_RESPONSES/ns3:AccountInquiryL8VLResponse[AZXAIO-ORG = $foreignOrg]
	        	return(
	        		if(count($localAccountInquiryL8VLRSP) > 0 and count($foreignAccountInquiryL8VLRSP) > 0 ) then (
	        				
	        			for $creditLimit in $foreignAccountInquiryL8VLRSP/AZXAIO-CRLIM
					    return
					        <CREDIT_LIMIT>{ data($creditLimit) }</CREDIT_LIMIT>,
					        
					   	<CREDIT_LIMIT_CCY>USD</CREDIT_LIMIT_CCY>,
					        
					    for $localPreviousBalance in $localAccountInquiryL8VLRSP/AZXAIO-LAST-CRLIM
					    return
					        <PREVIOUS_BALANCE_LCY>{ data($localPreviousBalance) }</PREVIOUS_BALANCE_LCY>,
					        
					    for $foreignPreviousBalance in $foreignAccountInquiryL8VLRSP/AZXAIO-LAST-CRLIM
					    return
					        <PREVIOUS_BALANCE_FCY>{ data($foreignPreviousBalance) }</PREVIOUS_BALANCE_FCY>
					            
	        		)else if(count($foreignAccountInquiryL8VLRSP) > 0)then (
	        				
	        			for $creditLimit in $foreignAccountInquiryL8VLRSP/AZXAIO-CRLIM
					    return
					        <CREDIT_LIMIT>{ data($creditLimit) }</CREDIT_LIMIT>,
					        
					    <CREDIT_LIMIT_CCY>USD</CREDIT_LIMIT_CCY>,
					        
					    for $foreignPreviousBalance in $foreignAccountInquiryL8VLRSP/AZXAIO-LAST-CRLIM
					    return
					        <PREVIOUS_BALANCE_FCY>{ data($foreignPreviousBalance) }</PREVIOUS_BALANCE_FCY>
					            
	        		)else if(count($localAccountInquiryL8VLRSP) > 0 )then (
	        			
	        			for $creditLimit in $localAccountInquiryL8VLRSP/AZXAIO-CRLIM
					    return
					        <CREDIT_LIMIT>{ data($creditLimit) }</CREDIT_LIMIT>,
					        
					    <CREDIT_LIMIT_CCY>GTQ</CREDIT_LIMIT_CCY>,
					        
					    for $localPreviousBalance in $localAccountInquiryL8VLRSP/AZXAIO-LAST-CRLIM
					    return
					        <PREVIOUS_BALANCE_LCY>{ data($localPreviousBalance) }</PREVIOUS_BALANCE_LCY>
					            
	        		)else()   		
	        	),
	        	for $cardNumber in distinct-values($conTransaccionesActuales/ns2:RowSet/ns2:Row/ns2:Column[@name = 'numtarjeta'])
	        	return
		        	<ns1:consultaMovimientosRecientesTCTarjetasAdicionales>
		        	{	        			
	        			<CARD_NUMBER>{ data($cardNumber) }</CARD_NUMBER>,
	        			let $movs := $conTransaccionesActuales/ns2:RowSet/ns2:Row[ ns2:Column[@name = 'numtarjeta']/text() = $cardNumber]
	        			return(
	        				<CARD_HOLDER_NAME>{ data($movs[1]/ns2:Column[@name = 'cardholder_name']) }</CARD_HOLDER_NAME>,
				        	<ns1:consultaMovimientosRecientesTCRegistroTarjetasAdicionales>
				        	{
				        		for $mov in $movs
				        		return
					        		<ns1:consultaMovimientosRecientesTCDetalleTarjeta>
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
						        	</ns1:consultaMovimientosRecientesTCDetalleTarjeta>
				        		}
				        		</ns1:consultaMovimientosRecientesTCRegistroTarjetasAdicionales>
				        	)
			        	}
			        	</ns1:consultaMovimientosRecientesTCTarjetasAdicionales>
			    )
        }    
        </ns1:consultaMovimientosRecientesTCResponse>
};

declare variable $resultGroup as element(*)? external;
declare variable $conDatoTarjeta as element(ns0:OutputParameters)? external;
declare variable $conTransaccionesActuales as element(ns2:OutputParameters)? external;
declare variable $outputParameters as element(ns4:OutputParameters)? external;

xf:consultaMovsRecientesTCGTOut($resultGroup, 
	$conDatoTarjeta,
    $conTransaccionesActuales,
    $outputParameters)
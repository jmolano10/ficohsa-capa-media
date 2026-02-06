xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$outputParameters1" element="ns2:OutputParameters" location="../../../BusinessServices/ProcesosPA/conDatoTarjeta/xsd/conDatoTarjeta_sp.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$outputParameters2" element="ns1:OutputParameters" location="../../../BusinessServices/ProcesosPA/conTransaccionesActuales/xsd/conTransaccionesActuales_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultaMovimientosRecientesTCResponse" location="../../../../Business_Resources/tarjetaCredito/ConsultaMovimientosRecientesTC/consultaMovimientosRecientesTCTypes.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns4:OutputParameters" location="../../../BusinessServices/CLIENTDATA/consultaMovimientosRecientesTC/xsd/consultaMovimientosRecientesTC_sp.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaMovimientosRecientesTC/xq/consultaMovsRecientesTCPAOut/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaMovimientosRecientesTCTypes";
declare namespace ns2 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/conDatoTarjeta";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/conTransaccionesActuales";
declare namespace ns3 = "http://www.procesa.com/fdcs";
declare namespace ns4 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaMovimientosRecientesTC";

declare function xf:consultaMovsRecientesTCPAOut($outputParameters1 as element(ns2:OutputParameters)?,
    $outputParameters2 as element(ns1:OutputParameters)?,
    $resultGroup as element(*)?,
    $outputParameters as element(ns4:OutputParameters)?)
    as element(ns0:consultaMovimientosRecientesTCResponse) {
        <ns0:consultaMovimientosRecientesTCResponse>
        {
        	if(not(empty($outputParameters/ns4:PT_MOVIMIENTOS_RECIENTES_TC/ns4:PT_MOVIMIENTOS_RECIENTES_TC_ITEM[1]))) then (
	    		let $ITEM := $outputParameters/ns4:PT_MOVIMIENTOS_RECIENTES_TC/ns4:PT_MOVIMIENTOS_RECIENTES_TC_ITEM[1]
	   			return(
	   				<OWNER_NAME>{ data($ITEM/ns4:OWNER_NAME) }</OWNER_NAME>,
	   				<CARD_NUMBER>{ data($ITEM/ns4:CARD_NUMBER) }</CARD_NUMBER>,
	   				<CREDIT_LIMIT>{ data($ITEM/ns4:CREDIT_LIMIT) }</CREDIT_LIMIT>,
	   				<CREDIT_LIMIT_CCY>{ data($ITEM/ns4:CREDIT_LIMIT_CCY) }</CREDIT_LIMIT_CCY>,
	   				<PREVIOUS_BALANCE_FCY>{ data($ITEM/ns4:PREVIOUS_BALANCE_FCY) }</PREVIOUS_BALANCE_FCY>,
	            	let $ADDITIONAL_CARDS := fn-bea:inlinedXML($ITEM/ns4:MOVEMENTS_DETAIL)
	                for $CARDITEMS in $ADDITIONAL_CARDS
	                return(
			            <ns0:consultaMovimientosRecientesTCTarjetasAdicionales>
			              	<CARD_NUMBER>{ data($CARDITEMS/CARD_NUMBER) }</CARD_NUMBER> 
			              	<CARD_HOLDER_NAME>{ data($CARDITEMS/CARD_HOLDER_NAME) }</CARD_HOLDER_NAME>
			              	<ns0:consultaMovimientosRecientesTCRegistroTarjetasAdicionales>
			              	
			              		{	
			              			for $MOVIMIENTOS in $CARDITEMS/consultaMovimientosRecientesTCRegistroTarjetasAdicionales/consultaMovimientosRecientesTCDetalleTarjeta
			              			return(
					              		<ns0:consultaMovimientosRecientesTCDetalleTarjeta>
					              			<TRANSACTION_DATE>{ data($MOVIMIENTOS/TRANSACTION_DATE) }</TRANSACTION_DATE>
					              			<DESCRIPTION>{ data($MOVIMIENTOS/DESCRIPTION) }</DESCRIPTION>
					              			<AMOUNT>{ data($MOVIMIENTOS/AMOUNT) }</AMOUNT>
					              			<CURRENCY>{ data($MOVIMIENTOS/CURRENCY) }</CURRENCY>
					              			<ORIGINAL_AMOUNT>{ data($MOVIMIENTOS/ORIGINAL_AMOUNT) }</ORIGINAL_AMOUNT>
					              			<ORIGINAL_CURRENCY>{ data($MOVIMIENTOS/ORIGINAL_CURRENCY) }</ORIGINAL_CURRENCY>
					              			<TYPE_OF_TRANSACTION>{ data($MOVIMIENTOS/TYPE_OF_TRANSACTION) }</TYPE_OF_TRANSACTION>
					              		</ns0:consultaMovimientosRecientesTCDetalleTarjeta>
				              		)
			              		}
			              	</ns0:consultaMovimientosRecientesTCRegistroTarjetasAdicionales>
			            </ns0:consultaMovimientosRecientesTCTarjetasAdicionales>
		              )
	          	 )
	         )else(
        	
        		let $firstRow := $outputParameters1/ns2:RowSet/ns2:Row[1]
        		return(
        			for $ownerName in $firstRow/ns2:Column[ @name='account_name' ]
	        		return
	        			<OWNER_NAME>{ data($ownerName) }</OWNER_NAME>,
	        			
	        		for $cardNumber in $firstRow/ns2:Column[ @name='numtarjeta' ]
	        		return
	        			<CARD_NUMBER>{ data($cardNumber) }</CARD_NUMBER>
        		),
        		let $foreignRow := $outputParameters1/ns2:RowSet/ns2:Row[ ns2:Column[@name='CodMoneda']/text() = 'USD']
        		let $foreignOrg := string($foreignRow/ns2:Column[ @name='org' ]/text())
        		let $foreignAccoutnInquiryRSP := $resultGroup/ACCOUNT_INQUIRY_RESPONSES/ns3:AccountInquiryL8VLResponse[ AZXAIO-ORG = $foreignOrg ]
        		return(
        			 if(count($foreignAccoutnInquiryRSP) > 0)then (
        				
        				for $creditLimit in $foreignAccoutnInquiryRSP/AZXAIO-CRLIM
				        return
				            <CREDIT_LIMIT>{ data($creditLimit) }</CREDIT_LIMIT>,
				        
				        <CREDIT_LIMIT_CCY>USD</CREDIT_LIMIT_CCY>,
				        
				        for $foreignPreviousBalance in $foreignAccoutnInquiryRSP/AZXAIO-LAST-CRLIM
				        return
				            <PREVIOUS_BALANCE_FCY>{ data($foreignPreviousBalance) }</PREVIOUS_BALANCE_FCY>
				            
        			)else()
        		),
        		for $cardNumber in distinct-values($outputParameters2/ns1:RowSet/ns1:Row/ns1:Column[ @name='numtarjeta' ])
        		return
	        		<ns0:consultaMovimientosRecientesTCTarjetasAdicionales>
	        		{	        			
        				<CARD_NUMBER>{ data($cardNumber) }</CARD_NUMBER>,
        				let $movs := $outputParameters2/ns1:RowSet/ns1:Row[ ns1:Column[ @name='numtarjeta' ]/text() = $cardNumber ]
        				return(
        					<CARD_HOLDER_NAME>{ data($movs[1]/ns1:Column[ @name='cardholder_name' ]) }</CARD_HOLDER_NAME>,
			        		<ns0:consultaMovimientosRecientesTCRegistroTarjetasAdicionales>
			        			{
			        				for $mov in $movs
			        				return
				        				<ns0:consultaMovimientosRecientesTCDetalleTarjeta>
				        					{
				        						for $transactionDate in $mov/ns1:Column[ @name='fecefectiva' ]
				        						return
				        							<TRANSACTION_DATE>{ fn-bea:dateTime-to-string-with-format('yyyyMMdd', data($transactionDate)) }</TRANSACTION_DATE>
				        					}
				        					{
				        						for $description in $mov/ns1:Column[ @name='descripcion' ]
				        						return
				        							<DESCRIPTION>{ data($description) }</DESCRIPTION>
				        					}
				        					{
				        						for $amount in $mov/ns1:Column[ @name='monto' ]
				        						return
				        							<AMOUNT>{ data($amount) }</AMOUNT>
				        					}
				        					{
				        						for $currency in $mov/ns1:Column[ @name='CodMoneda' ]
				        						return
				        							<CURRENCY>{ data($currency) }</CURRENCY>
				        					}
				        					{
				        						for $originalAmount in $mov/ns1:Column[ @name='MontoOriginal' ]
				        						return
				        							<ORIGINAL_AMOUNT>{ data($originalAmount) }</ORIGINAL_AMOUNT>
				        					}
				        					{
				        						for $originalCurrency in $mov/ns1:Column[ @name='MonedaOriginal' ]
				        						return
				        							<ORIGINAL_CURRENCY>{ data($originalCurrency) }</ORIGINAL_CURRENCY>
				        					}
				        					{
				        						for $transactionType in $mov/ns1:Column[ @name='TipoTransaccion' ]
				        						return
				        							<TYPE_OF_TRANSACTION>{ data($transactionType) }</TYPE_OF_TRANSACTION>
				        					}
					        			</ns0:consultaMovimientosRecientesTCDetalleTarjeta>
			        			}
			        		</ns0:consultaMovimientosRecientesTCRegistroTarjetasAdicionales>
			        	)
		        	}
		        	</ns0:consultaMovimientosRecientesTCTarjetasAdicionales>
        		)
        	}
        
        </ns0:consultaMovimientosRecientesTCResponse>
};

declare variable $outputParameters1 as element(ns2:OutputParameters)? external;
declare variable $outputParameters2 as element(ns1:OutputParameters)? external;
declare variable $resultGroup as element(*)? external;
declare variable $outputParameters as element(ns4:OutputParameters)? external;

xf:consultaMovsRecientesTCPAOut($outputParameters1,
    $outputParameters2,
    $resultGroup,
    $outputParameters)
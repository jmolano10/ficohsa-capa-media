xquery version "2004-draft";
(:: pragma  parameter="$resultGroup" type="anyType" ::)
(:: pragma bea:global-element-parameter parameter="$rspConDatoTarjeta" element="ns1:OutputParameters" location="../../../BusinessServices/MasterData/conDatoTarjeta/xsd/conDatoTarjeta_sp.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$rspConTransaccionesActuales" element="ns2:OutputParameters" location="../../../BusinessServices/MasterData/conTransaccionesActuales/xsd/conTransaccionesActuales_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns4:InputParameters" location="../../../BusinessServices/CLIENTDATA/registraMovimientosRecientesTC/xsd/registraMovimientosRecientesTC_sp.xsd" ::)

declare namespace ns2 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/conTransaccionesActuales";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/conDatoTarjeta";
declare namespace ns4 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/registraMovimientosRecientesTC";
declare namespace ns3 = "http://www.procesa.com/fdcs";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaMovimientosRecientesTCTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaMovimientosRecientesTC/xq/registraMovimientosRecientesTCNiIn/";

declare function xf:registraMovimientosRecientesTCNiIn($resultGroup as element(*),
    $rspConDatoTarjeta as element(ns1:OutputParameters),
    $rspConTransaccionesActuales as element(ns2:OutputParameters),
    $countryCode as xs:string)
    as element(ns4:InputParameters) {
        <ns4:InputParameters>
            <ns4:PT_MOVIMIENTOS_RECIENTES_TC>
                <ns4:PT_MOVIMIENTOS_RECIENTES_TC_ITEM>
                {
	        		let $firstRow := $rspConDatoTarjeta/ns1:RowSet/ns1:Row[1]
	        		return(
	        			for $ownerName in $firstRow/ns1:Column[ @name='account_name' ]
		        		return
		        			<ns4:OWNER_NAME>{ data($ownerName) }</ns4:OWNER_NAME>,
		        			
		        		for $cardNumber in $firstRow/ns1:Column[ @name='numtarjeta' ]
		        		return
		        			<ns4:CARD_NUMBER>{ data($cardNumber) }</ns4:CARD_NUMBER>
	        		)
	        	}
                {
	        		let $localRow := $rspConDatoTarjeta/ns1:RowSet/ns1:Row[ ns1:Column[@name='CodMoneda']/text() = 'NIO']
	        		let $foreignRow := $rspConDatoTarjeta/ns1:RowSet/ns1:Row[ ns1:Column[@name='CodMoneda']/text() = 'USD']
	        		let $localOrg := string($localRow/ns1:Column[ @name='org' ]/text())
	        		let $foreignOrg := string($foreignRow/ns1:Column[ @name='org' ]/text())
	        		let $localAccoutnInquiryL8VLRSP := $resultGroup/ACCOUNT_INQUIRY_RESPONSES/ns3:AccountInquiryL8VLResponse[ AZXAIO-ORG = $localOrg ]
	        		let $foreignAccoutnInquiryL8VLRSP := $resultGroup/ACCOUNT_INQUIRY_RESPONSES/ns3:AccountInquiryL8VLResponse[ AZXAIO-ORG = $foreignOrg ]
	        		return(
	        			if(count($localAccoutnInquiryL8VLRSP) > 0 and count($foreignAccoutnInquiryL8VLRSP) > 0 ) then (
	        				
	        				for $creditLimit in $foreignAccoutnInquiryL8VLRSP/AZXAIO-CRLIM
					        return
					            <ns4:CREDIT_LIMIT>{ data($creditLimit) }</ns4:CREDIT_LIMIT>,
					        
					        <ns4:CREDIT_LIMIT_CCY>USD</ns4:CREDIT_LIMIT_CCY>,
					        
					        for $localPreviousBalance in $localAccoutnInquiryL8VLRSP/AZXAIO-LAST-CRLIM
					        return
					            <ns4:PREVIOUS_BALANCE_LCY>{ data($localPreviousBalance) }</ns4:PREVIOUS_BALANCE_LCY>,
					        
					        for $foreignPreviousBalance in $foreignAccoutnInquiryL8VLRSP/AZXAIO-LAST-CRLIM
					        return
					            <ns4:PREVIOUS_BALANCE_FCY>{ data($foreignPreviousBalance) }</ns4:PREVIOUS_BALANCE_FCY>
					            
	        			)else if(count($foreignAccoutnInquiryL8VLRSP) > 0)then (
	        				
	        				for $creditLimit in $foreignAccoutnInquiryL8VLRSP/AZXAIO-CRLIM
					        return
					            <ns4:CREDIT_LIMIT>{ data($creditLimit) }</ns4:CREDIT_LIMIT>,
					        
					        <ns4:CREDIT_LIMIT_CCY>USD</ns4:CREDIT_LIMIT_CCY>,
					        
					        for $foreignPreviousBalance in $foreignAccoutnInquiryL8VLRSP/AZXAIO-LAST-CRLIM
					        return
					            <ns4:PREVIOUS_BALANCE_FCY>{ data($foreignPreviousBalance) }</ns4:PREVIOUS_BALANCE_FCY>
					            
	        			)else if(count($localAccoutnInquiryL8VLRSP) > 0 )then (
	        			
	        				for $creditLimit in $localAccoutnInquiryL8VLRSP/AZXAIO-CRLIM
					        return
					            <ns4:CREDIT_LIMIT>{ data($creditLimit) }</ns4:CREDIT_LIMIT>,
					        
					        <ns4:CREDIT_LIMIT_CCY>NIO</ns4:CREDIT_LIMIT_CCY>,
					        
					        for $localPreviousBalance in $localAccoutnInquiryL8VLRSP/AZXAIO-LAST-CRLIM
					        return
					            <ns4:PREVIOUS_BALANCE_LCY>{ data($localPreviousBalance) }</ns4:PREVIOUS_BALANCE_LCY>
					            
	        			)else()
	        		)
	        	}
	            <ns4:MOVEMENTS_DETAIL>
		        {
		        	fn-bea:serialize(
		        		for $cardNumber in distinct-values($rspConTransaccionesActuales/ns2:RowSet/ns2:Row/ns2:Column[ @name='numtarjeta' ])
		        		return
			        		<consultaMovimientosRecientesTCTarjetasAdicionales>
			        		{	        			
		        				<CARD_NUMBER>{ data($cardNumber) }</CARD_NUMBER>,
		        				let $movs := $rspConTransaccionesActuales/ns2:RowSet/ns2:Row[ ns2:Column[ @name='numtarjeta' ]/text() = $cardNumber ]
		        				return(
		        					<CARD_HOLDER_NAME>{ data($movs[1]/ns2:Column[ @name='cardholder_name' ]) }</CARD_HOLDER_NAME>,
					        		<consultaMovimientosRecientesTCRegistroTarjetasAdicionales>
					        			{
					        				for $mov in $movs
					        				return
						        				<consultaMovimientosRecientesTCDetalleTarjeta>
						        					{
						        						for $transactionDate in $mov/ns2:Column[ @name='fecefectiva' ]
						        						return
						        							<TRANSACTION_DATE>{ fn-bea:dateTime-to-string-with-format('yyyyMMdd', data($transactionDate)) }</TRANSACTION_DATE>
						        					}
						        					{
						        						for $description in $mov/ns2:Column[ @name='descripcion' ]
						        						return
						        							<DESCRIPTION>{ data($description) }</DESCRIPTION>
						        					}
						        					{
						        						for $amount in $mov/ns2:Column[ @name='monto' ]
						        						return
						        							<AMOUNT>{ data($amount) }</AMOUNT>
						        					}
						        					{
						        						for $currency in $mov/ns2:Column[ @name='CodMoneda' ]
						        						return
						        							<CURRENCY>{ data($currency) }</CURRENCY>
						        					}
						        					{
						        						for $originalAmount in $mov/ns2:Column[ @name='MontoOriginal' ]
						        						return
						        							<ORIGINAL_AMOUNT>{ data($originalAmount) }</ORIGINAL_AMOUNT>
						        					}
						        					{
						        						for $originalCurrency in $mov/ns2:Column[ @name='MonedaOriginal' ]
						        						return
						        							<ORIGINAL_CURRENCY>{ data($originalCurrency) }</ORIGINAL_CURRENCY>
						        					}
						        					{
						        						for $transactionType in $mov/ns2:Column[ @name='TipoTransaccion' ]
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
		        	</ns4:MOVEMENTS_DETAIL>    
                </ns4:PT_MOVIMIENTOS_RECIENTES_TC_ITEM>
            </ns4:PT_MOVIMIENTOS_RECIENTES_TC>
            <ns4:PV_COUNTRY_CODE>{ $countryCode }</ns4:PV_COUNTRY_CODE>
        </ns4:InputParameters>
};

declare variable $resultGroup as element(*) external;
declare variable $rspConDatoTarjeta as element(ns1:OutputParameters) external;
declare variable $rspConTransaccionesActuales as element(ns2:OutputParameters) external;
declare variable $countryCode as xs:string external;

xf:registraMovimientosRecientesTCNiIn($resultGroup,
    $rspConDatoTarjeta,
    $rspConTransaccionesActuales,
    $countryCode)
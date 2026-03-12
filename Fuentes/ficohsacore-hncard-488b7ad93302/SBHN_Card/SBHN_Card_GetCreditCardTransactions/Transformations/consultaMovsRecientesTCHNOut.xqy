xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="https://www.ficohsa.com/regional/card";
(:: import schema at "../../SBHN_Card_Commons/Schemas/CardInquiryTypes.xsd" ::)

declare namespace ns2 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/conTransaccionesActuales_v2";
(:: import schema at "../Schemas/conTransaccionesActuales_v2_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/conDatoTarjetaBS";
(:: import schema at "../Schemas/conDatoTarjetaBS_sp.xsd" ::)

declare namespace ns3 = "http://www.procesa.com/fdcs";


declare namespace ns4 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaMovimientosRecientesTC";
(:: import schema at "../Schemas/consultaMovimientosRecientesTC_sp.xsd" ::)


declare variable $conDatoTarjeta as element() (:: schema-element(ns0:OutputParameters) ::) external;
declare variable $conTransaccionesActuales as element() (:: schema-element(ns2:OutputParameters) ::) external;
declare variable $outputParameters as element() (:: schema-element(ns4:OutputParameters) ::) external;


declare variable $resultGroup as element() external;
declare variable $globalId as xs:string external;

declare function local:toString($value as item()) as xs:string {
  fn:string($value)
};


declare function local:consultaMovsRecientesTCHNOut($resultGroup as element(*)?, $conDatoTarjeta as element(ns0:OutputParameters)?,
    $conTransaccionesActuales as element(ns2:OutputParameters)?, 
     $outputParameters as element(ns4:OutputParameters)?,$globalId as xs:string) as element() (:: schema-element(ns1:getCreditCardTransactionsResponse) ::) {
    <ns1:getCreditCardTransactionsResponse>
        <StatusInfo>
                  <Status>Success</Status>
                  <ValueDate>{fn:substring(fn:string(fn:current-dateTime()),0,11)}</ValueDate>
                  <DateTime>{fn:substring(fn:string(fn:current-dateTime()),0,20)}</DateTime>
                  <GlobalId>{fn:data($globalId)}</GlobalId>
              </StatusInfo>
    {
      if(not(empty($outputParameters/ns4:PT_MOVIMIENTOS_RECIENTES_TC/ns4:PT_MOVIMIENTOS_RECIENTES_TC_ITEM[1]))) then (
	    		let $ITEM := $outputParameters/ns4:PT_MOVIMIENTOS_RECIENTES_TC/ns4:PT_MOVIMIENTOS_RECIENTES_TC_ITEM[1]
	   			return(
	   				<OwnerName>{ data($ITEM/ns4:OWNER_NAME) }</OwnerName>,
	   				<CardNumber>{ data($ITEM/ns4:CARD_NUMBER) }</CardNumber>,
	   				<CreditLimit>{ data($ITEM/ns4:CREDIT_LIMIT) }</CreditLimit>,
	   				<CreditLimitCcy>{ data($ITEM/ns4:CREDIT_LIMIT_CCY) }</CreditLimitCcy>,
	   				<PreviousBalanceLcy>{ data($ITEM/ns4:PREVIOUS_BALANCE_LCY) }</PreviousBalanceLcy>,
	   				<PreviousBalanceFcy>{ data($ITEM/ns4:PREVIOUS_BALANCE_FCY) }</PreviousBalanceFcy>,
	            	let $ADDITIONAL_CARDS := fn-bea:inlinedXML($ITEM/ns4:MOVEMENTS_DETAIL)
	                for $CARDITEMS in $ADDITIONAL_CARDS
	                return(
			            <AditionalCreditCards>
			              	<CardNumber>{ data($CARDITEMS/CARD_NUMBER) }</CardNumber> 
			              	<CardHolderName>{ data($CARDITEMS/CARD_HOLDER_NAME) }</CardHolderName>
			              	<Transactions>
			              	
			              		{	
			              			for $MOVIMIENTOS in $CARDITEMS/consultaMovimientosRecientesTCRegistroTarjetasAdicionales/consultaMovimientosRecientesTCDetalleTarjeta
			              			return(
					              		<TransactionsRecordType>
					              			<TransactionDate>{ data($MOVIMIENTOS/TRANSACTION_DATE) }</TransactionDate>
					              			<Description>{ data($MOVIMIENTOS/DESCRIPTION) }</Description>
					              			<Amount>{ data($MOVIMIENTOS/AMOUNT) }</Amount>
					              			<Currency>{ data($MOVIMIENTOS/CURRENCY) }</Currency>
					              			<OriginalAmount>{ data($MOVIMIENTOS/ORIGINAL_AMOUNT) }</OriginalAmount>
					              			<OriginalCurrency>{ data($MOVIMIENTOS/ORIGINAL_CURRENCY) }</OriginalCurrency>
					              			<TypeOfTransaction>{ data($MOVIMIENTOS/TYPE_OF_TRANSACTION) }</TypeOfTransaction>
					              		</TransactionsRecordType>
				              		)
			              		}
			              	</Transactions>
			            </AditionalCreditCards>
		              )
	          	 )
	         )else(
	        	let $firstRow := $conDatoTarjeta/ns0:RowSet/ns0:Row[1]
	        	return(
	        		for $ownerName in $firstRow/ns0:Column[@name = 'account_name']
	        		return
	        			<OwnerName>{ data($ownerName) }</OwnerName>,
	        		
	        		for $cardNumber in $firstRow/ns0:Column[@name = 'numtarjeta']
		        	return
		        		<CardNumber>{ data($cardNumber) }</CardNumber>
	        	),
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
					        <CreditLimit>{ data($creditLimit) }</CreditLimit>,
					        
					   	<CreditLimitCcy>USD</CreditLimitCcy>,
					        
					    for $localPreviousBalance in $localAccoutnInquiryRSP/ARXAIO-LAST-CRLIM
					    return
					        <PreviousBalanceLcy>{ data($localPreviousBalance) }</PreviousBalanceLcy>,
					        
					    for $foreignPreviousBalance in $foreignAccoutnInquiryRSP/ARXAIO-LAST-CRLIM
					    return
					        <PreviousBalanceFcy>{ data($foreignPreviousBalance) }</PreviousBalanceFcy>
					            
	        		)else if(count($foreignAccoutnInquiryRSP) > 0)then (
	        				
	        			for $creditLimit in $foreignAccoutnInquiryRSP/ARXAIO-CRLIM
					    return
					        <CreditLimit>{ data($creditLimit) }</CreditLimit>,
					        
					    <CreditLimitCcy>USD</CreditLimitCcy>,
					        
					    for $foreignPreviousBalance in $foreignAccoutnInquiryRSP/ARXAIO-LAST-CRLIM
					    return
					        <PreviousBalanceFcy>{ data($foreignPreviousBalance) }</PreviousBalanceFcy>
					            
	        		)else if(count($localAccoutnInquiryRSP) > 0 )then (
	        			
	        			for $creditLimit in $localAccoutnInquiryRSP/ARXAIO-CRLIM
					    return
					        <CreditLimit>{ data($creditLimit) }</CreditLimit>,
					        
					    <CreditLimitCcy>GTQ</CreditLimitCcy>,
					        
					    for $localPreviousBalance in $localAccoutnInquiryRSP/ARXAIO-LAST-CRLIM
					    return
					        <PreviousBalanceLcy>{ data($localPreviousBalance) }</PreviousBalanceLcy>
					            
	        		)else()   		
	        	),
	        	for $cardNumber in distinct-values($conTransaccionesActuales/ns2:RowSet/ns2:Row/ns2:Column[@name = 'numtarjeta'])
	        	return
		        	<AditionalCreditCards>
		        	{	        			
	        			<CardNumber>{ data($cardNumber) }</CardNumber>,
	        			let $movs := $conTransaccionesActuales/ns2:RowSet/ns2:Row[ ns2:Column[@name = 'numtarjeta']/text() = $cardNumber]
	        			return(
	        				<CardHolderName>{ data($movs[1]/ns2:Column[@name = 'cardholder_name']) }</CardHolderName>,
				        	<Transactions>
				        	{
				        		for $mov in $movs
				        		return
					        		<TransactionsRecordType>
					        		{
					        			for $transactionDate in $mov/ns2:Column[@name = 'fecefectiva']
					        			return
                                                                        
					        				<TransactionDate>{ concat(substring($transactionDate,1,4),substring($transactionDate,5,2),substring($transactionDate,7,2))}</TransactionDate>
					        		}
					        		{
					        			for $description in $mov/ns2:Column[@name = 'descripcion']
					        			return
					        				<Description>{ data($description) }</Description>
					        		}
					        		{
					        			for $amount in $mov/ns2:Column[@name = 'monto']
					        			return
					        				<Amount>{ data($amount) }</Amount>
					        		}
					        		{
					        			for $currency in $mov/ns2:Column[@name = 'CodMoneda']
					        			return
					        				<Currency>{ data($currency) }</Currency>
					        		}
					        		{
					        			for $originalAmount in $mov/ns2:Column[@name = 'MontoOriginal']
					        			return
					        				<OriginalAmount>{ data($originalAmount) }</OriginalAmount>				        					}
					        		{
					        			for $originalCurrency in $mov/ns2:Column[@name = 'MonedaOriginal']
					        			return
					        				<OriginalCurrency>{ data($originalCurrency) }</OriginalCurrency>
					        		}
					        		{
					        			for $transactionType in $mov/ns2:Column[@name = 'TipoTransaccion']
					        			return
					        				<TypeOfTransaction>{ data($transactionType) }</TypeOfTransaction>
					        		}
						        	</TransactionsRecordType>
				        		}
				        		</Transactions>
				        	)
			        	}
			        	</AditionalCreditCards>
			    )
        }    
    </ns1:getCreditCardTransactionsResponse>
};

local:consultaMovsRecientesTCHNOut($resultGroup,$conDatoTarjeta,$conTransaccionesActuales,$outputParameters,$globalId)
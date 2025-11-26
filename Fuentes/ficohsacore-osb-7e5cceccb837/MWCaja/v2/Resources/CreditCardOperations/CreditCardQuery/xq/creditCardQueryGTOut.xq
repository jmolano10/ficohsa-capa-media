(:: pragma bea:global-element-parameter parameter="$consultaDatosTarjetaCreditoResponse" element="ns3:consultaDatosTarjetaCreditoResponse" location="../../../../../../Middleware/v3/Resources/ConsultaDatosTarjetaCredito/xsd/consultaDatosTarjetaCreditoTypes.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultaFinanciamientosClienteResponse" element="ns0:consultaFinanciamientosClienteResponse" location="../../../../../../Middleware/v2/Resources/ConsultaFinanciamientosCliente/xsd/consultaFinanciamientosClienteTypes.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultaIntrasPorCuentaResponse" element="ns7:consultaIntrasPorCuentaResponse" location="../../../../../../Middleware/v2/Resources/ConsultaIntrasPorCuenta/xsd/consultaIntrasPorCuentaTypes.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultaExtrafinanciamientoDisponibleResponse" element="ns2:consultaExtrafinanciamientoDisponibleResponse" location="../../../../../../Middleware/v2/Resources/ConsultaExtrafinanciamientoDisponible/xsd/consultaExtrafinanciamientoDisponibleTypes.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultaSaldosTarjetaCreditoResponse" element="ns8:consultaSaldosTarjetaCreditoResponse" location="../../../../../../Middleware/v2/Resources/ConsultaSaldosTarjetaCredito/xsd/consultaSaldosTarjetaCreditoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns4:creditCardQueryResponse" location="../../../../../v1/Resources/CreditCardOperations/xsd/CreditCardOperationsTypes.xsd" ::)
(:: pragma  parameter="$resultGroup" type="xs:anyType" ::)

declare namespace ns6 = "http://www.ficohsa.com.hn/middleware.services/creditCardTypes";
declare namespace ns5 = "http://www.procesa.com/fdcs";
declare namespace ns8 = "http://www.ficohsa.com.hn/middleware.services/consultaSaldosTarjetaCreditoTypes";
declare namespace ns7 = "http://www.ficohsa.com.hn/middleware.services/consultaIntrasPorCuentaTypes";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaFinanciamientosClienteTypes";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/consultaExtrafinanciamientoDisponibleTypes";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/customerTypes";
declare namespace xf = "http://tempuri.org/MWCaja/v1/Resources/CreditCardOperations/CreditCardQuery/xq/creditCardQueryGTOut/";
declare namespace ns4 = "http://www.ficohsa.com.hn/middleware.services/creditCardOperationsTypes";
declare namespace ns3 = "http://www.ficohsa.com.hn/middleware.services/consultaDatosTarjetaCreditoTypes";

declare function xf:creditCardQueryGTOut($resultGroup as element(*),
	$consultaDatosTarjetaCreditoResponse as element(ns3:consultaDatosTarjetaCreditoResponse),
    $consultaFinanciamientosClienteResponse as element(ns0:consultaFinanciamientosClienteResponse),
    $consultaIntrasPorCuentaResponse as element(ns7:consultaIntrasPorCuentaResponse),
    $consultaExtrafinanciamientoDisponibleResponse as element(ns2:consultaExtrafinanciamientoDisponibleResponse),
    $consultaSaldosTarjetaCreditoResponse as element(ns8:consultaSaldosTarjetaCreditoResponse))
    as element(ns4:creditCardQueryResponse) {
        <ns4:creditCardQueryResponse>
            {
                for $CARD_NUMBER in $consultaDatosTarjetaCreditoResponse/CARD_NUMBER
                return
                    <ns4:CREDIT_CARD_NUMBER>{ data($CARD_NUMBER) }</ns4:CREDIT_CARD_NUMBER>
            }
            {
                for $ACCOUNT_NUMBER in $consultaDatosTarjetaCreditoResponse/ACCOUNT_NUMBER
                return
                    <ns4:ACCOUNT_NUMBER>{ data($ACCOUNT_NUMBER) }</ns4:ACCOUNT_NUMBER>
            }
            {
                for $CARD_HOLDER_NAME in $consultaDatosTarjetaCreditoResponse/CARD_HOLDER_NAME
                return
                    <ns4:NAME>{ data($CARD_HOLDER_NAME) }</ns4:NAME>
            }
            <ns4:CUSTOMER>
                <ns4:LEGAL_ID>
                	<ns1:NAME>{ 'DPI' }</ns1:NAME>                	
                    <ns1:ID>{ data($consultaDatosTarjetaCreditoResponse/CARD_HOLDER_LEGAL_ID) }</ns1:ID>
                </ns4:LEGAL_ID>
                <ns4:NAME>{ data($consultaDatosTarjetaCreditoResponse/ACCOUNT_HOLDER_NAME) }</ns4:NAME>
            </ns4:CUSTOMER>
            {
                for $LAST_CUTOFF_DATE in $consultaSaldosTarjetaCreditoResponse/LAST_CUTOFF_DATE
                return
                    <ns4:LAST_CUTOFF_DATE>{ fn-bea:date-from-string-with-format("yyyyMMdd",data($LAST_CUTOFF_DATE)) }</ns4:LAST_CUTOFF_DATE>
            }
            {
                for $MAX_PAYMENT_DATE in $consultaSaldosTarjetaCreditoResponse/MAX_PAYMENT_DATE
                return
                    <ns4:MAX_PAYMENT_DATE>{ fn-bea:date-from-string-with-format("yyyyMMdd",data($MAX_PAYMENT_DATE)) }</ns4:MAX_PAYMENT_DATE>
            }              
           
            <ns4:BALANCES>
			{
				for $rowExtrafinaciamientoDisponible in $consultaSaldosTarjetaCreditoResponse/ns8:consultaSaldosTarjetaCreditoResponseType/ns8:consultaSaldosTarjetaCreditoResponseRecordType
				return
				(            
                <ns6:BALANCE>
                    <ns6:CURRENCY>{ data($rowExtrafinaciamientoDisponible/CURRENCY) }</ns6:CURRENCY>
	   				{
                        let $minPaymentExtranjero := string($consultaSaldosTarjetaCreditoResponse/FCY_MIN_PAYMENT/text())
                        let $minPaymentLocal := string($consultaSaldosTarjetaCreditoResponse/LCY_MIN_PAYMENT/text())
                        let $currency := string($rowExtrafinaciamientoDisponible/CURRENCY/text())
                        return                                          	   				
	   						if( $currency = 'USD' and $minPaymentExtranjero != '')then( 
								<ns6:MIN_PAYMENT>{ data($minPaymentExtranjero) }</ns6:MIN_PAYMENT>
	                    	)
	                    	else if( $currency = 'GTQ' and $minPaymentLocal != '')then( 
								<ns6:MIN_PAYMENT>{ data($minPaymentLocal) }</ns6:MIN_PAYMENT>
	                    	)
	                    	else if( $currency = 'USD' and $minPaymentExtranjero = '')then( 
								<ns6:MIN_PAYMENT>{ 0 }</ns6:MIN_PAYMENT>
	                    	)
	                    	else if( $currency = 'GTQ' and $minPaymentLocal = '')then( 
								<ns6:MIN_PAYMENT>{ 0 }</ns6:MIN_PAYMENT>
	                    	)	                    	
	                    	else(
	                    	)	                    		                    					
	   				} 
	   				{
                        let $totalPaymentExtranjero := string($consultaSaldosTarjetaCreditoResponse/FCY_TOTAL_PAYMENT/text())
                        let $totalPaymentLocal := string($consultaSaldosTarjetaCreditoResponse/LCY_TOTAL_PAYMENT/text())
                        let $currency := string($rowExtrafinaciamientoDisponible/CURRENCY/text())
                        return                                          	   				
	   						if( $currency = 'USD' and $totalPaymentExtranjero != '')then( 
                    			<ns6:TOTAL_PAYMENT>{ data($totalPaymentExtranjero) }</ns6:TOTAL_PAYMENT>
	                    	)
	                    	else if( $currency = 'GTQ' and $totalPaymentLocal)then( 
								<ns6:TOTAL_PAYMENT>{ data($totalPaymentLocal) }</ns6:TOTAL_PAYMENT>
	                    	)
	                    	else if( $currency = 'USD' and $totalPaymentExtranjero = '')then( 
								<ns6:TOTAL_PAYMENT>{ 0 }</ns6:TOTAL_PAYMENT>
	                    	)
	                    	else if( $currency = 'GTQ' and $totalPaymentLocal = '')then( 
								<ns6:TOTAL_PAYMENT>{ 0 }</ns6:TOTAL_PAYMENT>
	                    	)	                    		                    	
	                    	else(
	                    	)	                    		                    					
	   				}
                    <ns6:CURRENT_AMOUNT>{ data($rowExtrafinaciamientoDisponible/CURRENT_BALANCE) }</ns6:CURRENT_AMOUNT>
                    {
                        for $rowFinanciamientosIntra in $consultaFinanciamientosClienteResponse/consultaFinanciamientosClienteResponseRecordType
                        for $CURRENT_BALANCE in $consultaIntrasPorCuentaResponse/PRODUCT_INFORMATION/CURRENT_BALANCE
                        let $currencyFinanciamiento := string($rowFinanciamientosIntra/CURRENCY/text())   
                        let $currency := string($rowExtrafinaciamientoDisponible/CURRENCY/text())  
                        let $extfinanceType := string($rowFinanciamientosIntra/PRODUCT_TYPE/text())  
                        let $CurrentBalanceIntra := string($consultaIntrasPorCuentaResponse/PRODUCT_INFORMATION/CURRENT_BALANCE/text())                                         
	   					return	   					
	   						if( ($extfinanceType = 'INTRAFINANCIAMIENTO') and ($currencyFinanciamiento = '840') and ($currency = 'GTQ')) then( 
                            <ns6:CASH_INTFINANCE_AMOUNT>{ sum(data(($rowFinanciamientosIntra[(CURRENCY = 840) and (PRODUCT_TYPE ='INTRAFINANCIAMIENTO')]/PENDING_PRINCIPAL_AMOUNT)) )}</ns6:CASH_INTFINANCE_AMOUNT>
	                    	)else if(($extfinanceType = 'INTRAFINANCIAMIENTO') and ($currencyFinanciamiento = '320') and ($currency = 'USD')) then(
                            	<ns6:CASH_INTFINANCE_AMOUNT>{ sum(data($rowFinanciamientosIntra[(CURRENCY = 320) and (PRODUCT_TYPE ='INTRAFINANCIAMIENTO')]/PENDING_PRINCIPAL_AMOUNT)) }</ns6:CASH_INTFINANCE_AMOUNT>
	                    	)
	                    	else()
	   				}
                    {
                        let $rowFinanciamientosExtra := $consultaFinanciamientosClienteResponse/consultaFinanciamientosClienteResponseRecordType
                        let $extfinanceType := $rowFinanciamientosExtra/PRODUCT_TYPE
                        let $currencyFinanciamiento := $rowFinanciamientosExtra/CURRENCY   
                        let $currency := $rowExtrafinaciamientoDisponible/CURRENCY                                
                    	return
	   						if( ($extfinanceType = 'EXTRAFINANCIAMIENTO' or $extfinanceType = 'PIL' or $extfinanceType = 'PIL TURBO' or $extfinanceType = 'REESTRUCTURAS') and ($currencyFinanciamiento = '840') and ($currency = 'GTQ')) then( 
                            	<ns6:CASH_EXTFINANCE_AMOUNT>{ sum(data($rowFinanciamientosExtra[(CURRENCY = 840) and (PRODUCT_TYPE ='EXTRAFINANCIAMIENTO' or PRODUCT_TYPE = 'PIL' or PRODUCT_TYPE = 'PIL TURBO' or PRODUCT_TYPE = 'REESTRUCTURAS')]/PENDING_PRINCIPAL_AMOUNT))}</ns6:CASH_EXTFINANCE_AMOUNT>
	                    	)else if(($extfinanceType = 'EXTRAFINANCIAMIENTO' or $extfinanceType = 'PIL' or $extfinanceType = 'PIL TURBO' or $extfinanceType = 'REESTRUCTURAS') and ($currencyFinanciamiento = '320') and ($currency = 'USD')) then(
                            	<ns6:CASH_EXTFINANCE_AMOUNT>{ sum(data($rowFinanciamientosExtra[(CURRENCY = 320) and (PRODUCT_TYPE ='EXTRAFINANCIAMIENTO' or PRODUCT_TYPE = 'PIL' or PRODUCT_TYPE = 'PIL TURBO' or PRODUCT_TYPE = 'REESTRUCTURAS')]/PENDING_PRINCIPAL_AMOUNT)) }</ns6:CASH_EXTFINANCE_AMOUNT>
	                    	)
	                    	else()
	   				}
                </ns6:BALANCE> 
               )} 
            </ns4:BALANCES>
            <ns4:FINANCE_DETAILS>          
                <ns6:CURRENT>
                {
                	let $rowCurrent := $consultaFinanciamientosClienteResponse/consultaFinanciamientosClienteResponseRecordType
                    for $i in 1 to count($rowCurrent)
                    where data($resultGroup/SETTLEMENT_QUOTE_RESPONSE/ns5:SettlementQuoteInquiryL8V1Response[$i]/ARXQIO-PLAN-DATA/ARXQIO-PLAN-ENTRY/ARXQIO-PLAN-PAYOFF-AMT1) != ''                     
                    return
                    <ns6:FINANCE>
                        <ns6:ID>{ data($rowCurrent[$i]/FINANCING_REFERENCE) }</ns6:ID>
                        <ns6:TYPE>{ data($rowCurrent[$i]/PRODUCT_TYPE) }</ns6:TYPE>
                        <ns6:DESCRIPTION>{ data($rowCurrent[$i]/PLAN_DESCRIPTION) }</ns6:DESCRIPTION>
						{
			            	let $currency := fn:string($rowCurrent[$i]/CURRENCY/text())
			            	return
			            		if ($currency = "320") then 
			            			(
			            				<ns6:CURRENCY>{ "GTQ" }</ns6:CURRENCY>
			            			) else if ($currency = "840") then 
			            				(
			            					<ns6:CURRENCY>{ "USD" }</ns6:CURRENCY>
			            				) else 
			            					(
			            						0
			            					) 
			            }                       
                        <ns6:DISBURSE_DATE>{ data($rowCurrent[$i]/DISBURSEMENT_DATE) }</ns6:DISBURSE_DATE>
                        <ns6:DISBURSE_BALANCE>{ data($rowCurrent[$i]/PRINCIPAL_INICIAL_AMOUNT) }</ns6:DISBURSE_BALANCE>
                        <ns6:PAYOFF_BALANCE>{ data($resultGroup/SETTLEMENT_QUOTE_RESPONSE/ns5:SettlementQuoteInquiryL8V1Response[$i]/ARXQIO-PLAN-DATA/ARXQIO-PLAN-ENTRY/ARXQIO-PLAN-PAYOFF-AMT1) }</ns6:PAYOFF_BALANCE>
                        <ns6:PLAN_CODE>{ data($rowCurrent[$i]/PLAN_CODE) }</ns6:PLAN_CODE>
                        <ns6:PLAN_SEQUENCE>{ data($rowCurrent[$i]/PLAN_SEQUENCE) }</ns6:PLAN_SEQUENCE>
                        <ns6:MONTHLY_PAYMENT>{ data($rowCurrent[$i]/MONTHLY_PAYMENT) }</ns6:MONTHLY_PAYMENT>
                        <ns6:INITIAL_LOAN_TERM>{ data($rowCurrent[$i]/INITIAL_LOAN_TERM) }</ns6:INITIAL_LOAN_TERM>
                    </ns6:FINANCE>	
                }
                {
                   for $PRODUCT_INFORMATION in $consultaIntrasPorCuentaResponse/PRODUCT_INFORMATION
                    return
                    
                    <ns6:FINANCE>
                            <ns6:ID>{ fn-bea:trim(data($PRODUCT_INFORMATION/INTRAFINANCING_ID)) }</ns6:ID>
                            <ns6:TYPE>n/a</ns6:TYPE>
                            <ns6:DESCRIPTION>{ fn-bea:trim(data($PRODUCT_INFORMATION/COMMERCE_NAME)) }</ns6:DESCRIPTION>
                            <ns6:CURRENCY>{ data($PRODUCT_INFORMATION/CURRENCY) }</ns6:CURRENCY>                      
                            <ns6:DISBURSE_DATE>{ data($PRODUCT_INFORMATION/TRANSACTION_DATE) }</ns6:DISBURSE_DATE>
                            <ns6:DISBURSE_BALANCE>{ data($PRODUCT_INFORMATION/AMOUNT) }</ns6:DISBURSE_BALANCE>
                            <ns6:PAYOFF_BALANCE>{ data($PRODUCT_INFORMATION/CURRENT_BALANCE) }</ns6:PAYOFF_BALANCE>
                            <ns6:MONTHLY_PAYMENT>{ data($PRODUCT_INFORMATION/FEE_AMOUNT) }</ns6:MONTHLY_PAYMENT>
                            <ns6:INITIAL_LOAN_TERM>{ data($PRODUCT_INFORMATION/TERM) }</ns6:INITIAL_LOAN_TERM>
                   </ns6:FINANCE>
                 }
                </ns6:CURRENT>
                {
                if($consultaExtrafinanciamientoDisponibleResponse != '') then(
                <ns6:PRE_AUTHORIZED>
                    <ns6:LOCAL_CURRENCY>
                        <ns6:CURRENCY>GTQ</ns6:CURRENCY>                    
                        <ns6:TERMS>
					    {
					        for $row in $consultaExtrafinanciamientoDisponibleResponse/TERMBREAKDOWN_INFORMATION
					        where $row != ''               						        
					        return
					        (
                            <ns6:TERM>
	                            {
						           	for $MONTHS in $row/TERM
						            return
						            	<ns6:MONTHS>{ data($MONTHS) }</ns6:MONTHS>
						        }
	                            {
						           	for $TOTAL_AMOUNT in $consultaExtrafinanciamientoDisponibleResponse/AVAILABLE_AMOUNT
						            return
						            	<ns6:TOTAL_AMOUNT>{ data($TOTAL_AMOUNT ) }</ns6:TOTAL_AMOUNT>
						        }
	                            {
						           	for $INTEREST_RATE in $consultaExtrafinanciamientoDisponibleResponse/INTEREST_RATE
						            return
						            	<ns6:INTEREST_RATE>{ data($INTEREST_RATE) }</ns6:INTEREST_RATE>
						        }
	                            {
						           	for $REPAYMENT_AMOUNT in $row/AMOUNT
						            return
						            	<ns6:REPAYMENT_AMOUNT>{ data($REPAYMENT_AMOUNT) }</ns6:REPAYMENT_AMOUNT>
						        }	
	                            {
						           	for $OFFER_TYPE in $consultaExtrafinanciamientoDisponibleResponse/OFFER_TYPE
						            return
						            	<ns6:TYPE>
						            		{ 
												if(data($OFFER_TYPE) = "Oferta Intra") then(
													"INTFINANCE"
												)else if(data($OFFER_TYPE) = "Oferta Extra") then(
													"EXTFINANCE"
												)else if(data($OFFER_TYPE) = "Oferta PilTurbo") then(
													"PERSONAL_LOAN"
												)else(
													""
												)
						            		}
						            	</ns6:TYPE>
						        }						        					        						        						        
                            </ns6:TERM>
                            )}
                        </ns6:TERMS>
                    </ns6:LOCAL_CURRENCY>
                    (:<ns6:FOREIGN_CURRENCY>
                        <ns6:CURRENCY/>
                        <ns6:TERMS>
                            <ns6:TERM>
                                <ns6:MONTHS/>
                                <ns6:TOTAL_AMOUNT/>
                                <ns6:INTEREST_RATE/>
                                <ns6:REPAYMENT_AMOUNT/>
                                <ns6:TYPE/>
                            </ns6:TERM>
                        </ns6:TERMS>
                    </ns6:FOREIGN_CURRENCY>:)
                </ns6:PRE_AUTHORIZED>
                )else('')}
            </ns4:FINANCE_DETAILS>
        </ns4:creditCardQueryResponse>
};

declare variable $resultGroup as element(*) external;
declare variable $consultaDatosTarjetaCreditoResponse as element(ns3:consultaDatosTarjetaCreditoResponse) external;
declare variable $consultaFinanciamientosClienteResponse as element(ns0:consultaFinanciamientosClienteResponse) external;
declare variable $consultaIntrasPorCuentaResponse as element(ns7:consultaIntrasPorCuentaResponse) external;
declare variable $consultaExtrafinanciamientoDisponibleResponse as element(ns2:consultaExtrafinanciamientoDisponibleResponse) external;
declare variable $consultaSaldosTarjetaCreditoResponse as element(ns8:consultaSaldosTarjetaCreditoResponse) external;

xf:creditCardQueryGTOut($resultGroup,
	$consultaDatosTarjetaCreditoResponse,
    $consultaFinanciamientosClienteResponse,
    $consultaIntrasPorCuentaResponse,
    $consultaExtrafinanciamientoDisponibleResponse,
    $consultaSaldosTarjetaCreditoResponse)
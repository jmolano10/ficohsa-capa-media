xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns1:OutputParameters" location="../../../BusinessServices/ServiciosEmpresariales/consultaClienteDesembolsoLineaCredito/xsd/consultaClienteDesembolsoLineaCredito_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultaClienteDesembolsoLineaCreditoResponse" location="../../ServiciosEmpresariales/xsd/serviciosEmpresarialesTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/serviciosEmpresarialesTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaClienteDesembolsoLineaCredito";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaClienteDesembolsoLineaCredito/xq/consultaClienteDesembolsoLineaCreditoHNOut/";

declare function xf:consultaClienteDesembolsoLineaCreditoHNOut($outputParameters as element(ns1:OutputParameters))
    as element(ns0:consultaClienteDesembolsoLineaCreditoResponse) {
        <ns0:consultaClienteDesembolsoLineaCreditoResponse>
            <CUSTOMERS>
                {
                    for $row in $outputParameters/ns1:P_CUSTOMERS/ns1:P_CUSTOMERS_ITEM
                    return
                    (
                    	if(upper-case(string($row/ns1:SUCCESS_INDICATOR/text())) = 'SUCCESS')then(
                    		<CUSTOMER>
                    			<SUCCESS_INDICATOR>{ upper-case(data($row/ns1:SUCCESS_INDICATOR)) }</SUCCESS_INDICATOR>
		                        <REQUEST_VALUE>{ data($row/ns1:REQUESTED_VALUE) }</REQUEST_VALUE>
		   						<MESSAGES>{ data($row/ns1:MESSAGES) }</MESSAGES>
                    		 	<GENERAL_INFO>
                                <BASIC>
                                    <ID>{ data($row/ns1:CUSTOMER_ID) }</ID>
                                    <NAME>{ data($row/ns1:CUSTOMER_NAME) }</NAME>
                                    <LEGAL_ID>{ data($row/ns1:LEGAL_ID) }</LEGAL_ID>
                                    <TARGET_ID>{ data($row/ns1:TARGET_ID) }</TARGET_ID>
                                    <TARGET_DESCRIPTION>{ data($row/ns1:TARGET_DESCRIPTION) }</TARGET_DESCRIPTION>
                                    <BRANCH_CODE>{ data($row/ns1:BRANCH_CODE) }</BRANCH_CODE>
                                    <EXPIRATION_DAY>{ data($row/ns1:EXPIRATION_DAY) }</EXPIRATION_DAY>
                                </BASIC>
                                <FINANCIAL>
                                {
                                	if(data($row/ns1:FINANCIAL_STMT_DATE) != '')then(
                                   		 <FINANCIAL_STMT_DATE>{  fn-bea:date-to-string-with-format("yyyyMMdd",fn-bea:date-from-dateTime(data($row/ns1:FINANCIAL_STMT_DATE))) }</FINANCIAL_STMT_DATE>
                                    )else()
                                }
                                {
                                	if(data($row/ns1:NEXT_FINANCIAL_STMT_DATE) != '')then(
                                   		 <NEXT_FINANCIAL_STMT_DATE>{ fn-bea:date-to-string-with-format("yyyyMMdd",fn-bea:date-from-dateTime(data($row/ns1:NEXT_FINANCIAL_STMT_DATE))) }</NEXT_FINANCIAL_STMT_DATE>
                                    )else()
                              	}
                                    <PRESENTED_FINANCIAL_STMT>{ data($row/ns1:PRESENTED_FINANCIAL_STMT) }</PRESENTED_FINANCIAL_STMT>
                               
                                </FINANCIAL>
                                <CONTACT>
                                    <EMAILS>
								    {
								        for $EMAIL in $row/ns1:EMAILS_DLC/ns1:EMAILS_DLC_ITEM/ns1:EMAIL
										return                                    
                                    	<EMAIL>
											<ID>{ data($EMAIL) }</ID>
										</EMAIL>
								    }							        	                                         
                                    </EMAILS>
                                </CONTACT>
                            </GENERAL_INFO>
                            <PRODUCT_INFO>
                                {
                                    for $ACTIVE in $row/ns1:ACTIVE
                                    return
                                        <ACTIVE>{ data($ACTIVE) }</ACTIVE>
                                }
                                <LOAN_LIMITS>
					            {
					            	for $LOAN_LIMIT in $row/ns1:LOAN_LIMITS_DLC/ns1:LOAN_LIMITS_DLC_ITEM
					            	return
					            		<LOAN_LIMIT>
						                    <CURRENCY>{ data($LOAN_LIMIT/ns1:CURRENCY) }</CURRENCY>
						                    <MAX_AMOUNT>{ data($LOAN_LIMIT/ns1:MAX_AMOUNT) }</MAX_AMOUNT>
						                    <ENABLED>{ data($LOAN_LIMIT/ns1:ENABLED) }</ENABLED>
						                </LOAN_LIMIT>
					            }
                                </LOAN_LIMITS>
                                <DESTINATION_PRODUCTS>
						            {
						            	for $PRODUCT in $row/ns1:DESTINATION_PRODUCTS_DLC/ns1:DESTINATION_PRODUCTS_DLC_ITEM
						            	return
							                <PRODUCT>
							                    <ID>{ data($PRODUCT/ns1:PRODUCT_ID) }</ID>
							                    <CURRENCY>{ data($PRODUCT/ns1:CURRENCY) }</CURRENCY>
							                    <TYPE>{ data($PRODUCT/ns1:TYPE) }</TYPE>
							                </PRODUCT>
						            }
                                </DESTINATION_PRODUCTS>
                                <REPAYMENT_DETAILS>
                                    <AUTO_DEBIT>{ data($row/ns1:AUTO_DEBIT) }</AUTO_DEBIT>
                                    <DEBIT_ACCOUNTS>
						            {
						            	for $ACCOUNT in $row/ns1:DEBIT_ACCOUNTS_DLC/ns1:DEBIT_ACCOUNTS_DLC_ITEM
						            	return
							                <ACCOUNT>
							                    <ID>{ data($ACCOUNT/ns1:ACCOUNT_ID) }</ID>
							                    <CURRENCY>{ data($ACCOUNT/ns1:CURRENCY) }</CURRENCY>
							                    <TYPE>{ data($ACCOUNT/ns1:TYPE) }</TYPE>
							                </ACCOUNT>
						            }
						            </DEBIT_ACCOUNTS>
                                </REPAYMENT_DETAILS>
                                <CREDIT_LINES>
                                {
                                	for $i in 1 to count($row/ns1:CREDIT_LINES_DLC/ns1:CREDIT_LINES_DLC_ITEM)
                    				return
                    				(
                                    <CREDIT_LINE>
                                        <ID>{ data($row/ns1:CREDIT_LINES_DLC/ns1:CREDIT_LINES_DLC_ITEM[$i]/ns1:ID) }</ID>
                                         {
		                                	if(data($row/ns1:CREDIT_LINES_DLC/ns1:CREDIT_LINES_DLC_ITEM[$i]/ns1:EXPIRY_DATE) != '')then(
		                                   		  <EXPIRY_DATE>{ fn-bea:date-to-string-with-format("yyyyMMdd",fn-bea:date-from-dateTime(data($row/ns1:CREDIT_LINES_DLC/ns1:CREDIT_LINES_DLC_ITEM[$i]/ns1:EXPIRY_DATE))) }</EXPIRY_DATE>
		                                    )else()
			                             }        
                                        <CURRENCY>{ data($row/ns1:CREDIT_LINES_DLC/ns1:CREDIT_LINES_DLC_ITEM[$i]/ns1:CURRENCY) }</CURRENCY>
                                        <AMOUNT>{ data($row/ns1:CREDIT_LINES_DLC/ns1:CREDIT_LINES_DLC_ITEM[$i]/ns1:AMOUNT) }</AMOUNT>
										<AVAILABLE_AMOUNT>{ data($row/ns1:CREDIT_LINES_DLC/ns1:CREDIT_LINES_DLC_ITEM[$i]/ns1:AVAILABLE_AMOUNT) }</AVAILABLE_AMOUNT>                                        
                                        <ECONOMIC_ACTIVITY_CODE>{ data($row/ns1:CREDIT_LINES_DLC/ns1:CREDIT_LINES_DLC_ITEM[$i]/ns1:ECONOMIC_ACTIVITY_CODE) }</ECONOMIC_ACTIVITY_CODE>
                                        <INVESTMENT_CODE>{ data($row/ns1:CREDIT_LINES_DLC/ns1:CREDIT_LINES_DLC_ITEM[$i]/ns1:INVESTMENT_CODE) }</INVESTMENT_CODE>
                                        <INVESTMENT_SUBCODE>{ data($row/ns1:CREDIT_LINES_DLC/ns1:CREDIT_LINES_DLC_ITEM[$i]/ns1:INVESTMENT_SUB_CODE) }</INVESTMENT_SUBCODE>
                                        <DESTINATION_CODE>{ data($row/ns1:CREDIT_LINES_DLC/ns1:CREDIT_LINES_DLC_ITEM[$i]/ns1:DESTINATION_CODE) }</DESTINATION_CODE>
                                        <APPROVAL_CODE>{ data($row/ns1:CREDIT_LINES_DLC/ns1:CREDIT_LINES_DLC_ITEM[$i]/ns1:APPROVAL_CODE) }</APPROVAL_CODE>
                                        <OFFICER>{ data($row/ns1:CREDIT_LINES_DLC/ns1:CREDIT_LINES_DLC_ITEM[$i]/ns1:OFFICER) }</OFFICER>
                                        <OFFICER_BRANCH_CODE>{ data($row/ns1:CREDIT_LINES_DLC/ns1:CREDIT_LINES_DLC_ITEM[$i]/ns1:OFFICER_BRANCH_CODE) }</OFFICER_BRANCH_CODE>
                                        <SUB_ORIGIN>{ data($row/ns1:CREDIT_LINES_DLC/ns1:CREDIT_LINES_DLC_ITEM[$i]/ns1:SUB_ORIGIN) }</SUB_ORIGIN>
                                        <REVISION_RATE_TYPE>{ data($row/ns1:CREDIT_LINES_DLC/ns1:CREDIT_LINES_DLC_ITEM[$i]/ns1:REVISION_RATE_TYPE) }</REVISION_RATE_TYPE>
                                        <MONTHLY_SETTLEMENT>{ data($row/ns1:CREDIT_LINES_DLC/ns1:CREDIT_LINES_DLC_ITEM[$i]/ns1:MONTHLY_SETTLEMENT) }</MONTHLY_SETTLEMENT>
                                        <YEARLY_SETTLEMENT>{ data($row/ns1:CREDIT_LINES_DLC/ns1:CREDIT_LINES_DLC_ITEM[$i]/ns1:YEARLY_SETTLEMENT) }</YEARLY_SETTLEMENT>
                                        <GRACE_PERIOD>{ data($row/ns1:CREDIT_LINES_DLC/ns1:CREDIT_LINES_DLC_ITEM[$i]/ns1:GRACE_PERIOD) }</GRACE_PERIOD>
                                 		<MAX_PAYMENT_PERIOD>{ data($row/ns1:CREDIT_LINES_DLC/ns1:CREDIT_LINES_DLC_ITEM[$i]/ns1:MAX_PAYMENT_PERIOD) }</MAX_PAYMENT_PERIOD>                                     
                                        <LOAN_PRODUCT_DETAILS>
                                        {
                                    		for $LOAN_PRODUCT in $row/ns1:CREDIT_LINES_DLC/ns1:CREDIT_LINES_DLC_ITEM[$i]/ns1:LOAN_PRODUCTS_DLC/ns1:LOAN_PRODUCTS_DLC_ITEM
                							return
                							(
	                                            <LOAN_PRODUCT>
	                                            	<ID>{ data($LOAN_PRODUCT/ns1:ID) }</ID>
	                                            	<CURRENCY>{ data($LOAN_PRODUCT/ns1:CURRENCY) }</CURRENCY>
	                                                <OBLIGATION_TYPE>{ data($LOAN_PRODUCT/ns1:OBLIGATION_TYPE) }</OBLIGATION_TYPE>
	                                                <OBLIGATION_DESCRIPTION>{ data($LOAN_PRODUCT/ns1:OBLIGATION_DESCRIPTION) }</OBLIGATION_DESCRIPTION>
	                                                <GUARANTEE_TYPE>{ data($LOAN_PRODUCT/ns1:GUARANTEE_TYPE) }</GUARANTEE_TYPE>
	                                                <GUARANTEE_DESCRIPTION>{ data($LOAN_PRODUCT/ns1:GUARANTEE_DESCRIPTION) }</GUARANTEE_DESCRIPTION>
	                                                <REPAYMENT_TYPES>
	                                                {
	                                                	for $REPAYMENT_TYPE in $LOAN_PRODUCT/ns1:REPAYMENT_TYPE/ns1:REPAYMENT_TYPE_ITEM
                										return
                										(
		                                                    <REPAYMENT_TYPE>
		                                                        <CODE>{ data($REPAYMENT_TYPE/ns1:CODE) }</CODE>
		                                                        <DESCRIPTION>{ data($REPAYMENT_TYPE/ns1:DESCRIPTION) }</DESCRIPTION>
		                                                        <FREQUENCY>{ data($REPAYMENT_TYPE/ns1:FRECUENCY) }</FREQUENCY>
		                                                        <MAX_PAYMENT_TERM>{ data($REPAYMENT_TYPE/ns1:MAX_PAYMENT_TERM) }</MAX_PAYMENT_TERM>
		                                                    </REPAYMENT_TYPE>
	                                                    )
	                                                }
	                                                </REPAYMENT_TYPES>
	                                                {
	                                                	
														
														let $RATE:= $LOAN_PRODUCT/ns1:RATE
														return
														if( empty($RATE/*) )then(
            		
                										)else
                										(
															<RATES>
															{
																for $RATE_ITEM in $LOAN_PRODUCT/ns1:RATE/ns1:RATE_ITEM
																return
																	<RATE>
																		{
																			for $RATE_CLASS in $RATE_ITEM/ns1:RATE_CLASS
																			return
																				if( $RATE_CLASS/text() != "" )then (
																					<CLASS>{ data($RATE_CLASS) }</CLASS>
																				)else()        
																		}
																		{
																			for $RATE_GROUP in $RATE_ITEM/ns1:RATE_GROUP
																			return
																				if( $RATE_GROUP/text() != "" )then (
																					<GROUP>{ data($RATE_GROUP) }</GROUP>
																				)else()        
																		}
																		{
																			for $TERM_IN_MONTHS in $RATE_ITEM/ns1:TERM_IN_MONTHS
																			return
																				if( $TERM_IN_MONTHS/text() != "" )then (
																					<TERM_IN_MONTHS>{ data($TERM_IN_MONTHS) }</TERM_IN_MONTHS>
																				)else()        
																		}
																		{
																			for $LOAN_RATE in $RATE_ITEM/ns1:LOAN_RATE
																			return
																				if( $LOAN_RATE/text() != "" )then (
																					<LOAN_RATE>{ data($LOAN_RATE) }</LOAN_RATE>
																				)else()        
																		}
																		{
																			for $RATE_ACTION in $RATE_ITEM/ns1:RATE_ACTION
																			return
																				<ACTION>{ data($RATE_ACTION) }</ACTION>																				      
																		}																		
																	</RATE>
															}
															</RATES>
														)
													}
													{
															
														let $CHARGE := $LOAN_PRODUCT/ns1:CHARGE													
														return
														if( empty($CHARGE/*) )then(
            		
                										)else(
															<CHARGES>
																{
																	for $CHARGE_ITEM in $LOAN_PRODUCT/ns1:CHARGE/ns1:CHARGE_ITEM
																	return
																		<CHARGE>
																			{
																				for $CHARGES_NAME in $CHARGE_ITEM/ns1:CHARGES_NAME
																				return
																					if( $CHARGES_NAME/text() != "" )then (
																						<NAME>{ data($CHARGES_NAME) }</NAME>
																					)else()        
																			}
		{
																				for $CHARGES_TYPE in $CHARGE_ITEM/ns1:CHARGES_TYPE
																				return
																					if( $CHARGES_TYPE/text() != "" )then (
																						<TYPE>{ data($CHARGES_TYPE) }</TYPE>
																					)else()       
																			}																	
																			
																			{
																				if( $CHARGE_ITEM/ns1:CHARGES_NAME/text() = "RANGO" )then 
																				(
																					<RANGES>
																					{
																						for $CHARGES_RANGE_ITEM in $CHARGE_ITEM/ns1:CHARGES_RANGE/ns1:CHARGES_RANGE_ITEM
																						return
																							<RANGE>
																								{
																									for $RANGE_INITIAL in $CHARGES_RANGE_ITEM/ns1:RANGE_INITIAL
																									return
																									if( $RANGE_INITIAL/text() != "" )then (
																										<INITIAL>{ data($RANGE_INITIAL) }</INITIAL>
																									)else()        
																								}
		{
																									for $RANGE_FINAL in $CHARGES_RANGE_ITEM/ns1:RANGE_FINAL
																									return
																									if( $RANGE_FINAL/text() != "" )then (
																										<FINAL>{ data($RANGE_FINAL) }</FINAL>
																									)else()        
																								}																						
																								{
																									for $RANGE_VALUE in $CHARGES_RANGE_ITEM/ns1:RANGE_VALUE
																									return
																									if( $RANGE_VALUE/text() != "" )then (
																										<VALUE>{ data($RANGE_VALUE) }</VALUE>
																									)else()        
																								}																								
																							</RANGE>
																					}
																					</RANGES>
																				)else
																				 ( 
																					  for $CHARGES_VALUE in $CHARGE_ITEM/ns1:CHARGES_VALUE
																					  return
																						if( $CHARGES_VALUE/text() != "" )then (
																							<VALUE>{ data($CHARGES_VALUE) }</VALUE>
																						)else()																			 
																				 )																				
																			}
																			{
																				for $CHARGES_ACTION in $CHARGE_ITEM/ns1:CHARGES_ACTION
																				return
																					<ACTION>{ data($CHARGES_ACTION) }</ACTION>																					        
																	        }																	
																		</CHARGE>
															}
														</CHARGES>
														)
													}
	                                            </LOAN_PRODUCT>
                                            )
                                        }
                                        </LOAN_PRODUCT_DETAILS>
                                    </CREDIT_LINE>
                                    )
                                 }
                                </CREDIT_LINES>
                            </PRODUCT_INFO>
                 		</CUSTOMER>	
                	)else(
                		<CUSTOMER>	
                    		<SUCCESS_INDICATOR>{ upper-case(data($row/ns1:SUCCESS_INDICATOR)) }</SUCCESS_INDICATOR>
                        	<REQUEST_VALUE>{ data($row/ns1:REQUESTED_VALUE) }</REQUEST_VALUE>
   							<MESSAGES>{ data($row/ns1:MESSAGES) }</MESSAGES>
                		</CUSTOMER>	
                	)      	
                 )
                    	
               }        
         	</CUSTOMERS>
			
        </ns0:consultaClienteDesembolsoLineaCreditoResponse>
};

declare variable $outputParameters as element(ns1:OutputParameters) external;

xf:consultaClienteDesembolsoLineaCreditoHNOut($outputParameters)
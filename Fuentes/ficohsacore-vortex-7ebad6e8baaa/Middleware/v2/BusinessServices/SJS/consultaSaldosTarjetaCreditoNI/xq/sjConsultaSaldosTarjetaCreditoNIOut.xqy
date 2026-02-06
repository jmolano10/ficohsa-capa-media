xquery version "2004-draft";
(:: pragma  parameter="$resultGroup" type="anyType" ::)
(:: pragma bea:global-element-return element="ns0:sjConsultaSaldosTarjetaCreditoResponse" location="../../consultaSaldosTarjetaCredito/xsd/sjConsultaSaldosTarjetaCreditoTypes.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$sjConsultaSaldosTC" element="ns0:sjConsultaSaldosTarjetaCredito" location="../../consultaSaldosTarjetaCredito/xsd/sjConsultaSaldosTarjetaCreditoTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/sjConsultaSaldosTarjetaCreditoTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/BusinessServices/SJS/consultaSaldosTarjetaCredito/xq/sjConsultaSaldosTarjetaCreditoOut/";
declare namespace ns1 = "http://www.procesa.com/fdcs";
declare namespace ns2 = "http://www.procesa.com/fdcs/ot";
declare namespace ns3 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/osbConSaldosTCOffLine";
declare namespace ns4 = "http://www.ficohsa.com.hn/middleware.services/cashOpenToBuyInquiryTypes";

declare function xf:sjConsultaSaldosTarjetaCreditoNIOut($resultGroup as element(*), $sjConsultaSaldosTC as element(ns0:sjConsultaSaldosTarjetaCredito))
    as element(ns0:sjConsultaSaldosTarjetaCreditoResponse) {
        <ns0:sjConsultaSaldosTarjetaCreditoResponse>
        {
        		let $rowBase :=  $sjConsultaSaldosTC/CARD_INFORMATION[ORG_TYPE = 'BASE']
				let $rowAlt:= $sjConsultaSaldosTC/CARD_INFORMATION[ORG_TYPE = 'ALT']
		        let $orgBase := string($rowBase/ORG/text())
		        let $orgAlt := string($rowAlt/ORG/text())
				let $currencyBase:= string($rowBase/CURRENCY/text())
				let $currencyAlt:= string($rowAlt/CURRENCY/text())		        
        		let $accountInquiryL8VLBase := $resultGroup/ACCOUNT_INQUIRY_RESPONSES/ns1:AccountInquiryL8VLResponse[AZXAIO-ORG = $orgBase]
            	let $accountInquiryL8VLAlt := $resultGroup/ACCOUNT_INQUIRY_RESPONSES/ns1:AccountInquiryL8VLResponse[AZXAIO-ORG = $orgAlt]
            	let $balanceInquiryBase := $resultGroup/BALANCE_INQUIRY_RESPONSES/ns1:BalanceInquiryResponse[ARXBIO-ORG = $orgBase]
            	let $balanceInquiryAlt := $resultGroup/BALANCE_INQUIRY_RESPONSES/ns1:BalanceInquiryResponse[ARXBIO-ORG = $orgAlt]
              	let $ARXBIO-PMT-TOT-AMT-DUE-BASE := xs:decimal($balanceInquiryBase/ARXBIO-PMT-TOT-AMT-DUE)
				let $AZXAIO-AMT-MEMO-CR-BASE := xs:decimal($accountInquiryL8VLBase/AZXAIO-AMT-MEMO-CR)
				let $AZXAIO-PMT-CTD-BASE := xs:decimal($accountInquiryL8VLBase/AZXAIO-PMT-CTD)
				let $ARXBIO-PMT-TOT-AMT-DUE-ALT := xs:decimal($balanceInquiryAlt/ARXBIO-PMT-TOT-AMT-DUE)
				let $AZXAIO-AMT-MEMO-CR-ALT := xs:decimal($accountInquiryL8VLAlt/AZXAIO-AMT-MEMO-CR)
				let $AZXAIO-PMT-CTD-ALT := xs:decimal($accountInquiryL8VLAlt/AZXAIO-PMT-CTD)
			    let $BASE_MIN_PAYMENT := $ARXBIO-PMT-TOT-AMT-DUE-BASE - $AZXAIO-AMT-MEMO-CR-BASE	
        		let $BASE_TOTAL_PAYMENT := ($AZXAIO-PMT-CTD-BASE + $AZXAIO-AMT-MEMO-CR-BASE)
                let $ALT_MIN_PAYMENT := $ARXBIO-PMT-TOT-AMT-DUE-ALT - $AZXAIO-AMT-MEMO-CR-ALT
                let $ALT_TOTAL_PAYMENT := ($AZXAIO-PMT-CTD-ALT + $AZXAIO-AMT-MEMO-CR-ALT)          
		        return(
		        
                	if(not(empty($accountInquiryL8VLBase)) and not(empty($balanceInquiryBase)) )then( 
                		if(($currencyBase = 'NIO'))then(
	                		if($BASE_MIN_PAYMENT >= 0)then(
		                		<LCY_MIN_PAYMENT>{ data($BASE_MIN_PAYMENT) }</LCY_MIN_PAYMENT>
		                	)else(
		                		<LCY_MIN_PAYMENT>0</LCY_MIN_PAYMENT>
		                	)
                		)else(
	                		if($BASE_MIN_PAYMENT >= 0)then(
		                		<FCY_MIN_PAYMENT>{ data($BASE_MIN_PAYMENT) }</FCY_MIN_PAYMENT>
		                	)else(
		                		<FCY_MIN_PAYMENT>0</FCY_MIN_PAYMENT>
		                	)                		
                		)

	                )else( 
	                	if(($currencyBase = 'NIO'))then(
	                	    <LCY_MIN_PAYMENT/>
	                	)else(
	                		<FCY_MIN_PAYMENT/>
	                	)

       		 	    ),
       		 	    if(not(empty($accountInquiryL8VLBase)))then(
       		 	    	if(($currencyBase = 'NIO'))then(
		                	if($BASE_TOTAL_PAYMENT >= 0)then(
		                		<LCY_TOTAL_PAYMENT>{ data($BASE_TOTAL_PAYMENT) }</LCY_TOTAL_PAYMENT>
		                	)else(
		                		<LCY_TOTAL_PAYMENT>0</LCY_TOTAL_PAYMENT>
		                	)
		                )else(
		                	if($BASE_TOTAL_PAYMENT >= 0)then(
		                		<FCY_TOTAL_PAYMENT>{ data($BASE_TOTAL_PAYMENT) }</FCY_TOTAL_PAYMENT>
		                	)else(
		                		<FCY_TOTAL_PAYMENT>0</FCY_TOTAL_PAYMENT>
		                	)		                
		                )
	                )else(
	                
	                	if(($currencyBase = 'NIO'))then(
	                	    <LCY_TOTAL_PAYMENT/>
	                	)else(
	                		<FCY_TOTAL_PAYMENT/>
	                	)	                
       		 	     	
       		 	     ),
       		 	     
       		 	     
                	if($orgAlt != '0')then(
                		if(not(empty($accountInquiryL8VLAlt)) and not(empty($balanceInquiryAlt)))then( 
                			if(($currencyBase = 'NIO'))then(
		                		if($ALT_MIN_PAYMENT >= 0)then(
			                		<FCY_MIN_PAYMENT>{ data($ALT_MIN_PAYMENT) }</FCY_MIN_PAYMENT>
			                	)else(
			                		<FCY_MIN_PAYMENT>0</FCY_MIN_PAYMENT>
			                	)                			
                			)else(
		                		if($ALT_MIN_PAYMENT >= 0)then(
			                		<LCY_MIN_PAYMENT>{ data($ALT_MIN_PAYMENT) }</LCY_MIN_PAYMENT>
			                	)else(
			                		<LCY_MIN_PAYMENT>0</LCY_MIN_PAYMENT>
			                	)                			
                			)

		                )else( 
		                	if(($currencyBase = 'NIO'))then(
                        		<FCY_MIN_PAYMENT/>		                	
		                	)else(
                        		<LCY_MIN_PAYMENT/>				                	
		                	)
                    	),
                    	if(not(empty($accountInquiryL8VLBase)))then(
                    		if(($currencyBase = 'NIO'))then(
	 		                	if($ALT_TOTAL_PAYMENT >= 0)then(
			                		<FCY_TOTAL_PAYMENT>{ data($ALT_TOTAL_PAYMENT)}</FCY_TOTAL_PAYMENT>
			                	)else(
			                		<FCY_TOTAL_PAYMENT>0</FCY_TOTAL_PAYMENT>
			                	)                   		
                    		)else(
			                	if($ALT_TOTAL_PAYMENT >= 0)then(
			                		<LCY_TOTAL_PAYMENT>{ data($ALT_TOTAL_PAYMENT)}</LCY_TOTAL_PAYMENT>
			                	)else(
			                		<LCY_TOTAL_PAYMENT>0</LCY_TOTAL_PAYMENT>
			                	)                    		
                    		)

		                )else(
		                	if(($currencyBase = 'NIO'))then(
       		 	    			<FCY_TOTAL_PAYMENT/>		                	
		                	)else(
       		 	    			<LCY_TOTAL_PAYMENT/>		                	
		                	)

       		 	    	)
                	)else(''),
                	
                	if(($orgBase = '333') or (($orgBase = '332')))then(
	                	if(not(empty($accountInquiryL8VLBase)))then(
	                	<CREDIT_LIMIT>{ data($accountInquiryL8VLBase/AZXAIO-CRLIM) }</CREDIT_LIMIT>,
		       		 	<CREDIT_LIMIT_CCY>{ data($currencyBase)}</CREDIT_LIMIT_CCY>
		       		 	) else (
		       		 	if(not(empty($accountInquiryL8VLAlt))) then (
		       		 			<CREDIT_LIMIT>{ data($accountInquiryL8VLAlt/AZXAIO-CRLIM) }</CREDIT_LIMIT>,
		       		 			<CREDIT_LIMIT_CCY>{ data($currencyAlt)}</CREDIT_LIMIT_CCY>
		       		 		) else (
		       		 	<CREDIT_LIMIT/>,
	    		    	<CREDIT_LIMIT_CCY/>
		       		 		)
	    		    	)                	
                	)else(
	                	if(not(empty($accountInquiryL8VLBase)))then(
		                	if(not(empty($accountInquiryL8VLAlt))) then (
		       		 			<CREDIT_LIMIT>{ data($accountInquiryL8VLAlt/AZXAIO-CRLIM) }</CREDIT_LIMIT>,
		       		 			<CREDIT_LIMIT_CCY>USD</CREDIT_LIMIT_CCY>
		       		 		) else (
		       		 			<CREDIT_LIMIT>{ data($accountInquiryL8VLBase/AZXAIO-CRLIM) }</CREDIT_LIMIT>,
		       		 			<CREDIT_LIMIT_CCY>NIO</CREDIT_LIMIT_CCY>
		       		 		)
		       		 	)else(
	    		    		<CREDIT_LIMIT/>,
	    		    		<CREDIT_LIMIT_CCY/>
	    		    	
	        		    )                	
                	),

	                	
	       		 	
		       		 <ns0:consultaSaldosTarjetaCreditoResponseType>
	            	  { 
		               
            	  		 <ns0:consultaSaldosTarjetaCreditoResponseRecordType>
            	  		 {
            	  		 		let $AZXAIO-PMT-PAST-DUE:= xs:decimal(data($accountInquiryL8VLBase/AZXAIO-PMT-PAST-DUE))
		            	  		let $AZXAIO-PMT-30DAYS:= xs:decimal(data($accountInquiryL8VLBase/AZXAIO-PMT-30DAYS))
		            	  		let $AZXAIO-PMT-60DAYS:= xs:decimal(data($accountInquiryL8VLBase/AZXAIO-PMT-60DAYS))
								let $AZXAIO-PMT-90DAYS:= xs:decimal(data($accountInquiryL8VLBase/AZXAIO-PMT-90DAYS))
								let $AZXAIO-PMT-120DAYS:=xs:decimal(data($accountInquiryL8VLBase/AZXAIO-PMT-120DAYS))
								let $AZXAIO-PMT-150DAYS:= xs:decimal(data($accountInquiryL8VLBase/AZXAIO-PMT-150DAYS))
								let $AZXAIO-PMT-180DAYS:= xs:decimal(data($accountInquiryL8VLBase/AZXAIO-PMT-180DAYS))
								let $AZXAIO-PMT-210DAYS:= xs:decimal(data($accountInquiryL8VLBase/AZXAIO-PMT-210DAYS))
								let $OVERDUE_BALANCE:= $AZXAIO-PMT-PAST-DUE + $AZXAIO-PMT-30DAYS +  $AZXAIO-PMT-60DAYS + $AZXAIO-PMT-90DAYS + $AZXAIO-PMT-120DAYS + $AZXAIO-PMT-150DAYS + $AZXAIO-PMT-180DAYS + $AZXAIO-PMT-210DAYS
            	  		 		return(
					             
								     if(not(empty($accountInquiryL8VLBase)))then(
								    	<OVERDUE_BALANCE>{ $OVERDUE_BALANCE }</OVERDUE_BALANCE>
				                    )else(
				                   		 <OVERDUE_BALANCE/>
				                    ),
				                    if(not(empty($accountInquiryL8VLBase)))then(
				                    	<FLOATING_BALANCE>{ data($accountInquiryL8VLBase/AZXAIO-AMT-MEMO-DB) }</FLOATING_BALANCE>
									)else(
										<FLOATING_BALANCE/>
									),
				                    if(not(empty($accountInquiryL8VLBase)))then(
				                    	<PURCHASES_LIMIT>{ data($accountInquiryL8VLBase/AZXAIO-AVAIL-CREDIT) }</PURCHASES_LIMIT>
				                    )else(
				                   		<PURCHASES_LIMIT/>
				                    ),
				                    if(not(empty($accountInquiryL8VLBase)))then(
				                    	<WITHDRAWAL_LIMIT>{ data($accountInquiryL8VLBase/AZXAIO-CASH-AVAIL-CREDIT) }</WITHDRAWAL_LIMIT>
				                    )else(
				                    	<WITHDRAWAL_LIMIT/>
				                    ),
				                    if(not(empty($accountInquiryL8VLBase)))then(
				                    	<PAYMENTS_TODAY>{ data($accountInquiryL8VLBase/AZXAIO-AMT-MEMO-CR) }</PAYMENTS_TODAY>
	                                )else(
	                                	<PAYMENTS_TODAY/>
	                                ),
	                          		<CURRENT_BALANCE_EXTRA>0</CURRENT_BALANCE_EXTRA>,
				                	<CURRENT_BALANCE_INTRA>0</CURRENT_BALANCE_INTRA>,
				                	<ORG_TYPE>{ data($rowBase/ORG_TYPE) }</ORG_TYPE>		,
				                	<ORG>{ data($rowBase/ORG) }</ORG>	
            	  		 		)
            	  		 	}
            	  		  </ns0:consultaSaldosTarjetaCreditoResponseRecordType>,
            	  		  if($orgAlt != '0')then( 
		            	  		  <ns0:consultaSaldosTarjetaCreditoResponseRecordType>
								{
									let $AZXAIO-PMT-PAST-DUE:= $accountInquiryL8VLAlt/AZXAIO-PMT-PAST-DUE
									let $AZXAIO-PMT-30DAYS:= $accountInquiryL8VLAlt/AZXAIO-PMT-30DAYS
									let $AZXAIO-PMT-60DAYS:= $accountInquiryL8VLAlt/AZXAIO-PMT-60DAYS
									let $AZXAIO-PMT-90DAYS:= $accountInquiryL8VLAlt/AZXAIO-PMT-90DAYS
									let $AZXAIO-PMT-120DAYS:= $accountInquiryL8VLAlt/AZXAIO-PMT-120DAYS
									let $AZXAIO-PMT-150DAYS:= $accountInquiryL8VLAlt/AZXAIO-PMT-150DAYS
									let $AZXAIO-PMT-180DAYS:= $accountInquiryL8VLAlt/AZXAIO-PMT-180DAYS
									let $AZXAIO-PMT-210DAYS:= $accountInquiryL8VLAlt/AZXAIO-PMT-210DAYS
									let $OVERDUE_BALANCE:= $AZXAIO-PMT-PAST-DUE + $AZXAIO-PMT-30DAYS +  $AZXAIO-PMT-60DAYS + $AZXAIO-PMT-90DAYS + $AZXAIO-PMT-120DAYS + $AZXAIO-PMT-150DAYS + $AZXAIO-PMT-180DAYS + $AZXAIO-PMT-210DAYS
									return(
						                if(not(empty($accountInquiryL8VLAlt)))then(
						                	<OVERDUE_BALANCE>{ $OVERDUE_BALANCE }</OVERDUE_BALANCE>
						                )else(
				                   			<OVERDUE_BALANCE/>
				                    	),
				                    	if(not(empty($accountInquiryL8VLAlt)))then(
						                	<FLOATING_BALANCE>{ data($accountInquiryL8VLAlt/AZXAIO-AMT-MEMO-DB) }</FLOATING_BALANCE>
										)else(
											<FLOATING_BALANCE/>
										),
						                if(not(empty($accountInquiryL8VLAlt)))then(
						                	<PURCHASES_LIMIT>{ data($accountInquiryL8VLAlt/AZXAIO-AVAIL-CREDIT) }</PURCHASES_LIMIT>
						                )else(
				                   			<PURCHASES_LIMIT/>
				                  		),
				                  		if(not(empty($accountInquiryL8VLAlt)))then(
						                	<WITHDRAWAL_LIMIT>{ data($accountInquiryL8VLAlt/AZXAIO-CASH-AVAIL-CREDIT) }</WITHDRAWAL_LIMIT>
						                )else(
				                    		<WITHDRAWAL_LIMIT/>
				                    	),
				                    	 if(not(empty($accountInquiryL8VLAlt)))then(
						                	<PAYMENTS_TODAY>{ data($accountInquiryL8VLAlt/AZXAIO-AMT-MEMO-CR) }</PAYMENTS_TODAY>
			                            )else(
	                                		<PAYMENTS_TODAY/>
	                                	),
			                          	<CURRENT_BALANCE_EXTRA>0</CURRENT_BALANCE_EXTRA>,
			                            <CURRENT_BALANCE_INTRA>0</CURRENT_BALANCE_INTRA>,
			                            <ORG_TYPE>{ data($rowAlt/ORG_TYPE) }</ORG_TYPE>,
				                		<ORG>{ data($rowAlt/ORG) }</ORG>	
									)
								}
								</ns0:consultaSaldosTarjetaCreditoResponseRecordType>
            	  		)else()
            	  	}
        	  </ns0:consultaSaldosTarjetaCreditoResponseType>
       	
             )   	
		}
            	
        </ns0:sjConsultaSaldosTarjetaCreditoResponse>
};

declare variable $resultGroup as element(*) external;
declare variable $sjConsultaSaldosTC as element(ns0:sjConsultaSaldosTarjetaCredito) external;

xf:sjConsultaSaldosTarjetaCreditoNIOut($resultGroup, $sjConsultaSaldosTC)
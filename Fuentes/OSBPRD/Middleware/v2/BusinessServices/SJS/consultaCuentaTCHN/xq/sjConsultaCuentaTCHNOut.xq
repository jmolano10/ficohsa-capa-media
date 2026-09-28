(:: pragma  parameter="$resultGroup" type="anyType" ::)
(:: pragma bea:global-element-return element="ns0:sjconsultaCuentaTCResponse" location="../../consultaCuentaTC/xsd/sjconsultaCuentaTCTypes.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$sjconsultaCuentaTC" element="ns0:sjconsultaCuentaTC" location="../../consultaCuentaTC/xsd/sjconsultaCuentaTCTypes.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$onlineInformationResponse" element="ns1:OnlineInformationResponse" location="../../../../Resources/OnlineInformation/xsd/onlineInformationTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/sjconsultaCuentaTCTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/BusinessServices/SJS/consultaCuentaTCHN/xq/sjConsultaCuentaTCHNOut/";
declare namespace ns4 = "http://www.procesa.com/fdcs";
declare namespace ns5 = "http://www.procesa.com/fdcs/ot";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/onlineInformationTypes";

declare function xf:sjConsultaCuentaTCHNOut($resultGroup as element(*), $sjconsultaCuentaTC as element(ns0:sjconsultaCuentaTC))
    as element(ns0:sjconsultaCuentaTCResponse) {
        <ns0:sjconsultaCuentaTCResponse>
        {
        	for $accountInquiryL8VLResponse in $resultGroup/ACCOUNT_INQUIRY_RESPONSES/ns4:AccountInquiryL8VLResponse[1]
			return(
				for $account in $accountInquiryL8VLResponse/AZXAIO-ACCT
			 		return
			 			<ACCOUNT_NUMBER>{ data($account) }</ACCOUNT_NUMBER>,
			 			for $logo in $accountInquiryL8VLResponse/AZXAIO-LOGO
			 		return
				 		<LOGO>{ data($logo) }</LOGO>,
				 	
				 	for $accountCycle in string($accountInquiryL8VLResponse/AZXAIO-BILLING-CYCLE/text())
				 	return
				 		if(fn-bea:trim($accountCycle) != '') then(
				 			<ACCOUNT_CYCLE>{ data($accountCycle) }</ACCOUNT_CYCLE>
				 		) else (),
				 	
				 	for $openingDate in string($accountInquiryL8VLResponse/AZXAIO-DATE-OPENED/text())
				 	return
				 		if(fn-bea:trim($openingDate) != '') then(
				 			<OPENING_DATE>{ $openingDate }</OPENING_DATE>
				 		) else(),
				 		
				 	for $settlementModel in $accountInquiryL8VLResponse/AZXAIO-STATE-OF-RESID
				 	return
				 		<SETTLEMENT_MODEL>{ data($settlementModel) }</SETTLEMENT_MODEL>,
				 		
				 	for $lastCutOffDate in string($accountInquiryL8VLResponse/AZXAIO-DATE-LAST-STMT/text())
				 	return
				 		if(fn-bea:trim($lastCutOffDate) != '') then(
				 			<LAST_CUTOFF_DATE>{ $lastCutOffDate }</LAST_CUTOFF_DATE>
				 		) else(),
				 		
				 	for $nextCutOffDate in string($accountInquiryL8VLResponse/AZXAIO-DATE-NEXT-STMT/text())
				 	return
				 		if(fn-bea:trim($nextCutOffDate) != '') then(
				 			<NEXT_CUTOFF_DATE>{ $nextCutOffDate }</NEXT_CUTOFF_DATE>
				 		) else(), 
				 		
				 	for $maxPaymentDate in string($accountInquiryL8VLResponse/AZXAIO-DATE-PMT-DUE/text())
				 	return
				 		if(fn-bea:trim($maxPaymentDate) != '') then(
				 			<MAX_PAYMENT_DATE>{ $maxPaymentDate }</MAX_PAYMENT_DATE>
				 		) else(),
				 		<HOLDER_INFORMATION>
				 		{
				 		    
				 		    for $educationLevel in $accountInquiryL8VLResponse/AZXAIO-USER-CODE-14
				 			return
				 				<EDUCATION_LEVEL> { string($educationLevel/text()) }</EDUCATION_LEVEL>,
				 			
				 			for $jobTitle in $accountInquiryL8VLResponse/AZXAIO-USER-CODE-3
				 			return
								<JOB_TITTLE>{ string($jobTitle/text()) }</JOB_TITTLE>,
							
							for $score in string($accountInquiryL8VLResponse/AZXAIO-USER-CODE-9/text())
				 			return	
				 				if(fn-bea:trim($score) != '') then( 
									<SCORE>{ $score }</SCORE>
								) else(),
								
							for $mainIncome in string($accountInquiryL8VLResponse/AZXAIO-USER-CODE-10/text())
				 			return
				 				if(fn-bea:trim($mainIncome) != '') then(	
									<MAIN_INCOME>{ $mainIncome }</MAIN_INCOME>
								)else(),
								
							for $secondaryIncome in string($accountInquiryL8VLResponse/AZXAIO-USER-CODE-11/text())
				 			return
				 				if(fn-bea:trim($secondaryIncome) != '') then(
									<SECONDARY_INCOME>{ $secondaryIncome }</SECONDARY_INCOME>
								)else(),
								
							for $incomeRange in $accountInquiryL8VLResponse/AZXAIO-INCOME
				 			return	
								<INCOME_RANGE>{ data($incomeRange) }</INCOME_RANGE>,
								
							for $customerId in $accountInquiryL8VLResponse/AZXAIO-REL-NBR
							return	
								<CUSTOMER_ID>{ data($customerId) }</CUSTOMER_ID>,
								
							for $customerSegment in $accountInquiryL8VLResponse/AZXAIO-USER-CODE-6
				 			return	
								<CUSTOMER_SEGMENT>{ data($customerSegment) }</CUSTOMER_SEGMENT>,
								
							for $customerType in $accountInquiryL8VLResponse/AZXAIO-USER-CODE-7
				 			return	
								<CUSTOMER_TYPE>{ data($customerType) }</CUSTOMER_TYPE>,
								
							for $pep in $accountInquiryL8VLResponse/AZXAIO-USER-CODE-8
				 			return	
								<PEP>{ data($pep) }</PEP>
				 		}			            
			         </HOLDER_INFORMATION>				
			)
        }
        {
        		for $datosCuenta at $i in $sjconsultaCuentaTC/ACCOUNT_INFORMATION
	         	let $org := data($datosCuenta/ORG)
	         	let $cashOTBResponse := $resultGroup/CASH_OTB_INQUIRY_RESPONSES/ns4:OTBResponse[$i]
	 			let $accountInquiryL8VLResponse := $resultGroup/ACCOUNT_INQUIRY_RESPONSES/ns4:AccountInquiryL8VLResponse[ AZXAIO-ORG = $org ]
	 			let $balanceInquiryVAResponse := $resultGroup/BALANCE_INQUIRY_RESPONSES/ns4:BalanceInquiryResponse[ ARXBIO-ORG = $org ]
	 			let $onlineInformationResponse := $resultGroup/ONLINE_INFORMATION_RESPONSES/ns1:onlineInformationResponse[$i]
	        	return
        	 		<BALANCE_INFORMATION>
			            {
			            	for $org in string($accountInquiryL8VLResponse/AZXAIO-ORG/text())
			            	return
			            		if(fn-bea:trim($org) != '') then(
			            			<ORG>{ $org }</ORG>
			            		)else()			            		
			            }
			            {
			            	if( count($accountInquiryL8VLResponse/*) > 0 ) then(  
			            	         
					            <BLOCKING_INFORMATION>
						            <BLOCK1>
						            	{
						            		for $blockCode in $accountInquiryL8VLResponse/AZXAIO-BLOCK-CODE-1
						            		return
						            			<BLOCK_CODE>{ data($blockCode) }</BLOCK_CODE>
						            	}
						            	{
						            		for $blockDate in string($accountInquiryL8VLResponse/AZXAIO-DATE-BLOCK-CODE-1/text())
						            		return
						            			if(fn-bea:trim($blockDate) != '')then(
						            				<BLOCK_DATE>{ $blockDate }</BLOCK_DATE>
						            			)else()
						            	}					       
						            </BLOCK1>						            
						            <BLOCK2>
						            	{
						            		for $blockCode in $accountInquiryL8VLResponse/AZXAIO-BLOCK-CODE-2
						            		return
						            			<BLOCK_CODE>{ data($blockCode) }</BLOCK_CODE>
						            	}
						            	{
						            		for $blockDate in string($accountInquiryL8VLResponse/AZXAIO-DATE-BLOCK-CODE-2/text())
						            		return
						            			if(fn-bea:trim($blockDate) != '')then(
						            				<BLOCK_DATE>{ $blockDate }</BLOCK_DATE>
						            			)else()
						            	}					            	
						            </BLOCK2>	
					            </BLOCKING_INFORMATION>					            
					        )else()
			            }
			            {
			            	for $currenBalance in string($accountInquiryL8VLResponse/AZXAIO-CURR-BAL/text())
			            	return
			            		if(fn-bea:trim($currenBalance) != '') then(
			            			<CURRENT_BALANCE>{ $currenBalance}</CURRENT_BALANCE>
			            		)else()
			            }
			            {
			            	(:for $currentMinPayment in string($balanceInquiryVAResponse/ARXBIO-PMT-TOT-AMT-DUE/text()):)
			            	for $currentMinPayment in string($accountInquiryL8VLResponse/AZXAIO-PMT-TOT-AMT-DUE/text())
			            	return
			            		if(fn-bea:trim($currentMinPayment) != '') then(
			            			<CURRENT_MIN_PAYMENT>{ $currentMinPayment }</CURRENT_MIN_PAYMENT>
			            		)else()
			            }
			            {
			            	for $paymentsAmount in string($accountInquiryL8VLResponse/AZXAIO-PMT-CTD/text())
			            	return
			            		if(fn-bea:trim($paymentsAmount) != '') then(
			            			<PAYMENTS_AMOUNT>{ $paymentsAmount }</PAYMENTS_AMOUNT>
			            		)else()
			            }
			            {
			            	for $pendingAuthorizations in string($accountInquiryL8VLResponse/AZXAIO-AMT-MEMO-DB/text())
			            	return
			            		if(fn-bea:trim($pendingAuthorizations) != '') then(
			            			<PENDING_AUTHORIZATIONS>{ $pendingAuthorizations }</PENDING_AUTHORIZATIONS>
			            		)else()
			            }
			            {
			            	for $pendingPayments in string($accountInquiryL8VLResponse/AZXAIO-AMT-MEMO-CR/text())
			            	return
			            		if(fn-bea:trim($pendingPayments) != '') then(
			            			<PENDING_PAYMENTS>{ $pendingPayments }</PENDING_PAYMENTS>
			            		)else()
			            }
			            {
			            	for $lateFeeBalance in string($accountInquiryL8VLResponse/AZXAIO-PMT-PAST-DUE/text())
			            	return
			            		if(fn-bea:trim($lateFeeBalance) != '') then(
			            			<LATE_FEE_BALANCE>{ $lateFeeBalance }</LATE_FEE_BALANCE>
			            		)else()
			            }             			            
			            {
			            	for $cicle in string($accountInquiryL8VLResponse/AZXAIO-PMT-CYCLE-DUE/text())
			            	return
			            		if(fn-bea:trim($cicle) != '') then(
			            			<CICLE>{ $cicle }</CICLE>
			            		)else()
			            }
			            {
			            	for $lastCoutoffLateFeeDate in string($accountInquiryL8VLResponse/AZXAIO-DATE-LAST-DELQ/text())
			            	return
			            		if(fn-bea:trim($lastCoutoffLateFeeDate) != '') then(
			            			<LAST_CUTOFF_LATE_FEE_DATE>{ $lastCoutoffLateFeeDate }</LAST_CUTOFF_LATE_FEE_DATE>
			            		)else()
			            }
			            {
			            	for $lastCoutoffPaymentDate in string($accountInquiryL8VLResponse/AZXAIO-DATE-LAST-PMT/text())
			            	return
			            		if(fn-bea:trim($lastCoutoffPaymentDate) != '') then(
			            			<LAST_CUTOFF_PAYMENT_DATE>{ $lastCoutoffPaymentDate }</LAST_CUTOFF_PAYMENT_DATE>
			            		)else()
			            }
			            {
			            	for $lastTxnDate in string($accountInquiryL8VLResponse/AZXAIO-DATE-LAST-PURCH/text())
			            	return
			            		if(fn-bea:trim($lastTxnDate) != '') then(
			            			<LAST_TXN_DATE>{ $lastTxnDate }</LAST_TXN_DATE>
			            		)else()
			            }
			            {
			            	for $tempCrlimDate in string($accountInquiryL8VLResponse/AZXAIO-DATE-TEMP-CRLIM-EXP/text())
			            	return
			            		if(fn-bea:trim($tempCrlimDate) != '') then(
									<TEMP_CRLIM_DATE>{ $tempCrlimDate }</TEMP_CRLIM_DATE>
			            		)else()
			            }
			            {
			            	for $tempCrlimAmount in string($accountInquiryL8VLResponse/AZXAIO-TEMP-CRLIM/text())
			            	return
			            		if(fn-bea:trim($tempCrlimAmount) != '') then(
			            			<TEMP_CRLIM_AMOUNT>{ $tempCrlimAmount }</TEMP_CRLIM_AMOUNT>
			            		)else()
			            }
			            {
			            	for $purchaseAvilableAmount in string($accountInquiryL8VLResponse/AZXAIO-AVAIL-CREDIT-WO-OVL/text())
			            	return
			            		if(fn-bea:trim($purchaseAvilableAmount) != '') then(
			            			<PURCHASE_AVAILABLE_AMOUNT>{ $purchaseAvilableAmount }</PURCHASE_AVAILABLE_AMOUNT>
			            		)else()
			            }
			            {
			            	for $openToBuy in string($accountInquiryL8VLResponse/AZXAIO-AVAIL-CREDIT/text())
			            	return
			            		if(fn-bea:trim($openToBuy) != '') then(
			            			<OPEN_TO_BUY>{ $openToBuy }</OPEN_TO_BUY>
			            		)else(
			            			<OPEN_TO_BUY>0</OPEN_TO_BUY>
			            		)
			            }
			            {
			            	for $availableWithdrawal in string($accountInquiryL8VLResponse/AZXAIO-CASH-AVAIL-CREDIT/text())
			            	return
			            		if(fn-bea:trim($availableWithdrawal) != '') then(
			            			<AVAILABLE_WITHDRAWAL>{ $availableWithdrawal }</AVAILABLE_WITHDRAWAL>
			            		)else(
			            			<AVAILABLE_WITHDRAWAL>0</AVAILABLE_WITHDRAWAL>
			            		)
			            }
			            {
			            	for $creditLimit in string($accountInquiryL8VLResponse/AZXAIO-CRLIM/text())
			            	return
			            		if(fn-bea:trim($creditLimit) != '') then(
			            			<CREDIT_LIMIT>{ $creditLimit }</CREDIT_LIMIT>
			            		)else()
			            }
			            {
			            	for $lastCrLimAmount in string($accountInquiryL8VLResponse/AZXAIO-LAST-CRLIM/text())
			            	return
			            		if(fn-bea:trim($lastCrLimAmount) != '') then(
									<LAST_CRLIM_AMOUNT>{ $lastCrLimAmount }</LAST_CRLIM_AMOUNT>
			            		)else()
			            }
			            	<LATE_FEE_INFORMATION>
				            	<LATE_FEE_TYPE>30</LATE_FEE_TYPE>
				            	{
				            		for $lateFeeCounter in string($accountInquiryL8VLResponse/AZXAIO-PMT-30DAYS-CTR/text())
				            		return
				            			if( fn-bea:trim($lateFeeCounter) != '')then(
				            				<LATE_FEE_COUNTER>{ $lateFeeCounter }</LATE_FEE_COUNTER>
				            			)else()
				            	}
				            	{
				            		for $lateFeeAmount in string($accountInquiryL8VLResponse/AZXAIO-PMT-30DAYS/text())
				            		return
				            			if( fn-bea:trim($lateFeeAmount) != '')then(
				            				<LATE_FEE_AMOUNT>{ $lateFeeAmount }</LATE_FEE_AMOUNT>
				            			)else()
				            	}
				         	</LATE_FEE_INFORMATION>
				         	<LATE_FEE_INFORMATION>
				            	<LATE_FEE_TYPE>60</LATE_FEE_TYPE>
				            	{
				            		for $lateFeeCounter in string($accountInquiryL8VLResponse/AZXAIO-PMT-60DAYS-CTR/text())
				            		return
				            			if( fn-bea:trim($lateFeeCounter) != '')then(
				            				<LATE_FEE_COUNTER>{ $lateFeeCounter }</LATE_FEE_COUNTER>
				            			)else()
				            	}
				            	{
				            		for $lateFeeAmount in string($accountInquiryL8VLResponse/AZXAIO-PMT-60DAYS/text())
				            		return
				            			if( fn-bea:trim($lateFeeAmount) != '')then(
				            				<LATE_FEE_AMOUNT>{ $lateFeeAmount }</LATE_FEE_AMOUNT>
				            			)else()
				            	}
				         	</LATE_FEE_INFORMATION>
				         	<LATE_FEE_INFORMATION>
				            	<LATE_FEE_TYPE>90</LATE_FEE_TYPE>
				            	{
				            		for $lateFeeCounter in string($accountInquiryL8VLResponse/AZXAIO-PMT-90DAYS-CTR/text())
				            		return
				            			if( fn-bea:trim($lateFeeCounter) != '')then(
				            				<LATE_FEE_COUNTER>{ $lateFeeCounter }</LATE_FEE_COUNTER>
				            			)else()
				            	}
				            	{
				            		for $lateFeeAmount in string($accountInquiryL8VLResponse/AZXAIO-PMT-90DAYS/text())
				            		return
				            			if( fn-bea:trim($lateFeeAmount) != '')then(
				            				<LATE_FEE_AMOUNT>{ $lateFeeAmount }</LATE_FEE_AMOUNT>
				            			)else()
				            	}
				         	</LATE_FEE_INFORMATION>
				         	<LATE_FEE_INFORMATION>
				            	<LATE_FEE_TYPE>120</LATE_FEE_TYPE>
				            	{
				            		for $lateFeeCounter in string($accountInquiryL8VLResponse/AZXAIO-PMT-120-DAYS-CTR/text())
				            		return
				            			if( fn-bea:trim($lateFeeCounter) != '')then(
				            				<LATE_FEE_COUNTER>{ $lateFeeCounter }</LATE_FEE_COUNTER>
				            			)else()
				            	}
				            	{
				            		for $lateFeeAmount in string($accountInquiryL8VLResponse/AZXAIO-PMT-120DAYS/text())
				            		return
				            			if( fn-bea:trim($lateFeeAmount) != '')then(
				            				<LATE_FEE_AMOUNT>{ $lateFeeAmount }</LATE_FEE_AMOUNT>
				            			)else()
				            	}
				         	</LATE_FEE_INFORMATION>
				         	<LATE_FEE_INFORMATION>
				            	<LATE_FEE_TYPE>150</LATE_FEE_TYPE>
				            	{
				            		for $lateFeeCounter in string($accountInquiryL8VLResponse/AZXAIO-PMT-150-DAYS-CTR/text())
				            		return
				            			if( fn-bea:trim($lateFeeCounter) != '')then(
				            				<LATE_FEE_COUNTER>{ $lateFeeCounter }</LATE_FEE_COUNTER>
				            			)else()
				            	}
				            	{
				            		for $lateFeeAmount in string($accountInquiryL8VLResponse/AZXAIO-PMT-150DAYS/text())
				            		return
				            			if( fn-bea:trim($lateFeeAmount) != '')then(
				            				<LATE_FEE_AMOUNT>{ $lateFeeAmount }</LATE_FEE_AMOUNT>
				            			)else()
				            	}
				         	</LATE_FEE_INFORMATION>
				         	<LATE_FEE_INFORMATION>
				            	<LATE_FEE_TYPE>180</LATE_FEE_TYPE>
				            	{
				            		for $lateFeeCounter in string($accountInquiryL8VLResponse/AZXAIO-PMT-180-DAYS-CTR/text())
				            		return
				            			if( fn-bea:trim($lateFeeCounter) != '')then(
				            				<LATE_FEE_COUNTER>{ $lateFeeCounter }</LATE_FEE_COUNTER>
				            			)else()
				            	}
				            	{
				            		for $lateFeeAmount in string($accountInquiryL8VLResponse/AZXAIO-PMT-180DAYS/text())
				            		return
				            			if( fn-bea:trim($lateFeeAmount) != '')then(
				            				<LATE_FEE_AMOUNT>{ $lateFeeAmount }</LATE_FEE_AMOUNT>
				            			)else()
				            	}
				         	</LATE_FEE_INFORMATION>
				         	<LATE_FEE_INFORMATION>
				            	<LATE_FEE_TYPE>210</LATE_FEE_TYPE>
				            	{
				            		for $lateFeeCounter in string($accountInquiryL8VLResponse/AZXAIO-PMT-210-DAYS-CTR/text())
				            		return
				            			if( fn-bea:trim($lateFeeCounter) != '')then(
				            				<LATE_FEE_COUNTER>{ $lateFeeCounter }</LATE_FEE_COUNTER>
				            			)else()
				            	}
				            	{
				            		for $lateFeeAmount in string($accountInquiryL8VLResponse/AZXAIO-PMT-210DAYS/text())
				            		return
				            			if( fn-bea:trim($lateFeeAmount) != '')then(
				            				<LATE_FEE_AMOUNT>{ $lateFeeAmount }</LATE_FEE_AMOUNT>
				            			)else()
				            	}
				         	</LATE_FEE_INFORMATION>
				         	{
				         		for $status in string($accountInquiryL8VLResponse/AZXAIO-INT-STATUS/text())
				         		return
	        	        		<STATUS>{ $status }</STATUS>
	        	        		
	        	        	}
	        	        	{
	        	        	(:for $lastPaymentAmount in string($balanceInquiryVAResponse/ARXBIO-LAST-PMT-AMOUNT/text()):)
				         	for $lastPaymentAmount in string($accountInquiryL8VLResponse/AZXAIO-PMT-LAST-AMT/text())
				         		return
	        	        		<LAST_PAYMENT_AMOUNT>{ $lastPaymentAmount }</LAST_PAYMENT_AMOUNT>
	        	        	}
	        	        	{
	        	        	(:for $lastPaymentDate in $balanceInquiryVAResponse/ARXBIO-DATE-LAST-PMT:) 
				         	for $lastPaymentDate in $accountInquiryL8VLResponse/AZXAIO-DATE-LAST-PMT
				         		return
				         		if(not(fn-bea:trim(string($lastPaymentDate/text())) = ("", "00000000")))then(
	        	        			<LAST_PAYMENT_DATE>{ replace(string($lastPaymentDate/text()), '-', '') }</LAST_PAYMENT_DATE>
	        	        		)else()
	        	        	}
                            {
                            for $amountLastWithdrawal in string($accountInquiryL8VLResponse/AZXAIO-LAST-CASH-ADV-AMOUNT/text())
                                return
                                <AMOUNT_LAST_WITHDRAWAL>{ $amountLastWithdrawal } </AMOUNT_LAST_WITHDRAWAL>
		        	        }
                            {
                            for $dateLastWithdrawal in $accountInquiryL8VLResponse/AZXAIO-LAST-CASH-ADV-DATE
                                return
                                if(fn-bea:trim(string($dateLastWithdrawal/text())) != "")then(
                                    <DATE_LAST_WITHDRAWAL>{ data($dateLastWithdrawal) } </DATE_LAST_WITHDRAWAL>
                                )else()  
		        	        }
                            {
                            for $lastPurchaseAmount in string($accountInquiryL8VLResponse/AZXAIO-AMT-LAST-PURCH/text())
                                return
                                <LAST_PURCHASE_AMOUNT>{ $lastPurchaseAmount } </LAST_PURCHASE_AMOUNT>
		        	        }
                            {
                            for $lastPurchaceDate in string($accountInquiryL8VLResponse/AZXAIO-DATE-LAST-PURCH/text())
                                return
                                <LAST_PURCHASE_DATE>{ $lastPurchaceDate } </LAST_PURCHASE_DATE>
                            }    
			         </BALANCE_INFORMATION>
        	 }
             {
        	 	for $accountInquiryL8VLResponse in $resultGroup/ACCOUNT_INQUIRY_RESPONSES/ns4:AccountInquiryL8VLResponse[1]
				return(
		            for $changeProductDate in $accountInquiryL8VLResponse/AZXAIO-DATE-XFR-EFF
					return
					if(fn-bea:trim(string($changeProductDate/text())) != "")then(
	               		<CHANGE_PRODUCT_DATE>{ data($changeProductDate) }</CHANGE_PRODUCT_DATE>
	               		)else(),
						
					for $newLogo in data($accountInquiryL8VLResponse/AZXAIO-XFR-LOGO)
					return
	        	        <NEW_LOGO>{ $newLogo }</NEW_LOGO>,
	        	        	
					for $newAccountNumber in data($accountInquiryL8VLResponse/AZXAIO-XFR-ACCT)
					return
	        	        <NEW_ACCOUNT_NUMBER>{ $newAccountNumber }</NEW_ACCOUNT_NUMBER>,
						
        			for $lastDateLimitChange in data($accountInquiryL8VLResponse/AZXAIO-DATE-CRLIM)
					return
	                	<LAST_DATE_LIMIT_CHANGE>{ $lastDateLimitChange }</LAST_DATE_LIMIT_CHANGE>,
						
					for $cashBackEarned in string($accountInquiryL8VLResponse/AZXAIO-USER-CODE-7/text())
					return
	        	        <CASH_BACK_EARNED>{ $cashBackEarned }</CASH_BACK_EARNED>,
				 	for $dateBenefitChange in data ($accountInquiryL8VLResponse/AZXAIO-USER-DATE-7)
			 		return
            			<DATE_BENEFIT_CHANGE>{ $dateBenefitChange }</DATE_BENEFIT_CHANGE>                         
				)
		     }
        </ns0:sjconsultaCuentaTCResponse>
};

declare variable $resultGroup as element(*) external;
declare variable $sjconsultaCuentaTC as element(ns0:sjconsultaCuentaTC) external;

xf:sjConsultaCuentaTCHNOut($resultGroup, $sjconsultaCuentaTC)
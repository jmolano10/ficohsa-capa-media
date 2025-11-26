(:: pragma  parameter="$resultGroup" type="anyType" ::)
(:: pragma bea:global-element-parameter parameter="$outputParameters1" element="ns1:OutputParameters" location="../../../../v2/BusinessServices/MasterDataHN/conDatoTarjeta/xsd/conDatoTarjeta_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultaDatosTarjetaCreditoResponse" location="../xsd/consultaDatosTarjetaCreditoTypes.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns5:OutputParameters" location="../../../BusinessServices/consultaDatosTC/xsd/consultaDatosTC_sp.xsd" ::)

declare namespace ns2 = "http://www.procesa.com/fdcs";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/conDatoTarjeta";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaDatosTarjetaCreditoTypes";
declare namespace xf = "http://tempuri.org/Middleware/v3/Resources/ConsultaDatosTarjetaCredito/xq/consultaDatosTarjetaCreditoHNOut/";
declare namespace ns5 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaDatosTC";

declare function xf:consultaDatosTarjetaCreditoHNOut($resultGroup as element(*)?,
    $outputParameters1 as element(ns1:OutputParameters)?,
    $outputParameters as element(ns5:OutputParameters)?)	
    as element(ns0:consultaDatosTarjetaCreditoResponse) {
    
        <ns0:consultaDatosTarjetaCreditoResponse>
        {
        	if(not(empty($outputParameters/ns5:PT_DATOS_TARJETA/ns5:PT_DATOS_TARJETA_ITEM))) then (
        		for $CARD_NUMBER in $outputParameters/ns5:PT_DATOS_TARJETA/ns5:PT_DATOS_TARJETA_ITEM[1]/ns5:CARD_NUMBER
                return
                <CARD_NUMBER>{ data($CARD_NUMBER) }</CARD_NUMBER>,

                for $DUAL_INDICATOR in $outputParameters/ns5:PT_DATOS_TARJETA/ns5:PT_DATOS_TARJETA_ITEM[1]/ns5:DUAL_INDICATOR
                return
                    <DUAL_INDICATOR>{ data($DUAL_INDICATOR) }</DUAL_INDICATOR>,

                for $ACCOUNT_NUMBER in $outputParameters/ns5:PT_DATOS_TARJETA/ns5:PT_DATOS_TARJETA_ITEM[1]/ns5:ACCOUNT_NUMBER
                return
                    <ACCOUNT_NUMBER>{ data($ACCOUNT_NUMBER) }</ACCOUNT_NUMBER>,

                for $CARD_HOLDER_NAME in $outputParameters/ns5:PT_DATOS_TARJETA/ns5:PT_DATOS_TARJETA_ITEM[1]/ns5:CARD_HOLDER_NAME
                return
                    <CARD_HOLDER_NAME>{ data($CARD_HOLDER_NAME) }</CARD_HOLDER_NAME>,

                for $ACCOUNT_HOLDER_NAME in $outputParameters/ns5:PT_DATOS_TARJETA/ns5:PT_DATOS_TARJETA_ITEM[1]/ns5:ACCOUNT_HOLDER_NAME
                return
                    <ACCOUNT_HOLDER_NAME>{ data($ACCOUNT_HOLDER_NAME) }</ACCOUNT_HOLDER_NAME>,

                for $CARD_HOLDER_LEGAL_ID in $outputParameters/ns5:PT_DATOS_TARJETA/ns5:PT_DATOS_TARJETA_ITEM[1]/ns5:CARD_HOLDER_LEGAL_ID
                return
                    <CARD_HOLDER_LEGAL_ID>{ data($CARD_HOLDER_LEGAL_ID) }</CARD_HOLDER_LEGAL_ID>,

                for $ACCOUNT_HOLDER_LEGAL_ID in $outputParameters/ns5:PT_DATOS_TARJETA/ns5:PT_DATOS_TARJETA_ITEM[1]/ns5:ACCOUNT_HOLDER_LEGAL_ID
                return
                    <ACCOUNT_HOLDER_LEGAL_ID>{ data($ACCOUNT_HOLDER_LEGAL_ID) }</ACCOUNT_HOLDER_LEGAL_ID>,

                for $CUSTOMER_ID in $outputParameters/ns5:PT_DATOS_TARJETA/ns5:PT_DATOS_TARJETA_ITEM[1]/ns5:CUSTOMER_ID
                return
                    <CUSTOMER_ID>{ data($CUSTOMER_ID) }</CUSTOMER_ID>,

                for $ACCOUNT_STATUS in $outputParameters/ns5:PT_DATOS_TARJETA/ns5:PT_DATOS_TARJETA_ITEM[1]/ns5:ACCOUNT_STATUS
                return
                    <ACCOUNT_STATUS>{ data($ACCOUNT_STATUS) }</ACCOUNT_STATUS>,

                for $CARD_TYPE in $outputParameters/ns5:PT_DATOS_TARJETA/ns5:PT_DATOS_TARJETA_ITEM[1]/ns5:CARD_TYPE
                return
                    <CARD_TYPE>{ data($CARD_TYPE) }</CARD_TYPE>,

                for $AFINITY_GROUP in $outputParameters/ns5:PT_DATOS_TARJETA/ns5:PT_DATOS_TARJETA_ITEM[1]/ns5:AFINITY_GROUP
                return
					<AFINITY_GROUP>{data($AFINITY_GROUP)}</AFINITY_GROUP>,
                for $PT_DATOS_TARJETA_ITEM in $outputParameters/ns5:PT_DATOS_TARJETA/ns5:PT_DATOS_TARJETA_ITEM
                return(
                    <CARD_CURRENCY_INFORMATION>
                        <ORG_IND>{ data($PT_DATOS_TARJETA_ITEM/ns5:ORG_IND) }</ORG_IND>
                        <ORG>{ data($PT_DATOS_TARJETA_ITEM/ns5:ORG) }</ORG>
                        <CURRENCY>{ data($PT_DATOS_TARJETA_ITEM/ns5:CURRENCY) }</CURRENCY>
                        <ANUAL_PURCHASE_LIMIT>{ data($PT_DATOS_TARJETA_ITEM/ns5:ANUAL_PURCHASE_LIMIT) }</ANUAL_PURCHASE_LIMIT>
                        <ANUAL_WITHDRAWAL_LIMIT>{ data($PT_DATOS_TARJETA_ITEM/ns5:ANUAL_WITHDRAWAL_LIMIT) }</ANUAL_WITHDRAWAL_LIMIT>
                     	<MONTHLY_PURCHASE_LIMIT>{ data($PT_DATOS_TARJETA_ITEM/ns5:MONTHLY_PURCHASE_LIMIT) }</MONTHLY_PURCHASE_LIMIT>
                        <MONTHLY_WITHDRAWAL_LIMIT>{ data($PT_DATOS_TARJETA_ITEM/ns5:MONTHLY_WITHDRAWAL_LIMIT) }</MONTHLY_WITHDRAWAL_LIMIT>
                        <DAILY_PURCHASE_LIMIT>{ data($PT_DATOS_TARJETA_ITEM/ns5:DAILY_PURCHASE_LIMIT) }</DAILY_PURCHASE_LIMIT>
                        <DAILY_WITHDRAWAL_LIMIT>{ data($PT_DATOS_TARJETA_ITEM/ns5:DAILY_WITHDRAWAL_LIMIT) }</DAILY_WITHDRAWAL_LIMIT>
                       	{
	                       	 if(data($PT_DATOS_TARJETA_ITEM/ns5:CARD_ACTIVATION_DATE/text()) != '')then(
	            				<CARD_ACTIVATION_DATE>{  fn-bea:dateTime-to-string-with-format("yyyy-MM-dd", data($PT_DATOS_TARJETA_ITEM/ns5:CARD_ACTIVATION_DATE)) }</CARD_ACTIVATION_DATE>
	          				 )else()
          				}
                        <CARD_STATUS>{ data($PT_DATOS_TARJETA_ITEM/ns5:CARD_STATUS) }</CARD_STATUS>
                       	 <CARD_EXPIRATION_DATE>{  data($PT_DATOS_TARJETA_ITEM/ns5:CARD_EXPIRATION_DATE) }</CARD_EXPIRATION_DATE>
                        <EMBOSSED_NUMBER>{ data($PT_DATOS_TARJETA_ITEM/ns5:EMBOSSED_NUMBER) }</EMBOSSED_NUMBER>
                        <BLOCK_CODE>{ data($PT_DATOS_TARJETA_ITEM/ns5:BLOCK_CODE) }</BLOCK_CODE>
                        <BLOCK_REASON>{ data($PT_DATOS_TARJETA_ITEM/ns5:BLOCK_REASON) }</BLOCK_REASON>
                        <BLOCK_DATE>{ data($PT_DATOS_TARJETA_ITEM/ns5:BLOCK_DATE) }</BLOCK_DATE>
                        <PRODUCT>{ data($PT_DATOS_TARJETA_ITEM/ns5:PRODUCT) }</PRODUCT>
                   		<PIN_INDICATOR>{ data($PT_DATOS_TARJETA_ITEM/ns5:PIN_INDICATOR) }</PIN_INDICATOR>
                   		<CURRENT_PLASTIC_ACTION>{ data($PT_DATOS_TARJETA_ITEM/ns5:CURRENT_PLASTIC_ACTION) }</CURRENT_PLASTIC_ACTION>
                   		<LAST_ACTION_PLASTIC>{ data($PT_DATOS_TARJETA_ITEM/ns5:LAST_ACTION_PLASTIC) }</LAST_ACTION_PLASTIC>
                   		<DATE_LAST_ISSUANCE_PLASTIC>{ data($PT_DATOS_TARJETA_ITEM/ns5:DATE_LAST_ISSUANCE_PLASTIC) }</DATE_LAST_ISSUANCE_PLASTIC>
                   		<PRIVILEGE_CODE>{ data($PT_DATOS_TARJETA_ITEM/ns5:PRIVILEGE_CODE) }</PRIVILEGE_CODE>
                   		<PRIORITY_PASS>{ data($PT_DATOS_TARJETA_ITEM/ns5:PRIORITY_PASS) }</PRIORITY_PASS>
                   		<LIMIT_INDICATOR_EXPENSES>{ data($PT_DATOS_TARJETA_ITEM/ns5:LIMIT_INDICATOR_EXPENSES) }</LIMIT_INDICATOR_EXPENSES>
                   		<PERCENTAGE_LIMIT_DAILY_PURCHASE>{ data($PT_DATOS_TARJETA_ITEM/ns5:PERCENTAGE_LIMIT_DAILY_PURCHASE) }</PERCENTAGE_LIMIT_DAILY_PURCHASE>
                   		<PERCENTAGE_MONTHLY_PURCHASE_LIMIT>{ data($PT_DATOS_TARJETA_ITEM/ns5:PERCENTAGE_MONTHLY_PURCHASE_LIMIT) }</PERCENTAGE_MONTHLY_PURCHASE_LIMIT>
                   		<ANNUAL_PURCHASE_LIMIT_PERCENTAGE>{ data($PT_DATOS_TARJETA_ITEM/ns5:ANNUAL_PURCHASE_LIMIT_PERCENTAGE) }</ANNUAL_PURCHASE_LIMIT_PERCENTAGE>
						<DAILY_WITHDRAWAL_LIMIT_PERCENTAGE>{ data($PT_DATOS_TARJETA_ITEM/ns5:DAILY_WITHDRAWAL_LIMIT_PERCENTAGE) }</DAILY_WITHDRAWAL_LIMIT_PERCENTAGE>
						<MONTHLY_WITHDRAWAL_LIMIT_PERCENTAGE>{ data($PT_DATOS_TARJETA_ITEM/ns5:MONTHLY_WITHDRAWAL_LIMIT_PERCENTAGE) }</MONTHLY_WITHDRAWAL_LIMIT_PERCENTAGE>					            									
						<ANNUAL_RETIREMENT_LIMIT_PERCENTAGE>{ data($PT_DATOS_TARJETA_ITEM/ns5:ANNUAL_RETIREMENT_LIMIT_PERCENTAGE) }</ANNUAL_RETIREMENT_LIMIT_PERCENTAGE>
						<DAILY_WITHDRAWAL_LIMIT_PERCENTAGE>{ data($PT_DATOS_TARJETA_ITEM/ns5:PRODUCT) }</DAILY_WITHDRAWAL_LIMIT_PERCENTAGE>
						<MONTHLY_WITHDRAWAL_LIMIT_PERCENTAGE>{ data($PT_DATOS_TARJETA_ITEM/ns5:PRODUCT) }</MONTHLY_WITHDRAWAL_LIMIT_PERCENTAGE>					            									
						<ANNUAL_RETIREMENT_LIMIT_PERCENTAGE>{ data($PT_DATOS_TARJETA_ITEM/ns5:PRODUCT) }</ANNUAL_RETIREMENT_LIMIT_PERCENTAGE>
						<NUM_WITHDRAWALS_APPLIED_TODAY>{ data($PT_DATOS_TARJETA_ITEM/ns5:NUM_WITHDRAWALS_APPLIED_TODAY) }</NUM_WITHDRAWALS_APPLIED_TODAY>
						<NUM_WITHDRAWALS_APPLIED_MONTH_TO_DATE>{ data($PT_DATOS_TARJETA_ITEM/ns5:NUM_WITHDRAWALS_APPLIED_MONTH_TO_DATE) }</NUM_WITHDRAWALS_APPLIED_MONTH_TO_DATE>
						<NUM_WITHDRAWALS_APPLIED_YEAR_TO_DATE>{ data($PT_DATOS_TARJETA_ITEM/ns5:NUM_WITHDRAWALS_APPLIED_YEAR_TO_DATE) }</NUM_WITHDRAWALS_APPLIED_YEAR_TO_DATE>
						<AMOUNT_IN_WITHDRAWALS_APPLIED_TODAY>{ data($PT_DATOS_TARJETA_ITEM/ns5:AMOUNT_IN_WITHDRAWALS_APPLIED_TODAY) }</AMOUNT_IN_WITHDRAWALS_APPLIED_TODAY>
						<AMOUNT_WITHDRAWALS_APPLIED_MONTH_TO_DATE>{ data($PT_DATOS_TARJETA_ITEM/ns5:AMOUNT_WITHDRAWALS_APPLIED_MONTH_TO_DATE) }</AMOUNT_WITHDRAWALS_APPLIED_MONTH_TO_DATE>
                     	<AMOUNT_WITHDRAWALS_APPLIED_YEAR_TO_DATE>{ data($PT_DATOS_TARJETA_ITEM/ns5:AMOUNT_WITHDRAWALS_APPLIED_YEAR_TO_DATE) }</AMOUNT_WITHDRAWALS_APPLIED_YEAR_TO_DATE>
						<NUM_DECLINED_RETIREMENTS_TODAY>{ data($PT_DATOS_TARJETA_ITEM/ns5:NUM_DECLINED_RETIREMENTS_TODAY) }</NUM_DECLINED_RETIREMENTS_TODAY>
						<NUM_DECLINED_RETIREMENTS_MONTH_TO_DATE>{ data($PT_DATOS_TARJETA_ITEM/ns5:NUM_DECLINED_RETIREMENTS_MONTH_TO_DATE) }</NUM_DECLINED_RETIREMENTS_MONTH_TO_DATE>
						<NUM_DECLINED_RETIREMENTS_YEAR_TO_DATE>{ data($PT_DATOS_TARJETA_ITEM/ns5:NUM_DECLINED_RETIREMENTS_YEAR_TO_DATE) }</NUM_DECLINED_RETIREMENTS_YEAR_TO_DATE>
						<AMOUNT_DECLINED_RETIREMENTS_TODAY>{ data($PT_DATOS_TARJETA_ITEM/ns5:AMOUNT_DECLINED_RETIREMENTS_TODAY) }</AMOUNT_DECLINED_RETIREMENTS_TODAY>
						<AMOUNT_DECLINED_WITHDRAWALS_MONTH_TO_DATE>{ data($PT_DATOS_TARJETA_ITEM/ns5:AMOUNT_DECLINED_WITHDRAWALS_MONTH_TO_DATE) }</AMOUNT_DECLINED_WITHDRAWALS_MONTH_TO_DATE>
						<AMOUNT_DECLINED_RETIREMENTS_YEAR_TO_DATE>{ data($PT_DATOS_TARJETA_ITEM/ns5:AMOUNT_DECLINED_RETIREMENTS_YEAR_TO_DATE) }</AMOUNT_DECLINED_RETIREMENTS_YEAR_TO_DATE>
						<NUM_PURCHASES_APPLIED_TODAY>{ data($PT_DATOS_TARJETA_ITEM/ns5:NUM_PURCHASES_APPLIED_TODAY) }</NUM_PURCHASES_APPLIED_TODAY>
						<NUM_PURCHASES_APPLIED_MONTH_TO_DATE>{ data($PT_DATOS_TARJETA_ITEM/ns5:NUM_PURCHASES_APPLIED_MONTH_TO_DATE) }</NUM_PURCHASES_APPLIED_MONTH_TO_DATE>
						<NUM_PURCHASES_APPLIED_YEAR_TO_DATE>{ data($PT_DATOS_TARJETA_ITEM/ns5:NUM_PURCHASES_APPLIED_YEAR_TO_DATE) }</NUM_PURCHASES_APPLIED_YEAR_TO_DATE>
						<AMOUNT_APPLIED_PURCHASES_TODAY>{ data($PT_DATOS_TARJETA_ITEM/ns5:AMOUNT_APPLIED_PURCHASES_TODAY) }</AMOUNT_APPLIED_PURCHASES_TODAY>
						<AMOUNT_APPLIED_PURCHASES_MONTH_TO_DATE>{ data($PT_DATOS_TARJETA_ITEM/ns5:AMOUNT_APPLIED_PURCHASES_MONTH_TO_DATE) }</AMOUNT_APPLIED_PURCHASES_MONTH_TO_DATE>
						<AMOUNT_APPLIED_PURCHASES_YEAR_TO_DATE>{ data($PT_DATOS_TARJETA_ITEM/ns5:AMOUNT_APPLIED_PURCHASES_YEAR_TO_DATE) }</AMOUNT_APPLIED_PURCHASES_YEAR_TO_DATE>
						<NUM_PURCHASES_DECLINED_TODAY>{ data($PT_DATOS_TARJETA_ITEM/ns5:NUM_PURCHASES_DECLINED_TODAY) }</NUM_PURCHASES_DECLINED_TODAY>
                     	<NUM_PURCHASES_DECLINED_MONTH_TO_DATE>{ data($PT_DATOS_TARJETA_ITEM/ns5:NUM_PURCHASES_DECLINED_MONTH_TO_DATE) }</NUM_PURCHASES_DECLINED_MONTH_TO_DATE>
						<NUM_PURCHASES_DECLINED_YEAR_TO_DATE>{ data($PT_DATOS_TARJETA_ITEM/ns5:NUM_PURCHASES_DECLINED_YEAR_TO_DATEDUCT) }</NUM_PURCHASES_DECLINED_YEAR_TO_DATE>
						<AMOUNT_PURCHASES_DECLINED_TODAY>{ data($PT_DATOS_TARJETA_ITEM/ns5:AMOUNT_PURCHASES_DECLINED_TODAY) }</AMOUNT_PURCHASES_DECLINED_TODAY>
						<AMOUNT_PURCHASES_DECLINED_MONTH_TO_DATE>{ data($PT_DATOS_TARJETA_ITEM/ns5:AMOUNT_PURCHASES_DECLINED_YEAR_TO_DATE) }</AMOUNT_PURCHASES_DECLINED_MONTH_TO_DATE>
						<AMOUNT_PURCHASES_DECLINED_YEAR_TO_DATE>{ data($PT_DATOS_TARJETA_ITEM/ns5:AMOUNT_PURCHASES_DECLINED_YEAR_TO_DATE) }</AMOUNT_PURCHASES_DECLINED_YEAR_TO_DATE>
                   </CARD_CURRENCY_INFORMATION>
                  )
        		
        	)else(
		        let $embosserInquiryL8V6 := $resultGroup/EMBOSSER_INQUIRY_RESPONSES/ns2:EmbosserInquiryL8V6Response[1]
			    let $datoTarjeta := $outputParameters1/ns1:RowSet/ns1:Row[1]
			    return(
					for $cardNumber in $datoTarjeta/ns1:Column[@name='numtarjeta']/text()
					return
		        		<CARD_NUMBER>{ data($cardNumber) }</CARD_NUMBER>,
					for $dualIndicator in $embosserInquiryL8V6/AZXCIO-DUAL-IND
					return
		        		<DUAL_INDICATOR>{ data($dualIndicator) }</DUAL_INDICATOR>,
		    		for $numCuenta in $datoTarjeta/ns1:Column[@name='numcuenta']/text()
		    		return
		    			<ACCOUNT_NUMBER>{ data($numCuenta) }</ACCOUNT_NUMBER>,
		    		for $cardHolderName in $embosserInquiryL8V6/AZXCIO-EMBOSSED-NAME-1
		    		return
		    			<CARD_HOLDER_NAME>{ data($cardHolderName) }</CARD_HOLDER_NAME>,
		    		for $accountHolder  in $datoTarjeta/ns1:Column[@name='account_name']/text()
		    		return
		    			<ACCOUNT_HOLDER_NAME>{ data($accountHolder) }</ACCOUNT_HOLDER_NAME>,
		    		for $CardHolderlegalID in $datoTarjeta/ns1:Column[@name='card_holder_id']/text()
		    		return
		    			<CARD_HOLDER_LEGAL_ID>{ data($CardHolderlegalID) }</CARD_HOLDER_LEGAL_ID>,
		    		for $AccountHolderLegalId in $datoTarjeta/ns1:Column[@name='account_holder_legal_id']/text()
		    		return
		            	<ACCOUNT_HOLDER_LEGAL_ID>{ data($AccountHolderLegalId) }</ACCOUNT_HOLDER_LEGAL_ID>,
		    		for $customerID in $datoTarjeta/ns1:Column[@name='customer_id']/text()
		    		return
		            	<CUSTOMER_ID>{ data($customerID) }</CUSTOMER_ID>,
		    		for $accountStatus in $datoTarjeta/ns1:Column[@name='estatus']/text()
		    		return
		            	<ACCOUNT_STATUS>{ data($accountStatus) }</ACCOUNT_STATUS>,
		    		for $cardType in $embosserInquiryL8V6/AZXCIO-CARDHOLDER-TYPE
		    		return
		            	<CARD_TYPE>{ data($cardType) }</CARD_TYPE>,
		        	<AFINITY_GROUP>{ data($datoTarjeta/ns1:Column[@name='logo']/text()) }</AFINITY_GROUP>,
		    		for $orgItem in $outputParameters1/ns1:RowSet/ns1:Row
					let $org := data($orgItem/ns1:Column[@name = 'org'])
					let $embosserInquiryL8V6 := $resultGroup/EMBOSSER_INQUIRY_RESPONSES/ns2:EmbosserInquiryL8V6Response[AZXCIO-ORG = $org]
					return(
			            <CARD_CURRENCY_INFORMATION>
							{
					    		for $orgInd in $orgItem/ns1:Column[@name='TipoOrg']
					    		return
					    			<ORG_IND>{ data($orgInd) }</ORG_IND>
					    	} 	
					    	{
								if(string($org) != '') then (
									<ORG>{ $org }</ORG>
								) else()
							}
							{
					    		for $currency in $orgItem/ns1:Column[@name='CodMoneda']/text()
					    		return
					            	<CURRENCY>{ data($currency) }</CURRENCY>
					    	} 
							{
					    		for $anualPurchaseLimit in $embosserInquiryL8V6/AZXCIO-RETAIL-AMOUNT-YTD
					    		return
					            	<ANUAL_PURCHASE_LIMIT>{ data($anualPurchaseLimit) }</ANUAL_PURCHASE_LIMIT>
					    	} 
					    	{
					    		for $anualWithdrawalLimit in $embosserInquiryL8V6/AZXCIO-CASH-AMOUNT-YTD
					    		return
						    		<ANUAL_WITHDRAWAL_LIMIT>{ data($anualWithdrawalLimit) }</ANUAL_WITHDRAWAL_LIMIT>
					    	} 
					    	{
					    		for $montlyPurchaseLimit in  $embosserInquiryL8V6/AZXCIO-RETAIL-AMOUNT-MTD
					    		return
					            	<MONTHLY_PURCHASE_LIMIT>{ data($montlyPurchaseLimit) }</MONTHLY_PURCHASE_LIMIT>
					    	} 
					    	{
					    		for $monthlyWithdrawalLimit in $embosserInquiryL8V6/AZXCIO-CASH-AMOUNT-MTD
					    		return
					                <MONTHLY_WITHDRAWAL_LIMIT>{ data($monthlyWithdrawalLimit) }</MONTHLY_WITHDRAWAL_LIMIT>
					    	} 
					    	{
					    		for $dailyPurchaseLimit in $embosserInquiryL8V6/AZXCIO-RETAIL-AMOUNT-DAILY/text()
					    		return
								if(fn-bea:trim($dailyPurchaseLimit) != "") then (
					                <DAILY_PURCHASE_LIMIT>{ data($dailyPurchaseLimit) }</DAILY_PURCHASE_LIMIT>
								)else()
					    	}
					    	{
					    		for $dailyWithdrawalLimit in $embosserInquiryL8V6/AZXCIO-CASH-AMOUNT-DAILY/text()
					    		return
								if(fn-bea:trim($dailyWithdrawalLimit) != "") then (
					            	<DAILY_WITHDRAWAL_LIMIT>{ data($dailyWithdrawalLimit) }</DAILY_WITHDRAWAL_LIMIT>
								)else()
					    	}  
					    	{
					    		for $cardActivationDate in $embosserInquiryL8V6/AZXCIO-CARD-ACTIVATED-DATE
					    		return
					            	<CARD_ACTIVATION_DATE>{ data($cardActivationDate) }</CARD_ACTIVATION_DATE>
					    	}
					        {
					    		for $cardStatus in $embosserInquiryL8V6/AZXCIO-CURR-CRD-ACT 
					    		return
					            	<CARD_STATUS>{ data($cardStatus) }</CARD_STATUS>
					    	}    
					    	{
					    		for $cardExpirationDate in $embosserInquiryL8V6/AZXCIO-DATE-EXPIRE
					    		return
					            	<CARD_EXPIRATION_DATE>{ data($cardExpirationDate) }</CARD_EXPIRATION_DATE>
					    	}   
					    	{
					    		for $embossedNumber in $embosserInquiryL8V6/AZXCIO-EMB-REPL
					    		return
					            	<EMBOSSED_NUMBER>{ data($embossedNumber) }</EMBOSSED_NUMBER>
					    	}   
					    	{
					    		for $blockCode in $embosserInquiryL8V6/AZXCIO-BLK-CODE
					    		return
									<BLOCK_CODE>{ data($blockCode) }</BLOCK_CODE>
					    	}   
					    	{
					    		for $blockReason in $embosserInquiryL8V6/AZXCIO-USER-4
					    		return
					            	<BLOCK_REASON>{ data($blockReason) }</BLOCK_REASON>
					    	}    
					    	{
					    		for $blockDate in $embosserInquiryL8V6/AZXCIO-DATE-BLOCK
					    		return
					                <BLOCK_DATE>{ data($blockDate) }</BLOCK_DATE>
					    	}   
					    	<PRODUCT>TCR</PRODUCT>
					    	{
					    		for $pinIndicator in $embosserInquiryL8V6/AZXCIO-PIN-SUPPRESSION
					    		return
					            	<PIN_INDICATOR>{ data($pinIndicator) }</PIN_INDICATOR>
					    	}     
					    	{
					    		for $currentPlasticActiion in $embosserInquiryL8V6/AZXCIO-CARD-ACTION
					    		return
					                <CURRENT_PLASTIC_ACTION>{ data($currentPlasticActiion) }</CURRENT_PLASTIC_ACTION>
					    	}         
					    	{
					    		for $lastActionPlastic in $embosserInquiryL8V6/AZXCIO-LAST-CARD-ACTION
					    		return
					                <LAST_ACTION_PLASTIC>{ data($lastActionPlastic) }</LAST_ACTION_PLASTIC>
					    	}    
					    	{
					    		for $dateLastIssuancePlastic in $embosserInquiryL8V6/AZXCIO-DATE-LST-PLASTICISSUE
					    		return
					            	<DATE_LAST_ISSUANCE_PLASTIC>{ data($dateLastIssuancePlastic) }</DATE_LAST_ISSUANCE_PLASTIC>
					    	}      
					    	{
					    		for $privilegeCode in $embosserInquiryL8V6/AZXCIO-EMBOSSED-NAME-2
					    		return
					            	<PRIVILEGE_CODE>{ data($privilegeCode) }</PRIVILEGE_CODE>
					    	}  
					    	{
					    		for $priorityPass in $embosserInquiryL8V6/AZXCIO-USER-1
					    		return
					            	<PRIORITY_PASS>{ data($priorityPass) }</PRIORITY_PASS>
					    	}			    	
					    	{
					    		for $limitIndicatorExpenses in $embosserInquiryL8V6/AZXCIO-SPEND-LIMITS-STATUS
					    		return
					            	<LIMIT_INDICATOR_EXPENSES>{ data($limitIndicatorExpenses) }</LIMIT_INDICATOR_EXPENSES>
					    	}
							{
					    		for $percentageLimitDailyPurchase in $embosserInquiryL8V6/AZXCIO-RETAIL-PERCENT-DAILY
					    		return
					            	<PERCENTAGE_LIMIT_DAILY_PURCHASE>{ data($percentageLimitDailyPurchase) }</PERCENTAGE_LIMIT_DAILY_PURCHASE>
					    	}  
							{
					    		for $percentageMonthlyPurchaseLimit in $embosserInquiryL8V6/AZXCIO-RETAIL-PERCENT-MTD
								return
									if($percentageMonthlyPurchaseLimit = 0)then(
										<PERCENTAGE_MONTHLY_PURCHASE_LIMIT>{0}</PERCENTAGE_MONTHLY_PURCHASE_LIMIT>)
									else if(fn:string-length($percentageMonthlyPurchaseLimit) = 6)then(
										<PERCENTAGE_MONTHLY_PURCHASE_LIMIT>{ fn:substring(data($percentageMonthlyPurchaseLimit), 1, 1) }</PERCENTAGE_MONTHLY_PURCHASE_LIMIT>																	
									)else(
										<PERCENTAGE_MONTHLY_PURCHASE_LIMIT>{ fn:substring(data($percentageMonthlyPurchaseLimit), 1, 2) }</PERCENTAGE_MONTHLY_PURCHASE_LIMIT>											
									)	
					    	}  
							{
					    		for $anualPurchaseLimitPercentage in $embosserInquiryL8V6/AZXCIO-RETAIL-PERCENT-YTD
					    		return
					            	<ANNUAL_PURCHASE_LIMIT_PERCENTAGE>{ data($anualPurchaseLimitPercentage) }</ANNUAL_PURCHASE_LIMIT_PERCENTAGE>
					    	}  
							{
					    		for $dailyWithdrawalLimitPercentage in $embosserInquiryL8V6/AZXCIO-CASH-PERCENT-DAILY
					    		return
					             	<DAILY_WITHDRAWAL_LIMIT_PERCENTAGE>{ data($dailyWithdrawalLimitPercentage) }</DAILY_WITHDRAWAL_LIMIT_PERCENTAGE>
					    	}  
							{
					    		for $monthlyWithdrawalLimitPercentage in $embosserInquiryL8V6/AZXCIO-CASH-PERCENT-MTD
					    		return
									if($monthlyWithdrawalLimitPercentage = 0)then(
										<MONTHLY_WITHDRAWAL_LIMIT_PERCENTAGE>{0}</MONTHLY_WITHDRAWAL_LIMIT_PERCENTAGE>
									)else if(fn:string-length($monthlyWithdrawalLimitPercentage) = 6)then(
										<MONTHLY_WITHDRAWAL_LIMIT_PERCENTAGE>{ fn:substring(data($monthlyWithdrawalLimitPercentage), 1, 1) }</MONTHLY_WITHDRAWAL_LIMIT_PERCENTAGE>																	
									)else(
				            			<MONTHLY_WITHDRAWAL_LIMIT_PERCENTAGE>{ fn:substring(data($monthlyWithdrawalLimitPercentage), 1, 2) }</MONTHLY_WITHDRAWAL_LIMIT_PERCENTAGE>					            								
									)	
					    	}  
							{
					    		for $anualRetirementLimitPercentage in $embosserInquiryL8V6/AZXCIO-CASH-PERCENT-YTD
					    		return
					                <ANNUAL_RETIREMENT_LIMIT_PERCENTAGE>{ data($anualRetirementLimitPercentage) }</ANNUAL_RETIREMENT_LIMIT_PERCENTAGE>
					    	}  
							{
					    		for $numWithdrawalsAppliedToday in $embosserInquiryL8V6/AZXCIO-CASH-POSTED-TODAY-NBR
					    		return
					            	<NUM_WITHDRAWALS_APPLIED_TODAY>{ data($numWithdrawalsAppliedToday) }</NUM_WITHDRAWALS_APPLIED_TODAY>
					    	} 
							{
					    		for $numWithdrawalsAppliedMonthToDate in $embosserInquiryL8V6/AZXCIO-CASH-POSTED-MTD-NBR
					    		return
					            	<NUM_WITHDRAWALS_APPLIED_MONTH_TO_DATE>{ data($numWithdrawalsAppliedMonthToDate) }</NUM_WITHDRAWALS_APPLIED_MONTH_TO_DATE>
					    	} 
							{
					    		for $numWithdrawalsAppliedYearToDate in $embosserInquiryL8V6/AZXCIO-CASH-POSTED-YTD-NBR
					    		return
					                <NUM_WITHDRAWALS_APPLIED_YEAR_TO_DATE>{ data($numWithdrawalsAppliedYearToDate) }</NUM_WITHDRAWALS_APPLIED_YEAR_TO_DATE>
					    	} 
							{
					    		for $amountInWithdrawalsAppliedToday in $embosserInquiryL8V6/AZXCIO-CASH-POSTED-TODAY-AMT
					    		return
					                <AMOUNT_IN_WITHDRAWALS_APPLIED_TODAY>{ data($amountInWithdrawalsAppliedToday) }</AMOUNT_IN_WITHDRAWALS_APPLIED_TODAY>
					    	} 
							{
					    		for $amountWhithdrawalsAppliedMonthToDate in $embosserInquiryL8V6/AZXCIO-CASH-POSTED-MTD-AMT
					    		return
					                <AMOUNT_WITHDRAWALS_APPLIED_MONTH_TO_DATE>{ data($amountWhithdrawalsAppliedMonthToDate) }</AMOUNT_WITHDRAWALS_APPLIED_MONTH_TO_DATE>
					    	} 
							{
					    		for $amountWithdrawalsAppliedYearToDate in $embosserInquiryL8V6/AZXCIO-CASH-POSTED-YTD-AMT
					    		return
					                <AMOUNT_WITHDRAWALS_APPLIED_YEAR_TO_DATE>{ data($amountWithdrawalsAppliedYearToDate) }</AMOUNT_WITHDRAWALS_APPLIED_YEAR_TO_DATE>
					    	} 
							{
					    		for $numDeclinedRetirementsToday in $embosserInquiryL8V6/AZXCIO-CASH-DECLINE-TODAY-NBR
					    		return
					                <NUM_DECLINED_RETIREMENTS_TODAY>{ data($numDeclinedRetirementsToday) }</NUM_DECLINED_RETIREMENTS_TODAY>
					    	} 
							{
					    		for $numDeclinedRetirementsMonthToDate in $embosserInquiryL8V6/AZXCIO-CASH-DECLINE-MTD-NBR
					    		return
					                <NUM_DECLINED_RETIREMENTS_MONTH_TO_DATE>{ data($numDeclinedRetirementsMonthToDate) }</NUM_DECLINED_RETIREMENTS_MONTH_TO_DATE>
					    	} 
							{
					    		for $numDeclinedRetirementsYearToDate in $embosserInquiryL8V6/AZXCIO-CASH-DECLINE-YTD-NBR
					    		return
					                <NUM_DECLINED_RETIREMENTS_YEAR_TO_DATE>{ data($numDeclinedRetirementsYearToDate) }</NUM_DECLINED_RETIREMENTS_YEAR_TO_DATE>
					    	} 
							{
					    		for $amountDeclinedRetirementsToday in $embosserInquiryL8V6/AZXCIO-CASH-DECLINE-TODAY-AMT
					    		return
					                <AMOUNT_DECLINED_RETIREMENTS_TODAY>{ data($amountDeclinedRetirementsToday) }</AMOUNT_DECLINED_RETIREMENTS_TODAY>
					    	} 
							{
					    		for $amountDeclinedWithdrawalsMonthToDate in $embosserInquiryL8V6/AZXCIO-CASH-DECLINE-MTD-AMT
					    		return
					                <AMOUNT_DECLINED_WITHDRAWALS_MONTH_TO_DATE>{ data($amountDeclinedWithdrawalsMonthToDate) }</AMOUNT_DECLINED_WITHDRAWALS_MONTH_TO_DATE>
					    	} 
							{
					    		for $amountDeclinedWithdrawalsYearToDate in $embosserInquiryL8V6/AZXCIO-CASH-DECLINE-YTD-AMT
					    		return
					                <AMOUNT_DECLINED_RETIREMENTS_YEAR_TO_DATE>{ data($amountDeclinedWithdrawalsYearToDate) }</AMOUNT_DECLINED_RETIREMENTS_YEAR_TO_DATE>
					    	} 
							{
					    		for $numPurchasesAppliedtoday in $embosserInquiryL8V6/AZXCIO-RETAIL-POSTED-TODAY-NBR
					    		return
					                <NUM_PURCHASES_APPLIED_TODAY>{ data($numPurchasesAppliedtoday) }</NUM_PURCHASES_APPLIED_TODAY>
					    	} 
							{
					    		for $numPurchasesAppliedMonthToDate in $embosserInquiryL8V6/AZXCIO-RETAIL-POSTED-MTD-NBR
					    		return
					                <NUM_PURCHASES_APPLIED_MONTH_TO_DATE>{ data($numPurchasesAppliedMonthToDate) }</NUM_PURCHASES_APPLIED_MONTH_TO_DATE>
					    	} 
							{
					    		for $numPurchasesAppliedYearToDate in $embosserInquiryL8V6/AZXCIO-RETAIL-POSTED-YTD-NBR
					    		return
					                <NUM_PURCHASES_APPLIED_YEAR_TO_DATE>{ data($numPurchasesAppliedYearToDate) }</NUM_PURCHASES_APPLIED_YEAR_TO_DATE>
					    	} 
							{
					    		for $amountPurchasesAppliedToday in $embosserInquiryL8V6/AZXCIO-RETAIL-POSTED-TODAY-AMT
					    		return
					                <AMOUNT_APPLIED_PURCHASES_TODAY>{ data($amountPurchasesAppliedToday) }</AMOUNT_APPLIED_PURCHASES_TODAY>
					    	} 
							{
					    		for $amountAppliedPurchasesMonthToDate in $embosserInquiryL8V6/AZXCIO-RETAIL-POSTED-MTD-AMT
					    		return
					                <AMOUNT_APPLIED_PURCHASES_MONTH_TO_DATE>{ data($amountAppliedPurchasesMonthToDate) }</AMOUNT_APPLIED_PURCHASES_MONTH_TO_DATE>
					    	}
							{
					    		for $amountAppliedPurchasesYearToDate in $embosserInquiryL8V6/AZXCIO-RETAIL-POSTED-YTD-AMT
					    		return
					                <AMOUNT_APPLIED_PURCHASES_YEAR_TO_DATE>{ data($amountAppliedPurchasesYearToDate) }</AMOUNT_APPLIED_PURCHASES_YEAR_TO_DATE>
					    	} 
							{
					    		for $numPurchasesDeclinedToday in $embosserInquiryL8V6/AZXCIO-RETAIL-DECLINE-TODAY-NBR
					    		return
					                <NUM_PURCHASES_DECLINED_TODAY>{ data($numPurchasesDeclinedToday) }</NUM_PURCHASES_DECLINED_TODAY>
					    	} 
							{
					    		for $numPurchasesDeclinedMonthToDate in $embosserInquiryL8V6/AZXCIO-RETAIL-DECLINE-MTD-NBR
					    		return
					                <NUM_PURCHASES_DECLINED_MONTH_TO_DATE>{ data($numPurchasesDeclinedMonthToDate) }</NUM_PURCHASES_DECLINED_MONTH_TO_DATE>
					    	} 
							{
					    		for $numPurchasesDeclinedYearToDate in $embosserInquiryL8V6/AZXCIO-RETAIL-DECLINE-YTD-NBR
					    		return
					                <NUM_PURCHASES_DECLINED_YEAR_TO_DATE>{ data($numPurchasesDeclinedYearToDate) }</NUM_PURCHASES_DECLINED_YEAR_TO_DATE>
					    	}  
							{
					    		for $amountPurchasesDeclinedToday in $embosserInquiryL8V6/AZXCIO-RETAIL-DECLINE-TODAY-AMT
					    		return
					                <AMOUNT_PURCHASES_DECLINED_TODAY>{ data($amountPurchasesDeclinedToday) }</AMOUNT_PURCHASES_DECLINED_TODAY>
					    	}  
							{
					    		for $amountPurchasesDeclinedMonthToDate in $embosserInquiryL8V6/AZXCIO-RETAIL-DECLINE-MTD-AMT
					    		return
					                <AMOUNT_PURCHASES_DECLINED_MONTH_TO_DATE>{ data($amountPurchasesDeclinedMonthToDate) }</AMOUNT_PURCHASES_DECLINED_MONTH_TO_DATE>
					    	}  
							{
					    		for $amountPurchasesDeclinedYearToDate in $embosserInquiryL8V6/AZXCIO-RETAIL-DECLINE-YTD-AMT
					    		return
					                <AMOUNT_PURCHASES_DECLINED_YEAR_TO_DATE>{ data($amountPurchasesDeclinedYearToDate) }</AMOUNT_PURCHASES_DECLINED_YEAR_TO_DATE>
					    	}
					    	{
					    		for $creditCardStatus in $orgItem/ns1:Column[@name='EstadoPlastico']/text()
					    		return
					            	<CREDIT_CARD_STATUS>{ fn:upper-case(data($creditCardStatus)) }</CREDIT_CARD_STATUS>
					    	}     
			            </CARD_CURRENCY_INFORMATION>
						)
			        )
			   )
			}
        </ns0:consultaDatosTarjetaCreditoResponse>
};

declare variable $resultGroup as element(*) external;
declare variable $outputParameters1 as element(ns1:OutputParameters) external;
declare variable $outputParameters as element(ns5:OutputParameters)? external;

xf:consultaDatosTarjetaCreditoHNOut($resultGroup,
    $outputParameters1, $outputParameters)
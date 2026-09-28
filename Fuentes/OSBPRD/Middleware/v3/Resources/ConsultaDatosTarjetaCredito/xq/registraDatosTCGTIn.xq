(:: pragma  parameter="$resultGroup" type="anyType" ::)
(:: pragma bea:local-element-parameter parameter="$ptEquivalencias" type="ns2:OutputParameters/ns2:PT_EQUIVALENCIAS" location="../../../../v2/BusinessServices/MDW/consultaEquivalenciasCatalogos/xsd/consultaEquivalenciasCatalogos_sp.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$datosCuenta" element="ns3:OutputParameters" location="../../../../v2/BusinessServices/MasterData/conDatoTarjeta/xsd/conDatoTarjeta_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/registroDatosTC/xsd/registroDatosTC_sp.xsd" ::)

declare namespace ns2 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaEquivalenciasCatalogos";
declare namespace ns1 = "http://www.procesa.com/fdcs";
declare namespace ns3 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/conDatoTarjeta";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/registroDatosTC";
declare namespace xf = "http://tempuri.org/Middleware/v3/Resources/ConsultaDatosTarjetaCredito/xq/registraDatosTCGTIn/";

declare function valorCatalogoAPPToOSB($valor as xs:string,
	$aplicacion as xs:string,
	$catalogoId as xs:string,
	$equivalencias as element(*)
) as xs:string {
	let $retorno := fn:string($equivalencias/ns2:EQUIVALENCIA[ns2:CATALOGO_ID = $catalogoId and 
															  ns2:APLICACION_DESC = $aplicacion and 
															  ns2:EQUIVALENCIA_DESC = $valor]/ns2:VALOR_DESC/text())
	return
		if($retorno != "") then (
			$retorno
		) else (
			$valor
		)
};

declare function xf:registraDatosTCGTIn($resultGroup as element(*),
    $ptEquivalencias as element(),
    $datosCuenta as element(ns3:OutputParameters), 
    $countryCode as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:PT_DATOS_TARJETA>
            {
            	for $orgItem in $datosCuenta/ns3:RowSet/ns3:Row
				let $org := data($orgItem/ns3:Column[@name = 'org'])
				let $embosserInquiryL8V6 := $resultGroup/EMBOSSER_INQUIRY_RESPONSES/ns1:EmbosserInquiryL8V6Response[AZXCIO-ORG = $org]
				return(
	                <ns0:PT_DATOS_TARJETA_ITEM>
	                 	{
							for $cardNumber in $embosserInquiryL8V6/AZXCIO-CARD
							return
				        	<ns0:CARD_NUMBER>{ data($cardNumber) }</ns0:CARD_NUMBER>
				    	}
				    	{
							for $dualIndicator in $embosserInquiryL8V6/AZXCIO-DUAL-IND
							return
				        	<ns0:DUAL_INDICATOR>{ data($dualIndicator) }</ns0:DUAL_INDICATOR>
				    	}
				        <ns0:ACCOUNT_NUMBER>{ $orgItem/ns3:Column[@name='numcuenta']/text() }</ns0:ACCOUNT_NUMBER>
				    	{
							for $cardHolderName in $embosserInquiryL8V6/AZXCIO-EMBOSSED-NAME-1
							return
				        	<ns0:CARD_HOLDER_NAME>{ data($cardHolderName) }</ns0:CARD_HOLDER_NAME>
				    	}
				        <ns0:ACCOUNT_HOLDER_NAME>{ $orgItem/ns3:Column[@name='account_name']/text() }</ns0:ACCOUNT_HOLDER_NAME>
				        <ns0:CARD_HOLDER_LEGAL_ID>{ $orgItem/ns3:Column[@name='card_holder_id']/text() }</ns0:CARD_HOLDER_LEGAL_ID>
				        <ns0:ACCOUNT_HOLDER_LEGAL_ID>{ $orgItem/ns3:Column[@name='account_holder_legal_id']/text() }</ns0:ACCOUNT_HOLDER_LEGAL_ID>
				        <ns0:CUSTOMER_ID>{ $orgItem/ns3:Column[@name='customer_id']/text() }</ns0:CUSTOMER_ID>
				        <ns0:ACCOUNT_STATUS>{ $orgItem/ns3:Column[@name='estatus']/text() }</ns0:ACCOUNT_STATUS>
				        {
							for $cardType in $embosserInquiryL8V6/AZXCIO-CARDHOLDER-TYPE
							return
				        	<ns0:CARD_TYPE>{ data($cardType) }</ns0:CARD_TYPE>
				    	}
				        <ns0:AFINITY_GROUP>{ $orgItem/ns3:Column[@name='logo']/text() }</ns0:AFINITY_GROUP>
			        	{
							for $orgInd in $orgItem/ns3:Column[@name = 'TipoOrg']
							return
							<ns0:ORG_IND>{ data($orgInd) }</ns0:ORG_IND>
			        	}
						{
							if(string($org) != '') then (
								<ns0:ORG>{ $org }</ns0:ORG>
							) else()
						}
						{
							for $currency in $orgItem/ns3:Column[@name = 'CodMoneda']
							return
							<ns0:CURRENCY>{ data($currency) }</ns0:CURRENCY>
						}
						{
							for $anualPurchaseLimit in $embosserInquiryL8V6/AZXCIO-RETAIL-AMOUNT-YTD
							return
							<ns0:ANUAL_PURCHASE_LIMIT>{ data($anualPurchaseLimit) }</ns0:ANUAL_PURCHASE_LIMIT>
						}
						{
							for $anualWithDrawalLimit in $embosserInquiryL8V6/AZXCIO-CASH-AMOUNT-YTD
							return
							<ns0:ANUAL_WITHDRAWAL_LIMIT>{ data($anualWithDrawalLimit) }</ns0:ANUAL_WITHDRAWAL_LIMIT>
						}
						{
							for $monthlyPurchaseLimit in $embosserInquiryL8V6/AZXCIO-RETAIL-AMOUNT-MTD
							return
							<ns0:MONTHLY_PURCHASE_LIMIT>{ data($monthlyPurchaseLimit) }</ns0:MONTHLY_PURCHASE_LIMIT>
						}
						{
							for $monthlyWithDrawalLimit in $embosserInquiryL8V6/AZXCIO-CASH-AMOUNT-MTD
							return
							<ns0:MONTHLY_WITHDRAWAL_LIMIT>{ data($monthlyWithDrawalLimit) }</ns0:MONTHLY_WITHDRAWAL_LIMIT>
						}
						{
							for $dailyPurchaseLimit in string($embosserInquiryL8V6/AZXCIO-RETAIL-AMOUNT-DAILY/text())
							return
							if(fn-bea:trim($dailyPurchaseLimit) != "") then (
								<ns0:DAILY_PURCHASE_LIMIT>{ $dailyPurchaseLimit }</ns0:DAILY_PURCHASE_LIMIT>
							)else()
						}
						{
							for $dailyWithDrawalLimit in string($embosserInquiryL8V6/AZXCIO-CASH-AMOUNT-DAILY/text())
							return
							if(fn-bea:trim($dailyWithDrawalLimit) != "") then (
								<ns0:DAILY_WITHDRAWAL_LIMIT>{ $dailyWithDrawalLimit }</ns0:DAILY_WITHDRAWAL_LIMIT>
							)else()
						}
						{
							for $cardActivationDate in string($embosserInquiryL8V6/AZXCIO-CARD-ACTIVATED-DATE/text())
							return
							if(fn-bea:trim($cardActivationDate) != "") then (
								<ns0:CARD_ACTIVATION_DATE>{ $cardActivationDate }</ns0:CARD_ACTIVATION_DATE>
							)else()
						}
						{
							for $cardStatus in $embosserInquiryL8V6/AZXCIO-CURR-CRD-ACT
				 			return
				 				<ns0:CARD_STATUS>
				 				{
				 					valorCatalogoAPPToOSB(string($cardStatus/text()), 'VISION+GT', '13', $ptEquivalencias)
				 				}
				 				</ns0:CARD_STATUS>
						}
						{
							for $cardExpirationDate in $embosserInquiryL8V6/AZXCIO-DATE-EXPIRE
							return
							<ns0:CARD_EXPIRATION_DATE>{ data($cardExpirationDate) }</ns0:CARD_EXPIRATION_DATE>
						}
						{
							for $embossedNumber in $embosserInquiryL8V6/AZXCIO-EMB-REPL
							return
							<ns0:EMBOSSED_NUMBER>{ fn-bea:trim(data($embossedNumber) )}</ns0:EMBOSSED_NUMBER>
						}
						{
							for $blockCode in $embosserInquiryL8V6/AZXCIO-BLK-CODE
							return
							<ns0:BLOCK_CODE>{ data($blockCode) }</ns0:BLOCK_CODE>
						}
						{
							for $blockReason in $embosserInquiryL8V6/AZXCIO-USER-4
							return
							<ns0:BLOCK_REASON>{ data($blockReason) }</ns0:BLOCK_REASON>
						}
						{
							for $blockDate in $embosserInquiryL8V6/AZXCIO-DATE-BLOCK
							return
							<ns0:BLOCK_DATE>{ data($blockDate) }</ns0:BLOCK_DATE>
						}
			            <ns0:PRODUCT>TCR</ns0:PRODUCT>
						{
							for $pinIndicator in $embosserInquiryL8V6/AZXCIO-PIN-SUPPRESSION
							return
			            	<ns0:PIN_INDICATOR>{ data($pinIndicator) }</ns0:PIN_INDICATOR>
						}
						{
							for $currentPlasticAction in $embosserInquiryL8V6/AZXCIO-CARD-ACTION
							return
			            	<ns0:CURRENT_PLASTIC_ACTION>{ data($currentPlasticAction) }</ns0:CURRENT_PLASTIC_ACTION>
						}
						{
							for $currentPlasticAction in $embosserInquiryL8V6/AZXCIO-LAST-CARD-ACTION
							return
			            	<ns0:LAST_ACTION_PLASTIC>{ data($currentPlasticAction) }</ns0:LAST_ACTION_PLASTIC>
						}
						{
							for $dateLastIssuancePlastic in $embosserInquiryL8V6/AZXCIO-DATE-LST-PLASTICISSUE
							return
			            	<ns0:DATE_LAST_ISSUANCE_PLASTIC>{ data($dateLastIssuancePlastic) }</ns0:DATE_LAST_ISSUANCE_PLASTIC>
						}
						{
							for $privilegeCode in $embosserInquiryL8V6/AZXCIO-EMBOSSED-NAME-2
							return
			            	<ns0:PRIVILEGE_CODE>{ fn-bea:trim(data($privilegeCode)) }</ns0:PRIVILEGE_CODE>
						}
						{
							for $priorityPass in $embosserInquiryL8V6/AZXCIO-USER-1
							return
			            	<ns0:PRIORITY_PASS>{ fn-bea:trim(data($priorityPass)) }</ns0:PRIORITY_PASS>
						}
						{
							for $limitIndicatorExpenses in $embosserInquiryL8V6/AZXCIO-SPEND-LIMITS-STATUS
							return
			            	<ns0:LIMIT_INDICATOR_EXPENSES>{ data($limitIndicatorExpenses) }</ns0:LIMIT_INDICATOR_EXPENSES>
						}
						{
							for $percentageLimitDailyPurchase in $embosserInquiryL8V6/AZXCIO-RETAIL-PERCENT-DAILY
							return
			            	<ns0:PERCENTAGE_LIMIT_DAILY_PURCHASE>{ data($percentageLimitDailyPurchase) }</ns0:PERCENTAGE_LIMIT_DAILY_PURCHASE>
						}
						{
							for $percentageMonthlyPurchaseLimit in $embosserInquiryL8V6/AZXCIO-RETAIL-PERCENT-MTD
							return
								if($percentageMonthlyPurchaseLimit = 0)then(
									<ns0:PERCENTAGE_MONTHLY_PURCHASE_LIMIT>{0}</ns0:PERCENTAGE_MONTHLY_PURCHASE_LIMIT>)
								elseif(fn:string-length($percentageMonthlyPurchaseLimit) = 6)then(
								<ns0:PERCENTAGE_MONTHLY_PURCHASE_LIMIT>{ fn:substring(data($percentageMonthlyPurchaseLimit), 1, 1) }</ns0:PERCENTAGE_MONTHLY_PURCHASE_LIMIT>																	
								)						
							else(
								<ns0:PERCENTAGE_MONTHLY_PURCHASE_LIMIT>{ fn:substring(data($percentageMonthlyPurchaseLimit), 1, 2) }</ns0:PERCENTAGE_MONTHLY_PURCHASE_LIMIT>											
							)					
						}
						{
							for $annualPurchaseLimitPercentage in $embosserInquiryL8V6/AZXCIO-RETAIL-PERCENT-YTD
							return
			            	<ns0:ANNUAL_PURCHASE_LIMIT_PERCENTAGE>{ data($annualPurchaseLimitPercentage) }</ns0:ANNUAL_PURCHASE_LIMIT_PERCENTAGE>
						}
						{
							for $dailyWithdrawalLimitPercentage in $embosserInquiryL8V6/AZXCIO-CASH-PERCENT-DAILY
							return
			            	<ns0:DAILY_WITHDRAWAL_LIMIT_PERCENTAGE>{ data($dailyWithdrawalLimitPercentage) }</ns0:DAILY_WITHDRAWAL_LIMIT_PERCENTAGE>
						}
						{
							for $monthlyWithdrawalLimitPercentage in $embosserInquiryL8V6/AZXCIO-CASH-PERCENT-MTD
							return
								if($monthlyWithdrawalLimitPercentage = 0)then(
								<ns0:MONTHLY_WITHDRAWAL_LIMIT_PERCENTAGE>{0}</ns0:MONTHLY_WITHDRAWAL_LIMIT_PERCENTAGE>
								)
								elseif(fn:string-length($monthlyWithdrawalLimitPercentage) = 6)then(
								<ns0:MONTHLY_WITHDRAWAL_LIMIT_PERCENTAGE>{ fn:substring(data($monthlyWithdrawalLimitPercentage), 1, 1) }</ns0:MONTHLY_WITHDRAWAL_LIMIT_PERCENTAGE>																	
								)							
								else(
			            			<ns0:MONTHLY_WITHDRAWAL_LIMIT_PERCENTAGE>{ fn:substring(data($monthlyWithdrawalLimitPercentage), 1, 2) }</ns0:MONTHLY_WITHDRAWAL_LIMIT_PERCENTAGE>					            								
								)				
																	
						}
						{
							for $annualRetirementLimitPercentage in $embosserInquiryL8V6/AZXCIO-CASH-PERCENT-YTD
							return
			            	<ns0:ANNUAL_RETIREMENT_LIMIT_PERCENTAGE>{ data($annualRetirementLimitPercentage) }</ns0:ANNUAL_RETIREMENT_LIMIT_PERCENTAGE>
						}
						{
							for $numWithdrawalsAppliedToday in $embosserInquiryL8V6/AZXCIO-CASH-POSTED-TODAY-NBR
							return
			            	<ns0:NUM_WITHDRAWALS_APPLIED_TODAY>{ data($numWithdrawalsAppliedToday) }</ns0:NUM_WITHDRAWALS_APPLIED_TODAY>
						}
						{
							for $numWithdrawalsAppliedMonthToDate in $embosserInquiryL8V6/AZXCIO-CASH-POSTED-MTD-NBR
							return
			            	<ns0:NUM_WITHDRAWALS_APPLIED_MONTH_TO_DATE>{ data($numWithdrawalsAppliedMonthToDate) }</ns0:NUM_WITHDRAWALS_APPLIED_MONTH_TO_DATE>
						}
						{
							for $numWithdrawalsAppliedYearToDate in $embosserInquiryL8V6/AZXCIO-CASH-POSTED-YTD-NBR
							return
			            	<ns0:NUM_WITHDRAWALS_APPLIED_YEAR_TO_DATE>{ data($numWithdrawalsAppliedYearToDate) }</ns0:NUM_WITHDRAWALS_APPLIED_YEAR_TO_DATE>
						}
						{
							for $amountInWithdrawalsAppliedToday in $embosserInquiryL8V6/AZXCIO-CASH-POSTED-TODAY-AMT
							return
			            	<ns0:AMOUNT_IN_WITHDRAWALS_APPLIED_TODAY>{ data($amountInWithdrawalsAppliedToday) }</ns0:AMOUNT_IN_WITHDRAWALS_APPLIED_TODAY>
						}
						{
							for $amountInWithdrawalsAppliedMonthToDate in $embosserInquiryL8V6/AZXCIO-CASH-POSTED-MTD-AMT
							return
			            	<ns0:AMOUNT_WITHDRAWALS_APPLIED_MONTH_TO_DATE>{ data($amountInWithdrawalsAppliedMonthToDate) }</ns0:AMOUNT_WITHDRAWALS_APPLIED_MONTH_TO_DATE>
						}
						{
							for $amountInWithdrawalsAppliedYearToDate in $embosserInquiryL8V6/AZXCIO-CASH-POSTED-YTD-AMT
							return
			            	<ns0:AMOUNT_WITHDRAWALS_APPLIED_YEAR_TO_DATE>{ data($amountInWithdrawalsAppliedYearToDate) }</ns0:AMOUNT_WITHDRAWALS_APPLIED_YEAR_TO_DATE>
						}
						{
							for $numDeclinedRetirementsToday in $embosserInquiryL8V6/AZXCIO-CASH-DECLINE-TODAY-NBR
							return
			            	<ns0:NUM_DECLINED_RETIREMENTS_TODAY>{ data($numDeclinedRetirementsToday) }</ns0:NUM_DECLINED_RETIREMENTS_TODAY>
						}
						{
							for $numDeclinedRetirementsMonthToDate in $embosserInquiryL8V6/AZXCIO-CASH-DECLINE-MTD-NBR
							return
			            	<ns0:NUM_DECLINED_RETIREMENTS_MONTH_TO_DATE>{ data($numDeclinedRetirementsMonthToDate) }</ns0:NUM_DECLINED_RETIREMENTS_MONTH_TO_DATE>
						}
						{
							for $numDeclinedRetirementsYearToDate in $embosserInquiryL8V6/AZXCIO-CASH-DECLINE-YTD-NBR
							return
			            	<ns0:NUM_DECLINED_RETIREMENTS_YEAR_TO_DATE>{ data($numDeclinedRetirementsYearToDate) }</ns0:NUM_DECLINED_RETIREMENTS_YEAR_TO_DATE>
						}
						{
							for $amountDeclinedRetirementsToday in $embosserInquiryL8V6/AZXCIO-CASH-DECLINE-TODAY-AMT
							return
			            	<ns0:AMOUNT_DECLINED_RETIREMENTS_TODAY>{ data($amountDeclinedRetirementsToday) }</ns0:AMOUNT_DECLINED_RETIREMENTS_TODAY>
						}
						{
							for $amountDeclinedRetirementsMonthToDate in $embosserInquiryL8V6/AZXCIO-CASH-DECLINE-MTD-AMT
							return
			            	<ns0:AMOUNT_DECLINED_WITHDRAWALS_MONTH_TO_DATE>{ data($amountDeclinedRetirementsMonthToDate) }</ns0:AMOUNT_DECLINED_WITHDRAWALS_MONTH_TO_DATE>
						}
						{
							for $amountDeclinedRetirementsYearToDate in $embosserInquiryL8V6/AZXCIO-CASH-DECLINE-YTD-AMT
							return
			            	<ns0:AMOUNT_DECLINED_RETIREMENTS_YEAR_TO_DATE>{ data($amountDeclinedRetirementsYearToDate) }</ns0:AMOUNT_DECLINED_RETIREMENTS_YEAR_TO_DATE>
						}
						{
							for $numPurchasesAppliedToday in $embosserInquiryL8V6/AZXCIO-RETAIL-POSTED-TODAY-NBR
							return
			            	<ns0:NUM_PURCHASES_APPLIED_TODAY>{ data($numPurchasesAppliedToday) }</ns0:NUM_PURCHASES_APPLIED_TODAY>
						}
						{
							for $numPurchasesAppliedMonthToDate in $embosserInquiryL8V6/AZXCIO-RETAIL-POSTED-MTD-NBR
							return
			            	<ns0:NUM_PURCHASES_APPLIED_MONTH_TO_DATE>{ data($numPurchasesAppliedMonthToDate) }</ns0:NUM_PURCHASES_APPLIED_MONTH_TO_DATE>
						}
						{
							for $numPurchasesAppliedYearToDate in $embosserInquiryL8V6/AZXCIO-RETAIL-POSTED-YTD-NBR
							return
			            	<ns0:NUM_PURCHASES_APPLIED_YEAR_TO_DATE>{ data($numPurchasesAppliedYearToDate) }</ns0:NUM_PURCHASES_APPLIED_YEAR_TO_DATE>
						}
						{
							for $amountAppliedPurchasesToday in $embosserInquiryL8V6/AZXCIO-RETAIL-POSTED-TODAY-AMT
							return
			            	<ns0:AMOUNT_APPLIED_PURCHASES_TODAY>{ data($amountAppliedPurchasesToday) }</ns0:AMOUNT_APPLIED_PURCHASES_TODAY>
						}
						{
							for $amountAppliedPurchasesMonthToDate in $embosserInquiryL8V6/AZXCIO-RETAIL-POSTED-MTD-AMT
							return
			            	<ns0:AMOUNT_APPLIED_PURCHASES_MONTH_TO_DATE>{ data($amountAppliedPurchasesMonthToDate) }</ns0:AMOUNT_APPLIED_PURCHASES_MONTH_TO_DATE>
						}
						{
							for $amountAppliedPurchasesYearToDate in $embosserInquiryL8V6/AZXCIO-RETAIL-POSTED-YTD-AMT
							return
			            	<ns0:AMOUNT_APPLIED_PURCHASES_YEAR_TO_DATE>{ data($amountAppliedPurchasesYearToDate) }</ns0:AMOUNT_APPLIED_PURCHASES_YEAR_TO_DATE>
						}
						{
							for $numPurchasesDeclinedToday in $embosserInquiryL8V6/AZXCIO-RETAIL-DECLINE-TODAY-NBR
							return
			            	<ns0:NUM_PURCHASES_DECLINED_TODAY>{ data($numPurchasesDeclinedToday) }</ns0:NUM_PURCHASES_DECLINED_TODAY>
						}
						{
							for $numPurchasesDeclinedMonthToDate in $embosserInquiryL8V6/AZXCIO-RETAIL-DECLINE-MTD-NBR
							return
			            	<ns0:NUM_PURCHASES_DECLINED_MONTH_TO_DATE>{ data($numPurchasesDeclinedMonthToDate) }</ns0:NUM_PURCHASES_DECLINED_MONTH_TO_DATE>
						}
						{
							for $numPurchasesDeclinedYearToDate in $embosserInquiryL8V6/AZXCIO-RETAIL-DECLINE-YTD-NBR
							return
			            	<ns0:NUM_PURCHASES_DECLINED_YEAR_TO_DATE>{ data($numPurchasesDeclinedYearToDate) }</ns0:NUM_PURCHASES_DECLINED_YEAR_TO_DATE>
						}
						{
							for $amountPurchasesDeclinedToday in $embosserInquiryL8V6/AZXCIO-RETAIL-DECLINE-TODAY-AMT
							return
			            	<ns0:AMOUNT_PURCHASES_DECLINED_TODAY>{ data($amountPurchasesDeclinedToday) }</ns0:AMOUNT_PURCHASES_DECLINED_TODAY>
						}
						{
							for $amountPurchasesDeclinedMonthToDate in $embosserInquiryL8V6/AZXCIO-RETAIL-DECLINE-MTD-AMT
							return
			            	<ns0:AMOUNT_PURCHASES_DECLINED_MONTH_TO_DATE>{ data($amountPurchasesDeclinedMonthToDate) }</ns0:AMOUNT_PURCHASES_DECLINED_MONTH_TO_DATE>
						}
						{
							for $amountPurchasesDeclinedYearToDate in $embosserInquiryL8V6/AZXCIO-RETAIL-DECLINE-YTD-AMT
							return
			            	<ns0:AMOUNT_PURCHASES_DECLINED_YEAR_TO_DATE>{ data($amountPurchasesDeclinedYearToDate) }</ns0:AMOUNT_PURCHASES_DECLINED_YEAR_TO_DATE>
						}
	                 	
	                </ns0:PT_DATOS_TARJETA_ITEM>
                )
             }
            </ns0:PT_DATOS_TARJETA>
             <ns0:PV_COUNTRY_CODE>{ $countryCode }</ns0:PV_COUNTRY_CODE>
        </ns0:InputParameters>
};

declare variable $resultGroup as element(*) external;
declare variable $ptEquivalencias as element() external;
declare variable $datosCuenta as element(ns3:OutputParameters) external;
declare variable $countryCode as xs:string external;

xf:registraDatosTCGTIn($resultGroup,
    $ptEquivalencias,
    $datosCuenta,
    $countryCode)
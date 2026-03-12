xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)


declare namespace ns0="https://www.ficohsa.com/regional/card";
(:: import schema at "../../../SBGT_Card_Commons/Schemas/CardInquiryTypesv2.xsd" ::)
declare namespace ns1 = "http://www.procesa.com/fdcs";
(:: import schema at "../../Resources/v2/VMX.wsdl" ::)
declare namespace ns2 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaEquivalenciasCatalogos";
(:: import schema at "../../Schemas/v2/consultaEquivalenciasCatalogos_sp.xsd" ::)
declare namespace ns3 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/conDatoTarjeta";
(:: import schema at "../../Schemas/v2/conDatoTarjeta_sp.xsd" ::)
declare namespace ns5 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaDatosTC";
(:: import schema at "../../Schemas/v2/consultaDatosTC_sp.xsd" ::)

declare function local:valorCatalogoAPPToOSB($valor as xs:string,
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
declare variable $globalId as xs:string external;

declare function local:consultaDatosTarjetaCreditoGTOut($resultGroup as element(*)?,
	$ptEquivalencias as element()?,
	$datosCuenta as element(ns3:OutputParameters)?,
	$outputParameters1 as element(ns5:OutputParameters)?,$globalId as xs:string)
as element(ns0:getCreditCardDetailsResponse) {
	let $embosserInquiryL8V6 := $resultGroup/EMBOSSER_INQUIRY_RESPONSES/ns1:EmbosserInquiryL8V6Response[1]
	let $datoCuenta := $datosCuenta/ns3:RowSet/ns3:Row[1]
	return
    <ns0:getCreditCardDetailsResponse>
            <StatusInfo>
                  <Status>Success</Status>
                  <ValueDate>{fn:substring(fn:string(fn:current-dateTime()),0,11)}</ValueDate>
                  <DateTime>{fn:substring(fn:string(fn:current-dateTime()),0,20)}</DateTime>
                  <GlobalId>{fn:data($globalId)}</GlobalId>
              </StatusInfo>
    {
    	if(not(empty($outputParameters1/ns5:PT_DATOS_TARJETA/ns5:PT_DATOS_TARJETA_ITEM))) then (
           		for $CARD_NUMBER in $outputParameters1/ns5:PT_DATOS_TARJETA/ns5:PT_DATOS_TARJETA_ITEM[1]/ns5:CARD_NUMBER
                return
                <CardNumber>{ data($CARD_NUMBER) }</CardNumber>,

                for $DUAL_INDICATOR in $outputParameters1/ns5:PT_DATOS_TARJETA/ns5:PT_DATOS_TARJETA_ITEM[1]/ns5:DUAL_INDICATOR
                return
                    <DualIndicator>{ data($DUAL_INDICATOR) }</DualIndicator>,

                for $ACCOUNT_NUMBER in $outputParameters1/ns5:PT_DATOS_TARJETA/ns5:PT_DATOS_TARJETA_ITEM[1]/ns5:ACCOUNT_NUMBER
                return
                    <AccountNumber>{ data($ACCOUNT_NUMBER) }</AccountNumber>,

                for $CARD_HOLDER_NAME in $outputParameters1/ns5:PT_DATOS_TARJETA/ns5:PT_DATOS_TARJETA_ITEM[1]/ns5:CARD_HOLDER_NAME
                return
                    <CardHolderName>{ data($CARD_HOLDER_NAME) }</CardHolderName>,

                for $ACCOUNT_HOLDER_NAME in $outputParameters1/ns5:PT_DATOS_TARJETA/ns5:PT_DATOS_TARJETA_ITEM[1]/ns5:ACCOUNT_HOLDER_NAME
                return
                    <AccountHolderName>{ data($ACCOUNT_HOLDER_NAME) }</AccountHolderName>,

                for $CARD_HOLDER_LEGAL_ID in $outputParameters1/ns5:PT_DATOS_TARJETA/ns5:PT_DATOS_TARJETA_ITEM[1]/ns5:CARD_HOLDER_LEGAL_ID
                return
                    <CardHolderLegalId>{ data($CARD_HOLDER_LEGAL_ID) }</CardHolderLegalId>,

                for $ACCOUNT_HOLDER_LEGAL_ID in $outputParameters1/ns5:PT_DATOS_TARJETA/ns5:PT_DATOS_TARJETA_ITEM[1]/ns5:ACCOUNT_HOLDER_LEGAL_ID
                return
                    <AccountHolderLegalId>{ data($ACCOUNT_HOLDER_LEGAL_ID) }</AccountHolderLegalId>,

                for $CUSTOMER_ID in $outputParameters1/ns5:PT_DATOS_TARJETA/ns5:PT_DATOS_TARJETA_ITEM[1]/ns5:CUSTOMER_ID
                return
                    <CustomerId>{ data($CUSTOMER_ID) }</CustomerId>,

                for $ACCOUNT_STATUS in $outputParameters1/ns5:PT_DATOS_TARJETA/ns5:PT_DATOS_TARJETA_ITEM[1]/ns5:ACCOUNT_STATUS
                return
                    <AccountStatus>{ data($ACCOUNT_STATUS) }</AccountStatus>,

                for $CARD_TYPE in $outputParameters1/ns5:PT_DATOS_TARJETA/ns5:PT_DATOS_TARJETA_ITEM[1]/ns5:CARD_TYPE
                return
                    <CardType>{ data($CARD_TYPE) }</CardType>,

                for $AFINITY_GROUP in $outputParameters1/ns5:PT_DATOS_TARJETA/ns5:PT_DATOS_TARJETA_ITEM[1]/ns5:AFINITY_GROUP
                return
					<AfinityGroup>{data($AFINITY_GROUP)}</AfinityGroup>,
                for $PT_DATOS_TARJETA_ITEM in $outputParameters1/ns5:PT_DATOS_TARJETA/ns5:PT_DATOS_TARJETA_ITEM
                return(
                    <CardCurrencyInformation>
                        <OrgInd>{ data($PT_DATOS_TARJETA_ITEM/ns5:ORG_IND) }</OrgInd>
                        <Org>{ data($PT_DATOS_TARJETA_ITEM/ns5:ORG) }</Org>
                        <Currency>{ data($PT_DATOS_TARJETA_ITEM/ns5:CURRENCY) }</Currency>
                        <AnualPurchaseLimit>{ data($PT_DATOS_TARJETA_ITEM/ns5:ANUAL_PURCHASE_LIMIT) }</AnualPurchaseLimit>
                        <AnualWithdrawalLimit>{ data($PT_DATOS_TARJETA_ITEM/ns5:ANUAL_WITHDRAWAL_LIMIT) }</AnualWithdrawalLimit>
                     	<MonthlyPurchaseLimit>{ data($PT_DATOS_TARJETA_ITEM/ns5:MONTHLY_PURCHASE_LIMIT) }</MonthlyPurchaseLimit>
                        <MonthlyWithdrawalLimit>{ data($PT_DATOS_TARJETA_ITEM/ns5:MONTHLY_WITHDRAWAL_LIMIT) }</MonthlyWithdrawalLimit>
                        <DailyPurchaseLimit>{ data($PT_DATOS_TARJETA_ITEM/ns5:DAILY_PURCHASE_LIMIT) }</DailyPurchaseLimit>
                        <DailyWithdrawalLimit>{ data($PT_DATOS_TARJETA_ITEM/ns5:DAILY_WITHDRAWAL_LIMIT) }</DailyWithdrawalLimit>
                        {
	                       	 if(data($PT_DATOS_TARJETA_ITEM/ns5:CARD_ACTIVATION_DATE/text()) != '')then(
	            				<CardActivationDate>{  fn-bea:dateTime-to-string-with-format("yyyy-MM-dd", data($PT_DATOS_TARJETA_ITEM/ns5:CARD_ACTIVATION_DATE)) }</CardActivationDate>
	          				 )else()
          				}
                        <CardStatus>{ data($PT_DATOS_TARJETA_ITEM/ns5:CARD_STATUS) }</CardStatus>
                       	 <CardExpirationDate>{  data($PT_DATOS_TARJETA_ITEM/ns5:CARD_EXPIRATION_DATE) }</CardExpirationDate>
                        <EmbossedNumber>{ data($PT_DATOS_TARJETA_ITEM/ns5:EMBOSSED_NUMBER) }</EmbossedNumber>
                        <BlockCode>{ data($PT_DATOS_TARJETA_ITEM/ns5:BLOCK_CODE) }</BlockCode>
                        <BlockReason>{ data($PT_DATOS_TARJETA_ITEM/ns5:BLOCK_REASON) }</BlockReason>
                        <BlockDate>{ data($PT_DATOS_TARJETA_ITEM/ns5:BLOCK_DATE) }</BlockDate>
                        <Product>{ data($PT_DATOS_TARJETA_ITEM/ns5:PRODUCT) }</Product>
                   		<PinIndicator>{ data($PT_DATOS_TARJETA_ITEM/ns5:PIN_INDICATOR) }</PinIndicator>
                   		<CurrentPlasticAction>{ data($PT_DATOS_TARJETA_ITEM/ns5:CURRENT_PLASTIC_ACTION) }</CurrentPlasticAction>
                   		<LastActionPlastic>{ data($PT_DATOS_TARJETA_ITEM/ns5:LAST_ACTION_PLASTIC) }</LastActionPlastic>
                   		<DateLastIssuancePlastic>{ data($PT_DATOS_TARJETA_ITEM/ns5:DATE_LAST_ISSUANCE_PLASTIC) }</DateLastIssuancePlastic>
                   		<PrivilegeCode>{ data($PT_DATOS_TARJETA_ITEM/ns5:PRIVILEGE_CODE) }</PrivilegeCode>
                   		<PriorityPass>{ data($PT_DATOS_TARJETA_ITEM/ns5:PRIORITY_PASS) }</PriorityPass>
                   		<LimitIndicatorExpenses>{ data($PT_DATOS_TARJETA_ITEM/ns5:LIMIT_INDICATOR_EXPENSES) }</LimitIndicatorExpenses>
                   		<PercentageLimitDailyPurchase>{ data($PT_DATOS_TARJETA_ITEM/ns5:PERCENTAGE_LIMIT_DAILY_PURCHASE) }</PercentageLimitDailyPurchase>
                   		<PercentageMonthlyPurchaseLimit>{ data($PT_DATOS_TARJETA_ITEM/ns5:PERCENTAGE_MONTHLY_PURCHASE_LIMIT) }</PercentageMonthlyPurchaseLimit>
                   		<AnnualPurchaseLimitPercentage>{ data($PT_DATOS_TARJETA_ITEM/ns5:ANNUAL_PURCHASE_LIMIT_PERCENTAGE) }</AnnualPurchaseLimitPercentage>
						<DailyWithdrawalLimitPercentage>{ data($PT_DATOS_TARJETA_ITEM/ns5:DAILY_WITHDRAWAL_LIMIT_PERCENTAGE) }</DailyWithdrawalLimitPercentage>
						<MonthlyWithdrawalLimitPercentage>{ data($PT_DATOS_TARJETA_ITEM/ns5:MONTHLY_WITHDRAWAL_LIMIT_PERCENTAGE) }</MonthlyWithdrawalLimitPercentage>					            									
						<AnnualRetirementLimitPercentage>{ data($PT_DATOS_TARJETA_ITEM/ns5:ANNUAL_RETIREMENT_LIMIT_PERCENTAGE) }</AnnualRetirementLimitPercentage>
						<DailyWithdrawalLimitPercentage>{ data($PT_DATOS_TARJETA_ITEM/ns5:PRODUCT) }</DailyWithdrawalLimitPercentage>
						<MonthlyWithdrawalLimitPercentage>{ data($PT_DATOS_TARJETA_ITEM/ns5:PRODUCT) }</MonthlyWithdrawalLimitPercentage>					            									
						<AnnualRetirementLimitPercentage>{ data($PT_DATOS_TARJETA_ITEM/ns5:PRODUCT) }</AnnualRetirementLimitPercentage>
						<NumWithdrawalsAppliedToday>{ data($PT_DATOS_TARJETA_ITEM/ns5:NUM_WITHDRAWALS_APPLIED_TODAY) }</NumWithdrawalsAppliedToday>
						<NumWithdrawalsAppliedMonthToDate>{ data($PT_DATOS_TARJETA_ITEM/ns5:NUM_WITHDRAWALS_APPLIED_MONTH_TO_DATE) }</NumWithdrawalsAppliedMonthToDate>
						<NumWithdrawalsAppliedYearToDate>{ data($PT_DATOS_TARJETA_ITEM/ns5:NUM_WITHDRAWALS_APPLIED_YEAR_TO_DATE) }</NumWithdrawalsAppliedYearToDate>
						<AmountInWithdrawalsAppliedToday>{ data($PT_DATOS_TARJETA_ITEM/ns5:AMOUNT_IN_WITHDRAWALS_APPLIED_TODAY) }</AmountInWithdrawalsAppliedToday>
						<AmountWithdrawalsAppliedMonthToDate>{ data($PT_DATOS_TARJETA_ITEM/ns5:AMOUNT_WITHDRAWALS_APPLIED_MONTH_TO_DATE) }</AmountWithdrawalsAppliedMonthToDate>
                     	<AmountWithdrawalsAppliedYearToDate>{ data($PT_DATOS_TARJETA_ITEM/ns5:AMOUNT_WITHDRAWALS_APPLIED_YEAR_TO_DATE) }</AmountWithdrawalsAppliedYearToDate>
						<NumDeclinedRetirementsToday>{ data($PT_DATOS_TARJETA_ITEM/ns5:NUM_DECLINED_RETIREMENTS_TODAY) }</NumDeclinedRetirementsToday>
						<NumDeclinedRetirementsMonthToDate>{ data($PT_DATOS_TARJETA_ITEM/ns5:NUM_DECLINED_RETIREMENTS_MONTH_TO_DATE) }</NumDeclinedRetirementsMonthToDate>
						<NumDeclinedRetirementsYearToDate>{ data($PT_DATOS_TARJETA_ITEM/ns5:NUM_DECLINED_RETIREMENTS_YEAR_TO_DATE) }</NumDeclinedRetirementsYearToDate>
						<AmountDeclinedRetirementsToday>{ data($PT_DATOS_TARJETA_ITEM/ns5:AMOUNT_DECLINED_RETIREMENTS_TODAY) }</AmountDeclinedRetirementsToday>
						<AmountDeclinedWithdrawalsMonthToDate>{ data($PT_DATOS_TARJETA_ITEM/ns5:AMOUNT_DECLINED_WITHDRAWALS_MONTH_TO_DATE) }</AmountDeclinedWithdrawalsMonthToDate>
						<AmountDeclinedRetirementsYearToDate>{ data($PT_DATOS_TARJETA_ITEM/ns5:AMOUNT_DECLINED_RETIREMENTS_YEAR_TO_DATE) }</AmountDeclinedRetirementsYearToDate>
						<NumPurchasesAppliedToday>{ data($PT_DATOS_TARJETA_ITEM/ns5:NUM_PURCHASES_APPLIED_TODAY) }</NumPurchasesAppliedToday>
						<NumPurchasesAppliedMonthToDate>{ data($PT_DATOS_TARJETA_ITEM/ns5:NUM_PURCHASES_APPLIED_MONTH_TO_DATE) }</NumPurchasesAppliedMonthToDate>
						<NumPurchasesAppliedYearToDate>{ data($PT_DATOS_TARJETA_ITEM/ns5:NUM_PURCHASES_APPLIED_YEAR_TO_DATE) }</NumPurchasesAppliedYearToDate>
						<AmountAppliedPurchasesToday>{ data($PT_DATOS_TARJETA_ITEM/ns5:AMOUNT_APPLIED_PURCHASES_TODAY) }</AmountAppliedPurchasesToday>
						<AmountAppliedPurchasesMonthToDate>{ data($PT_DATOS_TARJETA_ITEM/ns5:AMOUNT_APPLIED_PURCHASES_MONTH_TO_DATE) }</AmountAppliedPurchasesMonthToDate>
						<AmountAppliedPurchasesYearToDate>{ data($PT_DATOS_TARJETA_ITEM/ns5:AMOUNT_APPLIED_PURCHASES_YEAR_TO_DATE) }</AmountAppliedPurchasesYearToDate>
						<NumPurchasesDeclinedToday>{ data($PT_DATOS_TARJETA_ITEM/ns5:NUM_PURCHASES_DECLINED_TODAY) }</NumPurchasesDeclinedToday>
                     	<NumPurchasesDeclinedMonthToDate>{ data($PT_DATOS_TARJETA_ITEM/ns5:NUM_PURCHASES_DECLINED_MONTH_TO_DATE) }</NumPurchasesDeclinedMonthToDate>
						<NumPurchasesDeclinedYearToDate>{ data($PT_DATOS_TARJETA_ITEM/ns5:NUM_PURCHASES_DECLINED_YEAR_TO_DATEDUCT) }</NumPurchasesDeclinedYearToDate>
						<AmountPurchasesDeclinedToday>{ data($PT_DATOS_TARJETA_ITEM/ns5:AMOUNT_PURCHASES_DECLINED_TODAY) }</AmountPurchasesDeclinedToday>
						<AmountPurchasesDeclinedMonthToDate>{ data($PT_DATOS_TARJETA_ITEM/ns5:AMOUNT_PURCHASES_DECLINED_YEAR_TO_DATE) }</AmountPurchasesDeclinedMonthToDate>
						<AmountPurchasesDeclinedYearToDate>{ data($PT_DATOS_TARJETA_ITEM/ns5:AMOUNT_PURCHASES_DECLINED_YEAR_TO_DATE) }</AmountPurchasesDeclinedYearToDate>
                   </CardCurrencyInformation>
                  )
    	)else(
			for $cardNumber in $embosserInquiryL8V6/AZXCIO-CARD
			return
        	<CardNumber>{ data($cardNumber) }</CardNumber>,
			for $dualIndicator in $embosserInquiryL8V6/AZXCIO-DUAL-IND
			return
        	<DualIndicator>{ data($dualIndicator) }</DualIndicator>,
	        <AccountNumber>{ $datoCuenta/ns3:Column[@name='numcuenta']/text() }</AccountNumber>,
			for $cardHolderName in $embosserInquiryL8V6/AZXCIO-EMBOSSED-NAME-1
			return
        		<CardHolderName>{ data($cardHolderName) }</CardHolderName>,
	        <AccountHolderName>{ $datoCuenta/ns3:Column[@name='account_name']/text() }</AccountHolderName>,
	        <CardHolderLegalId>{ $datoCuenta/ns3:Column[@name='card_holder_id']/text() }</CardHolderLegalId>,
	        <AccountHolderLegalId>{ $datoCuenta/ns3:Column[@name='account_holder_legal_id']/text() }</AccountHolderLegalId>,
	        <CustomerId>{ $datoCuenta/ns3:Column[@name='customer_id']/text() }</CustomerId>,
	        <AccountStatus>{ $datoCuenta/ns3:Column[@name='estatus']/text() }</AccountStatus>,
			for $cardType in $embosserInquiryL8V6/AZXCIO-CARDHOLDER-TYPE
			return
        		<CardType>{ data($cardType) }</CardType>,
	        <AfinityGroup>{ $datoCuenta/ns3:Column[@name='logo']/text() }</AfinityGroup>,
	      
        	for $orgItem in $datosCuenta/ns3:RowSet/ns3:Row
			let $org := data($orgItem/ns3:Column[@name = 'org'])
			let $embosserInquiryL8V6 := $resultGroup/EMBOSSER_INQUIRY_RESPONSES/ns1:EmbosserInquiryL8V6Response[AZXCIO-ORG = $org]
			return(
		        <CardCurrencyInformation>
		        	{
						for $orgInd in $orgItem/ns3:Column[@name = 'TipoOrg']
						return
						<OrgInd>{ data($orgInd) }</OrgInd>
		        	}
					{
						if(string($org) != '') then (
							<Org>{ $org }</Org>
						) else()
					}
					{
						for $currency in $orgItem/ns3:Column[@name = 'CodMoneda']
						return
						<Currency>{ data($currency) }</Currency>
					}
					{
						for $anualPurchaseLimit in $embosserInquiryL8V6/AZXCIO-RETAIL-AMOUNT-YTD
						return
						<AnualPurchaseLimit>{ data($anualPurchaseLimit) }</AnualPurchaseLimit>
					}
					{
						for $anualWithDrawalLimit in $embosserInquiryL8V6/AZXCIO-CASH-AMOUNT-YTD
						return
						<AnualWithdrawalLimit>{ data($anualWithDrawalLimit) }</AnualWithdrawalLimit>
					}
					{
						for $monthlyPurchaseLimit in $embosserInquiryL8V6/AZXCIO-RETAIL-AMOUNT-MTD
						return
						<MonthlyPurchaseLimit>{ data($monthlyPurchaseLimit) }</MonthlyPurchaseLimit>
					}
					{
						for $monthlyWithDrawalLimit in $embosserInquiryL8V6/AZXCIO-CASH-AMOUNT-MTD
						return
						<MonthlyWithdrawalLimit>{ data($monthlyWithDrawalLimit) }</MonthlyWithdrawalLimit>
					}
					{
						for $dailyPurchaseLimit in string($embosserInquiryL8V6/AZXCIO-RETAIL-AMOUNT-DAILY/text())
						return
						if(fn-bea:trim($dailyPurchaseLimit) != "") then (
							<DailyPurchaseLimit>{ $dailyPurchaseLimit }</DailyPurchaseLimit>
						)else()
					}
					{
						for $dailyWithDrawalLimit in string($embosserInquiryL8V6/AZXCIO-CASH-AMOUNT-DAILY/text())
						return
						if(fn-bea:trim($dailyWithDrawalLimit) != "") then (
							<DailyWithdrawalLimit>{ $dailyWithDrawalLimit }</DailyWithdrawalLimit>
						)else()
					}
					{
						for $cardActivationDate in string($embosserInquiryL8V6/AZXCIO-CARD-ACTIVATED-DATE/text())
						return
						if(fn-bea:trim($cardActivationDate) != "") then (
							<CardActivationDate>{ $cardActivationDate }</CardActivationDate>
						)else()
					}
					{
						for $cardStatus in $embosserInquiryL8V6/AZXCIO-CURR-CRD-ACT
			 			return
			 				<CardStatus>
			 				{
			 					local:valorCatalogoAPPToOSB(string($cardStatus/text()), 'VISION+GT', '13', $ptEquivalencias)
			 				}
			 				</CardStatus>
					}
					{
						for $cardExpirationDate in $embosserInquiryL8V6/AZXCIO-DATE-EXPIRE
						return
						<CardExpirationDate>{ data($cardExpirationDate) }</CardExpirationDate>
					}
					{
						for $embossedNumber in $embosserInquiryL8V6/AZXCIO-EMB-REPL
						return
						<EmbossedNumber>{ data($embossedNumber) }</EmbossedNumber>
					}
					{
						for $blockCode in $embosserInquiryL8V6/AZXCIO-BLK-CODE
						return
						<BlockCode>{ data($blockCode) }</BlockCode>
					}
					{
						for $blockReason in $embosserInquiryL8V6/AZXCIO-USER-4
						return
						<BlockReason>{ data($blockReason) }</BlockReason>
					}
					{
						for $blockDate in $embosserInquiryL8V6/AZXCIO-DATE-BLOCK
						return
						<BlockDate>{ data($blockDate) }</BlockDate>
					}
		            <Product>TCR</Product>
					{
						for $pinIndicator in $embosserInquiryL8V6/AZXCIO-PIN-SUPPRESSION
						return
		            	<PinIndicator>{ data($pinIndicator) }</PinIndicator>
					}
					{
						for $currentPlasticAction in $embosserInquiryL8V6/AZXCIO-CARD-ACTION
						return
		            	<CurrentPlasticAction>{ data($currentPlasticAction) }</CurrentPlasticAction>
					}
					{
						for $currentPlasticAction in $embosserInquiryL8V6/AZXCIO-LAST-CARD-ACTION
						return
		            	<LastActionPlastic>{ data($currentPlasticAction) }</LastActionPlastic>
					}
					{
						for $dateLastIssuancePlastic in $embosserInquiryL8V6/AZXCIO-DATE-LST-PLASTICISSUE
						return
		            	<DateLastIssuancePlastic>{ data($dateLastIssuancePlastic) }</DateLastIssuancePlastic>
					}
					{
						for $privilegeCode in $embosserInquiryL8V6/AZXCIO-EMBOSSED-NAME-2
						return
		            	<PrivilegeCode>{ data($privilegeCode) }</PrivilegeCode>
					}
					{
						for $priorityPass in $embosserInquiryL8V6/AZXCIO-USER-1
						return
		            	<PriorityPass>{ data($priorityPass) }</PriorityPass>
					}
					{
						for $limitIndicatorExpenses in $embosserInquiryL8V6/AZXCIO-SPEND-LIMITS-STATUS
						return
		            	<LimitIndicatorExpenses>{ data($limitIndicatorExpenses) }</LimitIndicatorExpenses>
					}
					{
						for $percentageLimitDailyPurchase in $embosserInquiryL8V6/AZXCIO-RETAIL-PERCENT-DAILY
						return
		            	<PercentageLimitDailyPurchase>{ data($percentageLimitDailyPurchase) }</PercentageLimitDailyPurchase>
					}
					{
						for $percentageMonthlyPurchaseLimit in $embosserInquiryL8V6/AZXCIO-RETAIL-PERCENT-MTD
						return
							if($percentageMonthlyPurchaseLimit = 0)then(
								<PercentageMonthlyPurchaseLimit>{0}</PercentageMonthlyPurchaseLimit>)
							else if(fn:string-length($percentageMonthlyPurchaseLimit) = 6)then(
							<PercentageMonthlyPurchaseLimit>{ fn:substring(data($percentageMonthlyPurchaseLimit), 1, 1) }</PercentageMonthlyPurchaseLimit>																	
							)						
						else(
							<PercentageMonthlyPurchaseLimit>{ fn:substring(data($percentageMonthlyPurchaseLimit), 1, 2) }</PercentageMonthlyPurchaseLimit>											
						)					
					}
					{
						for $annualPurchaseLimitPercentage in $embosserInquiryL8V6/AZXCIO-RETAIL-PERCENT-YTD
						return
		            	<AnnualPurchaseLimitPercentage>{ data($annualPurchaseLimitPercentage) }</AnnualPurchaseLimitPercentage>
					}
					{
						for $dailyWithdrawalLimitPercentage in $embosserInquiryL8V6/AZXCIO-CASH-PERCENT-DAILY
						return
		            	<DailyWithdrawalLimitPercentage>{ data($dailyWithdrawalLimitPercentage) }</DailyWithdrawalLimitPercentage>
					}
					{
						for $monthlyWithdrawalLimitPercentage in $embosserInquiryL8V6/AZXCIO-CASH-PERCENT-MTD
						return
							if($monthlyWithdrawalLimitPercentage = 0)then(
							<MonthlyWithdrawalLimitPercentage>{0}</MonthlyWithdrawalLimitPercentage>
							)
							else if(fn:string-length($monthlyWithdrawalLimitPercentage) = 6)then(
							<MonthlyWithdrawalLimitPercentage>{ fn:substring(data($monthlyWithdrawalLimitPercentage), 1, 1) }</MonthlyWithdrawalLimitPercentage>																	
							)							
							else(
		            			<MonthlyWithdrawalLimitPercentage>{ fn:substring(data($monthlyWithdrawalLimitPercentage), 1, 2) }</MonthlyWithdrawalLimitPercentage>					            								
							)				
																
					}
					{
						for $annualRetirementLimitPercentage in $embosserInquiryL8V6/AZXCIO-CASH-PERCENT-YTD
						return
		            	<AnnualRetirementLimitPercentage>{ data($annualRetirementLimitPercentage) }</AnnualRetirementLimitPercentage>
					}
					{
						for $numWithdrawalsAppliedToday in $embosserInquiryL8V6/AZXCIO-CASH-POSTED-TODAY-NBR
						return
		            	<NumWithdrawalsAppliedToday>{ data($numWithdrawalsAppliedToday) }</NumWithdrawalsAppliedToday>
					}
					{
						for $numWithdrawalsAppliedMonthToDate in $embosserInquiryL8V6/AZXCIO-CASH-POSTED-MTD-NBR
						return
		            	<NumWithdrawalsAppliedMonthToDate>{ data($numWithdrawalsAppliedMonthToDate) }</NumWithdrawalsAppliedMonthToDate>
					}
					{
						for $numWithdrawalsAppliedYearToDate in $embosserInquiryL8V6/AZXCIO-CASH-POSTED-YTD-NBR
						return
		            	<NumWithdrawalsAppliedYearToDate>{ data($numWithdrawalsAppliedYearToDate) }</NumWithdrawalsAppliedYearToDate>
					}
					{
						for $amountInWithdrawalsAppliedToday in $embosserInquiryL8V6/AZXCIO-CASH-POSTED-TODAY-AMT
						return
		            	<AmountInWithdrawalsAppliedToday>{ data($amountInWithdrawalsAppliedToday) }</AmountInWithdrawalsAppliedToday>
					}
					{
						for $amountInWithdrawalsAppliedMonthToDate in $embosserInquiryL8V6/AZXCIO-CASH-POSTED-MTD-AMT
						return
		            	<AmountWithdrawalsAppliedMonthToDate>{ data($amountInWithdrawalsAppliedMonthToDate) }</AmountWithdrawalsAppliedMonthToDate>
					}
					{
						for $amountInWithdrawalsAppliedYearToDate in $embosserInquiryL8V6/AZXCIO-CASH-POSTED-YTD-AMT
						return
		            	<AmountWithdrawalsAppliedYearToDate>{ data($amountInWithdrawalsAppliedYearToDate) }</AmountWithdrawalsAppliedYearToDate>
					}
					{
						for $numDeclinedRetirementsToday in $embosserInquiryL8V6/AZXCIO-CASH-DECLINE-TODAY-NBR
						return
		            	<NumDeclinedRetirementsToday>{ data($numDeclinedRetirementsToday) }</NumDeclinedRetirementsToday>
					}
					{
						for $numDeclinedRetirementsMonthToDate in $embosserInquiryL8V6/AZXCIO-CASH-DECLINE-MTD-NBR
						return
		            	<NumDeclinedRetirementsMonthToDate>{ data($numDeclinedRetirementsMonthToDate) }</NumDeclinedRetirementsMonthToDate>
					}
					{
						for $numDeclinedRetirementsYearToDate in $embosserInquiryL8V6/AZXCIO-CASH-DECLINE-YTD-NBR
						return
		            	<NumDeclinedRetirementsYearToDate>{ data($numDeclinedRetirementsYearToDate) }</NumDeclinedRetirementsYearToDate>
					}
					{
						for $amountDeclinedRetirementsToday in $embosserInquiryL8V6/AZXCIO-CASH-DECLINE-TODAY-AMT
						return
		            	<AmountDeclinedRetirementsToday>{ data($amountDeclinedRetirementsToday) }</AmountDeclinedRetirementsToday>
					}
					{
					for $amountDeclinedRetirementsMonthToDate in $embosserInquiryL8V6/AZXCIO-CASH-DECLINE-MTD-AMT
					return
	            	<AmountDeclinedWithdrawalsMonthToDate>{ data($amountDeclinedRetirementsMonthToDate) }</AmountDeclinedWithdrawalsMonthToDate>
					}
					{
						for $amountDeclinedRetirementsYearToDate in $embosserInquiryL8V6/AZXCIO-CASH-DECLINE-YTD-AMT
						return
		            	<AmountDeclinedRetirementsYearToDate>{ data($amountDeclinedRetirementsYearToDate) }</AmountDeclinedRetirementsYearToDate>
					}
					{
						for $numPurchasesAppliedToday in $embosserInquiryL8V6/AZXCIO-RETAIL-POSTED-TODAY-NBR
						return
		            	<NumPurchasesAppliedToday>{ data($numPurchasesAppliedToday) }</NumPurchasesAppliedToday>
					}
					{
						for $numPurchasesAppliedMonthToDate in $embosserInquiryL8V6/AZXCIO-RETAIL-POSTED-MTD-NBR
						return
		            	<NumPurchasesAppliedMonthToDate>{ data($numPurchasesAppliedMonthToDate) }</NumPurchasesAppliedMonthToDate>
					}
					{
						for $numPurchasesAppliedYearToDate in $embosserInquiryL8V6/AZXCIO-RETAIL-POSTED-YTD-NBR
						return
		            	<NumPurchasesAppliedYearToDate>{ data($numPurchasesAppliedYearToDate) }</NumPurchasesAppliedYearToDate>
					}
					{
						for $amountAppliedPurchasesToday in $embosserInquiryL8V6/AZXCIO-RETAIL-POSTED-TODAY-AMT
						return
		            	<AmountAppliedPurchasesToday>{ data($amountAppliedPurchasesToday) }</AmountAppliedPurchasesToday>
					}
					{
						for $amountAppliedPurchasesMonthToDate in $embosserInquiryL8V6/AZXCIO-RETAIL-POSTED-MTD-AMT
						return
		            	<AmountAppliedPurchasesMonthToDate>{ data($amountAppliedPurchasesMonthToDate) }</AmountAppliedPurchasesMonthToDate>
					}
					{
						for $amountAppliedPurchasesYearToDate in $embosserInquiryL8V6/AZXCIO-RETAIL-POSTED-YTD-AMT
						return
		            	<AmountAppliedPurchasesYearToDate>{ data($amountAppliedPurchasesYearToDate) }</AmountAppliedPurchasesYearToDate>
					}
					{
						for $numPurchasesDeclinedToday in $embosserInquiryL8V6/AZXCIO-RETAIL-DECLINE-TODAY-NBR
						return
		            	<NumPurchasesDeclinedToday>{ data($numPurchasesDeclinedToday) }</NumPurchasesDeclinedToday>
					}
					{
						for $numPurchasesDeclinedMonthToDate in $embosserInquiryL8V6/AZXCIO-RETAIL-DECLINE-MTD-NBR
						return
		            	<NumPurchasesDeclinedMonthToDate>{ data($numPurchasesDeclinedMonthToDate) }</NumPurchasesDeclinedMonthToDate>
					}
					{
						for $numPurchasesDeclinedYearToDate in $embosserInquiryL8V6/AZXCIO-RETAIL-DECLINE-YTD-NBR
						return
		            	<NumPurchasesDeclinedYearToDate>{ data($numPurchasesDeclinedYearToDate) }</NumPurchasesDeclinedYearToDate>
					}
					{
						for $amountPurchasesDeclinedToday in $embosserInquiryL8V6/AZXCIO-RETAIL-DECLINE-TODAY-AMT
						return
		            	<AmountPurchasesDeclinedToday>{ data($amountPurchasesDeclinedToday) }</AmountPurchasesDeclinedToday>
					}
					{
						for $amountPurchasesDeclinedMonthToDate in $embosserInquiryL8V6/AZXCIO-RETAIL-DECLINE-MTD-AMT
						return
		            	<AmountPurchasesDeclinedMonthToDate>{ data($amountPurchasesDeclinedMonthToDate) }</AmountPurchasesDeclinedMonthToDate>
					}
					{
						for $amountPurchasesDeclinedYearToDate in $embosserInquiryL8V6/AZXCIO-RETAIL-DECLINE-YTD-AMT
						return
		            	<AmountPurchasesDeclinedYearToDate>{ data($amountPurchasesDeclinedYearToDate) }</AmountPurchasesDeclinedYearToDate>
					}
		        </CardCurrencyInformation>
		       )
		    )
        }
    </ns0:getCreditCardDetailsResponse>
};

declare variable $resultGroup as element(*)? external;
declare variable $ptEquivalencias as element()? external;
declare variable $datosCuenta as element(ns3:OutputParameters)? external;
declare variable $outputParameters1 as element(ns5:OutputParameters)? external;

local:consultaDatosTarjetaCreditoGTOut($resultGroup,
	$ptEquivalencias,
	$datosCuenta, $outputParameters1,$globalId)
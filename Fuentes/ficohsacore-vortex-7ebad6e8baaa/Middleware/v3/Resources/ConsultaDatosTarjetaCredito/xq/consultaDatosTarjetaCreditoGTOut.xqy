xquery version "2004-draft";
(:: pragma parameter="$resultGroup" type="xs:anyType" ::)
(:: pragma bea:global-element-return element="ns0:consultaDatosTarjetaCreditoResponse" location="../xsd/consultaDatosTarjetaCreditoTypes.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$embosserInquiryL8V6Response" element="ns1:EmbosserInquiryL8V6Response" location="../../../../v2/BusinessServices/VisionPlusGT/vmx/wsdl/VMX.wsdl" ::)
(:: pragma bea:local-element-parameter parameter="$ptEquivalencias" type="ns2:OutputParameters/ns2:PT_EQUIVALENCIAS" location="../../../../v2/BusinessServices/MDW/consultaEquivalenciasCatalogos/xsd/consultaEquivalenciasCatalogos_sp.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$datosCuenta" element="ns3:OutputParameters" location="../../../../v2/BusinessServices/MasterData/conDatoTarjeta/xsd/conDatoTarjeta_sp.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$outputParameters1" element="ns5:OutputParameters" location="../../../BusinessServices/consultaDatosTC/xsd/consultaDatosTC_sp.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v3/Resources/ConsultaDatosTarjetaCredito/xq/consultaDatosTarjetaCreditoGTOut/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaDatosTarjetaCreditoTypes";
declare namespace ns1 = "http://www.procesa.com/fdcs";
declare namespace ns2 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaEquivalenciasCatalogos";
declare namespace ns3 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/conDatoTarjeta";
declare namespace ns5 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaDatosTC";

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

declare function xf:consultaDatosTarjetaCreditoGTOut($resultGroup as element(*)?,
	$ptEquivalencias as element()?,
	$datosCuenta as element(ns3:OutputParameters)?,
	$outputParameters1 as element(ns5:OutputParameters)?)
as element(ns0:consultaDatosTarjetaCreditoResponse) {
	let $embosserInquiryL8V6 := $resultGroup/EMBOSSER_INQUIRY_RESPONSES/ns1:EmbosserInquiryL8V6Response[1]
	let $datoCuenta := $datosCuenta/ns3:RowSet/ns3:Row[1]
	return
    <ns0:consultaDatosTarjetaCreditoResponse>
    {
    	if(not(empty($outputParameters1/ns5:PT_DATOS_TARJETA/ns5:PT_DATOS_TARJETA_ITEM))) then (
           		for $CARD_NUMBER in $outputParameters1/ns5:PT_DATOS_TARJETA/ns5:PT_DATOS_TARJETA_ITEM[1]/ns5:CARD_NUMBER
                return
                <CARD_NUMBER>{ data($CARD_NUMBER) }</CARD_NUMBER>,

                for $DUAL_INDICATOR in $outputParameters1/ns5:PT_DATOS_TARJETA/ns5:PT_DATOS_TARJETA_ITEM[1]/ns5:DUAL_INDICATOR
                return
                    <DUAL_INDICATOR>{ data($DUAL_INDICATOR) }</DUAL_INDICATOR>,

                for $ACCOUNT_NUMBER in $outputParameters1/ns5:PT_DATOS_TARJETA/ns5:PT_DATOS_TARJETA_ITEM[1]/ns5:ACCOUNT_NUMBER
                return
                    <ACCOUNT_NUMBER>{ data($ACCOUNT_NUMBER) }</ACCOUNT_NUMBER>,

                for $CARD_HOLDER_NAME in $outputParameters1/ns5:PT_DATOS_TARJETA/ns5:PT_DATOS_TARJETA_ITEM[1]/ns5:CARD_HOLDER_NAME
                return
                    <CARD_HOLDER_NAME>{ data($CARD_HOLDER_NAME) }</CARD_HOLDER_NAME>,

                for $ACCOUNT_HOLDER_NAME in $outputParameters1/ns5:PT_DATOS_TARJETA/ns5:PT_DATOS_TARJETA_ITEM[1]/ns5:ACCOUNT_HOLDER_NAME
                return
                    <ACCOUNT_HOLDER_NAME>{ data($ACCOUNT_HOLDER_NAME) }</ACCOUNT_HOLDER_NAME>,

                for $CARD_HOLDER_LEGAL_ID in $outputParameters1/ns5:PT_DATOS_TARJETA/ns5:PT_DATOS_TARJETA_ITEM[1]/ns5:CARD_HOLDER_LEGAL_ID
                return
                    <CARD_HOLDER_LEGAL_ID>{ data($CARD_HOLDER_LEGAL_ID) }</CARD_HOLDER_LEGAL_ID>,

                for $ACCOUNT_HOLDER_LEGAL_ID in $outputParameters1/ns5:PT_DATOS_TARJETA/ns5:PT_DATOS_TARJETA_ITEM[1]/ns5:ACCOUNT_HOLDER_LEGAL_ID
                return
                    <ACCOUNT_HOLDER_LEGAL_ID>{ data($ACCOUNT_HOLDER_LEGAL_ID) }</ACCOUNT_HOLDER_LEGAL_ID>,

                for $CUSTOMER_ID in $outputParameters1/ns5:PT_DATOS_TARJETA/ns5:PT_DATOS_TARJETA_ITEM[1]/ns5:CUSTOMER_ID
                return
                    <CUSTOMER_ID>{ data($CUSTOMER_ID) }</CUSTOMER_ID>,

                for $ACCOUNT_STATUS in $outputParameters1/ns5:PT_DATOS_TARJETA/ns5:PT_DATOS_TARJETA_ITEM[1]/ns5:ACCOUNT_STATUS
                return
                    <ACCOUNT_STATUS>{ data($ACCOUNT_STATUS) }</ACCOUNT_STATUS>,

                for $CARD_TYPE in $outputParameters1/ns5:PT_DATOS_TARJETA/ns5:PT_DATOS_TARJETA_ITEM[1]/ns5:CARD_TYPE
                return
                    <CARD_TYPE>{ data($CARD_TYPE) }</CARD_TYPE>,

                for $AFINITY_GROUP in $outputParameters1/ns5:PT_DATOS_TARJETA/ns5:PT_DATOS_TARJETA_ITEM[1]/ns5:AFINITY_GROUP
                return
					<AFINITY_GROUP>{data($AFINITY_GROUP)}</AFINITY_GROUP>,
                for $PT_DATOS_TARJETA_ITEM in $outputParameters1/ns5:PT_DATOS_TARJETA/ns5:PT_DATOS_TARJETA_ITEM
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
			for $cardNumber in $embosserInquiryL8V6/AZXCIO-CARD
			return
        	<CARD_NUMBER>{ data($cardNumber) }</CARD_NUMBER>,
			for $dualIndicator in $embosserInquiryL8V6/AZXCIO-DUAL-IND
			return
        	<DUAL_INDICATOR>{ data($dualIndicator) }</DUAL_INDICATOR>,
	        <ACCOUNT_NUMBER>{ $datoCuenta/ns3:Column[@name='numcuenta']/text() }</ACCOUNT_NUMBER>,
			for $cardHolderName in $embosserInquiryL8V6/AZXCIO-EMBOSSED-NAME-1
			return
        		<CARD_HOLDER_NAME>{ data($cardHolderName) }</CARD_HOLDER_NAME>,
	        <ACCOUNT_HOLDER_NAME>{ $datoCuenta/ns3:Column[@name='account_name']/text() }</ACCOUNT_HOLDER_NAME>,
	        <CARD_HOLDER_LEGAL_ID>{ $datoCuenta/ns3:Column[@name='card_holder_id']/text() }</CARD_HOLDER_LEGAL_ID>,
	        <ACCOUNT_HOLDER_LEGAL_ID>{ $datoCuenta/ns3:Column[@name='account_holder_legal_id']/text() }</ACCOUNT_HOLDER_LEGAL_ID>,
	        <CUSTOMER_ID>{ $datoCuenta/ns3:Column[@name='customer_id']/text() }</CUSTOMER_ID>,
	        <ACCOUNT_STATUS>{ $datoCuenta/ns3:Column[@name='estatus']/text() }</ACCOUNT_STATUS>,
			for $cardType in $embosserInquiryL8V6/AZXCIO-CARDHOLDER-TYPE
			return
        		<CARD_TYPE>{ data($cardType) }</CARD_TYPE>,
	        <AFINITY_GROUP>{ $datoCuenta/ns3:Column[@name='logo']/text() }</AFINITY_GROUP>,
	      
        	for $orgItem in $datosCuenta/ns3:RowSet/ns3:Row
			let $org := data($orgItem/ns3:Column[@name = 'org'])
			let $embosserInquiryL8V6 := $resultGroup/EMBOSSER_INQUIRY_RESPONSES/ns1:EmbosserInquiryL8V6Response[AZXCIO-ORG = $org]
			return(
		        <CARD_CURRENCY_INFORMATION>
		        	{
						for $orgInd in $orgItem/ns3:Column[@name = 'TipoOrg']
						return
						<ORG_IND>{ data($orgInd) }</ORG_IND>
		        	}
					{
						if(string($org) != '') then (
							<ORG>{ $org }</ORG>
						) else()
					}
					{
						for $currency in $orgItem/ns3:Column[@name = 'CodMoneda']
						return
						<CURRENCY>{ data($currency) }</CURRENCY>
					}
					{
						for $anualPurchaseLimit in $embosserInquiryL8V6/AZXCIO-RETAIL-AMOUNT-YTD
						return
						<ANUAL_PURCHASE_LIMIT>{ data($anualPurchaseLimit) }</ANUAL_PURCHASE_LIMIT>
					}
					{
						for $anualWithDrawalLimit in $embosserInquiryL8V6/AZXCIO-CASH-AMOUNT-YTD
						return
						<ANUAL_WITHDRAWAL_LIMIT>{ data($anualWithDrawalLimit) }</ANUAL_WITHDRAWAL_LIMIT>
					}
					{
						for $monthlyPurchaseLimit in $embosserInquiryL8V6/AZXCIO-RETAIL-AMOUNT-MTD
						return
						<MONTHLY_PURCHASE_LIMIT>{ data($monthlyPurchaseLimit) }</MONTHLY_PURCHASE_LIMIT>
					}
					{
						for $monthlyWithDrawalLimit in $embosserInquiryL8V6/AZXCIO-CASH-AMOUNT-MTD
						return
						<MONTHLY_WITHDRAWAL_LIMIT>{ data($monthlyWithDrawalLimit) }</MONTHLY_WITHDRAWAL_LIMIT>
					}
					{
						for $dailyPurchaseLimit in string($embosserInquiryL8V6/AZXCIO-RETAIL-AMOUNT-DAILY/text())
						return
						if(fn-bea:trim($dailyPurchaseLimit) != "") then (
							<DAILY_PURCHASE_LIMIT>{ $dailyPurchaseLimit }</DAILY_PURCHASE_LIMIT>
						)else()
					}
					{
						for $dailyWithDrawalLimit in string($embosserInquiryL8V6/AZXCIO-CASH-AMOUNT-DAILY/text())
						return
						if(fn-bea:trim($dailyWithDrawalLimit) != "") then (
							<DAILY_WITHDRAWAL_LIMIT>{ $dailyWithDrawalLimit }</DAILY_WITHDRAWAL_LIMIT>
						)else()
					}
					{
						for $cardActivationDate in string($embosserInquiryL8V6/AZXCIO-CARD-ACTIVATED-DATE/text())
						return
						if(fn-bea:trim($cardActivationDate) != "") then (
							<CARD_ACTIVATION_DATE>{ $cardActivationDate }</CARD_ACTIVATION_DATE>
						)else()
					}
					{
						for $cardStatus in $embosserInquiryL8V6/AZXCIO-CURR-CRD-ACT
			 			return
			 				<CARD_STATUS>
			 				{
			 					valorCatalogoAPPToOSB(string($cardStatus/text()), 'VISION+GT', '13', $ptEquivalencias)
			 				}
			 				</CARD_STATUS>
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
						for $currentPlasticAction in $embosserInquiryL8V6/AZXCIO-CARD-ACTION
						return
		            	<CURRENT_PLASTIC_ACTION>{ data($currentPlasticAction) }</CURRENT_PLASTIC_ACTION>
					}
					{
						for $currentPlasticAction in $embosserInquiryL8V6/AZXCIO-LAST-CARD-ACTION
						return
		            	<LAST_ACTION_PLASTIC>{ data($currentPlasticAction) }</LAST_ACTION_PLASTIC>
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
							elseif(fn:string-length($percentageMonthlyPurchaseLimit) = 6)then(
							<PERCENTAGE_MONTHLY_PURCHASE_LIMIT>{ fn:substring(data($percentageMonthlyPurchaseLimit), 1, 1) }</PERCENTAGE_MONTHLY_PURCHASE_LIMIT>																	
							)						
						else(
							<PERCENTAGE_MONTHLY_PURCHASE_LIMIT>{ fn:substring(data($percentageMonthlyPurchaseLimit), 1, 2) }</PERCENTAGE_MONTHLY_PURCHASE_LIMIT>											
						)					
					}
					{
						for $annualPurchaseLimitPercentage in $embosserInquiryL8V6/AZXCIO-RETAIL-PERCENT-YTD
						return
		            	<ANNUAL_PURCHASE_LIMIT_PERCENTAGE>{ data($annualPurchaseLimitPercentage) }</ANNUAL_PURCHASE_LIMIT_PERCENTAGE>
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
							)
							elseif(fn:string-length($monthlyWithdrawalLimitPercentage) = 6)then(
							<MONTHLY_WITHDRAWAL_LIMIT_PERCENTAGE>{ fn:substring(data($monthlyWithdrawalLimitPercentage), 1, 1) }</MONTHLY_WITHDRAWAL_LIMIT_PERCENTAGE>																	
							)							
							else(
		            			<MONTHLY_WITHDRAWAL_LIMIT_PERCENTAGE>{ fn:substring(data($monthlyWithdrawalLimitPercentage), 1, 2) }</MONTHLY_WITHDRAWAL_LIMIT_PERCENTAGE>					            								
							)				
																
					}
					{
						for $annualRetirementLimitPercentage in $embosserInquiryL8V6/AZXCIO-CASH-PERCENT-YTD
						return
		            	<ANNUAL_RETIREMENT_LIMIT_PERCENTAGE>{ data($annualRetirementLimitPercentage) }</ANNUAL_RETIREMENT_LIMIT_PERCENTAGE>
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
						for $amountInWithdrawalsAppliedMonthToDate in $embosserInquiryL8V6/AZXCIO-CASH-POSTED-MTD-AMT
						return
		            	<AMOUNT_WITHDRAWALS_APPLIED_MONTH_TO_DATE>{ data($amountInWithdrawalsAppliedMonthToDate) }</AMOUNT_WITHDRAWALS_APPLIED_MONTH_TO_DATE>
					}
					{
						for $amountInWithdrawalsAppliedYearToDate in $embosserInquiryL8V6/AZXCIO-CASH-POSTED-YTD-AMT
						return
		            	<AMOUNT_WITHDRAWALS_APPLIED_YEAR_TO_DATE>{ data($amountInWithdrawalsAppliedYearToDate) }</AMOUNT_WITHDRAWALS_APPLIED_YEAR_TO_DATE>
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
					for $amountDeclinedRetirementsMonthToDate in $embosserInquiryL8V6/AZXCIO-CASH-DECLINE-MTD-AMT
					return
	            	<AMOUNT_DECLINED_WITHDRAWALS_MONTH_TO_DATE>{ data($amountDeclinedRetirementsMonthToDate) }</AMOUNT_DECLINED_WITHDRAWALS_MONTH_TO_DATE>
					}
					{
						for $amountDeclinedRetirementsYearToDate in $embosserInquiryL8V6/AZXCIO-CASH-DECLINE-YTD-AMT
						return
		            	<AMOUNT_DECLINED_RETIREMENTS_YEAR_TO_DATE>{ data($amountDeclinedRetirementsYearToDate) }</AMOUNT_DECLINED_RETIREMENTS_YEAR_TO_DATE>
					}
					{
						for $numPurchasesAppliedToday in $embosserInquiryL8V6/AZXCIO-RETAIL-POSTED-TODAY-NBR
						return
		            	<NUM_PURCHASES_APPLIED_TODAY>{ data($numPurchasesAppliedToday) }</NUM_PURCHASES_APPLIED_TODAY>
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
						for $amountAppliedPurchasesToday in $embosserInquiryL8V6/AZXCIO-RETAIL-POSTED-TODAY-AMT
						return
		            	<AMOUNT_APPLIED_PURCHASES_TODAY>{ data($amountAppliedPurchasesToday) }</AMOUNT_APPLIED_PURCHASES_TODAY>
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
		        </CARD_CURRENCY_INFORMATION>
		       )
		    )
        }
    </ns0:consultaDatosTarjetaCreditoResponse>
};

declare variable $resultGroup as element(*)? external;
declare variable $ptEquivalencias as element()? external;
declare variable $datosCuenta as element(ns3:OutputParameters)? external;
declare variable $outputParameters1 as element(ns5:OutputParameters)? external;

xf:consultaDatosTarjetaCreditoGTOut($resultGroup,
	$ptEquivalencias,
	$datosCuenta, $outputParameters1)
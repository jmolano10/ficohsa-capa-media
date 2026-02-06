xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaListasClienteResponse" element="ns3:consultaListasClienteResponse" location="../../../BusinessServices/consultaListasCliente/xsd/consultaListasClienteTypes.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultaOfertaCreditoConsumoResponse" element="ns1:consultaOfertaCreditoConsumoResponse" location="../../ConsultaOfertaCreditoConsumo/xsd/consultaOfertaCreditoConsumoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:originacionCreditoResponse" location="../../OriginacionCredito/xsd/originacionCreditoTypes.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaOfertaCreditoConsumoTypes";
declare namespace ns3 = "http://www.ficohsa.com.hn/middleware.services/consultaListasClienteTypes";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/originacionCreditoTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/OriginacionCreditoGT/xq/originacionCreditoGTOut/";

declare function xf:originacionCreditoGTOut($consultaListasClienteResponse as element(ns3:consultaListasClienteResponse),
    $consultaOfertaCreditoConsumoResponse as element(ns1:consultaOfertaCreditoConsumoResponse))
    as element(ns0:originacionCreditoResponse) {
        <ns0:originacionCreditoResponse>
        	{
        		for $EVALUATION_DATE in $consultaOfertaCreditoConsumoResponse/DATE
        		return
        		<EVALUATION_DATE>{ data($EVALUATION_DATE) }</EVALUATION_DATE>
        	}
            {
                for $CASE_ID in $consultaOfertaCreditoConsumoResponse/CASE_ID
                return
                    <CASE_ID>{ data($CASE_ID) }</CASE_ID>
            }
            {
                for $GENERAL_RCI in $consultaOfertaCreditoConsumoResponse/GENERAL_RCI
                return
                    <GENERAL_RCI>{ data($GENERAL_RCI) }</GENERAL_RCI>
            }
            {
                for $GENERAL_RCI_MAX in $consultaOfertaCreditoConsumoResponse/GENERAL_RCI_MAX
                return
                    <GENERAL_RCI_MAX>{ data($GENERAL_RCI_MAX) }</GENERAL_RCI_MAX>
            }
            {
                for $GENERAL_CURRENT_NDE in $consultaOfertaCreditoConsumoResponse/GENERAL_CURRENT_NDE
                return
                    <GENERAL_CURRENT_NDE>{ data($GENERAL_CURRENT_NDE) }</GENERAL_CURRENT_NDE>
            }
            {
                for $GENERAL_FINAL_NDE in $consultaOfertaCreditoConsumoResponse/GENERAL_FINAL_NDE
                return
                    <GENERAL_FINAL_NDE>{ data($GENERAL_FINAL_NDE) }</GENERAL_FINAL_NDE>
            }
            {
            	for $CREDIT_CARD_SCORE in $consultaOfertaCreditoConsumoResponse/CREDIT_CARD_SCORE
            	return
            	<CREDIT_CARD_SCORE>{ data($CREDIT_CARD_SCORE) }</CREDIT_CARD_SCORE>
            }
            {
                for $SCORE_STRATEGY in $consultaOfertaCreditoConsumoResponse/SCORE_STRATEGY
                return
                    <SCORE_STRATEGY>{ data($SCORE_STRATEGY) }</SCORE_STRATEGY>
            }
            {
                for $SCORE_TYPE in $consultaOfertaCreditoConsumoResponse/SCORE_TYPE
                return
                    <SCORE_TYPE>{ data($SCORE_TYPE) }</SCORE_TYPE>
            }
            {
                for $INTERNAL_SCORE in $consultaOfertaCreditoConsumoResponse/INTERNAL_SCORE
                return
                    <INTERNAL_SCORE>{ data($INTERNAL_SCORE) }</INTERNAL_SCORE>
            }
            {
                for $CREDIT_CARD_RISK_LEVEL in $consultaOfertaCreditoConsumoResponse/CREDIT_CARD_RISK_LEVEL
                return
                    <CREDIT_CARD_RISK_LEVEL>{ data($CREDIT_CARD_RISK_LEVEL) }</CREDIT_CARD_RISK_LEVEL>
            }
            {
                for $INTERNAL_RISK_LEVEL in $consultaOfertaCreditoConsumoResponse/INTERNAL_RISK_LEVEL
                return
                    <INTERNAL_RISK_LEVEL>{ data($INTERNAL_RISK_LEVEL) }</INTERNAL_RISK_LEVEL>
            }
            {
                for $EXTERNAL_RISK_LEVEL in $consultaOfertaCreditoConsumoResponse/EXTERNAL_RISK_LEVEL
                return
                    <EXTERNAL_RISK_LEVEL>{ data($EXTERNAL_RISK_LEVEL) }</EXTERNAL_RISK_LEVEL>
            }
            {
                for $CUSTOMER_SEGMENT in $consultaOfertaCreditoConsumoResponse/CUSTOMER_SEGMENT
                return
                    <CUSTOMER_SEGMENT>{ data($CUSTOMER_SEGMENT) }</CUSTOMER_SEGMENT>
            }
            {
                for $CUSTOMER_SUBSEGMENT in $consultaOfertaCreditoConsumoResponse/CUSTOMER_SUBSEGMENT
                return
                    <CUSTOMER_SUB_SEGMENT>{ data($CUSTOMER_SUBSEGMENT) }</CUSTOMER_SUB_SEGMENT>
            }
            {
                for $CUSTOMER_SALARY_SEGMENT in $consultaOfertaCreditoConsumoResponse/CUSTOMER_SALARY_SEGMENT
                return
                    <CUSTOMER_SALARY_SEGMENT>{ data($CUSTOMER_SALARY_SEGMENT) }</CUSTOMER_SALARY_SEGMENT>
            }
            {
            	for $CURRENT_EXPOSURE in $consultaOfertaCreditoConsumoResponse/CURRENT_EXPOSURE
            	return
            	<CURRENT_EXPOSURE>{ data($CURRENT_EXPOSURE) }</CURRENT_EXPOSURE>
            }
            {
            	for $GLOBAL_EXPOSURE_LOCAL_CCY in $consultaOfertaCreditoConsumoResponse/GLOBAL_EXPOSURE_LOCAL_CCY
            	return
            	<GLOBAL_EXPOSURE_LOCAL_CCY>{ data($GLOBAL_EXPOSURE_LOCAL_CCY) }</GLOBAL_EXPOSURE_LOCAL_CCY>
            }
            {
            	for $GLOBAL_EXPOSURE_FOREIGN_CCY in $consultaOfertaCreditoConsumoResponse/GLOBAL_EXPOSURE_FOREIGN_CCY
            	return
            	<GLOBAL_EXPOSURE_FOREIGN_CCY>{ data($GLOBAL_EXPOSURE_FOREIGN_CCY) }</GLOBAL_EXPOSURE_FOREIGN_CCY>
            }
            {
            	for $CREDIT_CARD_OVERDRAFT in $consultaOfertaCreditoConsumoResponse/CREDIT_CARD_OVERDRAFT
            	return
            	<CREDIT_CARD_OVERDRAFT>{ data($CREDIT_CARD_OVERDRAFT) }</CREDIT_CARD_OVERDRAFT>
            }
            {
            	for $CREDIT_REFERENCES in $consultaOfertaCreditoConsumoResponse/CREDIT_REFERENCES
            	return
            	<CREDIT_REFERENCES>{ data($CREDIT_REFERENCES) }</CREDIT_REFERENCES>
            }
            {
            	for $ACTIVE_DIRECT_CREDITS in $consultaOfertaCreditoConsumoResponse/ACTIVE_DIRECT_CREDITS
            	return
            	<ACTIVE_DIRECT_CREDITS>{ data($ACTIVE_DIRECT_CREDITS) }</ACTIVE_DIRECT_CREDITS>
            }
            {
            	for $CANCELED_DIRECT_CREDITS in $consultaOfertaCreditoConsumoResponse/CANCELED_DIRECT_CREDITS
            	return
            	<CANCELED_DIRECT_CREDITS>{ data($CANCELED_DIRECT_CREDITS) }</CANCELED_DIRECT_CREDITS>
            }
            {
            	for $ACTIVE_INDIRECT_CREDITS in $consultaOfertaCreditoConsumoResponse/ACTIVE_INDIRECT_CREDITS
            	return
            	<ACTIVE_INDIRECT_CREDITS>{ data($ACTIVE_INDIRECT_CREDITS) }</ACTIVE_INDIRECT_CREDITS>
            }
            {
            	for $CANCELED_INDIRECT_CREDITS in $consultaOfertaCreditoConsumoResponse/CANCELED_INDIRECT_CREDITS
            	return
            	<CANCELED_INDIRECT_CREDITS>{ data($CANCELED_INDIRECT_CREDITS) }</CANCELED_INDIRECT_CREDITS>
            }
            {
            	for $INTERNAL_LOAN_REFERENCES in $consultaOfertaCreditoConsumoResponse/INTERNAL_LOAN_REFERENCES
            	return
            	<INTERNAL_LOAN_REFERENCES>{ data($INTERNAL_LOAN_REFERENCES) }</INTERNAL_LOAN_REFERENCES>
            }
            {
            	for $REWRITE_REFERENCES in $consultaOfertaCreditoConsumoResponse/REWRITE_REFERENCES
            	return
            	<REWRITE_REFERENCES>{ data($REWRITE_REFERENCES) }</REWRITE_REFERENCES>
            }
            {
            	for $TOTAL_EXTRA in $consultaOfertaCreditoConsumoResponse/TOTAL_EXTRA
            	return
            	<TOTAL_EXTRA>{ data($TOTAL_EXTRA) }</TOTAL_EXTRA>
            }
            {
            	for $TOTAL_RISK in $consultaOfertaCreditoConsumoResponse/TOTAL_RISK
            	return
            	<TOTAL_RISK>{ data($TOTAL_RISK) }</TOTAL_RISK>
            }
            {
            	for $CURRENT_ARREAR in $consultaOfertaCreditoConsumoResponse/CURRENT_ARREAR
            	return
            	<CURRENT_ARREAR>{ data($CURRENT_ARREAR) }</CURRENT_ARREAR>
            }
            {
            	for $CURRENT_ARREAR_BALANCE in $consultaOfertaCreditoConsumoResponse/CURRENT_ARREAR_BALANCE
            	return
            	<CURRENT_ARREAR_BALANCE>{ data($CURRENT_ARREAR_BALANCE) }</CURRENT_ARREAR_BALANCE>
            }
            {
            	for $CREDIT_EXPERIENCE in $consultaOfertaCreditoConsumoResponse/CREDIT_EXPERIENCE
            	return
            	<CREDIT_EXPERIENCE>{ data($CREDIT_EXPERIENCE) }</CREDIT_EXPERIENCE>
            }
            {
            	for $ARREAR_ON_30_DAYS_FOR_3_MONTHS in $consultaOfertaCreditoConsumoResponse/ARREAR_ON_30DAYS_FOR_3MONTHS
            	return
            	<ARREAR_ON_30_DAYS_FOR_3_MONTHS>{ data($ARREAR_ON_30_DAYS_FOR_3_MONTHS) }</ARREAR_ON_30_DAYS_FOR_3_MONTHS>
            }
            {
            	for $ARREAR_ON_60_DAYS_FOR_6_MONTHS in $consultaOfertaCreditoConsumoResponse/ARREAR_ON_60DAYS_FOR_6MONTHS
            	return
            	<ARREAR_ON_60_DAYS_FOR_6_MONTHS>{ data($ARREAR_ON_60_DAYS_FOR_6_MONTHS) }</ARREAR_ON_60_DAYS_FOR_6_MONTHS>
            }
            {
            	for $ARREAR_ON_60_DAYS_FOR_12_MONTHS in $consultaOfertaCreditoConsumoResponse/ARREAR_ON_60DAYS_FOR_12MONTHS
            	return
            	<ARREAR_ON_60_DAYS_FOR_12_MONTHS>{ data($ARREAR_ON_60_DAYS_FOR_12_MONTHS) }</ARREAR_ON_60_DAYS_FOR_12_MONTHS>
            }
            {
            	for $ARREAR_ON_90_DAYS_FOR_12_MONTHS in $consultaOfertaCreditoConsumoResponse/ARREAR_ON_90DAYS_FOR_12MONTHS
            	return
            	<ARREAR_ON_90_DAYS_FOR_12_MONTHS>{ data($ARREAR_ON_90_DAYS_FOR_12_MONTHS) }</ARREAR_ON_90_DAYS_FOR_12_MONTHS>
            }
            {
            	for $ARREAR_ON_120_DAYS_FOR_18_MONTHS in $consultaOfertaCreditoConsumoResponse/ARREAR_ON_120DAYS_FOR_18MONTHS
            	return
            	<ARREAR_ON_120_DAYS_FOR_18_MONTHS>{ data($ARREAR_ON_120_DAYS_FOR_18_MONTHS) }</ARREAR_ON_120_DAYS_FOR_18_MONTHS>
            }
            {
            	for $TOTAL_DIRECT_DEBT in $consultaOfertaCreditoConsumoResponse/TOTAL_DIRECT_DEBT
            	return
            	<TOTAL_DIRECT_DEBT>{ data($TOTAL_DIRECT_DEBT) }</TOTAL_DIRECT_DEBT>
            }
            {
            	for $TOTAL_INDIRECT_DEBT in $consultaOfertaCreditoConsumoResponse/TOTAL_INDIRECT_DEBT
            	return
            	<TOTAL_INDIRECT_DEBT>{ data($TOTAL_INDIRECT_DEBT) }</TOTAL_INDIRECT_DEBT>
            }
            {
            	for $TOTAL_CONTINGENT_DEBT in $consultaOfertaCreditoConsumoResponse/TOTAL_CONTINGENT_DEBT
            	return
            	<TOTAL_CONTINGENT_DEBT>{ data($TOTAL_CONTINGENT_DEBT) }</TOTAL_CONTINGENT_DEBT>
            }
            {
            	for $CALCULATED_SALARY in $consultaOfertaCreditoConsumoResponse/CALCULATED_SALARY
            	return
            	<CALCULATED_SALARY>{ data($CALCULATED_SALARY) }</CALCULATED_SALARY>
            }
            {
            	for $DEBT_BURDEN_SALARY in $consultaOfertaCreditoConsumoResponse/DEBT_BURDEN_SALARY
            	return
            	<DEBT_BURDEN_SALARY>{ data($DEBT_BURDEN_SALARY) }</DEBT_BURDEN_SALARY>
            }
            {
            	for $BUREAU_INSTALLMENT in $consultaOfertaCreditoConsumoResponse/BUREAU_INSTALLMENT
            	return
            	<BUREAU_INSTALLMENT>{ data($BUREAU_INSTALLMENT) }</BUREAU_INSTALLMENT>
            }
            {
            	for $BUREAU_INSTALLMENT_EXTERNAL in $consultaOfertaCreditoConsumoResponse/BUREAU_INSTALLMENT_EXTERNAL
            	return
            	<BUREAU_INSTALLMENT_EXTERNAL>{ data($BUREAU_INSTALLMENT_EXTERNAL) }</BUREAU_INSTALLMENT_EXTERNAL>
            }
            {
            	for $TOTAL_BUREAU_INSTALLMENT in $consultaOfertaCreditoConsumoResponse/TOTAL_BUREAU_INSTALLMENT
            	return
            	<TOTAL_BUREAU_INSTALLMENT>{ data($TOTAL_BUREAU_INSTALLMENT) }</TOTAL_BUREAU_INSTALLMENT>
            }
            {
            	for $MAX_LIMIT_CREDICT_CARD in $consultaOfertaCreditoConsumoResponse/MAX_LIMIT_CREDIT_CARD
            	return
            	<MAX_LIMIT_CREDICT_CARD>{ data($MAX_LIMIT_CREDICT_CARD) }</MAX_LIMIT_CREDICT_CARD>
            }
            {
            	for $AVERAGE_LIMIT_CREDIT_CARD in $consultaOfertaCreditoConsumoResponse/AVERAGE_LIMIT_CREDIT_CARD
            	return
            	<AVERAGE_LIMIT_CREDIT_CARD>{ data($AVERAGE_LIMIT_CREDIT_CARD) }</AVERAGE_LIMIT_CREDIT_CARD>
            }
            {
            	for $CONSOLIDATE_BALANCE in $consultaOfertaCreditoConsumoResponse/CONSOLIDATE_BALANCE
            	return
            	<CONSOLIDATE_BALANCE>{ data($CONSOLIDATE_BALANCE) }</CONSOLIDATE_BALANCE>
            }
            {
                for $SIB_REFERENCE in $consultaOfertaCreditoConsumoResponse/SIB_REFERENCE
                return
                    <SIB_REFERENCE>{ data($SIB_REFERENCE) }</SIB_REFERENCE>
            }
            {
                for $REFERENCE in $consultaOfertaCreditoConsumoResponse/REFERENCE
                return
                    <REFERENCE>{ data($REFERENCE) }</REFERENCE>
            }
            {
                for $REFERENCE_TYPE in $consultaOfertaCreditoConsumoResponse/REFERENCE_TYPE
                return
                    <REFERENCE_TYPE>{ data($REFERENCE_TYPE) }</REFERENCE_TYPE>
            }
            {
                for $REFERENCE_ENTITY in $consultaOfertaCreditoConsumoResponse/REFERENCE_ENTITY
                return
                    <REFERENCE_ENTITY>{ data($REFERENCE_ENTITY) }</REFERENCE_ENTITY>
            }
            {
                for $REFERENCE_BALANCE in $consultaOfertaCreditoConsumoResponse/REFERENCE_BALANCE
                return
                    <REFERENCE_BALANCE>{ data($REFERENCE_BALANCE) }</REFERENCE_BALANCE>
            }
            {
                for $REFERENCE_OPENING_DATE in $consultaOfertaCreditoConsumoResponse/REFERENCE_OPENING_DATE
                return
                    <REFERENCE_OPENING_DATE>{ data($REFERENCE_OPENING_DATE) }</REFERENCE_OPENING_DATE>
            }
            {
            	if (fn:exists($consultaListasClienteResponse/ASSOCIATIONS_LIST/ASSOCIATION)) then (
            		<CUSTOMER_LIST>
            		{
            			for $ASSOCIATION in $consultaListasClienteResponse/ASSOCIATIONS_LIST/ASSOCIATION
            			return(
            				<ASSOCIATION>
            					<ASSOCIATION_NAME>{ data($ASSOCIATION/ASSOCIATION_NAME) }</ASSOCIATION_NAME>
            					<CUSTOMER_STATUS>{ data($ASSOCIATION/CUSTOMER_STATUS) }</CUSTOMER_STATUS>
            				</ASSOCIATION>
            			)
            		}
            		</CUSTOMER_LIST>
            	) else ()
            }
            {
            	if (fn:exists($consultaOfertaCreditoConsumoResponse/RESOLUTIONS/RESOLUTION)) then (
            		<RESOLUTIONS>
            		{
            			for $RESOLUTION in $consultaOfertaCreditoConsumoResponse/RESOLUTIONS/RESOLUTION
            			return(
            				<RESOLUTION>
            				{
            					for $RESOLUTION_ID in $RESOLUTION/RESOLUTION_ID
            					return
            					<RESOLUTION_ID>{ data($RESOLUTION_ID) }</RESOLUTION_ID>
            				}
            				{
            					for $RESOLUTION_DESCRIPTION in $RESOLUTION/RESOLUTION_DESCRIPTION
            					return
            					<RESOLUTION_DESCRIPTION>{ data($RESOLUTION_DESCRIPTION) }</RESOLUTION_DESCRIPTION>
            				}
            				</RESOLUTION>
            			)
            		}
            		</RESOLUTIONS>
            	) else ()
            }
            {
            	if (fn:exists($consultaOfertaCreditoConsumoResponse/RESOLUTION_OFFERS/OFFER)) then (
            		<OFFERS>
            		{
            			for $OFFER in $consultaOfertaCreditoConsumoResponse/RESOLUTION_OFFERS/OFFER
            			return(
            				<OFFER>
            				{
            					for $PRODUCT_CODE in $OFFER/PRODUCT_CODE
            					return
            					<PRODUCT_CODE>{ data($PRODUCT_CODE) }</PRODUCT_CODE>
            				}
            				{
            					for $RATE in $OFFER/RATE
            					return
            					<RATE>{ data($RATE) }</RATE>
            				}
            				{
            					for $INSTALLMENT in $OFFER/INSTALLMENT
            					return
            					<INSTALLMENT>{ data($INSTALLMENT) }</INSTALLMENT>
            				}
            				{
            					for $INSTALLMENT_NDE in $OFFER/INSTALLMENT_NDE
            					return
            					<INSTALLMENT_NDE>{ data($INSTALLMENT_NDE) }</INSTALLMENT_NDE>
            				}
            				{
            					for $INSTALLMENT_RCI_NONP2C in $OFFER/INSTALLMENT_RCI_NONP2C
            					return
            					<INSTALLMENT_RCI_NONP2C>{ data($INSTALLMENT_RCI_NONP2C) }</INSTALLMENT_RCI_NONP2C>
            				}
            				{
            					for $INSTALLMENT_RCI_P2C in $OFFER/INSTALLMENT_RCI_P2C
            					return
            					<INSTALLMENT_RCI_P2C>{ data($INSTALLMENT_RCI_P2C) }</INSTALLMENT_RCI_P2C>
            				}
            				{
            					for $FOR_12_MONTHS in $OFFER/FOR_12_MONTHS
            					return
            					<FOR_12_MONTHS>{ data($FOR_12_MONTHS) }</FOR_12_MONTHS>
            				}
            				{
            					for $FOR_18_MONTHS in $OFFER/FOR_18_MONTHS
            					return
            					<FOR_18_MONTHS>{ data($FOR_18_MONTHS) }</FOR_18_MONTHS>
            				}
            				{
            					for $FOR_24_MONTHS in $OFFER/FOR_24_MONTHS
            					return
            					<FOR_24_MONTHS>{ data($FOR_24_MONTHS) }</FOR_24_MONTHS>
            				}
            				{
            					for $FOR_36_MONTHS in $OFFER/FOR_36_MONTHS
            					return
            					<FOR_36_MONTHS>{ data($FOR_36_MONTHS) }</FOR_36_MONTHS>
            				}
            				{
            					for $FOR_48_MONTHS in $OFFER/FOR_48_MONTHS
            					return
            					<FOR_48_MONTHS>{ data($FOR_48_MONTHS) }</FOR_48_MONTHS>
            				}
            				{
            					for $FOR_60_MONTHS in $OFFER/FOR_60_MONTHS
            					return
            					<FOR_60_MONTHS>{ data($FOR_60_MONTHS) }</FOR_60_MONTHS>
            				}
            				{
            					for $FOR_72_MONTHS in $OFFER/FOR_72_MONTHS
            					return
            					<FOR_72_MONTHS>{ data($FOR_72_MONTHS) }</FOR_72_MONTHS>
            				}
            				{
            					for $FOR_84_MONTHS in $OFFER/FOR_84_MONTHS
            					return
            					<FOR_84_MONTHS>{ data($FOR_84_MONTHS) }</FOR_84_MONTHS>
            				}
            				{
            					for $FOR_96_MONTHS in $OFFER/FOR_96_MONTHS
            					return
            					<FOR_96_MONTHS>{ data($FOR_96_MONTHS) }</FOR_96_MONTHS>
            				}
            				{
            					for $FOR_108_MONTHS in $OFFER/FOR_108_MONTHS
            					return
            					<FOR_108_MONTHS>{ data($FOR_108_MONTHS) }</FOR_108_MONTHS>
            				}
            				{
            					for $FOR_120_MONTHS in $OFFER/FOR_120_MONTHS
            					return
            					<FOR_120_MONTHS>{ data($FOR_120_MONTHS) }</FOR_120_MONTHS>
            				}
            				{
            					for $FOR_MAX_AMOUNT in $OFFER/FOR_MAX_AMOUNT
            					return
            					<FOR_MAX_AMOUNT>{ data($FOR_MAX_AMOUNT) }</FOR_MAX_AMOUNT>
            				}
            				{
            					for $MEG_OFFER in $OFFER/MEG_OFFER
            					return
            					<MEG_OFFER>{ data($MEG_OFFER) }</MEG_OFFER>
            				}
            				{
            					for $MAX_OFFER in $OFFER/MAX_OFFER
            					return
            					<MAX_OFFER>{ data($MAX_OFFER) }</MAX_OFFER>
            				}
            				{
            					for $NDE_OFFER in $OFFER/NDE_OFFER
            					return
            					<NDE_OFFER>{ data($NDE_OFFER) }</NDE_OFFER>
            				}
            				{
            					for $NONP2C_OFFER in $OFFER/NONP2C_OFFER
            					return
            					<NONP2C_OFFER>{ data($NONP2C_OFFER) }</NONP2C_OFFER>
            				}
            				{
            					for $P2C_OFFER in $OFFER/P2C_OFFER
            					return
            					<P2C_OFFER>{ data($P2C_OFFER) }</P2C_OFFER>
            				}
            				{
            					for $RCI_OFFER in $OFFER/RCI_OFFER
            					return
            					<RCI_OFFER>{ data($RCI_OFFER) }</RCI_OFFER>
            				}
            				{
            					for $TIMESINCOME_OFFER in $OFFER/TIMESINCOME_OFFER
            					return
            					<TIMESINCOME_OFFER>{ data($TIMESINCOME_OFFER) }</TIMESINCOME_OFFER>
            				}
            				{
            					for $RCI in $OFFER/RCI
            					return
            					<RCI>{ data($RCI) }</RCI>
            				}
            				{
            					for $TIMESINCOME in $OFFER/TIMESINCOME
            					return
            					<TIMESINCOME>{ data($TIMESINCOME) }</TIMESINCOME>
            				}
                			</OFFER>
            			)
            		}
            		</OFFERS>
            	) else ()
            }
            {
            	if (fn:exists($consultaOfertaCreditoConsumoResponse/FOR_CONSOLIDATE/FOR_CONSOLIDATE)) then (
            		<FOR_CONSOLIDATE>
            		{
            			for $REFERENCE in $consultaOfertaCreditoConsumoResponse/FOR_CONSOLIDATE/FOR_CONSOLIDATE
            			return(
            				<REFERENCE>
            				{
            					for $REFERENCE_TYPE in $REFERENCE/REFERENCE_TYPE
            					return
            					<REFERENCE_TYPE>{ data($REFERENCE_TYPE) }</REFERENCE_TYPE>
            				}
            				{
            					for $REFERENCE_CURRENCY in $REFERENCE/REFERENCE_CURRENCY
            					return
            					<REFERENCE_CURRENCY>{ data($REFERENCE_CURRENCY) }</REFERENCE_CURRENCY>
            				}
            				{
            					for $REFERENCE_ENTITY in $REFERENCE/REFERENCE_ENTITY
            					return
            					<REFERENCE_ENTITY>{ data($REFERENCE_ENTITY) }</REFERENCE_ENTITY>
            				}
            				{
            					for $CHECK_BENEFECIARY in $REFERENCE/CHECK_BENEFECIARY
            					return
            					<CHECK_BENEFICIARY>{ data($CHECK_BENEFECIARY) }</CHECK_BENEFICIARY>
            				}
            				{
            					for $REFERENCE_ACCOUNT_NUMBER in $REFERENCE/REFERENCE_ACCOUNT_NUMBER
            					return
            					<REFERENCE_ACCOUNT_NUMBER>{ data($REFERENCE_ACCOUNT_NUMBER) }</REFERENCE_ACCOUNT_NUMBER>
            				}
            				{
            					for $REFERENCE_LIMIT_AMOUNT in $REFERENCE/REFERENCE_LIMIT_AMOUNT
            					return
            					<REFERENCE_LIMIT_AMOUNT>{ data($REFERENCE_LIMIT_AMOUNT) }</REFERENCE_LIMIT_AMOUNT>
            				}
            				{
            					for $REFERENCE_INSTALLMENT_AMOUNT in $REFERENCE/REFERENCE_INSTALLMENT_AMOUNT
            					return
            					<REFERENCE_INSTALLMENT_AMOUNT>{ data($REFERENCE_INSTALLMENT_AMOUNT) }</REFERENCE_INSTALLMENT_AMOUNT>
            				}
                			</REFERENCE>
            			)
            		}
            		</FOR_CONSOLIDATE>
            	) else ()
            }
        </ns0:originacionCreditoResponse>
};

declare variable $consultaListasClienteResponse as element(ns3:consultaListasClienteResponse) external;
declare variable $consultaOfertaCreditoConsumoResponse as element(ns1:consultaOfertaCreditoConsumoResponse) external;

xf:originacionCreditoGTOut($consultaListasClienteResponse,
    $consultaOfertaCreditoConsumoResponse)
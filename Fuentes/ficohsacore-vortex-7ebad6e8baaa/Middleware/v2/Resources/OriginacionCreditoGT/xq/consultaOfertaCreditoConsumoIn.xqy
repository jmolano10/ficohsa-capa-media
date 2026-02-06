xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$originacionCreditoRequest" element="ns1:originacionCreditoRequest" location="../../OriginacionCredito/xsd/originacionCreditoTypes.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultaConsolidadaRiesgoClienteResponse" element="ns2:consultaConsolidadaRiesgoClienteResponse" location="../../ConsultaConsolidadaRiesgoCliente/xsd/consultaConsolidadaRiesgoClienteTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultaOfertaCreditoConsumoRequest" location="../../ConsultaOfertaCreditoConsumo/xsd/consultaOfertaCreditoConsumoTypes.xsd" ::)

declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/consultaConsolidadaRiesgoClienteTypes";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/originacionCreditoTypes";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaOfertaCreditoConsumoTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/OriginacionCreditoGT/xq/consultaOfertaCreditoConsumoIn/";

declare function xf:consultaOfertaCreditoConsumoIn($originacionCreditoRequest as element(ns1:originacionCreditoRequest),
    $consultaConsolidadaRiesgoClienteResponse as element(ns2:consultaConsolidadaRiesgoClienteResponse))
    as element(ns0:consultaOfertaCreditoConsumoRequest) {
        <ns0:consultaOfertaCreditoConsumoRequest>
            <CASE_ID>{ data($originacionCreditoRequest/CASE_ID) }</CASE_ID>
            <CUSTOMER_INFO>
                <ID>{ data($consultaConsolidadaRiesgoClienteResponse/LOAN_MAINTENANCE/CUSTOMER_INFO[1]/ID) }</ID>
                <TARGET>{ data($consultaConsolidadaRiesgoClienteResponse/LOAN_MAINTENANCE/CUSTOMER_INFO[1]/TARGET) }</TARGET>
                <DATE_OF_BIRTH>{ data($consultaConsolidadaRiesgoClienteResponse/LOAN_MAINTENANCE/CUSTOMER_INFO[1]/DATE_OF_BIRTH) }</DATE_OF_BIRTH>
                <AGE>{ data($consultaConsolidadaRiesgoClienteResponse/LOAN_MAINTENANCE/CUSTOMER_INFO[1]/AGE) }</AGE>
                <GENDER>{ data($originacionCreditoRequest/GENDER) }</GENDER>
                <TYPE>{ data($consultaConsolidadaRiesgoClienteResponse/LOAN_MAINTENANCE/CUSTOMER_INFO[1]/TYPE) }</TYPE>
                <TOTAL_SALARY>{ data($consultaConsolidadaRiesgoClienteResponse/LOAN_MAINTENANCE/CUSTOMER_INFO[1]/SALARY) }</TOTAL_SALARY>
                <PAYROLL_SALARY>{ data($consultaConsolidadaRiesgoClienteResponse/LOAN_MAINTENANCE/CUSTOMER_INFO[1]/PAYROLL_SALARY) }</PAYROLL_SALARY>
                {
                    for $CREDIT_MONTHS in $consultaConsolidadaRiesgoClienteResponse/LOAN_MAINTENANCE/CUSTOMER_INFO[1]/CREDIT_MONTHS
                    return
                        <CREDIT_MONTHS>{ data($CREDIT_MONTHS) }</CREDIT_MONTHS>
                }
                {
                    for $FLAG_HIT in $consultaConsolidadaRiesgoClienteResponse/LOAN_MAINTENANCE/CUSTOMER_INFO[1]/FLAG_HIT
                    return
                        <FLAG_HIT>{ data($FLAG_HIT) }</FLAG_HIT>
                }
                {
                	for $EMPLOYMENT_START_DATE in $originacionCreditoRequest/EMPLOYMENT_START_DATE
                	return
                	<JOB_START_DATE>{ fn:data($EMPLOYMENT_START_DATE) }</JOB_START_DATE>
                }
                <USER_NAME>{ data($originacionCreditoRequest/USER_NAME) }</USER_NAME>
                <SALES_ORIGIN>{ data($originacionCreditoRequest/SALES_ORIGIN) }</SALES_ORIGIN>
                <FISCAL_ID>{ data($originacionCreditoRequest/FISCAL_ID) }</FISCAL_ID>
                <FIRST_NAME>{ data($originacionCreditoRequest/FIRST_NAME) }</FIRST_NAME>
                <LAST_NAME>{ data($originacionCreditoRequest/LAST_NAME) }</LAST_NAME>
                <EMPLOYMENT_START_DATE>{ data($originacionCreditoRequest/EMPLOYMENT_START_DATE) }</EMPLOYMENT_START_DATE>
                <CLIENT_PROFILE>{ data($originacionCreditoRequest/CLIENT_PROFILE) }</CLIENT_PROFILE>
                <CAMPAING>{ data($originacionCreditoRequest/CAMPAIGN) }</CAMPAING>
                <VIP_CLIENT>{ data($originacionCreditoRequest/VIP_CUSTOMER) }</VIP_CLIENT>
                <HOUSING_TYPE>{ data($originacionCreditoRequest/HOUSING_TYPE) }</HOUSING_TYPE>
                <HOUSING_ANTIQUITY>{ data($originacionCreditoRequest/HOUSING_ANTIQUITY) }</HOUSING_ANTIQUITY>
                {
                for $REFERENCIA_SIB in $consultaConsolidadaRiesgoClienteResponse/LOAN_MAINTENANCE/CUSTOMER_INFO[1]/REFERENCIA_SIB
                    return
                <REFERENCIA_SIB>{ data($REFERENCIA_SIB) }</REFERENCIA_SIB>
                }
            </CUSTOMER_INFO>
            {
                for $EXTERNAL_SCORE in $consultaConsolidadaRiesgoClienteResponse/LOAN_MAINTENANCE/CUSTOMER_INFO[1]/EXTERNAL_SCORE
                return
                    <EXTERNAL_SCORE>{ data($EXTERNAL_SCORE) }</EXTERNAL_SCORE>
            }
            <SCORE_INFO>
                {
                    for $SCORE_CALCULATION in $consultaConsolidadaRiesgoClienteResponse/LOAN_MAINTENANCE/CUSTOMER_INFO[1]/SCORE_INFO/SCORE_CALCULATION
                    return
                        <SCORE_CALCULATION>{ data($SCORE_CALCULATION) }</SCORE_CALCULATION>
                }
                {
                    for $QUALIFICATION in $consultaConsolidadaRiesgoClienteResponse/LOAN_MAINTENANCE/CUSTOMER_INFO[1]/SCORE_INFO/QUALIFICATION
                    return
                        <QUALIFICATION>{ data($QUALIFICATION) }</QUALIFICATION>
                }
                {
                    for $RISK_LEVEL in $consultaConsolidadaRiesgoClienteResponse/LOAN_MAINTENANCE/CUSTOMER_INFO[1]/SCORE_INFO/RISK_LEVEL
                    return
                        <RISK_LEVEL>{ data($RISK_LEVEL) }</RISK_LEVEL>
                }
            </SCORE_INFO>
            {
            	if (fn:exists($consultaConsolidadaRiesgoClienteResponse/LOAN_MAINTENANCE/CUSTOMER_INFO[1]/OFFERS/OFFER)) then (
            		<OFFERS>
            		{
            			for $OFFER in $consultaConsolidadaRiesgoClienteResponse/LOAN_MAINTENANCE/CUSTOMER_INFO[1]/OFFERS/OFFER
            			return(
            				<OFFER>
            				{
            					for $PRODUCT_CODE in $OFFER/PRODUCT_CODE
            					return
                            	<PRODUCT_CODE>{ data($PRODUCT_CODE) }</PRODUCT_CODE>
                           	}
                           	{
                           		for $MAX_AMOUNT in $OFFER/MAX_AMOUNT
                           		return
                           		<MAX_AMOUNT>{ data($MAX_AMOUNT) }</MAX_AMOUNT>
                           	}
                           	{
                           		for $INSTALLMENT in $OFFER/INSTALLMENT
                           		return
                           		<INSTALLMENT>{ data($INSTALLMENT) }</INSTALLMENT>
                           	}
                           	{
                           		for $RATE in $OFFER/RATE
                           		return
                           		<RATE>{ data($RATE) }</RATE>
                           	}
                    		<AMOUNT_CALCULATIONS>
                        	{
                            	for $FOR_12_MONTHS in $OFFER/AMOUNT_CALCULATIONS/FOR_12_MONTHS
                            	return
                                <FOR_12_MONTHS>{ data($FOR_12_MONTHS) }</FOR_12_MONTHS>
                        	}
                        	{
                            	for $FOR_18_MONTHS in $OFFER/AMOUNT_CALCULATIONS/FOR_18_MONTHS
                            	return
                                <FOR_18_MONTHS>{ data($FOR_18_MONTHS) }</FOR_18_MONTHS>
                            }
                            {
                            	for $FOR_24_MONTHS in $OFFER/AMOUNT_CALCULATIONS/FOR_24_MONTHS
                            	return
                                <FOR_24_MONTHS>{ data($FOR_24_MONTHS) }</FOR_24_MONTHS>
                        	}
                        	{
                            	for $FOR_36_MONTHS in $OFFER/AMOUNT_CALCULATIONS/FOR_36_MONTHS
                            	return
                                <FOR_36_MONTHS>{ data($FOR_36_MONTHS) }</FOR_36_MONTHS>
                        	}
                        	{
                            	for $FOR_48_MONTHS in $OFFER/AMOUNT_CALCULATIONS/FOR_48_MONTHS
                            	return
                                <FOR_48_MONTHS>{ data($FOR_48_MONTHS) }</FOR_48_MONTHS>
                        	}
                        	{
                            	for $FOR_60_MONTHS in $OFFER/AMOUNT_CALCULATIONS/FOR_60_MONTHS
                            	return
                                <FOR_60_MONTHS>{ data($FOR_60_MONTHS) }</FOR_60_MONTHS>
                        	}
                    		</AMOUNT_CALCULATIONS>
                    		{
                        		for $TIMES_INCOME in $OFFER/TIMES_INCOME
                        		return
                            	<TIMES_INCOME>{ data($TIMES_INCOME) }</TIMES_INCOME>
                    		}
                    		<RESOLUTION>
                        	{
                            	for $CODE in $OFFER/RESOLUTION/CODE
                            	return
                                <CODE>{ data($CODE) }</CODE>
                        	}
                        	{
                            	for $DESCRIPTION in $OFFER/RESOLUTION/DESCRIPTION
                            	return
                                <DESCRIPTION>{ data($DESCRIPTION) }</DESCRIPTION>
                        	}
                    		</RESOLUTION>
                		</OFFER>
            			)
            		}
            		</OFFERS>
            	) else ()
            }
            {
            	if (fn:exists($consultaConsolidadaRiesgoClienteResponse/LOAN_MAINTENANCE/CUSTOMER_INFO[1]/ASSETS/ASSET)) then (
            		<ASSETS>
            		{
            			for $ASSET in $consultaConsolidadaRiesgoClienteResponse/LOAN_MAINTENANCE/CUSTOMER_INFO[1]/ASSETS/ASSET
            			return(
            				<ASSET>
                    		{
                        		for $NUMBER in $ASSET/NUMBER
                        		return
                            	<NUMBER>{ data($NUMBER) }</NUMBER>
                    		}
                    		{
                    			for $CATEGORY in $ASSET/CATEGORY
                    			return
                    			<CATEGORY>{ data($CATEGORY) }</CATEGORY>
                    		}
                    		{
                        		for $CURRENCY in $ASSET/CURRENCY
                        		return
                            	<CURRENCY>{ data($CURRENCY) }</CURRENCY>
                    		}
                    		{
                        		for $OPENING_DATE in $ASSET/OPENING_DATE
                        		return
                            	<OPENING_DATE>{ data($OPENING_DATE) }</OPENING_DATE>
                    		}
                    		{
                        		for $CANCELATION_DATE in $ASSET/CANCELATION_DATE
                        		return
                            	<CANCELATION_DATE>{ data($CANCELATION_DATE) }</CANCELATION_DATE>
                    		}
                    		{
                        		for $CURRENT_BALANCE in $ASSET/CURRENT_BALANCE
                        		return
                            	<CURRENT_BALANCE>{ data($CURRENT_BALANCE) }</CURRENT_BALANCE>
                    		}
                    		{
                        		for $END_OF_MONTH_BALANCE in $ASSET/END_OF_MONTH_BALANCE
                        		return
                            	<END_OF_MONTH_BALANCE>{ data($END_OF_MONTH_BALANCE) }</END_OF_MONTH_BALANCE>
                    		}
                    		{
                        		for $AVERAGE_BALANCE in $ASSET/AVERAGE_BALANCE
                        		return
                            	<AVERAGE_BALANCE>{ data($AVERAGE_BALANCE) }</AVERAGE_BALANCE>
                    		}
                			</ASSET>
            			)
            		}
            		</ASSETS>
            	) else ()
            }
            <LIABILITIES>
            {
            	if (fn:exists($consultaConsolidadaRiesgoClienteResponse/LOAN_MAINTENANCE/CUSTOMER_INFO[1]/LIABILITIES/CREDIT_CARDS_INFO/CREDIT_CARD)) then (
            		<CREDIT_CARDS_INFO>
            		{
            			for $CREDIT_CARD in $consultaConsolidadaRiesgoClienteResponse/LOAN_MAINTENANCE/CUSTOMER_INFO[1]/LIABILITIES/CREDIT_CARDS_INFO/CREDIT_CARD
            			return(
            				<CREDIT_CARD>
                        	{
                            	for $ACCOUNT in $CREDIT_CARD/ACCOUNT
                            	return
                                <ACCOUNT>{ data($ACCOUNT) }</ACCOUNT>
                        	}
                        	{
                            	for $BEHAVIOR_SCORE in $CREDIT_CARD/BEHAVIOR_SCORE
                            	return
                                <BEHAVIOR_SCORE>{ data($BEHAVIOR_SCORE) }</BEHAVIOR_SCORE>
                        	}
                        	{
                            	for $QUALIFICATION_SCORE in $CREDIT_CARD/QUALIFICATION_SCORE
                            	return
                                <QUALIFICATION_SCORE>{ data($QUALIFICATION_SCORE) }</QUALIFICATION_SCORE>
                        	}
                        	{
                            	for $QUALIFICATION_CUSTOMER_SCORE in $CREDIT_CARD/QUALIFICATION_CUSTOMER_SCORE
                            	return
                                <QUALIFICATION_CUSTOMER_SCORE>{ data($QUALIFICATION_CUSTOMER_SCORE) }</QUALIFICATION_CUSTOMER_SCORE>
                        	}
                        	{
                            	for $STATUS in $CREDIT_CARD/STATUS
                            	return
                                <STATUS>{ data($STATUS) }</STATUS>
                        	}
                        	{
                            	for $AFFINITY_GROUP in $CREDIT_CARD/AFFINITY_GROUP
                            	return
                                <AFFINITY_GROUP>{ data($AFFINITY_GROUP) }</AFFINITY_GROUP>
                        	}
                        	{
                            	for $PRODUCT in $CREDIT_CARD/PRODUCT
                            	return
                                <PRODUCT>{ data($PRODUCT) }</PRODUCT>
                        	}
                        	{
                            	for $CLEARING_MODEL in $CREDIT_CARD/CLEARING_MODEL
                            	return
                                <CLEARING_MODEL>{ data($CLEARING_MODEL) }</CLEARING_MODEL>
                        	}
                        	{
                            	for $OPENING_DATE in $CREDIT_CARD/OPENING_DATE
                            	return
                                <OPENING_DATE>{ data($OPENING_DATE) }</OPENING_DATE>
                        	}
                        	{
                            	for $CANCELATION_DATE in $CREDIT_CARD/CANCELATION_DATE
                            	return
                                <CANCELATION_DATE>{ data($CANCELATION_DATE) }</CANCELATION_DATE>
                        	}
                        	{
                            	for $LAST_EXTRA_DATE in $CREDIT_CARD/LAST_EXTRA_DATE
                            	return
                                <LAST_EXTRA_DATE>{ data($LAST_EXTRA_DATE) }</LAST_EXTRA_DATE>
                        	}
                        	{
                            	for $CURRENT_DUE in $CREDIT_CARD/CURRENT_DUE
                            	return
                                <CURRENT_DUE>{ data($CURRENT_DUE) }</CURRENT_DUE>
                        	}
                        	{
                            	for $CURRENT_LIMIT in $CREDIT_CARD/CURRENT_LIMIT
                            	return
                                <CURRENT_LIMIT>{ data($CURRENT_LIMIT) }</CURRENT_LIMIT>
                        	}
                        	{
                            	for $CURRENT_BALANCE in $CREDIT_CARD/CURRENT_BALANCE
                            	return
                                <CURRENT_BALANCE>{ data($CURRENT_BALANCE) }</CURRENT_BALANCE>
                        	}
                        	{
                            	for $CLOSING_BALANCE in $CREDIT_CARD/CLOSING_BALANCE
                            	return
                                <CLOSING_BALANCE>{ data($CLOSING_BALANCE) }</CLOSING_BALANCE>
                        	}
                        	{
                            	for $EXTRA_BALANCE in $CREDIT_CARD/EXTRA_BALANCE
                            	return
                                <EXTRA_BALANCE>{ data($EXTRA_BALANCE) }</EXTRA_BALANCE>
                        	}
                        	{
                            	for $INTRA_BALANCE in $CREDIT_CARD/INTRA_BALANCE
                            	return
                                <INTRA_BALANCE>{ data($INTRA_BALANCE) }</INTRA_BALANCE>
                        	}
                        	{
                            	for $ACTIVE_EXTRA_INSTALLMENTS in $CREDIT_CARD/ACTIVE_EXTRA_INSTALLMENTS
                            	return
                                <ACTIVE_EXTRA_INSTALLMENTS>{ data($ACTIVE_EXTRA_INSTALLMENTS) }</ACTIVE_EXTRA_INSTALLMENTS>
                        	}
                        	{
                            	for $CASH_DISCOUNT_DATE in $CREDIT_CARD/CASH_DISCOUNT_DATE
                            	return
                                <CASH_DISCOUNT_DATE>{ data($CASH_DISCOUNT_DATE) }</CASH_DISCOUNT_DATE>
                        	}
                        	{
                            	for $LOCKCODE1 in $CREDIT_CARD/LOCKCODE1
                            	return
                                <LOCKCODE1>{ data($LOCKCODE1) }</LOCKCODE1>
                        	}
                        	{
                            	for $LOCKCODE2 in $CREDIT_CARD/LOCKCODE2
                            	return
                                <LOCKCODE2>{ data($LOCKCODE2) }</LOCKCODE2>
                        	}
                        	{
                            	for $LOGO in $CREDIT_CARD/LOGO
                            	return
                                <LOGO>{ data($LOGO) }</LOGO>
                        	}
                        	{
                            	for $AVAILABLE_CASH in $CREDIT_CARD/AVAILABLE_CASH
                            	return
                                <AVAILABLE_CASH>{ data($AVAILABLE_CASH) }</AVAILABLE_CASH>
                        	}
                        	{
                            	for $LOCK_DATE1 in $CREDIT_CARD/LOCK_DATE1
                            	return
                                <LOCK_DATE1>{ data($LOCK_DATE1) }</LOCK_DATE1>
                        	}
                        	{
                            	for $LOCK_DATE2 in $CREDIT_CARD/LOCK_DATE2
                            	return
                                <LOCK_DATE2>{ data($LOCK_DATE2) }</LOCK_DATE2>
                        	}
                        	{
                        		for $PRIOR_LIMIT in $CREDIT_CARD/PRIOR_LIMIT
                        		return
                        		<PRIOR_LIMIT>{ data($PRIOR_LIMIT) }</PRIOR_LIMIT>
                        	}
                        	{
                            	for $LAST_INTRA_DATE in $CREDIT_CARD/LAST_INTRA_DATE
                            	return
                                <LAST_INTRA_DATE>{ data($LAST_INTRA_DATE) }</LAST_INTRA_DATE>
                        	}
                        	{
                            	for $LAST_PIL_DATE in $CREDIT_CARD/LAST_PIL_DATE
                            	return
                                <LAST_PIL_DATE>{ data($LAST_PIL_DATE) }</LAST_PIL_DATE>
                        	}
                        	{
                            	for $HISTORICAL_ARREA_LOC in $CREDIT_CARD/HISTORICAL_ARREA_LOC
                            	return
                                <HISTORICAL_ARREAR_LOC>{ data($HISTORICAL_ARREA_LOC) }</HISTORICAL_ARREAR_LOC>
                        	}
                        	{
                            	for $HISTORICAL_ARREA_USD in $CREDIT_CARD/HISTORICAL_ARREA_USD
                            	return
                                <HISTORICAL_ARREAR_USD>{ data($HISTORICAL_ARREA_USD) }</HISTORICAL_ARREAR_USD>
                        	}
                        	{
                        		for $CHARGE_OFF_FLAG in $CREDIT_CARD/CHARGE_OFF_FLAG
                        		return
                        		<CHARGE_OFF_FLAG>{ data($CHARGE_OFF_FLAG) }</CHARGE_OFF_FLAG>
                        	}
                    		</CREDIT_CARD>
            			)
            		}
                	</CREDIT_CARDS_INFO>
            	) else ()
            }
            {
            	if (fn:exists($consultaConsolidadaRiesgoClienteResponse/LOAN_MAINTENANCE/CUSTOMER_INFO[1]/LIABILITIES/LOANS_INFO/LOAN)) then (
            		<LOANS_INFO>
            		{
            			for $LOAN in $consultaConsolidadaRiesgoClienteResponse/LOAN_MAINTENANCE/CUSTOMER_INFO[1]/LIABILITIES/LOANS_INFO/LOAN
            			return(
            				<LOAN>
                        	{
                            	for $NUMBER in $LOAN/NUMBER
                            	return
                                <NUMBER>{ data($NUMBER) }</NUMBER>
                        	}
                        	{
                            	for $AGENCY_CODE in $LOAN/AGENCY_CODE
                            	return
                                <AGENCY_CODE>{ data($AGENCY_CODE) }</AGENCY_CODE>
                        	}
                        	{
                            	for $SUB_APPLICATION in $LOAN/SUB_APPLICATION
                            	return
                                <SUB_APPLICATION>{ data($SUB_APPLICATION) }</SUB_APPLICATION>
                        	}
                        	{
                            	for $OPENING_DATE in $LOAN/OPENING_DATE
                            	return
                                <OPENING_DATE>{ data($OPENING_DATE) }</OPENING_DATE>
                        	}
                        	{
                            	for $CANCELATION_DATE in $LOAN/CANCELATION_DATE
                            	return
                                <CANCELATION_DATE>{ data($CANCELATION_DATE) }</CANCELATION_DATE>
                        	}
                        	{
                            	for $INITIAL_AMOUNT in $LOAN/INITIAL_AMOUNT
                            	return
                                <INITIAL_AMOUNT>{ data($INITIAL_AMOUNT) }</INITIAL_AMOUNT>
                        	}
                        	{
                            	for $CURRENT_BALANCE in $LOAN/CURRENT_BALANCE
                            	return
                                <CURRENT_BALANCE>{ data($CURRENT_BALANCE) }</CURRENT_BALANCE>
                        	}
                        	{
                            	for $PAYMENT_AMOUNT in $LOAN/PAYMENT_AMOUNT
                            	return
                                <PAYMENT_AMOUNT>{ data($PAYMENT_AMOUNT) }</PAYMENT_AMOUNT>
                        	}
                        	{
                            	for $RATE in $LOAN/RATE
                            	return
                                <RATE>{ data($RATE) }</RATE>
                        	}
                        	{
                            	for $TERM in $LOAN/TERM
                            	return
                                <TERM>{ data($TERM) }</TERM>
                        	}
                        	{
                            	for $PAYMENT_NUMBER in $LOAN/PAYMENT_NUMBER
                            	return
                                <PAYMENT_NUMBER>{ data($PAYMENT_NUMBER) }</PAYMENT_NUMBER>
                        	}
                        	{
                        		for $FIRST_PAYMENT_DATE in $LOAN/FIRST_CAPITAL_PAYMENT_DATE
                        		return
                        		<FIRST_PAYMENT_DATE>{ data($FIRST_PAYMENT_DATE) }</FIRST_PAYMENT_DATE>
                        	}
                        	{
                            	for $PAID_PAYMENTS in $LOAN/PAID_PAYMENTS
                            	return
                                <PAID_PAYMENTS>{ data($PAID_PAYMENTS) }</PAID_PAYMENTS>
                        	}
                        	{
                            	for $CAPITAL_FREQUENCY in $LOAN/CAPITAL_FREQUENCY
                            	return
                                <CAPITAL_FREQUENCY>{ data($CAPITAL_FREQUENCY) }</CAPITAL_FREQUENCY>
                        	}
                        	{
                            	for $DESTINATION_CODE in $LOAN/DESTINATION_CODE
                            	return
                                <DESTINATION_CODE>{ data($DESTINATION_CODE) }</DESTINATION_CODE>
                        	}
                        	{
                            	for $MONTHLY_PRIME in $LOAN/MONTHLY_PRIME
                            	return
                                <MONTHLY_PRIME>{ data($MONTHLY_PRIME) }</MONTHLY_PRIME>
                        	}
                        	{
                            	for $CONTRACT_NUMBER in $LOAN/CONTRACT_NUMBER
                            	return
                                <CONTRACT_NUMBER>{ data($CONTRACT_NUMBER) }</CONTRACT_NUMBER>
                        	}
                        	{
                            	for $CHARGES in $LOAN/CHARGES
                            	return
                                <CHARGES>{ data($CHARGES) }</CHARGES>
                        	}
                        	{
                            	for $INTEREST in $LOAN/INTEREST
                            	return
                                <INTEREST>{ data($INTEREST) }</INTEREST>
                        	}
                        	{
                            	for $INSURANCE in $LOAN/INSURANCE
                            	return
                                <INSURANCE>{ data($INSURANCE) }</INSURANCE>
                        	}
                        	{
                            	for $OTHER_CHARGES in $LOAN/OTHER_CHARGES
                            	return
                                <OTHER_CHARGES>{ data($OTHER_CHARGES) }</OTHER_CHARGES>
                        	}
                        	{
                            	for $CURRENT_DUE in $LOAN/CURRENT_DUE
                            	return
                                <CURRENT_DUE>{ data($CURRENT_DUE) }</CURRENT_DUE>
                        	}
                        	{
                            	for $DEBTOR_TYPE in $LOAN/DEBTOR_TYPE
                            	return
                                <DEBTOR_TYPE>{ data($DEBTOR_TYPE) }</DEBTOR_TYPE>
                        	}
                        	{
                            	for $CODE_TYPE in $LOAN/CODE_TYPE
                            	return
                                <CODE_TYPE>{ data($CODE_TYPE) }</CODE_TYPE>
                        	}
                        	{
                            	for $GUARANTEE_TYPE in $LOAN/GUARANTEE_TYPE
                            	return
                                <GUARANTEE_TYPE>{ data($GUARANTEE_TYPE) }</GUARANTEE_TYPE>
                        	}
                        	{
                        		if (fn:exists($LOAN//PRODUCT_TRANSACTIONS/TRANSACTION)) then (
                        			<PRODUCT_TRANSACTIONS>
                        			{
                        				for $TRANSACTION in $LOAN//PRODUCT_TRANSACTIONS/TRANSACTION
                        				return(
                        					<TRANSACTION>
                        					{
                                    			for $PERIOD_DATE in $TRANSACTION/PERIOD_DATE
                                    			return
                                        		<PERIOD_DATE>{ data($PERIOD_DATE) }</PERIOD_DATE>
                                        	}
                                        	{
                                    			for $PERIOD_BALANCE in $TRANSACTION/PERIOD_BALANCE
                                    			return
                                        		<PERIOD_BALANCE>{ data($PERIOD_BALANCE) }</PERIOD_BALANCE>
                                			}
                                			{
                                    			for $CAPITAL_BALANCE in $TRANSACTION/CAPITAL_BALANCE
                                    			return
                                        		<CAPITAL_BALANCE>{ data($CAPITAL_BALANCE) }</CAPITAL_BALANCE>
                                			}
                                			{
                                    			for $DUE_BALANCE in $TRANSACTION/DUE_BALANCE
                                    			return
                                        		<DUE_BALANCE>{ data($DUE_BALANCE) }</DUE_BALANCE>
                                			}
                                			{
                                    			for $CHARGES in $TRANSACTION/CHARGES
                                    			return
                                        		<CHARGES>{ data($CHARGES) }</CHARGES>
                                			}
                                			{
                                    			for $INTEREST in $TRANSACTION/INTEREST
                                    			return
                                        		<INTEREST>{ data($INTEREST) }</INTEREST>
                                			}
                                			{
                                    			for $PAYMENT in $TRANSACTION/PAYMENT
                                    			return
                                        		<PAYMENT>{ data($PAYMENT) }</PAYMENT>
                                			}
                                			{
                                    			for $INSURANCE in $TRANSACTION/INSURANCE
                                    			return
                                        		<INSURANCE>{ data($INSURANCE) }</INSURANCE>
                                			}
                                			{
                                    			for $OTHER_CHARGES in $TRANSACTION/OTHER_CHARGES
                                    			return
                                        		<OTHER_CHARGES>{ data($OTHER_CHARGES) }</OTHER_CHARGES>
                                			}
                                			{
                                    			for $CYCLE_DUE in $TRANSACTION/CYCLE_DUE
                                    			return
                                        		<CYCLE_DUE>{ data($CYCLE_DUE) }</CYCLE_DUE>
                                			}
                            				</TRANSACTION>
                        				)
                        			}
                        			</PRODUCT_TRANSACTIONS>
                        		) else ()
                        	}
                    		</LOAN>
            			)
            		}
                	</LOANS_INFO>
            	) else ()
            }
            </LIABILITIES>
            {
            	if (fn:exists($consultaConsolidadaRiesgoClienteResponse/LOAN_ORIGINATIONS/PRE_APPROVED_OFFERS/OFFER)) then (
            		<PRE_APPROVED_OFFERS>
            		{
            			for $OFFER in $consultaConsolidadaRiesgoClienteResponse/LOAN_ORIGINATIONS/PRE_APPROVED_OFFERS/OFFER
            			return(
            				<OFFER>
                    		{
                        		for $INFORMATION_DATE in $OFFER/INFORMATION_DATE
                        		return
                            	<INFORMATION_DATE>{ data($INFORMATION_DATE) }</INFORMATION_DATE>
                    		}
                    		{
                        		for $TYPE in $OFFER/TYPE
                        		return
                            	<TYPE>{ data($TYPE) }</TYPE>
                    		}
                    		<DETAILS>
                        	{
                            	for $FOR_12_MONTHS in $OFFER/DETAILS/FOR_12_MONTHS
                            	return
                                <FOR_12_MONTHS>{ data($FOR_12_MONTHS) }</FOR_12_MONTHS>
                        	}
                        	{
                            	for $FOR_18_MONTHS in $OFFER/DETAILS/FOR_18_MONTHS
                            	return
                                <FOR_18_MONTHS>{ data($FOR_18_MONTHS) }</FOR_18_MONTHS>
                        	}
                        	{
                            	for $FOR_24_MONTHS in $OFFER/DETAILS/FOR_24_MONTHS
                            	return
                                <FOR_24_MONTHS>{ data($FOR_24_MONTHS) }</FOR_24_MONTHS>
                        	}
                        	{
                            	for $FOR_36_MONTHS in $OFFER/DETAILS/FOR_36_MONTHS
                            	return
                                <FOR_36_MONTHS>{ data($FOR_36_MONTHS) }</FOR_36_MONTHS>
                        	}
                        	{
                            	for $FOR_48_MONTHS in $OFFER/DETAILS/FOR_48_MONTHS
                            	return
                                <FOR_48_MONTHS>{ data($FOR_48_MONTHS) }</FOR_48_MONTHS>
                        	}
                        	{
                            	for $FOR_60_MONTHS in $OFFER/DETAILS/FOR_60_MONTHS
                            	return
                                <FOR_60_MONTHS>{ data($FOR_60_MONTHS) }</FOR_60_MONTHS>
                        	}
                    		</DETAILS>
                    		{
                        		for $INSTALLMENT in $OFFER/INSTALLMENT
                        		return
                            	<INSTALLMENT>{ data($INSTALLMENT) }</INSTALLMENT>
                    		}
                    		{
                        		for $RATE in $OFFER/RATE
                        		return
                            	<RATE>{ data($RATE) }</RATE>
                    		}
                    		{
                        		for $TIMES_INCOME in $OFFER/TIMES_INCOME
                        		return
                            	<TIMES_INCOME>{ data($TIMES_INCOME) }</TIMES_INCOME>
                    		}
                			</OFFER>
            			)
            		}
            		</PRE_APPROVED_OFFERS>
            	) else ()
            }
            {
            	if (fn:exists($consultaConsolidadaRiesgoClienteResponse/LOAN_ORIGINATIONS/INTERNAL_EXTRAS/EXTRA)) then (
            		<INTERNAL_EXTRAS>
            		{
            			for $EXTRA in $consultaConsolidadaRiesgoClienteResponse/LOAN_ORIGINATIONS/INTERNAL_EXTRAS/EXTRA
            			return(
            				<EXTRA>
                    		{
                        		for $ACCOUNT_NUMBER in $EXTRA/ACCOUNT_NUMBER
                        		return
                            	<ACCOUNT_NUMBER>{ data($ACCOUNT_NUMBER) }</ACCOUNT_NUMBER>
                    		}
                    		{
                    			for $DATE in $EXTRA/DATE
                    			return
                    			<DATE>{ data($DATE) }</DATE>
                    		}
                    		{
                    			for $RATE in $EXTRA/RATE
                    			return
                    			<RATE>{ data($RATE) }</RATE>
                    		}
                    		{
                    			for $AMOUNT in $EXTRA/AMOUNT
                    			return
                    			<AMOUNT>{ data($AMOUNT) }</AMOUNT>
                    		}
                    		{
                    			for $INSTALLMENT in $EXTRA/INSTALLMENT
                    			return
                    			<INSTALLMENT>{ data($INSTALLMENT) }</INSTALLMENT>
                    		}
                    		{
                    			for $INSTALLMENT_COUNT in $EXTRA/INSTALLMENT_COUNT
                    			return
                    			<INSTALLMENT_COUNT>{ data($INSTALLMENT_COUNT) }</INSTALLMENT_COUNT>
                    		}
                    		{
                    			for $TOTAL_INSTALLMENT in $EXTRA/TOTAL_INSTALLMENT
                    			return
                    			<TOTAL_INSTALLMENT>{ data($TOTAL_INSTALLMENT) }</TOTAL_INSTALLMENT>
                    		}
                			</EXTRA>
            			)
            		}
            		</INTERNAL_EXTRAS>
            	) else ()
            }
            <REFERENCES_DETAILS>
            {
            	if (fn:exists($consultaConsolidadaRiesgoClienteResponse/LOAN_ORIGINATIONS/REFERENCES_DETAILS/QUERIES/QUERY_ITEM)) then (
            		<QUERIES>
            		{
            			for $QUERY_ITEM in $consultaConsolidadaRiesgoClienteResponse/LOAN_ORIGINATIONS/REFERENCES_DETAILS/QUERIES/QUERY_ITEM
            			return(
            				<QUERY_ITEM>
                        	{
                            	for $ID in $QUERY_ITEM/ID
                            	return
                                <ID>{ data($ID) }</ID>
                        	}
                        	{
                            	for $DATE in $QUERY_ITEM/DATE
                            	return
                                <DATE>{ data($DATE) }</DATE>
                        	}
                        	{
                            	for $ENTITY in $QUERY_ITEM/ENTITY
                            	return
                                <ENTITY>{ data($ENTITY) }</ENTITY>
                        	}
                    		</QUERY_ITEM>
            			)
            		}
                	</QUERIES>
            	) else ()
            }
            {
            	if (fn:exists($consultaConsolidadaRiesgoClienteResponse/LOAN_ORIGINATIONS/REFERENCES_DETAILS/ACTIVE_REFERENCES/REFERENCE)) then (
            		<ACTIVE_REFERENCES>
            		{
            			for $REFERENCE in $consultaConsolidadaRiesgoClienteResponse/LOAN_ORIGINATIONS/REFERENCES_DETAILS/ACTIVE_REFERENCES/REFERENCE
            			return(
            				<REFERENCE>
                        	{
                            	for $QUERY_ID in $REFERENCE/QUERY_ID
                            	return
                                <QUERY_ID>{ data($QUERY_ID) }</QUERY_ID>
                        	}
                        	{
                            	for $CREDITOR in $REFERENCE/CREDITOR
                            	return
                                <CREDITOR>{ data($CREDITOR) }</CREDITOR>
                        	}
                        	{
                            	for $REFERENCE_NUMBER in $REFERENCE/REFERENCE_NUMBER
                            	return
                                <REFERENCE_NUMBER>{ data($REFERENCE_NUMBER) }</REFERENCE_NUMBER>
                        	}
                        	{
                            	for $TYPE in $REFERENCE/TYPE
                            	return
                                <TYPE>{ data($TYPE) }</TYPE>
                        	}
                        	{
                            	for $OBLIGATION_TYPE in $REFERENCE/OBLIGATION_TYPE
                            	return
                                <OBLIGATION_TYPE>{ data($OBLIGATION_TYPE) }</OBLIGATION_TYPE>
                        	}
                        	{
                            	for $CREDIT_TYPE in $REFERENCE/CREDIT_TYPE
                            	return
                                <CREDIT_TYPE>{ data($CREDIT_TYPE) }</CREDIT_TYPE>
                        	}
                        	{
                            	for $STATUS in $REFERENCE/STATUS
                            	return
                                <STATUS>{ data($STATUS) }</STATUS>
                        	}
                        	{
                            	for $LIMIT in $REFERENCE/LIMIT
                            	return
                                <LIMIT>{ data($LIMIT) }</LIMIT>
                        	}
                        	{
                            	for $TERM in $REFERENCE/TERM
                            	return
                                <TERM>{ data($TERM) }</TERM>
                        	}
                        	{
                            	for $CURRENCY in $REFERENCE/CURRENCY
                            	return
                                <CURRENCY>{ data($CURRENCY) }</CURRENCY>
                        	}
                        	{
                            	for $EXCHANGE_FACTOR in $REFERENCE/EXCHANGE_FACTOR
                            	return
                                <EXCHANGE_FACTOR>{ data($EXCHANGE_FACTOR) }</EXCHANGE_FACTOR>
                        	}
                        	{
                            	for $BALANCE in $REFERENCE/BALANCE
                            	return
                                <BALANCE>{ data($BALANCE) }</BALANCE>
                        	}
                        	{
                            	for $MIN_PAYMENT in $REFERENCE/MIN_PAYMENT
                            	return
                                <MIN_PAYMENT>{ data($MIN_PAYMENT) }</MIN_PAYMENT>
                        	}
                        	{
                            	for $PAYMENT_DUE in $REFERENCE/PAYMENT_DUE
                            	return
                                <PAYMENT_DUE>{ data($PAYMENT_DUE) }</PAYMENT_DUE>
                        	}
                        	{
                            	for $PAYMENT_METHOD in $REFERENCE/PAYMENT_METHOD
                            	return
                                <PAYMENT_METHOD>{ data($PAYMENT_METHOD) }</PAYMENT_METHOD>
                        	}
                        	{
                            	for $GUARANTEE in $REFERENCE/GUARANTEE
                            	return
                                <GUARANTEE>{ data($GUARANTEE) }</GUARANTEE>
                        	}
                        	{
                            	for $GUARANTEE_TYPE in $REFERENCE/GUARANTEE_TYPE
                            	return
                                <GUARANTEE_TYPE>{ data($GUARANTEE_TYPE) }</GUARANTEE_TYPE>
                        	}
                        	{
                            	for $AMOUNT in $REFERENCE/AMOUNT
                            	return
                                <AMOUNT>{ data($AMOUNT) }</AMOUNT>
                        	}
                        	{
                            	for $ARREAR_BALANCE in $REFERENCE/ARREAR_BALANCE
                            	return
                                <ARREAR_BALANCE>{ data($ARREAR_BALANCE) }</ARREAR_BALANCE>
                        	}
                        	{
                            	for $ARREAR_LEVEL in $REFERENCE/ARREAR_LEVEL
                            	return
                                <ARREAR_LEVEL>{ data($ARREAR_LEVEL) }</ARREAR_LEVEL>
                        	}
                        	{
                            	for $DUE_BALANCE in $REFERENCE/DUE_BALANCE
                            	return
                                <DUE_BALANCE>{ data($DUE_BALANCE) }</DUE_BALANCE>
                        	}
                        	{
                            	for $IN_EXECUTION in $REFERENCE/IN_EXECUTION
                            	return
                                <IN_EXECUTION>{ data($IN_EXECUTION) }</IN_EXECUTION>
                        	}
                        	{
                            	for $PUNISHED in $REFERENCE/PUNISHED
                            	return
                                <PUNISHED>{ data($PUNISHED) }</PUNISHED>
                        	}
                        	{
                            	for $PUNISHED_BALANCE in $REFERENCE/PUNISHED_BALANCE
                            	return
                                <PUNISHED_BALANCE>{ data($PUNISHED_BALANCE) }</PUNISHED_BALANCE>
                        	}
                        	{
                            	for $CATEGORY in $REFERENCE/CATEGORY
                            	return
                                <CATEGORY>{ data($CATEGORY) }</CATEGORY>
                        	}
                        	{
                            	for $PERIOD in $REFERENCE/PERIOD
                            	return
                                <PERIOD>{ data($PERIOD) }</PERIOD>
                        	}
                        	{
                            	for $INFORMATION_DATE in $REFERENCE/INFORMATION_DATE
                            	return
                                <INFORMATION_DATE>{ data($INFORMATION_DATE) }</INFORMATION_DATE>
                        	}
                        	{
                            	for $OPENING_DATE in $REFERENCE/OPENING_DATE
                            	return
                                <OPENING_DATE>{ data($OPENING_DATE) }</OPENING_DATE>
                        	}
                        	{
                            	for $CANCELATION_DATE in $REFERENCE/CANCELATION_DATE
                            	return
                                <CANCELATION_DATE>{ data($CANCELATION_DATE) }</CANCELATION_DATE>
                        	}
                        	{
                            	for $EXPIRATION_DATE in $REFERENCE/EXPIRATION_DATE
                            	return
                                <EXPIRATION_DATE>{ data($EXPIRATION_DATE) }</EXPIRATION_DATE>
                        	}
                        	{
                            	for $INSTALLMENT in $REFERENCE/INSTALLMENT
                            	return
                                <INSTALLMENT>{ data($INSTALLMENT) }</INSTALLMENT>
                        	}
                        	{
                            	for $HISTORICAL_ARREAR in $REFERENCE/HISTORICAL_ARREAR
                            	return
                                <HISTORICAL_ARREAR>{ data($HISTORICAL_ARREAR) }</HISTORICAL_ARREAR>
                        	}
                        	{
                            	for $HISTORICAL_COUNT_LOC in $REFERENCE/HISTORICAL_COUNT_LOC
                            	return
                                <HISTORICAL_COUNT_LOC>{ data($HISTORICAL_COUNT_LOC) }</HISTORICAL_COUNT_LOC>
                        	}
                        	{
                            	for $HISTORICAL_COUNT_DOL in $REFERENCE/HISTORICAL_COUNT_DOL
                            	return
                                <HISTORICAL_COUNT_DOL>{ data($HISTORICAL_COUNT_DOL) }</HISTORICAL_COUNT_DOL>
                        	}
                    		</REFERENCE>
            			)
            		}
                	</ACTIVE_REFERENCES>
            	) else ()
            }
            {
            	if (fn:exists($consultaConsolidadaRiesgoClienteResponse/LOAN_ORIGINATIONS/REFERENCES_DETAILS/HISTORICAL_REFERENCES/REFERENCE)) then (
            		<HISTORICAL_REFERENCES>
            		{
            			for $REFERENCE in $consultaConsolidadaRiesgoClienteResponse/LOAN_ORIGINATIONS/REFERENCES_DETAILS/HISTORICAL_REFERENCES/REFERENCE
            			return(
            				<REFERENCE>
                        	{
                            	for $QUERY_ID in $REFERENCE/QUERY_ID
                            	return
                                <QUERY_ID>{ data($QUERY_ID) }</QUERY_ID>
                        	}
                        	{
                            	for $CREDITOR in $REFERENCE/CREDITOR
                            	return
                                <CREDITOR>{ data($CREDITOR) }</CREDITOR>
                        	}
                        	{
                            	for $REFERENCE_NUMBER in $REFERENCE/REFERENCE_NUMBER
                            	return
                                <REFERENCE_NUMBER>{ data($REFERENCE_NUMBER) }</REFERENCE_NUMBER>
                        	}
                        	{
                            	for $TYPE in $REFERENCE/TYPE
                            	return
                                <TYPE>{ data($TYPE) }</TYPE>
                        	}
                        	{
                            	for $OBLIGATION_TYPE in $REFERENCE/OBLIGATION_TYPE
                            	return
                                <OBLIGATION_TYPE>{ data($OBLIGATION_TYPE) }</OBLIGATION_TYPE>
                        	}
                        	{
                            	for $CREDIT_TYPE in $REFERENCE/CREDIT_TYPE
                            	return
                                <CREDIT_TYPE>{ data($CREDIT_TYPE) }</CREDIT_TYPE>
                        	}
                        	{
                            	for $STATUS in $REFERENCE/STATUS
                            	return
                                <STATUS>{ data($STATUS) }</STATUS>
                        	}
                        	{
                            	for $LIMIT in $REFERENCE/LIMIT
                            	return
                                <LIMIT>{ data($LIMIT) }</LIMIT>
                        	}
                        	{
                            	for $TERM in $REFERENCE/TERM
                            	return
                                <TERM>{ data($TERM) }</TERM>
                        	}
                        	{
                            	for $CURRENCY in $REFERENCE/CURRENCY
                            	return
                                <CURRENCY>{ data($CURRENCY) }</CURRENCY>
                        	}
                        	{
                            	for $EXCHANGE_FACTOR in $REFERENCE/EXCHANGE_FACTOR
                            	return
                                <EXCHANGE_FACTOR>{ data($EXCHANGE_FACTOR) }</EXCHANGE_FACTOR>
                        	}
                        	{
                            	for $BALANCE in $REFERENCE/BALANCE
                            	return
                                <BALANCE>{ data($BALANCE) }</BALANCE>
                        	}
                        	{
                            	for $MIN_PAYMENT in $REFERENCE/MIN_PAYMENT
                            	return
                                <MIN_PAYMENT>{ data($MIN_PAYMENT) }</MIN_PAYMENT>
                        	}
                        	{
                            	for $PAYMENT_DUE in $REFERENCE/PAYMENT_DUE
                            	return
                                <PAYMENT_DUE>{ data($PAYMENT_DUE) }</PAYMENT_DUE>
                        	}
                        	{
                            	for $PAYMENT_METHOD in $REFERENCE/PAYMENT_METHOD
                            	return
                                <PAYMENT_METHOD>{ data($PAYMENT_METHOD) }</PAYMENT_METHOD>
                        	}
                        	{
                            	for $GUARANTEE in $REFERENCE/GUARANTEE
                            	return
                                <GUARANTEE>{ data($GUARANTEE) }</GUARANTEE>
                        	}
                        	{
                            	for $GUARANTEE_TYPE in $REFERENCE/GUARANTEE_TYPE
                            	return
                                <GUARANTEE_TYPE>{ data($GUARANTEE_TYPE) }</GUARANTEE_TYPE>
                        	}
                        	{
                            	for $AMOUNT in $REFERENCE/AMOUNT
                            	return
                                <AMOUNT>{ data($AMOUNT) }</AMOUNT>
                        	}
                        	{
                            	for $ARREAR_BALANCE in $REFERENCE/ARREAR_BALANCE
                            	return
                                <ARREAR_BALANCE>{ data($ARREAR_BALANCE) }</ARREAR_BALANCE>
                        	}
                        	{
                            	for $ARREAR_LEVEL in $REFERENCE/ARREAR_LEVEL
                            	return
                                <ARREAR_LEVEL>{ data($ARREAR_LEVEL) }</ARREAR_LEVEL>
                        	}
                        	{
                            	for $DUE_BALANCE in $REFERENCE/DUE_BALANCE
                            	return
                                <DUE_BALANCE>{ data($DUE_BALANCE) }</DUE_BALANCE>
                        	}
                        	{
                            	for $IN_EXECUTION in $REFERENCE/IN_EXECUTION
                            	return
                                <IN_EXECUTION>{ data($IN_EXECUTION) }</IN_EXECUTION>
                        	}
                        	{
                            	for $PUNISHED in $REFERENCE/PUNISHED
                            	return
                                <PUNISHED>{ data($PUNISHED) }</PUNISHED>
                        	}
                        	{
                            	for $PUNISHED_BALANCE in $REFERENCE/PUNISHED_BALANCE
                            	return
                                <PUNISHED_BALANCE>{ data($PUNISHED_BALANCE) }</PUNISHED_BALANCE>
                        	}
                        	{
                            	for $CATEGORY in $REFERENCE/CATEGORY
                            	return
                                <CATEGORY>{ data($CATEGORY) }</CATEGORY>
                        	}
                        	{
                            	for $PERIOD in $REFERENCE/PERIOD
                            	return
                                <PERIOD>{ data($PERIOD) }</PERIOD>
                        	}
                        	{
                            	for $INFORMATION_DATE in $REFERENCE/INFORMATION_DATE
                            	return
                                <INFORMATION_DATE>{ data($INFORMATION_DATE) }</INFORMATION_DATE>
                        	}
                        	{
                            	for $OPENING_DATE in $REFERENCE/OPENING_DATE
                            	return
                                <OPENING_DATE>{ data($OPENING_DATE) }</OPENING_DATE>
                        	}
                        	{
                            	for $CANCELATION_DATE in $REFERENCE/CANCELATION_DATE
                            	return
                                <CANCELATION_DATE>{ data($CANCELATION_DATE) }</CANCELATION_DATE>
                        	}
                        	{
                            	for $EXPIRATION_DATE in $REFERENCE/EXPIRATION_DATE
                            	return
                                <EXPIRATION_DATE>{ data($EXPIRATION_DATE) }</EXPIRATION_DATE>
                        	}
                        	{
                            	for $INSTALLMENT in $REFERENCE/INSTALLMENT
                            	return
                                <INSTALLMENT>{ data($INSTALLMENT) }</INSTALLMENT>
                        	}
                        	{
                            	for $HISTORICAL_ARREAR in $REFERENCE/HISTORICAL_ARREAR
                            	return
                                <HISTORICAL_ARREAR>{ data($HISTORICAL_ARREAR) }</HISTORICAL_ARREAR>
                        	}
                        	{
                            	for $HISTORICAL_COUNT_LOC in $REFERENCE/HISTORICAL_COUNT_LOC
                            	return
                                <HISTORICAL_COUNT_LOC>{ data($HISTORICAL_COUNT_LOC) }</HISTORICAL_COUNT_LOC>
                        	}
                        	{
                            	for $HISTORICAL_COUNT_DOL in $REFERENCE/HISTORICAL_COUNT_DOL
                            	return
                                <HISTORICAL_COUNT_DOL>{ data($HISTORICAL_COUNT_DOL) }</HISTORICAL_COUNT_DOL>
                        	}
                    		</REFERENCE>
            			)
            		}
                	</HISTORICAL_REFERENCES>
            	) else ()
            }
            {
            	if (fn:exists($consultaConsolidadaRiesgoClienteResponse/LOAN_ORIGINATIONS/REFERENCES_DETAILS/REFERENCE_BUREAU_TUCA/REFERENCE)) then (
            		<REFERENCE_BUREAU_TUCA>
            		{
            			for $REFERENCE in $consultaConsolidadaRiesgoClienteResponse/LOAN_ORIGINATIONS/REFERENCES_DETAILS/REFERENCE_BUREAU_TUCA/REFERENCE
            			return(
            				<REFERENCE>
            				{
                            	for $QUERY_ID in $REFERENCE/QUERY_ID
                            	return
                                <QUERY_ID>{ data($QUERY_ID) }</QUERY_ID>
                        	}
                        	{
                            	for $TYPE in $REFERENCE/TYPE
                            	return
                                <TYPE>{ data($TYPE) }</TYPE>
                        	}
                        	{
                            	for $REFERENCE_NUMBER in $REFERENCE/REFERENCE_NUMBER
                            	return
                                <REFERENCE_NUMBER>{ data($REFERENCE_NUMBER) }</REFERENCE_NUMBER>
                        	}
                        	{
                        		for $OBLIGATION_CODE in $REFERENCE/OBLIGATION_CODE
                        		return
                        		<OBLIGATION_CODE>{ data($OBLIGATION_CODE) }</OBLIGATION_CODE>
                        	}
                        	{
                        		for $OBLIGATION_TYPE in $REFERENCE/OBLIGATION_TYPE
                        		return
                        		<OBLIGATION_TYPE>{ data($OBLIGATION_TYPE) }</OBLIGATION_TYPE>
                        	}{
                            	for $OBLIGATION_SECTOR in $REFERENCE/OBLIGATION_SECTOR
                            	return
                                <OBLIGATION_SECTOR>{ data($OBLIGATION_SECTOR) }</OBLIGATION_SECTOR>
                        	}
                        	{
                            	for $CREDITOR in $REFERENCE/CREDITOR
                            	return
                                <CREDITOR>{ data($CREDITOR) }</CREDITOR>
                        	}
                        	{
                            	for $CREDIT_TYPE in $REFERENCE/CREDIT_TYPE
                            	return
                                <CREDIT_TYPE>{ data($CREDIT_TYPE) }</CREDIT_TYPE>
                        	}
                        	{
                            	for $GUARANTEE_TYPE in $REFERENCE/GUARANTEE_TYPE
                            	return
                                <GUARANTEE_TYPE>{ data($GUARANTEE_TYPE) }</GUARANTEE_TYPE>
                        	}
                        	{
                            	for $OPENING_DATE in $REFERENCE/OPENING_DATE
                            	return
                                <OPENING_DATE>{ data($OPENING_DATE) }</OPENING_DATE>
                        	}
                        	{
                            	for $CANCELATION_DATE in $REFERENCE/CANCELATION_DATE
                            	return
                                <CANCELATION_DATE>{ data($CANCELATION_DATE) }</CANCELATION_DATE>
                        	}
                        	{
                            	for $INFORMATION_DATE in $REFERENCE/INFORMATION_DATE
                            	return
                                <INFORMATION_DATE>{ data($INFORMATION_DATE) }</INFORMATION_DATE>
                        	}
                        	{
                            	for $PAYMENT_METHOD in $REFERENCE/PAYMENT_METHOD
                            	return
                                <PAYMENT_METHOD>{ data($PAYMENT_METHOD) }</PAYMENT_METHOD>
                        	}
                        	{
                            	for $CATEGORY in $REFERENCE/CATEGORY
                            	return
                                <CATEGORY>{ data($CATEGORY) }</CATEGORY>
                        	}
                        	{
                            	for $CURRENCY in $REFERENCE/CURRENCY
                            	return
                                <CURRENCY>{ data($CURRENCY) }</CURRENCY>
                        	}
                        	{
                            	for $CREDIT_STATUS in $REFERENCE/CREDIT_STATUS
                            	return
                                <CREDIT_STATUS>{ data($CREDIT_STATUS) }</CREDIT_STATUS>
                        	}
                        	{
                            	for $STATUS in $REFERENCE/STATUS
                            	return
                                <STATUS>{ data($STATUS) }</STATUS>
                        	}
                        	{
                            	for $LIMIT in $REFERENCE/LIMIT
                            	return
                                <LIMIT>{ data($LIMIT) }</LIMIT>
                        	}
                        	{
                            	for $BALANCE in $REFERENCE/BALANCE
                            	return
                                <BALANCE>{ data($BALANCE) }</BALANCE>
                        	}
                        	{
                            	for $ARREAR_BALANCE in $REFERENCE/ARREAR_BALANCE
                            	return
                                <ARREAR_BALANCE>{ data($ARREAR_BALANCE) }</ARREAR_BALANCE>
                        	}
                        	{
                            	for $INSTALLMENT in $REFERENCE/INSTALLMENT
                            	return
                                <INSTALLMENT>{ data($INSTALLMENT) }</INSTALLMENT>
                        	}
                        	{
                        		for $LAST_MOVEMENT_MONTH in $REFERENCE/LAST_MOVEMENT_MONTH
                        		return
                        		<LAST_MOVEMENT_MONTH>{ data($LAST_MOVEMENT_MONTH) }</LAST_MOVEMENT_MONTH>
                        	}
                        	{
                        		for $LAST_MOVEMENT_YEAR in $REFERENCE/LAST_MOVEMENT_YEAR
                        		return
                        		<LAST_MOVEMENT_YEAR>{ data($LAST_MOVEMENT_YEAR) }</LAST_MOVEMENT_YEAR>
                        	}
                        	{
                        		for $HISTORICAL_ARREAR in $REFERENCE/HISTORICAL_ARREAR
                        		return
                        		<HISTORICAL_ARREAR>{ data($HISTORICAL_ARREAR) }</HISTORICAL_ARREAR>
                        	}
                    		</REFERENCE>
            			)
            		}
                	</REFERENCE_BUREAU_TUCA>
            	) else ()
            }
            {
            	if (fn:exists($consultaConsolidadaRiesgoClienteResponse/LOAN_ORIGINATIONS/REFERENCES_DETAILS/REFERENCE_BUREAU_SIRC/REFERENCE)) then (
            		<REFERENCE_BUREAU_SIRC>
            		{
            			for $REFERENCE in $consultaConsolidadaRiesgoClienteResponse/LOAN_ORIGINATIONS/REFERENCES_DETAILS/REFERENCE_BUREAU_SIRC/REFERENCE
            			return(
            				<REFERENCE>
                        	{
                            	for $QUERY_ID in $REFERENCE/QUERY_ID
                            	return
                                <QUERY_ID>{ data($QUERY_ID) }</QUERY_ID>
                        	}
                        	{
                            	for $CREDITOR in $REFERENCE/CREDITOR
                            	return
                                <CREDITOR>{ data($CREDITOR) }</CREDITOR>
                        	}
                        	{
                            	for $ASSET_TYPE in $REFERENCE/ASSET_TYPE
                            	return
                                <ASSET_TYPE>{ data($ASSET_TYPE) }</ASSET_TYPE>
                        	}
                        	{
                            	for $WARRANTY_TYPE in $REFERENCE/WARRANTY_TYPE
                            	return
                                <WARRANTY_TYPE>{ data($WARRANTY_TYPE) }</WARRANTY_TYPE>
                        	}
                        	{
                            	for $CURRENCY in $REFERENCE/CURRENCY
                            	return
                                <CURRENCY>{ data($CURRENCY) }</CURRENCY>
                        	}
                        	{
                            	for $AMOUNT in $REFERENCE/AMOUNT
                            	return
                                <AMOUNT>{ data($AMOUNT) }</AMOUNT>
                        	}
                        	{
                        		for $BALANCE in $REFERENCE/BALANCE
                        		return
                        		<BALANCE>{ data($BALANCE) }</BALANCE>
                        	}
                        	{
                        		for $DUE_BALANCE in $REFERENCE/DUE_BALANCE
                        		return
                        		<DUE_BALANCE>{ data($DUE_BALANCE) }</DUE_BALANCE>
                        	}
                        	{
                        		for $OPENING_DATE in $REFERENCE/OPENING_DATE
                        		return
                        		<OPENING_DATE>{ data($OPENING_DATE) }</OPENING_DATE>
                        	}
                        	{
                            	for $CONSESSION_DATE in $REFERENCE/CONSESSION_DATE
                            	return
                                <CONSESSION_DATE>{ data($CONSESSION_DATE) }</CONSESSION_DATE>
                        	}
                        	{
                            	for $EXPIRATION_DATE in $REFERENCE/EXPIRATION_DATE
                            	return
                                <EXPIRATION_DATE>{ data($EXPIRATION_DATE) }</EXPIRATION_DATE>
                        	}
                        	{
                            	for $CANCELATION_DATE in $REFERENCE/CANCELATION_DATE
                            	return
                                <CANCELATION_DATE>{ data($CANCELATION_DATE) }</CANCELATION_DATE>
                        	}
                        	{
                            	for $HISTORICAL_ARREAR in $REFERENCE/HISTORICAL_ARREAR
                            	return
                                <HISTORICAL_ARREAR>{ data($HISTORICAL_ARREAR) }</HISTORICAL_ARREAR>
                        	}
                        	{
                            	for $CATEGORY in $REFERENCE/CATEGORY
                            	return
                                <CATEGORY>{ data($CATEGORY) }</CATEGORY>
                        	}
                        	{
                            	for $STATUS in $REFERENCE/STATUS
                            	return
                                <STATUS>{ data($STATUS) }</STATUS>
                        	}
                        	{
                            	for $TYPE in $REFERENCE/TYPE
                            	return
                                <TYPE>{ data($TYPE) }</TYPE>
                        	}
                        	{
                            	for $DEBTOR_TYPE in $REFERENCE/DEBTOR_TYPE
                            	return
                                <DEBTOR_TYPE>{ data($DEBTOR_TYPE) }</DEBTOR_TYPE>
                        	}
                    		</REFERENCE>
            			)
            		}
                	</REFERENCE_BUREAU_SIRC>
            	) else ()
            }
            {
            	if (fn:exists($originacionCreditoRequest/FOR_CONSOLIDATE/REFERENCE)) then (
            		<FOR_CONSOLIDATE>
            		{
            			for $REFERENCE in $originacionCreditoRequest/FOR_CONSOLIDATE/REFERENCE
            			return(
            				<FOR_CONSOLIDATE>
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
                            	for $CHECK_BENEFICIARY in $REFERENCE/CHECK_BENEFICIARY
                            	return
                                <CHECK_BENEFECIARY>{ data($CHECK_BENEFICIARY) }</CHECK_BENEFECIARY>
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
                    		</FOR_CONSOLIDATE>
            			)
            		}
            		</FOR_CONSOLIDATE>
            	) else ()
            }
            </REFERENCES_DETAILS>
        </ns0:consultaOfertaCreditoConsumoRequest>
};

declare variable $originacionCreditoRequest as element(ns1:originacionCreditoRequest) external;
declare variable $consultaConsolidadaRiesgoClienteResponse as element(ns2:consultaConsolidadaRiesgoClienteResponse) external;

xf:consultaOfertaCreditoConsumoIn($originacionCreditoRequest,
    $consultaConsolidadaRiesgoClienteResponse)
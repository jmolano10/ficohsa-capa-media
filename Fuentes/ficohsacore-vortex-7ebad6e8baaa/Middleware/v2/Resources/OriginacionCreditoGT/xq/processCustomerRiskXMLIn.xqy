xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaConsolidadaRiesgoClienteResponse" element="ns1:consultaConsolidadaRiesgoClienteResponse" location="../../ConsultaConsolidadaRiesgoCliente/xsd/consultaConsolidadaRiesgoClienteTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/CreditOrigination/ProcessCustomerRiskXML/xsd/processCustomerRiskXML_sp.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaConsolidadaRiesgoClienteTypes";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/processCustomerRiskXML";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/OriginacionCreditoGT/xq/processCustomerRiskXMLIn/";

declare function xf:buildXMLResponse($successIndicator as xs:string,
    $message as xs:string,
    $caseId as xs:string,
    $consultaConsolidadaRiesgoClienteResponse as element(ns1:consultaConsolidadaRiesgoClienteResponse))
    as element(*) {
    	<CONSOLIDATED_CUSTOMER_RISK_RESPONSE>
			<SUCCESS_INDICATOR>{ $successIndicator }</SUCCESS_INDICATOR>
			{
				if ($message != "") then (
					<MESSAGE>{ $message }</MESSAGE>
				) else ()
			}
			<CASE_ID>{ $caseId }</CASE_ID>
			{
				if (fn:exists($consultaConsolidadaRiesgoClienteResponse/LOAN_MAINTENANCE) and fn:not(fn:empty($consultaConsolidadaRiesgoClienteResponse/LOAN_MAINTENANCE))) then (
					<LOAN_MAINTENANCE>
					{
						for $CUSTOMER_INFO in $consultaConsolidadaRiesgoClienteResponse/LOAN_MAINTENANCE/CUSTOMER_INFO
						return(
							<CUSTOMER_INFO>
							{
								for $ID in $CUSTOMER_INFO/ID
								return
								<ID>{ fn:data($ID) }</ID>
							}
							{
								for $FISCAL_ID in $CUSTOMER_INFO/FISCAL_ID
								return
								<FISCAL_ID>{ fn:data($FISCAL_ID) }</FISCAL_ID>
							}
							{
								for $FIRST_NAME in $CUSTOMER_INFO/FIRST_NAME
								return
								<FIRST_NAME>{ fn:data($FIRST_NAME) }</FIRST_NAME>
							}
							{
								for $LAST_NAME in $CUSTOMER_INFO/LAST_NAME
								return
								<LAST_NAME>{ fn:data($LAST_NAME) }</LAST_NAME>
							}
							{
								for $BIRTH_DATE in $CUSTOMER_INFO/BIRTH_DATE
								return
								<BIRTH_DATE>{ fn:data($BIRTH_DATE) }</BIRTH_DATE>
							}
							{
								for $TARGET in $CUSTOMER_INFO/TARGET
								return
								<TARGET>{ fn:data($TARGET) }</TARGET>
							}
							{
								for $DATE_OF_BIRTH in $CUSTOMER_INFO/DATE_OF_BIRTH
								return
								<DATE_OF_BIRTH>{ fn:data($DATE_OF_BIRTH) }</DATE_OF_BIRTH>
							}
							{
								for $AGE in $CUSTOMER_INFO/AGE
								return
								<AGE>{ fn:data($AGE) }</AGE>
							}
							{
								for $TYPE in $CUSTOMER_INFO/TYPE
								return
								<TYPE>{ fn:data($TYPE) }</TYPE>
							}
							{
								for $SALARY in $CUSTOMER_INFO/SALARY
								return
								<SALARY>{ fn:data($SALARY) }</SALARY>
							}
							{
								for $PAYROLL_SALARY in $CUSTOMER_INFO/PAYROLL_SALARY
								return
								<PAYROLL_SALARY>{ fn:data($PAYROLL_SALARY) }</PAYROLL_SALARY>
							}
							{
								for $CREDIT_MONTHS in $CUSTOMER_INFO/CREDIT_MONTHS
								return
								<CREDIT_MONTHS>{ fn:data($CREDIT_MONTHS) }</CREDIT_MONTHS>
							}
							{
								for $FLAG_BLAZE in $CUSTOMER_INFO/FLAG_BLAZE
								return
								<FLAG_BLAZE>{ fn:data($FLAG_BLAZE) }</FLAG_BLAZE>
							}
							{
								for $FLAG_HIT in $CUSTOMER_INFO/FLAG_HIT
								return
								<FLAG_HIT>{ fn:data($FLAG_HIT) }</FLAG_HIT>
							}
							{
								for $EVALUATION_RESULT in $CUSTOMER_INFO/EVALUATION_RESULT
								return
								<EVALUATION_RESULT>{ fn:data($EVALUATION_RESULT) }</EVALUATION_RESULT>
							}
							{
								if (fn:exists($CUSTOMER_INFO/ADDRESSES_INFO/ADDRESS_ITEM)) then (
									<ADDRESSES_INFO>
									{
										for $ADDRESS_ITEM in $CUSTOMER_INFO/ADDRESSES_INFO/ADDRESS_ITEM
										return(
											<ADDRESS_ITEM>
											{
												for $PERIOD in $ADDRESS_ITEM/PERIOD
												return
												<PERIOD>{ fn:data($PERIOD) }</PERIOD>
											}
											{
												for $ADDRESS in $ADDRESS_ITEM/ADDRESS
												return
												<ADDRESS>{ fn:data($ADDRESS) }</ADDRESS>
											}
											</ADDRESS_ITEM>
										)
									}
									</ADDRESSES_INFO>
								) else ()
							}
							{
								if (fn:exists($CUSTOMER_INFO/PHONES_INFO/PHONE_ITEM)) then (
									<PHONES_INFO>
									{
										for $PHONE_ITEM in $CUSTOMER_INFO/PHONES_INFO/PHONE_ITEM
										return(
											<PHONE_ITEM>
											{
												for $PERIOD in $PHONE_ITEM/PERIOD
												return
												<PERIOD>{ fn:data($PERIOD) }</PERIOD>
											}
											{
												for $PHONE in $PHONE_ITEM/PHONE
												return
												<PHONE>{ fn:data($PHONE) }</PHONE>
											}
											</PHONE_ITEM>
										)
									}
									</PHONES_INFO>
								) else ()
							}
							{
								if (fn:exists($CUSTOMER_INFO/ADMINISTRATIVE_CHARGES/CHARGE)) then (
									<ADMINISTRATIVE_CHARGES>
									{
										for $CHARGE in $CUSTOMER_INFO/ADMINISTRATIVE_CHARGES/CHARGE
										return(
											<CHARGE>
											{
												for $ID in $CHARGE/ID
												return
												<ID>{ fn:data($ID) }</ID>
											}
											{
												for $INFORMATION_DATE in $CHARGE/INFORMATION_DATE
												return
												<INFORMATION_DATE>{ fn:data($INFORMATION_DATE) }</INFORMATION_DATE>
											}
											{
												for $IN_DATE in $CHARGE/IN_DATE
												return
												<IN_DATE>{ fn:data($IN_DATE) }</IN_DATE>
											}
											{
												for $CREDITOR in $CHARGE/CREDITOR
												return
												<CREDITOR>{ fn:data($CREDITOR) }</CREDITOR>
											}
											{
												for $MOTIVATION in $CHARGE/MOTIVATION
												return
												<MOTIVATION>{ fn:data($MOTIVATION) }</MOTIVATION>
											}
											{
												for $CURRENCY in $CHARGE/CURRENCY
												return
												<CURRENCY>{ fn:data($CURRENCY) }</CURRENCY>
											}
											{
												for $TOTAL_DEBT_AMOUNT in $CHARGE/TOTAL_DEBT_AMOUNT
												return
												<TOTAL_DEBT_AMOUNT>{ fn:data($TOTAL_DEBT_AMOUNT) }</TOTAL_DEBT_AMOUNT>
											}
											{
												for $EXCHANGE_FACTOR in $CHARGE/EXCHANGE_FACTOR
												return
												<EXCHANGE_FACTOR>{ fn:data($EXCHANGE_FACTOR) }</EXCHANGE_FACTOR>
											}
											</CHARGE>
										)
									}
									</ADMINISTRATIVE_CHARGES>
								) else ()
							}
							{
								if (fn:exists($CUSTOMER_INFO/CURRENT_ARREAR_SUMMARY/ARREAR)) then (
									<CURRENT_ARREAR_SUMMARY>
									{
										for $ARREAR in $CUSTOMER_INFO/CURRENT_ARREAR_SUMMARY/ARREAR
										return(
											<ARREAR>
											{
												for $ID in $ARREAR/ID
												return
												<ID>{ fn:data($ID) }</ID>
											}
											{
												for $INFORMATION_DATE in $ARREAR/INFORMATION_DATE
												return
												<INFORMATION_DATE>{ fn:data($INFORMATION_DATE) }</INFORMATION_DATE>
											}
											{
												for $DATE in $ARREAR/DATE
												return
												<DATE>{ fn:data($DATE) }</DATE>
											}
											{
												for $CREDITOR in $ARREAR/CREDITOR
												return
												<CREDITOR>{ fn:data($CREDITOR) }</CREDITOR>
											}
											{
												for $ACCOUNT_TYPE in $ARREAR/ACCOUNT_TYPE
												return
												<ACCOUNT_TYPE>{ fn:data($ACCOUNT_TYPE) }</ACCOUNT_TYPE>
											}
											{
												for $CURRENCY in $ARREAR/CURRENCY
												return
												<CURRENCY>{ fn:data($CURRENCY) }</CURRENCY>
											}
											{
												for $DAYS in $ARREAR/DAYS
												return
												<DAYS>{ fn:data($DAYS) }</DAYS>
											}
											{
												for $AMOUNT in $ARREAR/AMOUNT
												return
												<AMOUNT>{ fn:data($AMOUNT) }</AMOUNT>
											}
											{
												for $EXCHANGE_FACTOR in $ARREAR/EXCHANGE_FACTOR
												return
												<EXCHANGE_FACTOR>{ fn:data($EXCHANGE_FACTOR) }</EXCHANGE_FACTOR>
											}
											</ARREAR>
										)
									}
									</CURRENT_ARREAR_SUMMARY>
								) else ()
							}
							{
								for $EXTERNAL_SCORE in $CUSTOMER_INFO/EXTERNAL_SCORE
								return
								<EXTERNAL_SCORE>{ fn:data($EXTERNAL_SCORE) }</EXTERNAL_SCORE>
							}
							{
								if (fn:exists($CUSTOMER_INFO/SCORE_INFO)) then (
									<SCORE_INFO>
									{
										for $SCORE_CALCULATION in $CUSTOMER_INFO/SCORE_INFO/SCORE_CALCULATION
										return
										<SCORE_CALCULATION>{ fn:data($SCORE_CALCULATION) }</SCORE_CALCULATION>
									}
									{
										for $QUALIFICATION in $CUSTOMER_INFO/SCORE_INFO/QUALIFICATION
										return
										<QUALIFICATION>{ fn:data($QUALIFICATION) }</QUALIFICATION>
									}
									{
										for $RISK_LEVEL in $CUSTOMER_INFO/SCORE_INFO/RISK_LEVEL
										return
										<RISK_LEVEL>{ fn:data($RISK_LEVEL) }</RISK_LEVEL>
									}
									</SCORE_INFO>
								) else ()
							}
							{
								if(fn:exists($CUSTOMER_INFO/OFFERS/OFFER)) then (
									<OFFERS>
									{
										for $OFFER in $CUSTOMER_INFO/OFFERS/OFFER
										return(
											<OFFER>
											{
												for $PRODUCT_CODE in $OFFER/PRODUCT_CODE
												return
												<PRODUCT_CODE>{ fn:data($PRODUCT_CODE) }</PRODUCT_CODE>
											}
											{
												for $MAX_AMOUNT in $OFFER/MAX_AMOUNT
												return
												<MAX_AMOUNT>{ fn:data($MAX_AMOUNT) }</MAX_AMOUNT>
											}
											{
												for $INSTALLMENT in $OFFER/INSTALLMENT
												return
												<INSTALLMENT>{ fn:data($INSTALLMENT) }</INSTALLMENT>
											}
											{
												for $RATE in $OFFER/RATE
												return
												<RATE>{ fn:data($RATE) }</RATE>
											}
											{
												if (fn:exists($OFFER/AMOUNT_CALCULATIONS)) then (
													<AMOUNT_CALCULATIONS>
													{
														for $FOR_12_MONTHS in $OFFER/AMOUNT_CALCULATIONS/FOR_12_MONTHS
														return
														<FOR_12_MONTHS>{ fn:data($FOR_12_MONTHS) }</FOR_12_MONTHS>
													}
													{
														for $FOR_18_MONTHS in $OFFER/AMOUNT_CALCULATIONS/FOR_18_MONTHS
														return
														<FOR_18_MONTHS>{ fn:data($FOR_18_MONTHS) }</FOR_18_MONTHS>
													}
													{
														for $FOR_24_MONTHS in $OFFER/AMOUNT_CALCULATIONS/FOR_24_MONTHS
														return
														<FOR_24_MONTHS>{ fn:data($FOR_24_MONTHS) }</FOR_24_MONTHS>
													}
													{
														for $FOR_36_MONTHS in $OFFER/AMOUNT_CALCULATIONS/FOR_36_MONTHS
														return
														<FOR_36_MONTHS>{ fn:data($FOR_36_MONTHS) }</FOR_36_MONTHS>
													}
													{
														for $FOR_48_MONTHS in $OFFER/AMOUNT_CALCULATIONS/FOR_48_MONTHS
														return
														<FOR_48_MONTHS>{ fn:data($FOR_48_MONTHS) }</FOR_48_MONTHS>
													}
													{
														for $FOR_60_MONTHS in $OFFER/AMOUNT_CALCULATIONS/FOR_60_MONTHS
														return
														<FOR_60_MONTHS>{ fn:data($FOR_60_MONTHS) }</FOR_60_MONTHS>
													}
													</AMOUNT_CALCULATIONS>
												) else ()
											}
											{
												for $TIMES_INCOME in $OFFER/TIMES_INCOME
												return
												<TIMES_INCOME>{ fn:data($TIMES_INCOME) }</TIMES_INCOME>
											}
											{
												if (fn:exists($OFFER/RESOLUTION) and fn:not(fn:empty($OFFER/RESOLUTION))) then (
													<RESOLUTION>
													{
														for $CODE in $OFFER/RESOLUTION/CODE
														return
														<CODE>{ fn:data($CODE) }</CODE>
													}
													{
														for $DESCRIPTION in $OFFER/RESOLUTION/DESCRIPTION
														return
														<DESCRIPTION>{ fn:data($DESCRIPTION) }</DESCRIPTION>
													}
													</RESOLUTION>
												) else ()
											}
											</OFFER>
										)
									}
									</OFFERS>
								) else ()
							}
							{
								if (fn:exists($CUSTOMER_INFO/ASSETS/ASSET)) then (
									<ASSETS>
									{
										for $ASSET in $CUSTOMER_INFO/ASSETS/ASSET
										return(
											<ASSET>
											{
												for $NUMBER in $ASSET/NUMBER
												return
												<NUMBER>{ fn:data($NUMBER) }</NUMBER>
											}
											{
												for $CATEGORY in $ASSET/CATEGORY
												return
												<CATEGORY>{ fn:data($CATEGORY) }</CATEGORY>
											}
											{
												for $CURRENCY in $ASSET/CURRENCY
												return
												<CURRENCY>{ fn:data($CURRENCY) }</CURRENCY>
											}
											{
												for $OPENING_DATE in $ASSET/OPENING_DATE
												return
												<OPENING_DATE>{ fn:data($OPENING_DATE) }</OPENING_DATE>
											}
											{
												for $CANCELATION_DATE in $ASSET/CANCELATION_DATE
												return
												<CANCELATION_DATE>{ fn:data($CANCELATION_DATE) }</CANCELATION_DATE>
											}
											{
												for $CURRENT_BALANCE in $ASSET/CURRENT_BALANCE
												return
												<CURRENT_BALANCE>{ fn:data($CURRENT_BALANCE) }</CURRENT_BALANCE>
											}
											{
												for $END_OF_MONTH_BALANCE in $ASSET/END_OF_MONTH_BALANCE
												return
												<END_OF_MONTH_BALANCE>{ fn:data($END_OF_MONTH_BALANCE) }</END_OF_MONTH_BALANCE>
											}
											{
												for $AVERAGE_BALANCE in $ASSET/AVERAGE_BALANCE
												return
												<AVERAGE_BALANCE>{ fn:data($AVERAGE_BALANCE) }</AVERAGE_BALANCE>
											}
											{
												if (fn:exists($ASSET/PRODUCT_TRANSACTIONS) and fn:not(fn:empty($ASSET/PRODUCT_TRANSACTIONS))) then (
													<PRODUCT_TRANSACTIONS>
													{
														for $TRANSACTION in $ASSET/PRODUCT_TRANSACTIONS/TRANSACTION
														return(
															<TRANSACTION>
															{
																for $PERIOD_DATE in $TRANSACTION/PERIOD_DATE
																return
																<PERIOD_DATE>{ fn:data($PERIOD_DATE) }</PERIOD_DATE>
															}
															{
																for $PERIOD_BALANCE in $TRANSACTION/PERIOD_BALANCE
																return
																<PERIOD_BALANCE>{ fn:data($PERIOD_BALANCE) }</PERIOD_BALANCE>
															}
															{
																for $MAX_BALANCE in $TRANSACTION/MAX_BALANCE
																return
																<MAX_BALANCE>{ fn:data($MAX_BALANCE) }</MAX_BALANCE>
															}
															{
																for $MIN_BALANCE in $TRANSACTION/MIN_BALANCE
																return
																<MIN_BALANCE>{ fn:data($MIN_BALANCE) }</MIN_BALANCE>
															}
															{
																for $AVERAGE_BALANCE in $TRANSACTION/AVERAGE_BALANCE
																return
																<AVERAGE_BALANCE>{ fn:data($AVERAGE_BALANCE) }</AVERAGE_BALANCE>
															}
															{
																for $LAST_CREDIT_DATE in $TRANSACTION/LAST_CREDIT_DATE
																return
																<LAST_CREDIT_DATE>{ fn:data($LAST_CREDIT_DATE) }</LAST_CREDIT_DATE>
															}
															{
																for $LAST_DEBIT_DATE in $TRANSACTION/LAST_DEBIT_DATE
																return
																<LAST_DEBIT_DATE>{ fn:data($LAST_DEBIT_DATE) }</LAST_DEBIT_DATE>
															}
															{
																for $FACILITIES in $TRANSACTION/FACILITIES
																return
																<FACILITIES>{ fn:data($FACILITIES) }</FACILITIES>
															}
															{
																for $LEGAL_REPRESENTATIVE in $TRANSACTION/LEGAL_REPRESENTATIVE
																return
																<LEGAL_REPRESENTATIVE>{ fn:data($LEGAL_REPRESENTATIVE) }</LEGAL_REPRESENTATIVE>
															}
															{
																for $PAYROLL_ACCOUNTS in $TRANSACTION/PAYROLL_ACCOUNTS
																return
																<PAYROLL_ACCOUNTS>{ fn:data($PAYROLL_ACCOUNTS) }</PAYROLL_ACCOUNTS>
															}
															{
																for $PAYROLL_CREDIT_AMOUNT in $TRANSACTION/PAYROLL_CREDIT_AMOUNT
																return
																<PAYROLL_CREDIT_AMOUNT>{ fn:data($PAYROLL_CREDIT_AMOUNT) }</PAYROLL_CREDIT_AMOUNT>
															}
															{
																for $JOINT_ACCOUNTS in $TRANSACTION/JOINT_ACCOUNTS
																return
																<JOINT_ACCOUNTS>{ fn:data($JOINT_ACCOUNTS) }</JOINT_ACCOUNTS>
															}
															{
																for $PRODUCT_BLOCK in $TRANSACTION/PRODUCT_BLOCK
																return
																<PRODUCT_BLOCK>{ fn:data($PRODUCT_BLOCK) }</PRODUCT_BLOCK>
															}
															{
																if (fn:exists($TRANSACTION/CREDITS_INFO) and fn:not(fn:empty($TRANSACTION/CREDITS_INFO))) then (
																	<CREDITS_INFO>
																	{
																		for $AMOUNT_ON_PERIOD in $TRANSACTION/CREDITS_INFO/AMOUNT_ON_PERIOD
																		return
																		<AMOUNT_ON_PERIOD>{ fn:data($AMOUNT_ON_PERIOD) }</AMOUNT_ON_PERIOD>
																	}
																	{
																		for $SUMMATION in $TRANSACTION/CREDITS_INFO/SUMMATION
																		return
																		<SUMMATION>{ fn:data($SUMMATION) }</SUMMATION>
																	}
																	{
																		for $INTEREST_ON_PERIOD in $TRANSACTION/CREDITS_INFO/INTEREST_ON_PERIOD
																		return
																		<INTEREST_ON_PERIOD>{ fn:data($INTEREST_ON_PERIOD) }</INTEREST_ON_PERIOD>
																	}
																	{
																		for $INTERESTS_SUMMATION in $TRANSACTION/CREDITS_INFO/INTERESTS_SUMMATION
																		return
																		<INTERESTS_SUMMATION>{ fn:data($INTERESTS_SUMMATION) }</INTERESTS_SUMMATION>
																	}
																	</CREDITS_INFO>
																) else ()
															}
															{
																if (fn:exists($TRANSACTION/DEBITS_INFO) and fn:not(fn:empty($TRANSACTION/DEBITS_INFO))) then (
																	<DEBITS_INFO>
																	{
																		for $AMOUNT_ON_PERIOD in $TRANSACTION/DEBITS_INFO/AMOUNT_ON_PERIOD
																		return
																		<AMOUNT_ON_PERIOD>{ fn:data($AMOUNT_ON_PERIOD) }</AMOUNT_ON_PERIOD>
																	}
																	{
																		for $SUMMATION in $TRANSACTION/DEBITS_INFO/SUMMATION
																		return
																		<SUMMATION>{ fn:data($SUMMATION) }</SUMMATION>
																	}
																	{
																		for $INTEREST_ON_PERIOD in $TRANSACTION/DEBITS_INFO/INTEREST_ON_PERIOD
																		return
																		<INTEREST_ON_PERIOD>{ fn:data($INTEREST_ON_PERIOD) }</INTEREST_ON_PERIOD>
																	}
																	{
																		for $INTERESTS_SUMMATION in $TRANSACTION/DEBITS_INFO/INTERESTS_SUMMATION
																		return
																		<INTERESTS_SUMMATION>{ fn:data($INTERESTS_SUMMATION) }</INTERESTS_SUMMATION>
																	}
																	</DEBITS_INFO>
																) else ()
															}
															</TRANSACTION>
														)
													}
													</PRODUCT_TRANSACTIONS>
												) else ()
											}
											</ASSET>
										)
									}
				
									</ASSETS>
								) else ()
							}
							{
								if (fn:exists($CUSTOMER_INFO/LIABILITIES) and fn:not(fn:empty($CUSTOMER_INFO/LIABILITIES))) then (
									<LIABILITIES>
									{
										if(fn:exists($CUSTOMER_INFO/LIABILITIES/CREDIT_CARDS_INFO/CREDIT_CARD)) then (
											<CREDIT_CARDS_INFO>
											{
												for $CREDIT_CARD in $CUSTOMER_INFO/LIABILITIES/CREDIT_CARDS_INFO/CREDIT_CARD
												return(
													<CREDIT_CARD>
													{
														for $ACCOUNT in $CREDIT_CARD/ACCOUNT
														return
														<ACCOUNT>{ fn:data($ACCOUNT) }</ACCOUNT>
													}
													{
														for $BEHAVIOR_SCORE in $CREDIT_CARD/BEHAVIOR_SCORE
														return
														<BEHAVIOR_SCORE>{ fn:data($BEHAVIOR_SCORE) }</BEHAVIOR_SCORE>
													}
													{
														for $QUALIFICATION_SCORE in $CREDIT_CARD/QUALIFICATION_SCORE
														return
														<QUALIFICATION_SCORE>{ fn:data($QUALIFICATION_SCORE) }</QUALIFICATION_SCORE>
													}
													{
														for $QUALIFICATION_CUSTOMER_SCORE in $CREDIT_CARD/QUALIFICATION_CUSTOMER_SCORE
														return
														<QUALIFICATION_CUSTOMER_SCORE>{ fn:data($QUALIFICATION_CUSTOMER_SCORE) }</QUALIFICATION_CUSTOMER_SCORE>
													}
													{
														for $STATUS in $CREDIT_CARD/STATUS
														return
														<STATUS>{ fn:data($STATUS) }</STATUS>
													}
													{
														for $AFFINITY_GROUP in $CREDIT_CARD/AFFINITY_GROUP
														return
														<AFFINITY_GROUP>{ fn:data($AFFINITY_GROUP) }</AFFINITY_GROUP>
													}
													{
														for $PRODUCT in $CREDIT_CARD/PRODUCT
														return
														<PRODUCT>{ fn:data($PRODUCT) }</PRODUCT>
													}
													{
														for $CLEARING_MODEL in $CREDIT_CARD/CLEARING_MODEL
														return
														<CLEARING_MODEL>{ fn:data($CLEARING_MODEL) }</CLEARING_MODEL>
													}
													{
														for $OPENING_DATE in $CREDIT_CARD/OPENING_DATE
														return
														<OPENING_DATE>{ fn:data($OPENING_DATE) }</OPENING_DATE>
													}
													{
														for $CANCELATION_DATE in $CREDIT_CARD/CANCELATION_DATE
														return
														<CANCELATION_DATE>{ fn:data($CANCELATION_DATE) }</CANCELATION_DATE>
													}
													{
														for $LAST_EXTRA_DATE in $CREDIT_CARD/LAST_EXTRA_DATE
														return
														<LAST_EXTRA_DATE>{ fn:data($LAST_EXTRA_DATE) }</LAST_EXTRA_DATE>
													}
													{
														for $CURRENT_DUE in $CREDIT_CARD/CURRENT_DUE
														return
														<CURRENT_DUE>{ fn:data($CURRENT_DUE) }</CURRENT_DUE>
													}
													{
														for $CURRENT_LIMIT in $CREDIT_CARD/CURRENT_LIMIT
														return
														<CURRENT_LIMIT>{ fn:data($CURRENT_LIMIT) }</CURRENT_LIMIT>
													}
													{
														for $CURRENT_BALANCE in $CREDIT_CARD/CURRENT_BALANCE
														return
														<CURRENT_BALANCE>{ fn:data($CURRENT_BALANCE) }</CURRENT_BALANCE>
													}
													{
														for $CLOSING_BALANCE in $CREDIT_CARD/CLOSING_BALANCE
														return
														<CLOSING_BALANCE>{ fn:data($CLOSING_BALANCE) }</CLOSING_BALANCE>
													}
													{
														for $EXTRA_BALANCE in $CREDIT_CARD/EXTRA_BALANCE
														return
														<EXTRA_BALANCE>{ fn:data($EXTRA_BALANCE) }</EXTRA_BALANCE>
													}
													{
														for $INTRA_BALANCE in $CREDIT_CARD/INTRA_BALANCE
														return
														<INTRA_BALANCE>{ fn:data($INTRA_BALANCE) }</INTRA_BALANCE>
													}
													{
														for $ACTIVE_EXTRA_INSTALLMENTS in $CREDIT_CARD/ACTIVE_EXTRA_INSTALLMENTS
														return
														<ACTIVE_EXTRA_INSTALLMENTS>{ fn:data($ACTIVE_EXTRA_INSTALLMENTS) }</ACTIVE_EXTRA_INSTALLMENTS>
													}
													{
														for $CASH_DISCOUNT_DATE in $CREDIT_CARD/CASH_DISCOUNT_DATE
														return
														<CASH_DISCOUNT_DATE>{ fn:data($CASH_DISCOUNT_DATE) }</CASH_DISCOUNT_DATE>
													}
													{
														for $SECOND_ACCOUNT_NEW_LIMIT in $CREDIT_CARD/SECOND_ACCOUNT_NEW_LIMIT
														return
														<SECOND_ACCOUNT_NEW_LIMIT>{ fn:data($SECOND_ACCOUNT_NEW_LIMIT) }</SECOND_ACCOUNT_NEW_LIMIT>
													}
													{
														for $SECOND_ACCOUNT_REJECTION in $CREDIT_CARD/SECOND_ACCOUNT_REJECTION
														return
														<SECOND_ACCOUNT_REJECTION>{ fn:data($SECOND_ACCOUNT_REJECTION) }</SECOND_ACCOUNT_REJECTION>
													}
													{
														for $LOCKCODE1 in $CREDIT_CARD/LOCKCODE1
														return
														<LOCKCODE1>{ fn:data($LOCKCODE1) }</LOCKCODE1>
													}
													{
														for $LOCKCODE2 in $CREDIT_CARD/LOCKCODE2
														return
														<LOCKCODE2>{ fn:data($LOCKCODE2) }</LOCKCODE2>
													}
													{
														for $LOGO in $CREDIT_CARD/LOGO
														return
														<LOGO>{ fn:data($LOGO) }</LOGO>
													}
													{
														for $AVAILABLE_CASH in $CREDIT_CARD/AVAILABLE_CASH
														return
														<AVAILABLE_CASH>{ fn:data($AVAILABLE_CASH) }</AVAILABLE_CASH>
													}
													{
														for $LOCK_DATE1 in $CREDIT_CARD/LOCK_DATE1
														return
														<LOCK_DATE1>{ fn:data($LOCK_DATE1) }</LOCK_DATE1>
													}
													{
														for $LOCK_DATE2 in $CREDIT_CARD/LOCK_DATE2
														return
														<LOCK_DATE2>{ fn:data($LOCK_DATE2) }</LOCK_DATE2>
													}
													{
														for $BIN in $CREDIT_CARD/BIN
														return
														<BIN>{ fn:data($BIN) }</BIN>
													}
													{
														for $EXTRA_APPROVAL_DATE in $CREDIT_CARD/EXTRA_APPROVAL_DATE
														return
														<EXTRA_APPROVAL_DATE>{ fn:data($EXTRA_APPROVAL_DATE) }</EXTRA_APPROVAL_DATE>
													}
													{
														for $INTRA_APPROVAL_DATE in $CREDIT_CARD/INTRA_APPROVAL_DATE
														return
														<INTRA_APPROVAL_DATE>{ fn:data($INTRA_APPROVAL_DATE) }</INTRA_APPROVAL_DATE>
													}
													{
														for $PIL_APPROVAL_DATE in $CREDIT_CARD/PIL_APPROVAL_DATE
														return
														<PIL_APPROVAL_DATE>{ fn:data($PIL_APPROVAL_DATE) }</PIL_APPROVAL_DATE>
													}
													{
														for $PRIOR_LIMIT in $CREDIT_CARD/PRIOR_LIMIT
														return
														<PRIOR_LIMIT>{ fn:data($PRIOR_LIMIT) }</PRIOR_LIMIT>
													}
													{
														for $AUTH_BALANCE in $CREDIT_CARD/AUTH_BALANCE
														return
														<AUTH_BALANCE>{ fn:data($AUTH_BALANCE) }</AUTH_BALANCE>
													}
													{
														if (fn:exists($CREDIT_CARD/PRODUCT_TRANSACTIONS/TRANSACTION)) then (
															<PRODUCT_TRANSACTIONS>
															{
																for $TRANSACTION in $CREDIT_CARD/PRODUCT_TRANSACTIONS/TRANSACTION
																return(
																	<TRANSACTION>
																	{
																		for $PERIOD_DATE in $TRANSACTION/PERIOD_DATE
																		return
																		<PERIOD_DATE>{ fn:data($PERIOD_DATE) }</PERIOD_DATE>
																	}
																	{
																		for $PERIOD_BALANCE in $TRANSACTION/PERIOD_BALANCE
																		return
																		<PERIOD_BALANCE>{ fn:data($PERIOD_BALANCE) }</PERIOD_BALANCE>
																	}
																	{
																		for $AMOUNT_DUE in $TRANSACTION/AMOUNT_DUE
																		return
																		<AMOUNT_DUE>{ fn:data($AMOUNT_DUE) }</AMOUNT_DUE>
																	}
																	{
																		for $PAYMENTS in $TRANSACTION/PAYMENTS
																		return
																		<PAYMENTS>{ fn:data($PAYMENTS) }</PAYMENTS>
																	}
																	{
																		for $MERCH_SALES in $TRANSACTION/MERCH_SALES
																		return
																		<MERCH_SALES>{ fn:data($MERCH_SALES) }</MERCH_SALES>
																	}
																	{
																		for $CASH_WITHDRAWAL in $TRANSACTION/CASH_WITHDRAWAL
																		return
																		<CASH_WITHDRAWAL>{ fn:data($CASH_WITHDRAWAL) }</CASH_WITHDRAWAL>
																	}
																	{
																		for $LIMIT in $TRANSACTION/LIMIT
																		return
																		<LIMIT>{ fn:data($LIMIT) }</LIMIT>
																	}
																	{
																		for $OTHER_TRANSACTIONS in $TRANSACTION/OTHER_TRANSACTIONS
																		return
																		<OTHER_TRANSACTIONS>{ fn:data($OTHER_TRANSACTIONS) }</OTHER_TRANSACTIONS>
																	}
																	{
																		for $INTEREST in $TRANSACTION/INTEREST
																		return
																		<INTEREST>{ fn:data($INTEREST) }</INTEREST>
																	}
																	{
																		for $TOTAL_FEES in $TRANSACTION/TOTAL_FEES
																		return
																		<TOTAL_FEES>{ fn:data($TOTAL_FEES) }</TOTAL_FEES>
																	}
																	{
																		for $OTHER_DEBITS in $TRANSACTION/OTHER_DEBITS
																		return
																		<OTHER_DEBITS>{ fn:data($OTHER_DEBITS) }</OTHER_DEBITS>
																	}
																	{
																		for $CYCLE_DUE in $TRANSACTION/CYCLE_DUE
																		return
																		<CYCLE_DUE>{ fn:data($CYCLE_DUE) }</CYCLE_DUE>
																	}
																	{
																		for $CYCLE_TOTAL_BALANCE in $TRANSACTION/CYCLE_TOTAL_BALANCE
																		return
																		<CYCLE_TOTAL_BALANCE>{ fn:data($CYCLE_TOTAL_BALANCE) }</CYCLE_TOTAL_BALANCE>
																	}
																	{
																		if (fn:exists($TRANSACTION/EXTRA_CASH_INFO) and fn:not(fn:empty($TRANSACTION/EXTRA_CASH_INFO))) then (
																			<EXTRA_CASH_INFO>
																			{
																				for $BALANCE in $TRANSACTION/EXTRA_CASH_INFO/BALANCE
																				return
																				<BALANCE>{ fn:data($BALANCE) }</BALANCE>
																			}
																			{
																				for $INSTALLMENT in $TRANSACTION/EXTRA_CASH_INFO/INSTALLMENT
																				return
																				<INSTALLMENT>{ fn:data($INSTALLMENT) }</INSTALLMENT>
																			}
																			{
																				for $INTEREST in $TRANSACTION/EXTRA_CASH_INFO/INTEREST
																				return
																				<INTEREST>{ fn:data($INTEREST) }</INTEREST>
																			}
																			{
																				for $FEE in $TRANSACTION/EXTRA_CASH_INFO/FEE
																				return
																				<FEE>{ fn:data($FEE) }</FEE>
																			}
																			</EXTRA_CASH_INFO>
																		) else ()
																	}
																	{
																		if (fn:exists($TRANSACTION/INTRA_CASH_INFO) and fn:not(fn:empty($TRANSACTION/INTRA_CASH_INFO))) then (
																			<INTRA_CASH_INFO>
																			{
																				for $BALANCE in $TRANSACTION/INTRA_CASH_INFO/BALANCE
																				return
																				<BALANCE>{ fn:data($BALANCE) }</BALANCE>
																			}
																			{
																				for $INSTALLMENT in $TRANSACTION/INTRA_CASH_INFO/INSTALLMENT
																				return
																				<INSTALLMENT>{ fn:data($INSTALLMENT) }</INSTALLMENT>
																			}
																			{
																				for $INTEREST in $TRANSACTION/INTRA_CASH_INFO/INTEREST
																				return
																				<INTEREST>{ fn:data($INTEREST) }</INTEREST>
																			}
																			{
																				for $FEE in $TRANSACTION/INTRA_CASH_INFO/FEE
																				return
																				<FEE>{ fn:data($FEE) }</FEE>
																			}
																			</INTRA_CASH_INFO>
																		) else ()
																	}
																	{
																		for $EXTRA_FEE in $TRANSACTION/EXTRA_FEE
																		return
																		<EXTRA_FEE>{ fn:data($EXTRA_FEE) }</EXTRA_FEE>
																	}
																	{
																		for $INTRA_FEE in $TRANSACTION/INTRA_FEE
																		return
																		<INTRA_FEE>{ fn:data($INTRA_FEE) }</INTRA_FEE>
																	}
																	{
																		for $EXTRA_BALANCE in $TRANSACTION/EXTRA_BALANCE
																		return
																		<EXTRA_BALANCE>{ fn:data($EXTRA_BALANCE) }</EXTRA_BALANCE>
																	}
																	{
																		for $INTRA_BALANCE in $TRANSACTION/INTRA_BALANCE
																		return
																		<INTRA_BALANCE>{ fn:data($INTRA_BALANCE) }</INTRA_BALANCE>
																	}
																	</TRANSACTION>
																)
															}
							
															</PRODUCT_TRANSACTIONS>
														) else ()
													}
													{
														for $LAST_INTRA_DATE in $CREDIT_CARD/LAST_INTRA_DATE
														return
														<LAST_INTRA_DATE>{ fn:data($LAST_INTRA_DATE) }</LAST_INTRA_DATE>
													}
													{
														for $LAST_PIL_DATE in $CREDIT_CARD/LAST_PIL_DATE
														return
														<LAST_PIL_DATE>{ fn:data($LAST_PIL_DATE) }</LAST_PIL_DATE>
													}
													{
														for $HISTORICAL_ARREA_LOC in $CREDIT_CARD/HISTORICAL_ARREA_LOC
														return
														<HISTORICAL_ARREA_LOC>{ fn:data($HISTORICAL_ARREA_LOC) }</HISTORICAL_ARREA_LOC>
													}
													{
														for $HISTORICAL_ARREA_USD in $CREDIT_CARD/HISTORICAL_ARREA_USD
														return
														<HISTORICAL_ARREA_USD>{ fn:data($HISTORICAL_ARREA_USD) }</HISTORICAL_ARREA_USD>
													}
													{
														for $CHARGE_OFF_FLAG in $CREDIT_CARD/CHARGE_OFF_FLAG
														return
														<CHARGE_OFF_FLAG>{ fn:data($CHARGE_OFF_FLAG) }</CHARGE_OFF_FLAG>
													}
													</CREDIT_CARD>
												)
											}
					
											</CREDIT_CARDS_INFO>
										) else ()
									}
									{
										if(fn:exists($CUSTOMER_INFO/LIABILITIES/LOANS_INFO/LOAN)) then (
											<LOANS_INFO>
											{
												for $LOAN in $CUSTOMER_INFO/LIABILITIES/LOANS_INFO/LOAN
												return(
													<LOAN>
													{
														for $NUMBER in $LOAN/NUMBER
														return
														<NUMBER>{ fn:data($NUMBER) }</NUMBER>
													}
													{
														for $AGENCY_CODE in $LOAN/AGENCY_CODE
														return
														<AGENCY_CODE>{ fn:data($AGENCY_CODE) }</AGENCY_CODE>
													}
													{
														for $SUB_APPLICATION in $LOAN/SUB_APPLICATION
														return
														<SUB_APPLICATION>{ fn:data($SUB_APPLICATION) }</SUB_APPLICATION>
													}
													{
														for $OPENING_DATE in $LOAN/OPENING_DATE
														return
														<OPENING_DATE>{ fn:data($OPENING_DATE) }</OPENING_DATE>
													}
													{
														for $CANCELATION_DATE in $LOAN/CANCELATION_DATE
														return
														<CANCELATION_DATE>{ fn:data($CANCELATION_DATE) }</CANCELATION_DATE>
													}
													{
														for $INITIAL_AMOUNT in $LOAN/INITIAL_AMOUNT
														return
														<INITIAL_AMOUNT>{ fn:data($INITIAL_AMOUNT) }</INITIAL_AMOUNT>
													}
													{
														for $CURRENT_BALANCE in $LOAN/CURRENT_BALANCE
														return
														<CURRENT_BALANCE>{ fn:data($CURRENT_BALANCE) }</CURRENT_BALANCE>
													}
													{
														for $PAYMENT_AMOUNT in $LOAN/PAYMENT_AMOUNT
														return
														<PAYMENT_AMOUNT>{ fn:data($PAYMENT_AMOUNT) }</PAYMENT_AMOUNT>
													}
													{
														for $RATE in $LOAN/RATE
														return
														<RATE>{ fn:data($RATE) }</RATE>
													}
													{
														for $TERM in $LOAN/TERM
														return
														<TERM>{ fn:data($TERM) }</TERM>
													}
													{
														for $PAYMENT_NUMBER in $LOAN/PAYMENT_NUMBER
														return
														<PAYMENT_NUMBER>{ fn:data($PAYMENT_NUMBER) }</PAYMENT_NUMBER>
													}
													{
														for $FIRST_CAPITAL_PAYMENT_DATE in $LOAN/FIRST_CAPITAL_PAYMENT_DATE
														return
														<FIRST_CAPITAL_PAYMENT_DATE>{ fn:data($FIRST_CAPITAL_PAYMENT_DATE) }</FIRST_CAPITAL_PAYMENT_DATE>
													}
													{
														for $LAST_PAYMENT_DATE in $LOAN/LAST_PAYMENT_DATE
														return
														<LAST_PAYMENT_DATE>{ fn:data($LAST_PAYMENT_DATE) }</LAST_PAYMENT_DATE>
													}
													{
														for $PAID_PAYMENTS in $LOAN/PAID_PAYMENTS
														return
														<PAID_PAYMENTS>{ fn:data($PAID_PAYMENTS) }</PAID_PAYMENTS>
													}
													{
														for $CAPITAL_FREQUENCY in $LOAN/CAPITAL_FREQUENCY
														return
														<CAPITAL_FREQUENCY>{ fn:data($CAPITAL_FREQUENCY) }</CAPITAL_FREQUENCY>
													}
													{
														for $DESTINATION_CODE in $LOAN/DESTINATION_CODE
														return
														<DESTINATION_CODE>{ fn:data($DESTINATION_CODE) }</DESTINATION_CODE>
													}
													{
														for $MONTHLY_PRIME in $LOAN/MONTHLY_PRIME
														return
														<MONTHLY_PRIME>{ fn:data($MONTHLY_PRIME) }</MONTHLY_PRIME>
													}
													{
														for $CONTRACT_NUMBER in $LOAN/CONTRACT_NUMBER
														return
														<CONTRACT_NUMBER>{ fn:data($CONTRACT_NUMBER) }</CONTRACT_NUMBER>
													}
													{
														for $CHARGES in $LOAN/CHARGES
														return
														<CHARGES>{ fn:data($CHARGES) }</CHARGES>
													}
													{
														for $INTEREST in $LOAN/INTEREST
														return
														<INTEREST>{ fn:data($INTEREST) }</INTEREST>
													}
													{
														for $INSURANCE in $LOAN/INSURANCE
														return
														<INSURANCE>{ fn:data($INSURANCE) }</INSURANCE>
													}
													{
														for $OTHER_CHARGES in $LOAN/OTHER_CHARGES
														return
														<OTHER_CHARGES>{ fn:data($OTHER_CHARGES) }</OTHER_CHARGES>
													}
													{
														for $CURRENT_DUE in $LOAN/CURRENT_DUE
														return
														<CURRENT_DUE>{ fn:data($CURRENT_DUE) }</CURRENT_DUE>
													}
													{
														for $DEBTOR_TYPE in $LOAN/DEBTOR_TYPE
														return
														<DEBTOR_TYPE>{ fn:data($DEBTOR_TYPE) }</DEBTOR_TYPE>
													}
													{
														for $CODE_TYPE in $LOAN/CODE_TYPE
														return
														<CODE_TYPE>{ fn:data($CODE_TYPE) }</CODE_TYPE>
													}
													{
														for $GUARANTEE_TYPE in $LOAN/GUARANTEE_TYPE
														return
														<GUARANTEE_TYPE>{ fn:data($GUARANTEE_TYPE) }</GUARANTEE_TYPE>
													}
													{
														if (fn:exists($LOAN/PRODUCT_TRANSACTIONS/TRANSACTION)) then (
															<PRODUCT_TRANSACTIONS>
															{
																for $TRANSACTION in $LOAN/PRODUCT_TRANSACTIONS/TRANSACTION
																return(
																	<TRANSACTION>
																	{
																		for $PERIOD_DATE in $TRANSACTION/PERIOD_DATE
																		return
																		<PERIOD_DATE>{ fn:data($PERIOD_DATE) }</PERIOD_DATE>
																	}
																	{
																		for $PERIOD_BALANCE in $TRANSACTION/PERIOD_BALANCE
																		return
																		<PERIOD_BALANCE>{ fn:data($PERIOD_BALANCE) }</PERIOD_BALANCE>
																	}
																	{
																		for $CAPITAL_BALANCE in $TRANSACTION/CAPITAL_BALANCE
																		return
																		<CAPITAL_BALANCE>{ fn:data($CAPITAL_BALANCE) }</CAPITAL_BALANCE>
																	}
																	{
																		for $DUE_BALANCE in $TRANSACTION/DUE_BALANCE
																		return
																		<DUE_BALANCE>{ fn:data($DUE_BALANCE) }</DUE_BALANCE>
																	}
																	{
																		for $CHARGES in $TRANSACTION/CHARGES
																		return
																		<CHARGES>{ fn:data($CHARGES) }</CHARGES>
																	}
																	{
																		for $INTEREST in $TRANSACTION/INTEREST
																		return
																		<INTEREST>{ fn:data($INTEREST) }</INTEREST>
																	}
																	{
																		for $PAYMENT in $TRANSACTION/PAYMENT
																		return
																		<PAYMENT>{ fn:data($PAYMENT) }</PAYMENT>
																	}
																	{
																		for $INSURANCE in $TRANSACTION/INSURANCE
																		return
																		<INSURANCE>{ fn:data($INSURANCE) }</INSURANCE>
																	}
																	{
																		for $OTHER_CHARGES in $TRANSACTION/OTHER_CHARGES
																		return
																		<OTHER_CHARGES>{ fn:data($OTHER_CHARGES) }</OTHER_CHARGES>
																	}
																	{
																		for $CYCLE_DUE in $TRANSACTION/CYCLE_DUE
																		return
																		<CYCLE_DUE>{ fn:data($CYCLE_DUE) }</CYCLE_DUE>
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
								) else ()
								
							}
							{
								for $REFERENCIA_SIB in $CUSTOMER_INFO/ID
								return
								<ID>{ fn:data($REFERENCIA_SIB) }</ID>
							}
							</CUSTOMER_INFO>
						)
					}
					</LOAN_MAINTENANCE>
				) else ()
			}
			{
				if (fn:exists($consultaConsolidadaRiesgoClienteResponse/LOAN_ORIGINATIONS) and fn:not(fn:empty($consultaConsolidadaRiesgoClienteResponse/LOAN_ORIGINATIONS))) then (
					<LOAN_ORIGINATIONS>
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
										<INFORMATION_DATE>{ fn:data($INFORMATION_DATE) }</INFORMATION_DATE>
									}
									{
										for $TYPE in $OFFER/TYPE
										return
										<TYPE>{ fn:data($TYPE) }</TYPE>
									}
									{
										if (fn:exists($OFFER/DETAILS) and fn:not(fn:empty($OFFER/DETAILS))) then (
											<DETAILS>
											{
												for $FOR_12_MONTHS in $OFFER/DETAILS/FOR_12_MONTHS
												return
												<FOR_12_MONTHS>{ fn:data($FOR_12_MONTHS) }</FOR_12_MONTHS>
											}
											{
												for $FOR_18_MONTHS in $OFFER/DETAILS/FOR_18_MONTHS
												return
												<FOR_18_MONTHS>{ fn:data($FOR_18_MONTHS) }</FOR_18_MONTHS>
											}
											{
												for $FOR_24_MONTHS in $OFFER/DETAILS/FOR_24_MONTHS
												return
												<FOR_24_MONTHS>{ fn:data($FOR_24_MONTHS) }</FOR_24_MONTHS>
											}
											{
												for $FOR_36_MONTHS in $OFFER/DETAILS/FOR_36_MONTHS
												return
												<FOR_36_MONTHS>{ fn:data($FOR_36_MONTHS) }</FOR_36_MONTHS>
											}
											{
												for $FOR_48_MONTHS in $OFFER/DETAILS/FOR_48_MONTHS
												return
												<FOR_48_MONTHS>{ fn:data($FOR_48_MONTHS) }</FOR_48_MONTHS>
											}
											{
												for $FOR_60_MONTHS in $OFFER/DETAILS/FOR_60_MONTHS
												return
												<FOR_60_MONTHS>{ fn:data($FOR_60_MONTHS) }</FOR_60_MONTHS>
											}
											</DETAILS>
										) else ()
									}
									{
										for $INSTALLMENT in $OFFER/INSTALLMENT
										return
										<INSTALLMENT>{ fn:data($INSTALLMENT) }</INSTALLMENT>
									}
									{
										for $RATE in $OFFER/RATE
										return
										<RATE>{ fn:data($RATE) }</RATE>
									}
									{
										for $TIMES_INCOME in $OFFER/RATE
										return
										<TIMES_INCOME>{ fn:data($TIMES_INCOME) }</TIMES_INCOME>
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
										<ACCOUNT_NUMBER>{ fn:data($ACCOUNT_NUMBER) }</ACCOUNT_NUMBER>
									}
									{
										for $DATE in $EXTRA/DATE
										return
										<DATE>{ fn:data($DATE) }</DATE>
									}
									{
										for $RATE in $EXTRA/RATE
										return
										<RATE>{ fn:data($RATE) }</RATE>
									}
									{
										for $AMOUNT in $EXTRA/AMOUNT
										return
										<AMOUNT>{ fn:data($AMOUNT) }</AMOUNT>
									}
									{
										for $INSTALLMENT in $EXTRA/INSTALLMENT
										return
										<INSTALLMENT>{ fn:data($INSTALLMENT) }</INSTALLMENT>
									}
									{
										for $INSTALLMENT_COUNT in $EXTRA/INSTALLMENT_COUNT
										return
										<INSTALLMENT_COUNT>{ fn:data($INSTALLMENT_COUNT) }</INSTALLMENT_COUNT>
									}
									{
										for $TOTAL_INSTALLMENT in $EXTRA/TOTAL_INSTALLMENT
										return
										<TOTAL_INSTALLMENT>{ fn:data($TOTAL_INSTALLMENT) }</TOTAL_INSTALLMENT>
									}
									</EXTRA>
								)
							}
							</INTERNAL_EXTRAS>
						) else ()
					}
					{
						if (fn:exists($consultaConsolidadaRiesgoClienteResponse/LOAN_ORIGINATIONS/REFERENCES_DETAILS) and fn:not(fn:empty($consultaConsolidadaRiesgoClienteResponse/LOAN_ORIGINATIONS/REFERENCES_DETAILS))) then (
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
												<ID>{ fn:data($ID) }</ID>
											}
											{
												for $DATE in $QUERY_ITEM/DATE
												return
												<DATE>{ fn:data($DATE) }</DATE>
											}
											{
												for $ENTITY in $QUERY_ITEM/ENTITY
												return
												<ENTITY>{ fn:data($ENTITY) }</ENTITY>
											}
											{
												for $TYPE in $QUERY_ITEM/TYPE
												return
												<TYPE>{ fn:data($TYPE) }</TYPE>
											}
											</QUERY_ITEM>
										)
									}
									</QUERIES>
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
												<QUERY_ID>{ fn:data($QUERY_ID) }</QUERY_ID>
											}
											{
												for $TYPE in $REFERENCE/TYPE
												return
												<TYPE>{ fn:data($TYPE) }</TYPE>
											}
											{
												for $REFERENCE_NUMBER in $REFERENCE/REFERENCE_NUMBER
												return
												<REFERENCE_NUMBER>{ fn:data($REFERENCE_NUMBER) }</REFERENCE_NUMBER>
											}
											{
												for $OBLIGATION_CODE in $REFERENCE/OBLIGATION_CODE
												return
												<OBLIGATION_CODE>{ fn:data($OBLIGATION_CODE) }</OBLIGATION_CODE>
											}
											{
												for $OBLIGATION_TYPE in $REFERENCE/OBLIGATION_TYPE
												return
												<OBLIGATION_TYPE>{ fn:data($OBLIGATION_TYPE) }</OBLIGATION_TYPE>
											}
											{
												for $OBLIGATION_SECTOR in $REFERENCE/OBLIGATION_SECTOR
												return
												<OBLIGATION_SECTOR>{ fn:data($OBLIGATION_SECTOR) }</OBLIGATION_SECTOR>
											}
											{
												for $CREDITOR in $REFERENCE/CREDITOR
												return
												<CREDITOR>{ fn:data($CREDITOR) }</CREDITOR>
											}
											{
												for $CREDIT_TYPE in $REFERENCE/CREDIT_TYPE
												return
												<CREDIT_TYPE>{ fn:data($CREDIT_TYPE) }</CREDIT_TYPE>
											}
											{
												for $GUARANTEE_TYPE in $REFERENCE/GUARANTEE_TYPE
												return
												<GUARANTEE_TYPE>{ fn:data($GUARANTEE_TYPE) }</GUARANTEE_TYPE>
											}
											{
												for $OPENING_DATE in $REFERENCE/OPENING_DATE
												return
												<OPENING_DATE>{ fn:data($OPENING_DATE) }</OPENING_DATE>
											}
											{
												for $CANCELATION_DATE in $REFERENCE/CANCELATION_DATE
												return
												<CANCELATION_DATE>{ fn:data($CANCELATION_DATE) }</CANCELATION_DATE>
											}
											{
												for $INFORMATION_DATE in $REFERENCE/INFORMATION_DATE
												return
												<INFORMATION_DATE>{ fn:data($INFORMATION_DATE) }</INFORMATION_DATE>
											}
											{
												for $PAYMENT_METHOD in $REFERENCE/PAYMENT_METHOD
												return
												<PAYMENT_METHOD>{ fn:data($PAYMENT_METHOD) }</PAYMENT_METHOD>
											}
											{
												for $CATEGORY in $REFERENCE/CATEGORY
												return
												<CATEGORY>{ fn:data($CATEGORY) }</CATEGORY>
											}
											{
												for $CURRENCY in $REFERENCE/CURRENCY
												return
												<CURRENCY>{ fn:data($CURRENCY) }</CURRENCY>
											}
											{
												for $CREDIT_STATUS in $REFERENCE/CREDIT_STATUS
												return
												<CREDIT_STATUS>{ fn:data($CREDIT_STATUS) }</CREDIT_STATUS>
											}
											{
												for $STATUS in $REFERENCE/STATUS
												return
												<STATUS>{ fn:data($STATUS) }</STATUS>
											}
											{
												for $LIMIT in $REFERENCE/LIMIT
												return
												<LIMIT>{ fn:data($LIMIT) }</LIMIT>
											}
											{
												for $BALANCE in $REFERENCE/BALANCE
												return
												<BALANCE>{ fn:data($BALANCE) }</BALANCE>
											}
											{
												for $ARREAR_BALANCE in $REFERENCE/ARREAR_BALANCE
												return
												<ARREAR_BALANCE>{ fn:data($ARREAR_BALANCE) }</ARREAR_BALANCE>
											}
											{
												for $INSTALLMENT in $REFERENCE/INSTALLMENT
												return
												<INSTALLMENT>{ fn:data($INSTALLMENT) }</INSTALLMENT>
											}
											{
												for $LAST_MOVEMENT_MONTH in $REFERENCE/LAST_MOVEMENT_MONTH
												return
												<LAST_MOVEMENT_MONTH>{ fn:data($LAST_MOVEMENT_MONTH) }</LAST_MOVEMENT_MONTH>
											}
											{
												for $LAST_MOVEMENT_YEAR in $REFERENCE/LAST_MOVEMENT_YEAR
												return
												<LAST_MOVEMENT_YEAR>{ fn:data($LAST_MOVEMENT_YEAR) }</LAST_MOVEMENT_YEAR>
											}
											{
												for $HISTORICAL_ARREAR in $REFERENCE/HISTORICAL_ARREAR
												return
												<HISTORICAL_ARREAR>{ fn:data($HISTORICAL_ARREAR) }</HISTORICAL_ARREAR>
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
												<QUERY_ID>{ fn:data($QUERY_ID) }</QUERY_ID>
											}
											{
												for $CREDITOR in $REFERENCE/CREDITOR
												return
												<CREDITOR>{ fn:data($CREDITOR) }</CREDITOR>
											}
											{
												for $ASSET_TYPE in $REFERENCE/ASSET_TYPE
												return
												<ASSET_TYPE>{ fn:data($ASSET_TYPE) }</ASSET_TYPE>
											}
											{
												for $WARRANTY_TYPE in $REFERENCE/WARRANTY_TYPE
												return
												<WARRANTY_TYPE>{ fn:data($WARRANTY_TYPE) }</WARRANTY_TYPE>
											}
											{
												for $CURRENCY in $REFERENCE/CURRENCY
												return
												<CURRENCY>{ fn:data($CURRENCY) }</CURRENCY>
											}
											{
												for $AMOUNT in $REFERENCE/AMOUNT
												return
												<AMOUNT>{ fn:data($AMOUNT) }</AMOUNT>
											}
											{
												for $BALANCE in $REFERENCE/BALANCE
												return
												<BALANCE>{ fn:data($BALANCE) }</BALANCE>	
											}
											{
												for $DUE_BALANCE in $REFERENCE/DUE_BALANCE
												return
												<DUE_BALANCE>{ fn:data($DUE_BALANCE) }</DUE_BALANCE>
											}
											{
												for $OPENING_DATE in $REFERENCE/OPENING_DATE
												return
												<OPENING_DATE>{ fn:data($OPENING_DATE) }</OPENING_DATE>
											}
											{
												for $CONSESSION_DATE in $REFERENCE/CONSESSION_DATE
												return
												<CONSESSION_DATE>{ fn:data($CONSESSION_DATE) }</CONSESSION_DATE>
											}
											{
												for $EXPIRATION_DATE in $REFERENCE/EXPIRATION_DATE
												return
												<EXPIRATION_DATE>{ fn:data($EXPIRATION_DATE) }</EXPIRATION_DATE>
											}
											{
												for $CANCELATION_DATE in $REFERENCE/CANCELATION_DATE
												return
												<CANCELATION_DATE>{ fn:data($CANCELATION_DATE) }</CANCELATION_DATE>
											}
											{
												for $HISTORICAL_ARREAR in $REFERENCE/HISTORICAL_ARREAR
												return
												<HISTORICAL_ARREAR>{ fn:data($HISTORICAL_ARREAR) }</HISTORICAL_ARREAR>
											}
											{
												for $CATEGORY in $REFERENCE/CATEGORY
												return
												<CATEGORY>{ fn:data($CATEGORY) }</CATEGORY>
											}
											{
												for $STATUS in $REFERENCE/STATUS
												return
												<STATUS>{ fn:data($STATUS) }</STATUS>
											}
											{
												for $TYPE in $REFERENCE/TYPE
												return
												<TYPE>{ fn:data($TYPE) }</TYPE>
											}
											{
												for $DEBTOR_TYPE in $REFERENCE/DEBTOR_TYPE
												return
												<DEBTOR_TYPE>{ fn:data($DEBTOR_TYPE) }</DEBTOR_TYPE>
											}
											</REFERENCE>
										)
									}
									</REFERENCE_BUREAU_SIRC>
								) else ()
							}
							{
								if (fn:exists($consultaConsolidadaRiesgoClienteResponse/LOAN_ORIGINATIONS/REFERENCES_DETAILS/FOR_CONSOLIDATE/REFERENCE)) then (
									<FOR_CONSOLIDATE>
									{
										for $REFERENCE in $consultaConsolidadaRiesgoClienteResponse/LOAN_ORIGINATIONS/REFERENCES_DETAILS/FOR_CONSOLIDATE/REFERENCE
										return(
											<REFERENCE>
											{
												for $REFERENCE_TYPE in $REFERENCE/REFERENCE_TYPE
												return
												<REFERENCE_TYPE>{ fn:data($REFERENCE_TYPE) }</REFERENCE_TYPE>
											}
											{
												for $REFERENCE_CURRENCY in $REFERENCE/REFERENCE_CURRENCY
												return
												<REFERENCE_CURRENCY>{ fn:data($REFERENCE_CURRENCY) }</REFERENCE_CURRENCY>
											}
											{
												for $REFERENCE_ENTITY in $REFERENCE/REFERENCE_ENTITY
												return
												<REFERENCE_ENTITY>{ fn:data($REFERENCE_ENTITY) }</REFERENCE_ENTITY>
											}
											{
												for $CHECK_BENEFICIARY in $REFERENCE/CHECK_BENEFICIARY
												return
												<CHECK_BENEFICIARY>{ fn:data($CHECK_BENEFICIARY) }</CHECK_BENEFICIARY>
											}
											{
												for $REFERENCE_ACCOUNT_NUMBER in $REFERENCE/REFERENCE_ACCOUNT_NUMBER
												return
												<REFERENCE_ACCOUNT_NUMBER>{ fn:data($REFERENCE_ACCOUNT_NUMBER) }</REFERENCE_ACCOUNT_NUMBER>
											}
											{
												for $REFERENCE_LIMIT_AMOUNT in $REFERENCE/REFERENCE_LIMIT_AMOUNT
												return
												<REFERENCE_LIMIT_AMOUNT>{ fn:data($REFERENCE_LIMIT_AMOUNT) }</REFERENCE_LIMIT_AMOUNT>
											}
											{
												for $REFERENCE_INSTALLMENT_AMOUNT in $REFERENCE/REFERENCE_INSTALLMENT_AMOUNT
												return
												<REFERENCE_INSTALLMENT_AMOUNT>{ fn:data($REFERENCE_INSTALLMENT_AMOUNT) }</REFERENCE_INSTALLMENT_AMOUNT>
											}
											</REFERENCE>
										)
									}
									</FOR_CONSOLIDATE>
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
												<QUERY_ID>{ fn:data($QUERY_ID) }</QUERY_ID>
											}
											{
												for $CREDITOR in $REFERENCE/CREDITOR
												return
												<CREDITOR>{ fn:data($CREDITOR) }</CREDITOR>
											}
											{
												for $REFERENCE_NUMBER in $REFERENCE/REFERENCE_NUMBER
												return
												<REFERENCE_NUMBER>{ fn:data($REFERENCE_NUMBER) }</REFERENCE_NUMBER>
											}
											{
												for $TYPE in $REFERENCE/TYPE
												return
												<TYPE>{ fn:data($TYPE) }</TYPE>
											}
											{
												for $OBLIGATION_TYPE in $REFERENCE/OBLIGATION_TYPE
												return
												<OBLIGATION_TYPE>{ fn:data($OBLIGATION_TYPE) }</OBLIGATION_TYPE>
											}
											{
												for $CREDIT_TYPE in $REFERENCE/CREDIT_TYPE
												return
												<CREDIT_TYPE>{ fn:data($CREDIT_TYPE) }</CREDIT_TYPE>
											}
											{
												for $STATUS in $REFERENCE/STATUS
												return
												<STATUS>{ fn:data($STATUS) }</STATUS>
											}
											{
												for $LIMIT in $REFERENCE/LIMIT
												return
												<LIMIT>{ fn:data($LIMIT) }</LIMIT>
											}
											{
												for $TERM in $REFERENCE/TERM
												return
												<TERM>{ fn:data($TERM) }</TERM>
											}
											{
												for $CURRENCY in $REFERENCE/CURRENCY
												return
												<CURRENCY>{ fn:data($CURRENCY) }</CURRENCY>
											}
											{
												for $EXCHANGE_FACTOR in $REFERENCE/EXCHANGE_FACTOR
												return
												<EXCHANGE_FACTOR>{ fn:data($EXCHANGE_FACTOR) }</EXCHANGE_FACTOR>
											}
											{
												for $BALANCE in $REFERENCE/BALANCE
												return
												<BALANCE>{ fn:data($BALANCE) }</BALANCE>
											}
											{
												for $MIN_PAYMENT in $REFERENCE/MIN_PAYMENT
												return
												<MIN_PAYMENT>{ fn:data($MIN_PAYMENT) }</MIN_PAYMENT>
											}
											{
												for $PAYMENT_DUE in $REFERENCE/PAYMENT_DUE
												return
												<PAYMENT_DUE>{ fn:data($PAYMENT_DUE) }</PAYMENT_DUE>
											}
											{
												for $PAYMENT_METHOD in $REFERENCE/PAYMENT_METHOD
												return
												<PAYMENT_METHOD>{ fn:data($PAYMENT_METHOD) }</PAYMENT_METHOD>
											}
											{
												for $GUARANTEE in $REFERENCE/GUARANTEE
												return
												<GUARANTEE>{ fn:data($GUARANTEE) }</GUARANTEE>
											}
											{
												for $GUARANTEE_TYPE in $REFERENCE/GUARANTEE_TYPE
												return
												<GUARANTEE_TYPE>{ fn:data($GUARANTEE_TYPE) }</GUARANTEE_TYPE>
											}
											{
												for $AMOUNT in $REFERENCE/AMOUNT
												return
												<AMOUNT>{ fn:data($AMOUNT) }</AMOUNT>
											}
											{
												for $ARREAR_BALANCE in $REFERENCE/ARREAR_BALANCE
												return
												<ARREAR_BALANCE>{ fn:data($ARREAR_BALANCE) }</ARREAR_BALANCE>
											}
											{
												for $ARREAR_LEVEL in $REFERENCE/ARREAR_LEVEL
												return
												<ARREAR_LEVEL>{ fn:data($ARREAR_LEVEL) }</ARREAR_LEVEL>
											}
											{
												for $DUE_BALANCE in $REFERENCE/DUE_BALANCE
												return
												<DUE_BALANCE>{ fn:data($DUE_BALANCE) }</DUE_BALANCE>
											}
											{
												for $IN_EXECUTION in $REFERENCE/IN_EXECUTION
												return
												<IN_EXECUTION>{ fn:data($IN_EXECUTION) }</IN_EXECUTION>
											}
											{
												for $PUNISHED in $REFERENCE/PUNISHED
												return
												<PUNISHED>{ fn:data($PUNISHED) }</PUNISHED>
											}
											{
												for $PUNISHED_BALANCE in $REFERENCE/PUNISHED_BALANCE
												return
												<PUNISHED_BALANCE>{ fn:data($PUNISHED_BALANCE) }</PUNISHED_BALANCE>
											}
											{
												for $CATEGORY in $REFERENCE/CATEGORY
												return
												<CATEGORY>{ fn:data($CATEGORY) }</CATEGORY>
											}
											{
												for $PERIOD in $REFERENCE/PERIOD
												return
												<PERIOD>{ fn:data($PERIOD) }</PERIOD>
											}
											{
												for $INFORMATION_DATE in $REFERENCE/INFORMATION_DATE
												return
												<INFORMATION_DATE>{ fn:data($INFORMATION_DATE) }</INFORMATION_DATE>
											}
											{
												for $OPENING_DATE in $REFERENCE/OPENING_DATE
												return
												<OPENING_DATE>{ fn:data($OPENING_DATE) }</OPENING_DATE>
											}
											{
												for $CANCELATION_DATE in $REFERENCE/CANCELATION_DATE
												return
												<CANCELATION_DATE>{ fn:data($CANCELATION_DATE) }</CANCELATION_DATE>
											}
											{
												for $EXPIRATION_DATE in $REFERENCE/EXPIRATION_DATE
												return
												<EXPIRATION_DATE>{ fn:data($EXPIRATION_DATE) }</EXPIRATION_DATE>
											}
											{
												for $INSTALLMENT in $REFERENCE/INSTALLMENT
												return
												<INSTALLMENT>{ fn:data($INSTALLMENT) }</INSTALLMENT>
											}
											{
												for $HISTORICAL_ARREAR in $REFERENCE/HISTORICAL_ARREAR
												return
												<HISTORICAL_ARREAR>{ fn:data($HISTORICAL_ARREAR) }</HISTORICAL_ARREAR>
											}
											{
												for $HISTORICAL_COUNT_LOC in $REFERENCE/HISTORICAL_COUNT_LOC
												return
												<HISTORICAL_COUNT_LOC>{ fn:data($HISTORICAL_COUNT_LOC) }</HISTORICAL_COUNT_LOC>
											}
											{
												for $HISTORICAL_COUNT_DOL in $REFERENCE/HISTORICAL_COUNT_DOL
												return
												<HISTORICAL_COUNT_DOL>{ fn:data($HISTORICAL_COUNT_DOL) }</HISTORICAL_COUNT_DOL>
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
												<QUERY_ID>{ fn:data($QUERY_ID) }</QUERY_ID>
											}
											{
												for $CREDITOR in $REFERENCE/CREDITOR
												return
												<CREDITOR>{ fn:data($CREDITOR) }</CREDITOR>
											}
											{
												for $REFERENCE_NUMBER in $REFERENCE/REFERENCE_NUMBER
												return
												<REFERENCE_NUMBER>{ fn:data($REFERENCE_NUMBER) }</REFERENCE_NUMBER>
											}
											{
												for $TYPE in $REFERENCE/TYPE
												return
												<TYPE>{ fn:data($TYPE) }</TYPE>
											}
											{
												for $OBLIGATION_TYPE in $REFERENCE/OBLIGATION_TYPE
												return
												<OBLIGATION_TYPE>{ fn:data($OBLIGATION_TYPE) }</OBLIGATION_TYPE>
											}
											{
												for $CREDIT_TYPE in $REFERENCE/CREDIT_TYPE
												return
												<CREDIT_TYPE>{ fn:data($CREDIT_TYPE) }</CREDIT_TYPE>
											}
											{
												for $STATUS in $REFERENCE/STATUS
												return
												<STATUS>{ fn:data($STATUS) }</STATUS>
											}
											{
												for $LIMIT in $REFERENCE/LIMIT
												return
												<LIMIT>{ fn:data($LIMIT) }</LIMIT>
											}
											{
												for $TERM in $REFERENCE/TERM
												return
												<TERM>{ fn:data($TERM) }</TERM>
											}
											{
												for $CURRENCY in $REFERENCE/CURRENCY
												return
												<CURRENCY>{ fn:data($CURRENCY) }</CURRENCY>
											}
											{
												for $EXCHANGE_FACTOR in $REFERENCE/EXCHANGE_FACTOR
												return
												<EXCHANGE_FACTOR>{ fn:data($EXCHANGE_FACTOR) }</EXCHANGE_FACTOR>
											}
											{
												for $BALANCE in $REFERENCE/BALANCE
												return
												<BALANCE>{ fn:data($BALANCE) }</BALANCE>
											}
											{
												for $MIN_PAYMENT in $REFERENCE/MIN_PAYMENT
												return
												<MIN_PAYMENT>{ fn:data($MIN_PAYMENT) }</MIN_PAYMENT>
											}
											{
												for $PAYMENT_DUE in $REFERENCE/PAYMENT_DUE
												return
												<PAYMENT_DUE>{ fn:data($PAYMENT_DUE) }</PAYMENT_DUE>
											}
											{
												for $PAYMENT_METHOD in $REFERENCE/PAYMENT_METHOD
												return
												<PAYMENT_METHOD>{ fn:data($PAYMENT_METHOD) }</PAYMENT_METHOD>
											}
											{
												for $GUARANTEE in $REFERENCE/GUARANTEE
												return
												<GUARANTEE>{ fn:data($GUARANTEE) }</GUARANTEE>
											}
											{
												for $GUARANTEE_TYPE in $REFERENCE/GUARANTEE_TYPE
												return
												<GUARANTEE_TYPE>{ fn:data($GUARANTEE_TYPE) }</GUARANTEE_TYPE>
											}
											{
												for $AMOUNT in $REFERENCE/AMOUNT
												return
												<AMOUNT>{ fn:data($AMOUNT) }</AMOUNT>
											}
											{
												for $ARREAR_BALANCE in $REFERENCE/ARREAR_BALANCE
												return
												<ARREAR_BALANCE>{ fn:data($ARREAR_BALANCE) }</ARREAR_BALANCE>
											}
											{
												for $ARREAR_LEVEL in $REFERENCE/ARREAR_LEVEL
												return
												<ARREAR_LEVEL>{ fn:data($ARREAR_LEVEL) }</ARREAR_LEVEL>
											}
											{
												for $DUE_BALANCE in $REFERENCE/DUE_BALANCE
												return
												<DUE_BALANCE>{ fn:data($DUE_BALANCE) }</DUE_BALANCE>
											}
											{
												for $IN_EXECUTION in $REFERENCE/IN_EXECUTION
												return
												<IN_EXECUTION>{ fn:data($IN_EXECUTION) }</IN_EXECUTION>
											}
											{
												for $PUNISHED in $REFERENCE/PUNISHED
												return
												<PUNISHED>{ fn:data($PUNISHED) }</PUNISHED>
											}
											{
												for $PUNISHED_BALANCE in $REFERENCE/PUNISHED_BALANCE
												return
												<PUNISHED_BALANCE>{ fn:data($PUNISHED_BALANCE) }</PUNISHED_BALANCE>
											}
											{
												for $CATEGORY in $REFERENCE/CATEGORY
												return
												<CATEGORY>{ fn:data($CATEGORY) }</CATEGORY>
											}
											{
												for $PERIOD in $REFERENCE/PERIOD
												return
												<PERIOD>{ fn:data($PERIOD) }</PERIOD>
											}
											{
												for $INFORMATION_DATE in $REFERENCE/INFORMATION_DATE
												return
												<INFORMATION_DATE>{ fn:data($INFORMATION_DATE) }</INFORMATION_DATE>
											}
											{
												for $OPENING_DATE in $REFERENCE/OPENING_DATE
												return
												<OPENING_DATE>{ fn:data($OPENING_DATE) }</OPENING_DATE>
											}
											{
												for $CANCELATION_DATE in $REFERENCE/CANCELATION_DATE
												return
												<CANCELATION_DATE>{ fn:data($CANCELATION_DATE) }</CANCELATION_DATE>
											}
											{
												for $EXPIRATION_DATE in $REFERENCE/EXPIRATION_DATE
												return
												<EXPIRATION_DATE>{ fn:data($EXPIRATION_DATE) }</EXPIRATION_DATE>
											}
											{
												for $INSTALLMENT in $REFERENCE/INSTALLMENT
												return
												<INSTALLMENT>{ fn:data($INSTALLMENT) }</INSTALLMENT>
											}
											{
												for $HISTORICAL_ARREAR in $REFERENCE/HISTORICAL_ARREAR
												return
												<HISTORICAL_ARREAR>{ fn:data($HISTORICAL_ARREAR) }</HISTORICAL_ARREAR>
											}
											{
												for $HISTORICAL_COUNT_LOC in $REFERENCE/HISTORICAL_COUNT_LOC
												return
												<HISTORICAL_COUNT_LOC>{ fn:data($HISTORICAL_COUNT_LOC) }</HISTORICAL_COUNT_LOC>
											}
											{
												for $HISTORICAL_COUNT_DOL in $REFERENCE/HISTORICAL_COUNT_DOL
												return
												<HISTORICAL_COUNT_DOL>{ fn:data($HISTORICAL_COUNT_DOL) }</HISTORICAL_COUNT_DOL>
											}
											</REFERENCE>
										)
									}
									</HISTORICAL_REFERENCES>
								) else ()
							}
							</REFERENCES_DETAILS>
						) else ()
					}
					</LOAN_ORIGINATIONS>
				) else ()
			}
</CONSOLIDATED_CUSTOMER_RISK_RESPONSE>
};

declare function xf:processCustomerRiskXMLIn($successIndicator as xs:string,
    $message as xs:string,
    $caseId as xs:string,
    $consultaConsolidadaRiesgoClienteResponse as element(ns1:consultaConsolidadaRiesgoClienteResponse))
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:P_XMLRESPONSE>{ fn-bea:serialize(xf:buildXMLResponse($successIndicator, $message, $caseId, $consultaConsolidadaRiesgoClienteResponse)) }</ns0:P_XMLRESPONSE>
        </ns0:InputParameters>
};

declare variable $successIndicator as xs:string external;
declare variable $message as xs:string external;
declare variable $caseId as xs:string external;
declare variable $consultaConsolidadaRiesgoClienteResponse as element(ns1:consultaConsolidadaRiesgoClienteResponse) external;

xf:processCustomerRiskXMLIn($successIndicator,
    $message,
    $caseId,
    $consultaConsolidadaRiesgoClienteResponse)
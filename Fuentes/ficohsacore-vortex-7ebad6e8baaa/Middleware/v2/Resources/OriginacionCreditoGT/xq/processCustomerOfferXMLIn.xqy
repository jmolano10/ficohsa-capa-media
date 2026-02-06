xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaOfertaCreditoConsumoResponse" element="ns0:consultaOfertaCreditoConsumoResponse" location="../../ConsultaOfertaCreditoConsumo/xsd/consultaOfertaCreditoConsumoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/CreditOrigination/ProcessCustomerOfferXML/xsd/processCustomerOfferXML_sp.xsd" ::)

declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/processCustomerOfferXML";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaOfertaCreditoConsumoTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/OriginacionCreditoGT/xq/processCustomerOfferXMLIn/";

declare function xf:buildXMLResponse($successIndicator as xs:string,
    $message as xs:string,
    $consultaOfertaCreditoConsumoResponse as element(ns0:consultaOfertaCreditoConsumoResponse)) 
    as element(*) {
    <CREDIT_OFFER_INQUIRY_RESPONSE>
		<SUCCESS_INDICATOR>{ $successIndicator }</SUCCESS_INDICATOR>
		{
			if ($message != "") then (
				<MESSAGE>{ $message }</MESSAGE>
			) else ()
		}
		{
			for $CASE_ID in $consultaOfertaCreditoConsumoResponse/CASE_ID
			return
			<CASE_ID>{ fn:data($CASE_ID) }</CASE_ID>
		}
		{
			for $GENERAL_RCI in $consultaOfertaCreditoConsumoResponse/GENERAL_RCI
			return
			<GENERAL_RCI>{ fn:data($GENERAL_RCI) }</GENERAL_RCI>
		}
		{
			for $GENERAL_RCI_MAX in $consultaOfertaCreditoConsumoResponse/GENERAL_RCI_MAX
			return
			<GENERAL_RCI_MAX>{ fn:data($GENERAL_RCI_MAX) }</GENERAL_RCI_MAX>
		}
		{
			for $GENERAL_CURRENT_NDE in $consultaOfertaCreditoConsumoResponse/GENERAL_CURRENT_NDE
			return
			<GENERAL_CURRENT_NDE>{ fn:data($GENERAL_CURRENT_NDE) }</GENERAL_CURRENT_NDE>
		}
		{
			for $GENERAL_FINAL_NDE in $consultaOfertaCreditoConsumoResponse/GENERAL_FINAL_NDE
			return
			<GENERAL_FINAL_NDE>{ fn:data($GENERAL_FINAL_NDE) }</GENERAL_FINAL_NDE>
		}
		{
			for $CREDIT_CARD_SCORE in $consultaOfertaCreditoConsumoResponse/CREDIT_CARD_SCORE
			return
			<CREDIT_CARD_SCORE>{ fn:data($CREDIT_CARD_SCORE) }</CREDIT_CARD_SCORE>
		}
		{
			for $INTERNAL_SCORE in $consultaOfertaCreditoConsumoResponse/INTERNAL_SCORE
			return
			<INTERNAL_SCORE>{ fn:data($INTERNAL_SCORE) }</INTERNAL_SCORE>
		}
		{
			for $CREDIT_CARD_RISK_LEVEL in $consultaOfertaCreditoConsumoResponse/CREDIT_CARD_RISK_LEVEL
			return
			<CREDIT_CARD_RISK_LEVEL>{ fn:data($CREDIT_CARD_RISK_LEVEL) }</CREDIT_CARD_RISK_LEVEL>
		}
		{
			for $INTERNAL_RISK_LEVEL in $consultaOfertaCreditoConsumoResponse/INTERNAL_RISK_LEVEL
			return
			<INTERNAL_RISK_LEVEL>{ fn:data($INTERNAL_RISK_LEVEL) }</INTERNAL_RISK_LEVEL>
		}
		{
			for $EXTERNAL_RISK_LEVEL in $consultaOfertaCreditoConsumoResponse/EXTERNAL_RISK_LEVEL
			return
			<EXTERNAL_RISK_LEVEL>{ fn:data($EXTERNAL_RISK_LEVEL) }</EXTERNAL_RISK_LEVEL>
		}
		{
			for $CUSTOMER_SEGMENT in $consultaOfertaCreditoConsumoResponse/CUSTOMER_SEGMENT
			return
			<CUSTOMER_SEGMENT>{ fn:data($CUSTOMER_SEGMENT) }</CUSTOMER_SEGMENT>
		}
		{
			for $CUSTOMER_SUBSEGMENT in $consultaOfertaCreditoConsumoResponse/CUSTOMER_SUBSEGMENT
			return
			<CUSTOMER_SUBSEGMENT>{ fn:data($CUSTOMER_SUBSEGMENT) }</CUSTOMER_SUBSEGMENT>
		}
		{
			for $CURRENT_EXPOSURE in $consultaOfertaCreditoConsumoResponse/CURRENT_EXPOSURE
			return
			<CURRENT_EXPOSURE>{ fn:data($CURRENT_EXPOSURE) }</CURRENT_EXPOSURE>
		}
		{
			for $GLOBAL_EXPOSURE_LOCAL_CCY in $consultaOfertaCreditoConsumoResponse/GLOBAL_EXPOSURE_LOCAL_CCY
			return
			<GLOBAL_EXPOSURE_LOCAL_CCY>{ fn:data($GLOBAL_EXPOSURE_LOCAL_CCY) }</GLOBAL_EXPOSURE_LOCAL_CCY>
		}
		{
			for $GLOBAL_EXPOSURE_FOREIGN_CCY in $consultaOfertaCreditoConsumoResponse/GLOBAL_EXPOSURE_FOREIGN_CCY
			return
			<GLOBAL_EXPOSURE_FOREIGN_CCY>{ fn:data($GLOBAL_EXPOSURE_FOREIGN_CCY) }</GLOBAL_EXPOSURE_FOREIGN_CCY>
		}
		{
			for $CREDIT_CARD_OVERDRAFT in $consultaOfertaCreditoConsumoResponse/CREDIT_CARD_OVERDRAFT
			return
			<CREDIT_CARD_OVERDRAFT>{ fn:data($CREDIT_CARD_OVERDRAFT) }</CREDIT_CARD_OVERDRAFT>
		}
		{
			for $CREDIT_REFERENCES in $consultaOfertaCreditoConsumoResponse/CREDIT_REFERENCES
			return
			<CREDIT_REFERENCES>{ fn:data($CREDIT_REFERENCES) }</CREDIT_REFERENCES>
		}
		{
			for $INTERNAL_LOAN_REFERENCES in $consultaOfertaCreditoConsumoResponse/INTERNAL_LOAN_REFERENCES
			return
			<INTERNAL_LOAN_REFERENCES>{ fn:data($INTERNAL_LOAN_REFERENCES) }</INTERNAL_LOAN_REFERENCES>
		}
		{
			for $REWRITE_REFERENCES in $consultaOfertaCreditoConsumoResponse/REWRITE_REFERENCES
			return
			<REWRITE_REFERENCES>{ fn:data($REWRITE_REFERENCES) }</REWRITE_REFERENCES>
		}
		{
			for $TOTAL_EXTRA in $consultaOfertaCreditoConsumoResponse/TOTAL_EXTRA
			return
			<TOTAL_EXTRA>{ fn:data($TOTAL_EXTRA) }</TOTAL_EXTRA>
		}
		{
			for $TOTAL_RISK in $consultaOfertaCreditoConsumoResponse/TOTAL_RISK
			return
			<TOTAL_RISK>{ fn:data($TOTAL_RISK) }</TOTAL_RISK>
		}
		{
			for $CURRENT_ARREAR in $consultaOfertaCreditoConsumoResponse/CURRENT_ARREAR
			return
			<CURRENT_ARREAR>{ fn:data($CURRENT_ARREAR) }</CURRENT_ARREAR>
		}
		{
			for $CURRENT_ARREAR_BALANCE in $consultaOfertaCreditoConsumoResponse/CURRENT_ARREAR_BALANCE
			return
			<CURRENT_ARREAR_BALANCE>{ fn:data($CURRENT_ARREAR_BALANCE) }</CURRENT_ARREAR_BALANCE>
		}
		{
			for $CREDIT_EXPERIENCE in $consultaOfertaCreditoConsumoResponse/CREDIT_EXPERIENCE
			return
			<CREDIT_EXPERIENCE>{ fn:data($CREDIT_EXPERIENCE) }</CREDIT_EXPERIENCE>
		}
		{
			for $ARREAR_ON_60DAYS_FOR_6MONTHS in $consultaOfertaCreditoConsumoResponse/ARREAR_ON_60DAYS_FOR_6MONTHS
			return
			<ARREAR_ON_60DAYS_FOR_6MONTHS>{ fn:data($ARREAR_ON_60DAYS_FOR_6MONTHS) }</ARREAR_ON_60DAYS_FOR_6MONTHS>
		}
		{
			for $ARREAR_ON_60DAYS_FOR_12MONTHS in $consultaOfertaCreditoConsumoResponse/ARREAR_ON_60DAYS_FOR_12MONTHS
			return
			<ARREAR_ON_60DAYS_FOR_12MONTHS>{ fn:data($ARREAR_ON_60DAYS_FOR_12MONTHS) }</ARREAR_ON_60DAYS_FOR_12MONTHS>
		}
		{
			for $ARREAR_ON_90DAYS_FOR_12MONTHS in $consultaOfertaCreditoConsumoResponse/ARREAR_ON_90DAYS_FOR_12MONTHS
			return
			<ARREAR_ON_90DAYS_FOR_12MONTHS>{ fn:data($ARREAR_ON_90DAYS_FOR_12MONTHS) }</ARREAR_ON_90DAYS_FOR_12MONTHS>
		}
		{
			for $ARREAR_ON_90DAYS_FOR_12MONTHS in $consultaOfertaCreditoConsumoResponse/ARREAR_ON_90DAYS_FOR_12MONTHS
			return
			<ARREAR_ON_90DAYS_FOR_12MONTHS>{ fn:data($ARREAR_ON_90DAYS_FOR_12MONTHS) }</ARREAR_ON_90DAYS_FOR_12MONTHS>
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
							<RESOLUTION_ID>{ fn:data($RESOLUTION_ID) }</RESOLUTION_ID>
						}
						{
							for $RESOLUTION_DESCRIPTION in $RESOLUTION/RESOLUTION_DESCRIPTION
							return
							<RESOLUTION_DESCRIPTION>{ fn:data($RESOLUTION_DESCRIPTION) }</RESOLUTION_DESCRIPTION>
						}
						</RESOLUTION>
					)
				}
				</RESOLUTIONS>
			) else ()
		}
		{
			if (fn:exists($consultaOfertaCreditoConsumoResponse/RESOLUTION_OFFERS/OFFER)) then (
				<RESOLUTION_OFFERS>
				{
					for $OFFER in $consultaOfertaCreditoConsumoResponse/RESOLUTION_OFFERS/OFFER
					return(
						<OFFER>
						{
							for $PRODUCT_CODE in $OFFER/PRODUCT_CODE
							return
							<PRODUCT_CODE>{ fn:data($PRODUCT_CODE) }</PRODUCT_CODE>
						}
						{
							for $RATE in $OFFER/RATE
							return
							<RATE>{ fn:data($RATE) }</RATE>
						}
						{
							for $INSTALLMENT in $OFFER/INSTALLMENT
							return
							<INSTALLMENT>{ fn:data($INSTALLMENT) }</INSTALLMENT>
						}
						{
							for $INSTALLMENT_NDE in $OFFER/INSTALLMENT_NDE
							return
							<INSTALLMENT_NDE>{ fn:data($INSTALLMENT_NDE) }</INSTALLMENT_NDE>
						}
						{
							for $INSTALLMENT_RCI_NONP2C in $OFFER/INSTALLMENT_RCI_NONP2C
							return
							<INSTALLMENT_RCI_NONP2C>{ fn:data($INSTALLMENT_RCI_NONP2C) }</INSTALLMENT_RCI_NONP2C>
						}
						{
							for $INSTALLMENT_RCI_P2C in $OFFER/INSTALLMENT_RCI_P2C
							return
							<INSTALLMENT_RCI_P2C>{ fn:data($INSTALLMENT_RCI_P2C) }</INSTALLMENT_RCI_P2C>
						}
						{
							for $FOR_12_MONTHS in $OFFER/FOR_12_MONTHS
							return
							<FOR_12_MONTHS>{ fn:data($FOR_12_MONTHS) }</FOR_12_MONTHS>
						}
						{
							for $FOR_18_MONTHS in $OFFER/FOR_18_MONTHS
							return
							<FOR_18_MONTHS>{ fn:data($FOR_18_MONTHS) }</FOR_18_MONTHS>
						}
						{
							for $FOR_24_MONTHS in $OFFER/FOR_24_MONTHS
							return
							<FOR_24_MONTHS>{ fn:data($FOR_24_MONTHS) }</FOR_24_MONTHS>
						}
						{
							for $FOR_36_MONTHS in $OFFER/FOR_36_MONTHS
							return
							<FOR_36_MONTHS>{ fn:data($FOR_36_MONTHS) }</FOR_36_MONTHS>
						}
						{
							for $FOR_48_MONTHS in $OFFER/FOR_48_MONTHS
							return
							<FOR_48_MONTHS>{ fn:data($FOR_48_MONTHS) }</FOR_48_MONTHS>
						}
						{
							for $FOR_60_MONTHS in $OFFER/FOR_60_MONTHS
							return
							<FOR_60_MONTHS>{ fn:data($FOR_60_MONTHS) }</FOR_60_MONTHS>
						}
						{
							for $FOR_72_MONTHS in $OFFER/FOR_72_MONTHS
							return
							<FOR_72_MONTHS>{ fn:data($FOR_72_MONTHS) }</FOR_72_MONTHS>
						}
						{
							for $FOR_84_MONTHS in $OFFER/FOR_84_MONTHS
							return
							<FOR_84_MONTHS>{ fn:data($FOR_84_MONTHS) }</FOR_84_MONTHS>
						}
						{
							for $FOR_96_MONTHS in $OFFER/FOR_96_MONTHS
							return
							<FOR_96_MONTHS>{ fn:data($FOR_96_MONTHS) }</FOR_96_MONTHS>
						}
						{
							for $FOR_108_MONTHS in $OFFER/FOR_108_MONTHS
							return
							<FOR_108_MONTHS>{ fn:data($FOR_108_MONTHS) }</FOR_108_MONTHS>
						}
						{
							for $FOR_120_MONTHS in $OFFER/FOR_120_MONTHS
							return
							<FOR_120_MONTHS>{ fn:data($FOR_120_MONTHS) }</FOR_120_MONTHS>
						}
						{
							for $FOR_MAX_AMOUNT in $OFFER/FOR_MAX_AMOUNT
							return
							<FOR_MAX_AMOUNT>{ fn:data($FOR_MAX_AMOUNT) }</FOR_MAX_AMOUNT>
						}
						{
							for $MEG_OFFER in $OFFER/MEG_OFFER
							return
							<MEG_OFFER>{ fn:data($MEG_OFFER) }</MEG_OFFER>
						}
						{
							for $MAX_OFFER in $OFFER/MAX_OFFER
							return
							<MAX_OFFER>{ fn:data($MAX_OFFER) }</MAX_OFFER>
						}
						{
							for $NDE_OFFER in $OFFER/NDE_OFFER
							return
							<NDE_OFFER>{ fn:data($NDE_OFFER) }</NDE_OFFER>
						}
						{
							for $NONP2C_OFFER in $OFFER/NONP2C_OFFER
							return
							<NONP2C_OFFER>{ fn:data($NONP2C_OFFER) }</NONP2C_OFFER>
						}
						{
							for $P2C_OFFER in $OFFER/P2C_OFFER
							return
							<P2C_OFFER>{ fn:data($P2C_OFFER) }</P2C_OFFER>
						}
						{
							for $RCI_OFFER in $OFFER/RCI_OFFER
							return
							<RCI_OFFER>{ fn:data($RCI_OFFER) }</RCI_OFFER>
						}
						{
							for $TIMESINCOME_OFFER in $OFFER/TIMESINCOME_OFFER
							return
							<TIMESINCOME_OFFER>{ fn:data($TIMESINCOME_OFFER) }</TIMESINCOME_OFFER>
						}
						{
							for $RCI in $OFFER/RCI
							return
							<RCI>{ fn:data($RCI) }</RCI>
						}
						{
							for $TIMESINCOME in $OFFER/TIMESINCOME
							return
							<TIMESINCOME>{ fn:data($TIMESINCOME) }</TIMESINCOME>
						}
						</OFFER>
					)
				}
				</RESOLUTION_OFFERS>
			) else ()
		}
		{
			for $CREDIT_CARD in $consultaOfertaCreditoConsumoResponse/CREDIT_CARD
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
					if (fn:exists($CREDIT_CARD/TRANSACTION_CREDIT_CARD_TYPE/TRANSACTION)) then (
						<TRANSACTION_CREDIT_CARD_TYPE>
						{
							for $TRANSACTION in $CREDIT_CARD/TRANSACTION_CREDIT_CARD_TYPE/TRANSACTION
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
						</TRANSACTION_CREDIT_CARD_TYPE>
					) else ()
				}
				{
					for $PRIOR_LIMIT in $CREDIT_CARD/PRIOR_LIMIT
					return
					<PRIOR_LIMIT>{ fn:data($PRIOR_LIMIT) }</PRIOR_LIMIT>
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
					for $HISTORICAL_ARREAR_LOC in $CREDIT_CARD/HISTORICAL_ARREAR_LOC
					return
					<HISTORICAL_ARREAR_LOC>{ fn:data($HISTORICAL_ARREAR_LOC) }</HISTORICAL_ARREAR_LOC>
				}
				{
					for $HISTORICAL_ARREAR_USD in $CREDIT_CARD/HISTORICAL_ARREAR_USD
					return
					<HISTORICAL_ARREAR_USD>{ fn:data($HISTORICAL_ARREAR_USD) }</HISTORICAL_ARREAR_USD>
				}
				{
					for $CHARGE_OFF_FLAG in $CREDIT_CARD/CHARGE_OFF_FLAG
					return
					<CHARGE_OFF_FLAG>{ fn:data($CHARGE_OFF_FLAG) }</CHARGE_OFF_FLAG>
				}
				</CREDIT_CARD>
			)
		}
		{
			for $DATE in $consultaOfertaCreditoConsumoResponse/DATE
			return
			<DATE>{ fn:data($DATE) }</DATE>
		}
		{
			for $SCORE_STRATEGY in $consultaOfertaCreditoConsumoResponse/SCORE_STRATEGY
			return
			<SCORE_STRATEGY>{ fn:data($SCORE_STRATEGY) }</SCORE_STRATEGY>
		}
		{
			for $SCORE_TYPE in $consultaOfertaCreditoConsumoResponse/SCORE_TYPE
			return
			<SCORE_TYPE>{ fn:data($SCORE_TYPE) }</SCORE_TYPE>
		}
		{
			for $CUSTOMER_SALARY_SEGMENT in $consultaOfertaCreditoConsumoResponse/CUSTOMER_SALARY_SEGMENT
			return
			<CUSTOMER_SALARY_SEGMENT>{ fn:data($CUSTOMER_SALARY_SEGMENT) }</CUSTOMER_SALARY_SEGMENT>
		}
		{
			for $ACTIVE_DIRECT_CREDITS in $consultaOfertaCreditoConsumoResponse/ACTIVE_DIRECT_CREDITS
			return
			<ACTIVE_DIRECT_CREDITS>{ fn:data($ACTIVE_DIRECT_CREDITS) }</ACTIVE_DIRECT_CREDITS>
		}
		{
			for $CANCELED_DIRECT_CREDITS in $consultaOfertaCreditoConsumoResponse/CANCELED_DIRECT_CREDITS
			return
			<CANCELED_DIRECT_CREDITS>{ fn:data($CANCELED_DIRECT_CREDITS) }</CANCELED_DIRECT_CREDITS>
		}
		{
			for $ACTIVE_INDIRECT_CREDITS in $consultaOfertaCreditoConsumoResponse/ACTIVE_INDIRECT_CREDITS
			return
			<ACTIVE_INDIRECT_CREDITS>{ fn:data($ACTIVE_INDIRECT_CREDITS) }</ACTIVE_INDIRECT_CREDITS>
		}
		{
			for $CANCELED_INDIRECT_CREDITS in $consultaOfertaCreditoConsumoResponse/CANCELED_INDIRECT_CREDITS
			return
			<CANCELED_INDIRECT_CREDITS>{ fn:data($CANCELED_INDIRECT_CREDITS) }</CANCELED_INDIRECT_CREDITS>
		}
		{
			for $ARREAR_ON_30DAYS_FOR_3MONTHS in $consultaOfertaCreditoConsumoResponse/ARREAR_ON_30DAYS_FOR_3MONTHS
			return
			<ARREAR_ON_30DAYS_FOR_3MONTHS>{ fn:data($ARREAR_ON_30DAYS_FOR_3MONTHS) }</ARREAR_ON_30DAYS_FOR_3MONTHS>
		}
		{
			for $ARREAR_ON_120DAYS_FOR_18MONTHS in $consultaOfertaCreditoConsumoResponse/ARREAR_ON_120DAYS_FOR_18MONTHS
			return
			<ARREAR_ON_120DAYS_FOR_18MONTHS>{ fn:data($ARREAR_ON_120DAYS_FOR_18MONTHS) }</ARREAR_ON_120DAYS_FOR_18MONTHS>
		}
		{
			for $TOTAL_DIRECT_DEBT in $consultaOfertaCreditoConsumoResponse/TOTAL_DIRECT_DEBT
			return
			<TOTAL_DIRECT_DEBT>{ fn:data($TOTAL_DIRECT_DEBT) }</TOTAL_DIRECT_DEBT>
		}
		{
			for $TOTAL_INDIRECT_DEBT in $consultaOfertaCreditoConsumoResponse/TOTAL_INDIRECT_DEBT
			return
			<TOTAL_INDIRECT_DEBT>{ fn:data($TOTAL_INDIRECT_DEBT) }</TOTAL_INDIRECT_DEBT>
		}
		{
			for $TOTAL_CONTINGENT_DEBT in $consultaOfertaCreditoConsumoResponse/TOTAL_CONTINGENT_DEBT
			return
			<TOTAL_CONTINGENT_DEBT>{ fn:data($TOTAL_CONTINGENT_DEBT) }</TOTAL_CONTINGENT_DEBT>
		}
		{
			for $CALCULATED_SALARY in $consultaOfertaCreditoConsumoResponse/CALCULATED_SALARY
			return
			<CALCULATED_SALARY>{ fn:data($CALCULATED_SALARY) }</CALCULATED_SALARY>
		}
		{
			for $DEBT_BURDEN_SALARY in $consultaOfertaCreditoConsumoResponse/DEBT_BURDEN_SALARY
			return
			<DEBT_BURDEN_SALARY>{ fn:data($DEBT_BURDEN_SALARY) }</DEBT_BURDEN_SALARY>
		}
		{
			for $BUREAU_INSTALLMENT in $consultaOfertaCreditoConsumoResponse/BUREAU_INSTALLMENT
			return
			<BUREAU_INSTALLMENT>{ fn:data($BUREAU_INSTALLMENT) }</BUREAU_INSTALLMENT>
		}
		{
			for $BUREAU_INSTALLMENT_EXTERNAL in $consultaOfertaCreditoConsumoResponse/BUREAU_INSTALLMENT_EXTERNAL
			return
			<BUREAU_INSTALLMENT_EXTERNAL>{ fn:data($BUREAU_INSTALLMENT_EXTERNAL) }</BUREAU_INSTALLMENT_EXTERNAL>
		}
		{
			for $TOTAL_BUREAU_INSTALLMENT in $consultaOfertaCreditoConsumoResponse/TOTAL_BUREAU_INSTALLMENT
			return
			<TOTAL_BUREAU_INSTALLMENT>{ fn:data($TOTAL_BUREAU_INSTALLMENT) }</TOTAL_BUREAU_INSTALLMENT>
		}
		{
			for $MAX_LIMIT_CREDIT_CARD in $consultaOfertaCreditoConsumoResponse/MAX_LIMIT_CREDIT_CARD
			return
			<MAX_LIMIT_CREDIT_CARD>{ fn:data($MAX_LIMIT_CREDIT_CARD) }</MAX_LIMIT_CREDIT_CARD>
		}
		{
			for $AVERAGE_LIMIT_CREDIT_CARD in $consultaOfertaCreditoConsumoResponse/AVERAGE_LIMIT_CREDIT_CARD
			return
			<AVERAGE_LIMIT_CREDIT_CARD>{ fn:data($AVERAGE_LIMIT_CREDIT_CARD) }</AVERAGE_LIMIT_CREDIT_CARD>
		}
		{
			for $CONSOLIDATE_BALANCE in $consultaOfertaCreditoConsumoResponse/CONSOLIDATE_BALANCE
			return
			<CONSOLIDATE_BALANCE>{ fn:data($CONSOLIDATE_BALANCE) }</CONSOLIDATE_BALANCE>
		}
		{
			for $SIB_REFERENCE in $consultaOfertaCreditoConsumoResponse/SIB_REFERENCE
			return
			<SIB_REFERENCE>{ fn:data($SIB_REFERENCE) }</SIB_REFERENCE>
		}
		{
			for $REFERENCE in $consultaOfertaCreditoConsumoResponse/REFERENCE
			return
			<REFERENCE>{ fn:data($REFERENCE) }</REFERENCE>
		}
		{
			for $REFERENCE_TYPE in $consultaOfertaCreditoConsumoResponse/REFERENCE_TYPE
			return
			<REFERENCE_TYPE>{ fn:data($REFERENCE_TYPE) }</REFERENCE_TYPE>
		}
		{
			for $REFERENCE_ENTITY in $consultaOfertaCreditoConsumoResponse/REFERENCE_ENTITY
			return
			<REFERENCE_ENTITY>{ fn:data($REFERENCE_ENTITY) }</REFERENCE_ENTITY>
		}
		{
			for $REFERENCE_BALANCE in $consultaOfertaCreditoConsumoResponse/REFERENCE_BALANCE
			return
			<REFERENCE_BALANCE>{ fn:data($REFERENCE_BALANCE) }</REFERENCE_BALANCE>
		}
		{
			for $REFERENCE_OPENING_DATE in $consultaOfertaCreditoConsumoResponse/REFERENCE_OPENING_DATE
			return
			<REFERENCE_OPENING_DATE>{ fn:data($REFERENCE_OPENING_DATE) }</REFERENCE_OPENING_DATE>
		}
		{
			if (fn:exists($consultaOfertaCreditoConsumoResponse/SCORE/SCORE)) then (
				<SCORE>
				{
					for $SCORE in $consultaOfertaCreditoConsumoResponse/SCORE/SCORE
					return(
						<SCORE>
						{
							for $VAR1 in $SCORE/VAR1
							return
							<VAR1>{ fn:data($VAR1) }</VAR1>
						}
						{
							for $VAR2 in $SCORE/VAR2
							return
							<VAR2>{ fn:data($VAR2) }</VAR2>
						}
						{
							for $VAR3 in $SCORE/VAR3
							return
							<VAR3>{ fn:data($VAR3) }</VAR3>
						}
						{
							for $VAR4 in $SCORE/VAR4
							return
							<VAR4>{ fn:data($VAR4) }</VAR4>
						}
						{
							for $VAR5 in $SCORE/VAR5
							return
							<VAR5>{ fn:data($VAR5) }</VAR5>
						}
						{
							for $VAR6 in $SCORE/VAR6
							return
							<VAR6>{ fn:data($VAR6) }</VAR6>
						}
						{
							for $VAR7 in $SCORE/VAR7
							return
							<VAR7>{ fn:data($VAR7) }</VAR7>
						}
						{
							for $VAR8 in $SCORE/VAR8
							return
							<VAR8>{ fn:data($VAR8) }</VAR8>
						}
						{
							for $VAR9 in $SCORE/VAR9
							return
							<VAR9>{ fn:data($VAR9) }</VAR9>
						}
						{
							for $VAR10 in $SCORE/VAR10
							return
							<VAR10>{ fn:data($VAR10) }</VAR10>
						}
						{
							for $VAR11 in $SCORE/VAR11
							return
							<VAR11>{ fn:data($VAR11) }</VAR11>
						}
						{
							for $VAR12 in $SCORE/VAR12
							return
							<VAR12>{ fn:data($VAR12) }</VAR12>
						}
						{
							for $VAR13 in $SCORE/VAR13
							return
							<VAR13>{ fn:data($VAR13) }</VAR13>
						}
						{
							for $VAR14 in $SCORE/VAR14
							return
							<VAR14>{ fn:data($VAR14) }</VAR14>
						}
						{
							for $VAR15 in $SCORE/VAR15
							return
							<VAR15>{ fn:data($VAR15) }</VAR15>
						}
						{
							for $INTERNAL_SCORE in $SCORE/INTERNAL_SCORE
							return
							<INTERNAL_SCORE>{ fn:data($INTERNAL_SCORE) }</INTERNAL_SCORE>
						}
						{
							for $INTERNAL_RISK_LEVEL in $SCORE/INTERNAL_RISK_LEVEL
							return
							<INTERNAL_RISK_LEVEL>{ fn:data($INTERNAL_RISK_LEVEL) }</INTERNAL_RISK_LEVEL>
						}
						{
							for $SCORE_STRATEGY in $SCORE/SCORE_STRATEGY
							return
							<SCORE_STRATEGY>{ fn:data($SCORE_STRATEGY) }</SCORE_STRATEGY>
						}
						{
							for $SCORE_TYPE in $SCORE/SCORE_TYPE
							return
							<SCORE_TYPE>{ fn:data($SCORE_TYPE) }</SCORE_TYPE>
						}
						</SCORE>
					)
				}
				</SCORE>
			) else ()
		}
		{
			if (fn:exists($consultaOfertaCreditoConsumoResponse/FOR_CONSOLIDATE/FOR_CONSOLIDATE)) then (
				<FOR_CONSOLIDATE>
				{
					for $FOR_CONSOLIDATE in $consultaOfertaCreditoConsumoResponse/FOR_CONSOLIDATE/FOR_CONSOLIDATE
					return(
						<FOR_CONSOLIDATE>
						{
							for $REFERENCE_TYPE in $FOR_CONSOLIDATE/REFERENCE_TYPE
							return
							<REFERENCE_TYPE>{ fn:data($REFERENCE_TYPE) }</REFERENCE_TYPE>
						}
						{
							for $REFERENCE_CURRENCY in $FOR_CONSOLIDATE/REFERENCE_CURRENCY
							return
							<REFERENCE_CURRENCY>{ fn:data($REFERENCE_CURRENCY) }</REFERENCE_CURRENCY>
						}
						{
							for $REFERENCE_ENTITY in $FOR_CONSOLIDATE/REFERENCE_ENTITY
							return
							<REFERENCE_ENTITY>{ fn:data($REFERENCE_ENTITY) }</REFERENCE_ENTITY>
						}
						{
							for $CHECK_BENEFECIARY in $FOR_CONSOLIDATE/CHECK_BENEFECIARY
							return
							<CHECK_BENEFECIARY>{ fn:data($CHECK_BENEFECIARY) }</CHECK_BENEFECIARY>
						}
						{
							for $REFERENCE_ACCOUNT_NUMBER in $FOR_CONSOLIDATE/REFERENCE_ACCOUNT_NUMBER
							return
							<REFERENCE_ACCOUNT_NUMBER>{ fn:data($REFERENCE_ACCOUNT_NUMBER) }</REFERENCE_ACCOUNT_NUMBER>
						}
						{
							for $REFERENCE_LIMIT_AMOUNT in $FOR_CONSOLIDATE/REFERENCE_LIMIT_AMOUNT
							return
							<REFERENCE_LIMIT_AMOUNT>{ fn:data($REFERENCE_LIMIT_AMOUNT) }</REFERENCE_LIMIT_AMOUNT>
						}
						{
							for $REFERENCE_INSTALLMENT_AMOUNT in $FOR_CONSOLIDATE/REFERENCE_INSTALLMENT_AMOUNT
							return
							<REFERENCE_INSTALLMENT_AMOUNT>{ fn:data($REFERENCE_INSTALLMENT_AMOUNT) }</REFERENCE_INSTALLMENT_AMOUNT>
						}
						</FOR_CONSOLIDATE>
					)
				}
				</FOR_CONSOLIDATE>
			) else ()
		}
		</CREDIT_OFFER_INQUIRY_RESPONSE>
};

declare function xf:processCustomerOfferXMLIn($successIndicator as xs:string,
    $message as xs:string,
    $consultaOfertaCreditoConsumoResponse as element(ns0:consultaOfertaCreditoConsumoResponse))
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:P_XMLRESPONSE>{ fn-bea:serialize(xf:buildXMLResponse($successIndicator, $message, $consultaOfertaCreditoConsumoResponse)) }</ns1:P_XMLRESPONSE>
        </ns1:InputParameters>
};

declare variable $successIndicator as xs:string external;
declare variable $message as xs:string external;
declare variable $consultaOfertaCreditoConsumoResponse as element(ns0:consultaOfertaCreditoConsumoResponse) external;

xf:processCustomerOfferXMLIn($successIndicator,
    $message,
    $consultaOfertaCreditoConsumoResponse)
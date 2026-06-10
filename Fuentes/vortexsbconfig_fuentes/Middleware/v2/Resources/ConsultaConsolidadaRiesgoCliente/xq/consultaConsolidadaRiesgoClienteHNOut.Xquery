<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://www.ficohsa.com.hn/middleware.services/consultaConsolidadaRiesgoClienteTypes";
(:: import schema at "../xsd/consultaConsolidadaRiesgoClienteTypes.xsd" ::)


declare variable $InputJSConsultaConsolidadaRiegoCliente as element() external;

declare variable $InputConsultaInformacionBuroTucaHN as element() external;

declare function local:func($InputJSConsultaConsolidadaRiegoCliente as element(), 
                            $InputConsultaInformacionBuroTucaHN as element()) 
                            as element() (:: schema-element(ns1:consultaConsolidadaRiesgoClienteResponse) ::) {
                            
        
        let $orig := $InputConsultaInformacionBuroTucaHN/BUREAU_TUCA
             
        let $cust := $InputJSConsultaConsolidadaRiegoCliente/LOAN_MAINTENANCE
        
        let $lm   := $InputJSConsultaConsolidadaRiegoCliente/LOAN_ORIGINATIONS
        let $val := '0'
        return
        
                      
    <ns1:consultaConsolidadaRiesgoClienteResponse>
        <LOAN_MAINTENANCE>
        
            <CUSTOMER_INFO>
                <ID>{ data($cust/CUSTOMER_INFO/ID) }</ID>
                <TARGET>{ data($cust/CUSTOMER_INFO/TARGET) }</TARGET>
                <DATE_OF_BIRTH>{ fn-bea:date-from-string-with-format("yyyy-MM-dd",data($cust/CUSTOMER_INFO/DATE_OF_BIRTH)) }</DATE_OF_BIRTH>
                <AGE>{ data($cust/CUSTOMER_INFO/AGE) }</AGE>
                <TYPE>{ data($cust/CUSTOMER_INFO/TYPE) }</TYPE>
                <SALARY>{ data($cust/CUSTOMER_INFO/SALARY) }</SALARY>
                <PAYROLL_SALARY>{ data($cust/CUSTOMER_INFO/PAYROLL_SALARY) }</PAYROLL_SALARY>
                <CREDIT_MONTHS>{ data($cust/CUSTOMER_INFO/CREDIT_MONTHS) }</CREDIT_MONTHS>
                <FLAG_BLAZE>{ data($cust/CUSTOMER_INFO/FLAG_BLAZE) }</FLAG_BLAZE>
                <FLAG_HIT></FLAG_HIT>
                <EVALUATION_RESULT></EVALUATION_RESULT> <!-- No se encontro-->
                {
                 if (not(empty($orig/LOCATION/LOCATION_ITEM/DESC))) then(
                
                <ADDRESSES_INFO>
                {
                for $row in $orig/LOCATION/LOCATION_ITEM
                return
                    <ADDRESS_ITEM>
                        <PERIOD>{data($row/PERIOD)}</PERIOD>
                        <ADDRESS>{data($row/DESC)}</ADDRESS>
                    </ADDRESS_ITEM>
                  }
                </ADDRESSES_INFO>
                 )else()
                    }
                {
                 if (not(empty($orig/LOCATION/LOCATION_ITEM/PHONE))) then(
                <PHONES_INFO>
                {
                for $row in $orig/LOCATION/LOCATION_ITEM
                return
                    <PHONE_ITEM>
                        <PERIOD>{data($row/PERIOD)}</PERIOD>
                        <PHONE>{ data($row/PHONE)}</PHONE>
                    </PHONE_ITEM>
                    }
                </PHONES_INFO>
                )else()
                }
                
                {
                 if ($val != '0') then(
                <ADMINISTRATIVE_CHARGES> <!-- No se encontro bloque-->
                    <CHARGE>
                        <ID></ID>
                        <INFORMATION_DATE></INFORMATION_DATE>
                        <IN_DATE></IN_DATE>
                        <CREDITOR></CREDITOR>
                        <MOTIVATION></MOTIVATION>
                        <CURRENCY></CURRENCY>
                        <TOTAL_DEBT_AMOUNT></TOTAL_DEBT_AMOUNT>
                        <EXCHANGE_FACTOR></EXCHANGE_FACTOR>
                    </CHARGE>
                </ADMINISTRATIVE_CHARGES>
                )else()
                }
                
                {
                 if ($val != '0') then(
                <CURRENT_ARREAR_SUMMARY> <!-- No se encontro bloque-->
                    <ARREAR>
                        <ID></ID>
                        <INFORMATION_DATE></INFORMATION_DATE>
                        <DATE></DATE>
                        <CREDITOR></CREDITOR>
                        <ACCOUNT_TYPE></ACCOUNT_TYPE>
                        <CURRENCY></CURRENCY>
                        <DAYS></DAYS>
                        <AMOUNT></AMOUNT>
                        <EXCHANGE_FACTOR></EXCHANGE_FACTOR>
                    </ARREAR>
                </CURRENT_ARREAR_SUMMARY>
                )else()
                }
                {
                for $row in $orig/MODEL/MODEL_ITEM
                return
                
                <EXTERNAL_SCORE>{ data($row/RESULT)}</EXTERNAL_SCORE>
                }
                
                 {
                 if ($val != '0') then(
                <SCORE_INFO>
                    <SCORE_CALCULATION></SCORE_CALCULATION>
                    <QUALIFICATION></QUALIFICATION>
                    <RISK_LEVEL></RISK_LEVEL>
                </SCORE_INFO>
                )else()
                }
                {
                if (not(empty($cust/CUSTOMER_INFO/ASSETS/ASSET/NUMBER))) then(
                <ASSETS>
                {
                for $row in $cust/CUSTOMER_INFO/ASSETS/ASSET
                return
                    <ASSET>
                        <NUMBER>{ data($row/NUMBER) }</NUMBER>
                        <CATEGORY>{ data($row/CATEGORY) }</CATEGORY>
                        <CURRENCY>{ data($row/CURRENCY) }</CURRENCY>
                        <OPENING_DATE>{fn-bea:date-from-string-with-format("yyyy-MM-dd",data($row/OPENING_DATE)) }</OPENING_DATE>
                        <CURRENT_BALANCE>{ xs:float(data($row/CURRENT_BALANCE)) }</CURRENT_BALANCE>
                        <END_OF_MONTH_BALANCE>{ xs:float(data($row/END_OF_MONTH_BALANCE)) }</END_OF_MONTH_BALANCE>
                        <AVERAGE_BALANCE>{ xs:float(data($row/AVERAGE_BALANCE)) }</AVERAGE_BALANCE>
			{
                          let $tx := $row/PRODUCT_TRANSACTIONS/TRANSACTION[ASSET_NUMBER = $row/NUMBER]
                          return
                            if (exists($tx)) then (
                          <PRODUCT_TRANSACTIONS>
                          {
                            for $RHJ in $tx
                            return
                              <TRANSACTION>
                                  <PERIOD_DATE>{ fn-bea:dateTime-from-string-with-format("yyyy-MM-dd", data($RHJ/PERIOD_DATE)) }</PERIOD_DATE>
                                  <PERIOD_BALANCE>{ data($RHJ/PERIOD_BALANCE) }</PERIOD_BALANCE>
                                  <MAX_BALANCE>{ data($RHJ/MAX_BALANCE) }</MAX_BALANCE>
                                  <MIN_BALANCE>{ data($RHJ/MIN_BALANCE) }</MIN_BALANCE>
                                  <AVERAGE_BALANCE>{ data($RHJ/AVERAGE_BALANCE) }</AVERAGE_BALANCE>
                                  <LAST_CREDIT_DATE>{ data($RHJ/LAST_CREDIT_DATE) }</LAST_CREDIT_DATE>
                                  <LAST_DEBIT_DATE>{ data($RHJ/LAST_DEBIT_DATE) }</LAST_DEBIT_DATE>
                                  <FACILITIES>{ data($RHJ/FACILITIES) }</FACILITIES>
                                  <LEGAL_REPRESENTATIVE>{ data($RHJ/LEGAL_REPRESENTATIVE) }</LEGAL_REPRESENTATIVE>
                                  <PAYROLL_ACCOUNTS>{ data($RHJ/PAYROLL_ACCOUNTS) }</PAYROLL_ACCOUNTS>
                                  <PAYROLL_CREDIT_AMOUNT>{ data($RHJ/PAYROLL_CREDIT_AMOUNT) }</PAYROLL_CREDIT_AMOUNT>
                                  <JOINT_ACCOUNTS>{ data($RHJ/JOINT_ACCOUNTS) }</JOINT_ACCOUNTS>
                                  <PRODUCT_BLOCK>{ data($RHJ/PRODUCT_BLOCK) }</PRODUCT_BLOCK>
                                  <CREDITS_INFO>
                                      <AMOUNT_ON_PERIOD>{ data($RHJ/CREDITS_INFO/AMOUNT_ON_PERIOD) }</AMOUNT_ON_PERIOD>
                                      <SUMMATION>{ data($RHJ/CREDITS_INFO/SUMMATION) }</SUMMATION>
                                      <INTEREST_ON_PERIOD>{ data($RHJ/CREDITS_INFO/INTEREST_ON_PERIOD) }</INTEREST_ON_PERIOD>
                                      <INTERESTS_SUMMATION>{ data($RHJ/CREDITS_INFO/INTERESTS_SUMMATION) }</INTERESTS_SUMMATION>
                                  </CREDITS_INFO>
                                  <DEBITS_INFO>
                                      <AMOUNT_ON_PERIOD>{ data($RHJ/DEBITS_INFO/AMOUNT_ON_PERIOD) }</AMOUNT_ON_PERIOD>
                                      <SUMMATION>{ data($RHJ/DEBITS_INFO/SUMMATION) }</SUMMATION>
                                      <INTEREST_ON_PERIOD>{ data($RHJ/DEBITS_INFO/INTEREST_ON_PERIOD) }</INTEREST_ON_PERIOD>
                                      <INTERESTS_SUMMATION>{ data($RHJ/DEBITS_INFO/INTERESTS_SUMMATION) }</INTERESTS_SUMMATION>
                                  </DEBITS_INFO>
                              </TRANSACTION>
                          }
                          </PRODUCT_TRANSACTIONS>
                        ) else ()
                      }
                    </ASSET>
                    }
                </ASSETS>
                )else()
                }
                <LIABILITIES>
                {
                if (not(empty($cust/CUSTOMER_INFO/LIABILITIES/CREDIT_CARDS_INFO/CREDIT_CARD/ACCOUNT))) then(
                    <CREDIT_CARDS_INFO>
                    {
                for $row in $cust/CUSTOMER_INFO/LIABILITIES/CREDIT_CARDS_INFO/CREDIT_CARD
                return
                        <CREDIT_CARD>
                            <ACCOUNT>{data($row/ACCOUNT)}</ACCOUNT>
                            <BEHAVIOR_SCORE>{data($row/BEHAVIOR_SCORE)}</BEHAVIOR_SCORE>
                            <QUALIFICATION_SCORE>{xs:string(data($row/QUALIFICATION_SCORE))}</QUALIFICATION_SCORE>
                            <QUALIFICATION_CUSTOMER_SCORE>{xs:string(data($row/QUALIFICATION_CUSTOMER_SCORE))}</QUALIFICATION_CUSTOMER_SCORE>
                            <STATUS>{data($row/STATUS)}</STATUS>
                            <AFFINITY_GROUP>{data($row/AFFINITY_GROUP)}</AFFINITY_GROUP>
                            <PRODUCT>{data($row/PRODUCT)}</PRODUCT>
                            <CLEARING_MODEL></CLEARING_MODEL>
                            <OPENING_DATE>{ fn-bea:date-from-string-with-format("yyyy-MM-dd", data($row/OPENING_DATE))}</OPENING_DATE>
                            {
                             if(data($row/CANCELATION_DATE) != "") then(
                            <CANCELATION_DATE>{fn-bea:date-from-string-with-format("yyyy-MM-dd",data($row/CANCELATION_DATE))}</CANCELATION_DATE>
                            )else()
                            }
                            {
                             if(data($row/LAST_EXTRA_DATE) != "") then(
                            <LAST_EXTRA_DATE>{fn-bea:date-from-string-with-format("yyyy-MM-dd", data($row/LAST_EXTRA_DATE))}</LAST_EXTRA_DATE>
                            )else()
                            }
                            <CURRENT_DUE>{data($row/CURRENT_DUE)}</CURRENT_DUE>
                            <CURRENT_LIMIT>{xs:float(data($row/CURRENT_LIMIT))}</CURRENT_LIMIT>
                            <CURRENT_BALANCE>{xs:float(data($row/CURRENT_BALANCE))}</CURRENT_BALANCE>
                            <CLOSING_BALANCE>{xs:float(data($row/CLOSING_BALANCE))}</CLOSING_BALANCE>
                            <EXTRA_BALANCE>{xs:float(data($row/EXTRA_BALANCE))}</EXTRA_BALANCE>
                            <INTRA_BALANCE>{xs:float(data($row/INTRA_BALANCE))}</INTRA_BALANCE>
                            <ACTIVE_EXTRA_INSTALLMENTS>{xs:float(data($row/ACTIVE_EXTRA_INSTALLMENTS))}</ACTIVE_EXTRA_INSTALLMENTS>
                            <LOCKCODE1>{data($row/LOCKCODE1)}</LOCKCODE1>
                            <LOCKCODE2>{data($row/LOCKCODE2)}</LOCKCODE2>
                            <LOGO>{data($row/LOGO)}</LOGO>
                            <AVAILABLE_CASH>{data($row/AVAILABLE_CASH)}</AVAILABLE_CASH>
                            {
                             if(data($row/LOCK_DATE1) != "") then(
                            <LOCK_DATE1>{fn-bea:date-from-string-with-format("yyyy-MM-dd",data($row/LOCK_DATE1))}</LOCK_DATE1>
                            )else()
                            }
                            {
                             if(data($row/LOCK_DATE2) != "") then(
                            <LOCK_DATE2>{fn-bea:date-from-string-with-format("yyyy-MM-dd",data($row/LOCK_DATE2))}</LOCK_DATE2>
                            )else()
                            }
                            <BIN></BIN>
                            
                            <EXTRA_APPROVAL_DATE>{data($row/EXTRA_APPROVAL_DATE)}</EXTRA_APPROVAL_DATE>
                           
                            <INTRA_APPROVAL_DATE>{data($row/INTRA_APPROVAL_DATE)}</INTRA_APPROVAL_DATE>
                           
                            <PIL_APPROVAL_DATE>{data($row/INTRA_APPROVAL_DATE)}</PIL_APPROVAL_DATE>
                            <PRIOR_LIMIT>{data($row/PRIOR_LIMIT)}</PRIOR_LIMIT>
                            <AUTH_BALANCE>{data($row/AUTH_BALANCE)}</AUTH_BALANCE>
                            {
                              if(
                                  data($cust/CUSTOMER_INFO/LIABILITIES/CREDIT_CARDS_INFO/CREDIT_CARD/PRODUCT_TRANSACTIONS/TRANSACTION[1]/CARD_NUMBER) = replace($row/ACCOUNT[1],'^00000','')
                                    ) then (
                            <PRODUCT_TRANSACTIONS>
                             {
                                for $RHJ in $cust/CUSTOMER_INFO/LIABILITIES/CREDIT_CARDS_INFO/CREDIT_CARD/PRODUCT_TRANSACTIONS/TRANSACTION
                                return
                                <TRANSACTION>
                                    <PERIOD_DATE>{data($RHJ/PERIOD_DATE)}</PERIOD_DATE>
                                    <PERIOD_BALANCE>{data($RHJ/PERIOD_BALANCE)}</PERIOD_BALANCE>
                                    <AMOUNT_DUE>{data($RHJ/AMOUNT_DUE)}</AMOUNT_DUE>
                                    <PAYMENTS>{data($RHJ/PAYMENTS)}</PAYMENTS>
                                    <MERCH_SALES>{data($RHJ/PERIOD_DATE)}</MERCH_SALES>
                                    <CASH_WITHDRAWAL>{data($RHJ/CASH_WITHDRAWAL)}</CASH_WITHDRAWAL>
                                    <LIMIT>{data($RHJ/LIMIT)}</LIMIT>
                                    <OTHER_TRANSACTIONS>{data($RHJ/OTHER_TRANSACTIONS)}</OTHER_TRANSACTIONS>
                                    <INTEREST>{data($RHJ/INTEREST)}</INTEREST>
                                    <TOTAL_FEES>{data($RHJ/TOTAL_FEES)}</TOTAL_FEES>
                                    <OTHER_DEBITS>{data($RHJ/OTHER_DEBITS)}</OTHER_DEBITS>
                                    <CYCLE_DUE>{data($RHJ/CYCLE_DUE)}</CYCLE_DUE>
                                    <CYCLE_TOTAL_BALANCE>{data($RHJ/CYCLE_TOTAL_BALANCE)}</CYCLE_TOTAL_BALANCE>
                                    <EXTRA_CASH_INFO>
                                        <BALANCE>{data($RHJ/BALANCE)}</BALANCE>
                                        <INSTALLMENT>{data($RHJ/INSTALLMENT)}</INSTALLMENT>
                                        <INTEREST>{data($RHJ/INTEREST)}</INTEREST>
                                        <FEE>{data($RHJ/FEE)}</FEE>
                                    </EXTRA_CASH_INFO>
                                    <INTRA_CASH_INFO>
                                        <BALANCE>{data($RHJ/BALANCE)}</BALANCE>
                                        <INSTALLMENT>{data($RHJ/INSTALLMENT)}</INSTALLMENT>
                                        <INTEREST>{data($RHJ/INTEREST)}</INTEREST>
                                        <FEE>{data($RHJ/FEE)}</FEE>
                                    </INTRA_CASH_INFO>
                                    <EXTRA_FEE>{data($RHJ/EXTRA_FEE)}</EXTRA_FEE>
                                    <INTRA_FEE>{data($RHJ/INTRA_FEE)}</INTRA_FEE>
                                    <EXTRA_BALANCE>{data($RHJ/EXTRA_BALANC)}</EXTRA_BALANCE>
                                    <INTRA_BALANCE>{data($RHJ/INTRA_BALANCE)}</INTRA_BALANCE>
                                </TRANSACTION>
                                }
                            </PRODUCT_TRANSACTIONS>
                           ) else()
                            }
                        </CREDIT_CARD>
                        }
                    </CREDIT_CARDS_INFO>
                    )else()
                    }
                    {
                if (not(empty($cust/CUSTOMER_INFO/LIABILITIES/LOANS_INFO/LOAN/NUMBER))) then(
                    <LOANS_INFO>
                         {
                for $row in $cust/CUSTOMER_INFO/LIABILITIES/LOANS_INFO/LOAN
                return
                        <LOAN>
                            <NUMBER>{data($row/NUMBER)}</NUMBER>
                            <AGENCY_CODE>{data($row/AGENCY_CODE)}</AGENCY_CODE>
                            <SUB_APPLICATION>{data($row/SUB_APPLICATION)}</SUB_APPLICATION>
                            <OPENING_DATE>{fn-bea:date-from-string-with-format("yyyy-MM-dd",data($row/OPENING_DATE))}</OPENING_DATE>
                            {
                            if(data($row/CANCELATION_DATE) != "") then(
                            <CANCELATION_DATE>{fn-bea:date-from-string-with-format("yyyy-MM-dd", data($row/CANCELATION_DATE))}</CANCELATION_DATE>
                            )else()
                            }
                            <INITIAL_AMOUNT>{xs:float(data($row/INITIAL_AMOUNT))}</INITIAL_AMOUNT>
                            <CURRENT_BALANCE>{xs:float(data($row/CURRENT_BALANCE))}</CURRENT_BALANCE>
                            <PAYMENT_AMOUNT>{xs:float(data($row/PAYMENT_AMOUNT))}</PAYMENT_AMOUNT>
                            <RATE>{xs:float(data($row/RATE))}</RATE>
                            <TERM>{data($row/TERM)}</TERM>
                            <PAYMENT_NUMBER>{data($row/PAYMENT_NUMBER)}</PAYMENT_NUMBER>
                             {
                            if(data($row/FIRST_CAPITAL_PAYMENT_DATE) != "") then(
                            <FIRST_CAPITAL_PAYMENT_DATE>{fn-bea:date-from-string-with-format("yyyy-MM-dd",data($row/FIRST_CAPITAL_PAYMENT_DATE))}</FIRST_CAPITAL_PAYMENT_DATE>
                            )else()
                            }
                             {
                            if(data($row/LAST_PAYMENT_DATE) != "") then(
                            <LAST_PAYMENT_DATE>{fn-bea:date-from-string-with-format("yyyy-MM-dd",data($row/LAST_PAYMENT_DATE))}</LAST_PAYMENT_DATE>
                            )else()
                            }
                            <PAID_PAYMENTS>{data($row/PAID_PAYMENTS)}</PAID_PAYMENTS>
                            <CAPITAL_FREQUENCY>{data($row/CAPITAL_FREQUENCY)}</CAPITAL_FREQUENCY>
                            <DESTINATION_CODE>{data($row/DESTINATION_CODE)}</DESTINATION_CODE>
                            <MONTHLY_PRIME>{data($row/MONTHLY_PRIME)}</MONTHLY_PRIME>
                            <CONTRACT_NUMBER>{xs:int(data($row/CONTRACT_NUMBER))}</CONTRACT_NUMBER>
                            <CHARGES>{xs:float(data($row/CHARGES))}</CHARGES>
                            <INTEREST>{xs:float(data($row/INTEREST))}</INTEREST>
                            <INSURANCE>{xs:float(data($row/INSURANCE))}</INSURANCE>
                            <OTHER_CHARGES>{xs:float(data($row/OTHER_CHARGES))}</OTHER_CHARGES>
                            <CURRENT_DUE>{xs:float(data($row/CURRENT_DUE))}</CURRENT_DUE>
                            <DEBTOR_TYPE>{data($row/DEBTOR_TYPE)}</DEBTOR_TYPE>
                            <CODE_TYPE>{data($row/CODE_TYPE)}</CODE_TYPE>
                            <GUARANTEE_TYPE>{data($row/GUARANTEE_TYPE)}</GUARANTEE_TYPE>
                            <PRODUCT_TRANSACTIONS>
                            {
                              for $RHJ in $row/PRODUCT_TRANSACTIONS/TRANSACTION
                              return
                                <TRANSACTION>
                                    <PERIOD_DATE>{fn-bea:dateTime-from-string-with-format("yyyy-MM-dd", data($RHJ/PERIOD_DATE))}</PERIOD_DATE>
                                    <PERIOD_BALANCE>{
                                                if (normalize-space(data($RHJ/PERIOD_BALANCE)) != '') then
                                                  xs:float(data($RHJ/PERIOD_BALANCE))
                                                else 0
                                    }</PERIOD_BALANCE>
                                    <CAPITAL_BALANCE>{xs:float(data($RHJ//CAPITAL_BALANCE))}</CAPITAL_BALANCE>
                                    <DUE_BALANCE>{xs:int(xs:decimal(data($RHJ/DUE_BALANCE)))}</DUE_BALANCE>
                                    <CHARGES>{xs:float(data($RHJ/CHARGES))}</CHARGES>
                                    <INTEREST>{xs:float(data($RHJ/INTEREST))}</INTEREST>
                                    <PAYMENT>{xs:float(data($RHJ/PAYMENT))}</PAYMENT>
                                    <INSURANCE>{xs:float(data($RHJ/INSURANCE))}</INSURANCE>
                                    <OTHER_CHARGES>{xs:float(data($RHJ/OTHER_CHARGES))}</OTHER_CHARGES>
                                    <CYCLE_DUE>{data($RHJ/CYCLE_DUE)}</CYCLE_DUE>
                                </TRANSACTION>
                                }
                            </PRODUCT_TRANSACTIONS>
                        </LOAN>
                        }
                    </LOANS_INFO>
                    )else()
                    }
                </LIABILITIES>
                <REFERENCIA_SIB></REFERENCIA_SIB>
            </CUSTOMER_INFO>
        </LOAN_MAINTENANCE>
        
        
        
        <LOAN_ORIGINATIONS>
        {
                if (not(empty($lm/PRE_APPROVED_OFFERS/OFFER/TYPE))) then(
            <PRE_APPROVED_OFFERS>
            {
              for $row in $lm/PRE_APPROVED_OFFERS/OFFER
              return
                <OFFER>
                    <INFORMATION_DATE>{ fn-bea:dateTime-from-string-with-format("yyyy-MM-dd",data($row/INFORMATION_DATE))}</INFORMATION_DATE>
                    <TYPE>{data($row/TYPE)}</TYPE>
                    <DETAILS>
                        <FOR_12_MONTHS>{xs:float(data($row/DETAILS/FOR_12_MONTHS))}</FOR_12_MONTHS>
                        <FOR_24_MONTHS>{xs:float(data($row/DETAILS/FOR_24_MONTHS))}</FOR_24_MONTHS>
                        <FOR_36_MONTHS>{xs:float(data($row/DETAILS/FOR_36_MONTHS))}</FOR_36_MONTHS>
                        <FOR_48_MONTHS>{xs:float(data($row/DETAILS/FOR_48_MONTHS))}</FOR_48_MONTHS>
                        <FOR_60_MONTHS>{xs:float(data($row/DETAILS/FOR_60_MONTHS))}</FOR_60_MONTHS>
                    </DETAILS>
                    <INSTALLMENT>{xs:float(data($row/INSTALLMENT))}</INSTALLMENT>
                    <RATE>{xs:float(data($row/RATE)*100)}</RATE>
                    <TIMES_INCOME>{xs:int(data($row/TIMES_INCOME))}</TIMES_INCOME>
                </OFFER>
                }
            </PRE_APPROVED_OFFERS>
            )else()
            }
            {
                if (not(empty($lm/INTERNAL_EXTRAS/EXTRA/ACCOUNT_NUMBER))) then(
            <INTERNAL_EXTRAS>
            {
              for $row in $lm/INTERNAL_EXTRAS/EXTRA
              return
                <EXTRA>
                    <ACCOUNT_NUMBER>{data($row/ACCOUNT_NUMBER)}</ACCOUNT_NUMBER>
                    <DATE>{data($row/DATE)}</DATE>
                    <RATE>{data($row/RATE)}</RATE>
                    <AMOUNT>{data($row/AMOUNT)}</AMOUNT>
                    <INSTALLMENT>{data($row/INSTALLMENT)}</INSTALLMENT>
                    <INSTALLMENT_COUNT>{data($row/INSTALLMENT_COUNT)}</INSTALLMENT_COUNT>
                    <TOTAL_INSTALLMENT>{data($row/TOTAL_INSTALLMENT)}</TOTAL_INSTALLMENT>
                </EXTRA>
                }
            </INTERNAL_EXTRAS>
            )else()
            }
            
            <REFERENCES_DETAILS>
            {
            if (not(empty($orig/INQUIRIES/INQUIRIES_ITEM/TYPE))) then(
                <QUERIES>
                {
                for $row at $post in $orig/INQUIRIES/INQUIRIES_ITEM
                return
                    <QUERY_ITEM>
                        <ID>{ data($row/TYPE) }</ID>
                        {
                          if(data($row/DATE) != "") then(
                        <DATE>{fn-bea:date-from-string-with-format("yyyy-MM-dd",data($row/DATE)) }</DATE>
                        )else()
                        }
                        <ENTITY>{ fn-bea:trim(data($row/ENTITY)) }</ENTITY>
                    </QUERY_ITEM>
                }
                </QUERIES>
                )else()
                }
                
                <ACTIVE_REFERENCES>
                {
                    if (not(empty($orig/OBLIGATIONS_BEHAVIOR/ACTIVE_REFERENCES_t/IDESTUDIOTUCA))) then(
                    for $row at $post in $orig/OBLIGATIONS_BEHAVIOR/ACTIVE_REFERENCES_t
                    return
                    <REFERENCE>
                         {
                            if(data($row/IDESTUDIOTUCA) != "") then (
                        <QUERY_ID>{ data($row/IDESTUDIOTUCA) }</QUERY_ID>
                        )else()
                        }
                        <CREDITOR>{ fn-bea:trim(data($row/ENTITY)) }</CREDITOR>
                        <REFERENCE_NUMBER>{ fn-bea:trim(data($row/NUMBER)) }</REFERENCE_NUMBER>
                        <TYPE>{data($row/TYPE)}</TYPE>
                        <OBLIGATION_TYPE>{ fn-bea:trim(data($row/SECTOR)) }</OBLIGATION_TYPE>
                        <CREDIT_TYPE>{ fn-bea:trim(data($row/TYPE_OBS)) }</CREDIT_TYPE>
                        <STATUS>{ fn-bea:trim(data($row/STATUS)) }</STATUS>
                        <LIMIT>{ xs:float(data($row/LIMIT)) }</LIMIT>
                        <CURRENCY>{ fn-bea:trim(data($row/CURRENCY)) }</CURRENCY>
                        <BALANCE>{ xs:float(data($row/CURRENT_BALANCE)) }</BALANCE>
                        <PAYMENT_METHOD>{ data($row/PERIOD) }</PAYMENT_METHOD>
                        <GUARANTEE>{ xs:float(data($row/GUARANTEE)) }</GUARANTEE>
                        <GUARANTEE_TYPE>{fn-bea:trim( data($row/GUARANTEE_TYPE)) }</GUARANTEE_TYPE>
                        <ARREAR_BALANCE>{ xs:float(data($row/DELINQUENCY_BALANCE)) }</ARREAR_BALANCE>
                        <ARREAR_LEVEL>{ data($row/DUE) }</ARREAR_LEVEL>
                        <DUE_BALANCE>{ data($row/DUE_BALANCE) }</DUE_BALANCE>
                        <IN_EXECUTION>{ data($row/IN_EXECUTION) }</IN_EXECUTION>
                        <PUNISHED_BALANCE>{data($row/PUNISHED_BALANCE) }</PUNISHED_BALANCE>
                        <PERIOD>{ data($row/BEHAVIOR_DATE) }</PERIOD>
                        <OPENING_DATE>{fn-bea:date-from-string-with-format("yyyy-MM-dd", data($row/OPENING_DATE)) }</OPENING_DATE>
                        {
                         if(data($row/LAST_DATE) != "00/00/0000")then (
                        <CANCELATION_DATE>{fn-bea:date-from-string-with-format("yyyy-MM-dd", data($row/LAST_DATE)) }</CANCELATION_DATE>
                        )else()
                        }
                        {
                        if(data($row/LAST_DATE) != "00/00/0000")then (
                        <EXPIRATION_DATE>{fn-bea:date-from-string-with-format("yyyy-MM-dd", data($row/LAST_DATE)) }</EXPIRATION_DATE>
                        )else()
                        }
                        <INSTALLMENT>{ data($row/INSTALLMENT) }</INSTALLMENT>
                         {
                        for $rowb in $orig/OBLIGATIONS_BEHAVIOR/ACTIVE_REFERENCES_t/NUMBER = $row/NUMBER
                        return
                        <HISTORICAL_ARREAR>{ data($row/BEHAVIOR) }</HISTORICAL_ARREAR>,
                        <HISTORICAL_COUNT_LOC>{ data($row/HISTORICAL_LOC_HNL) }</HISTORICAL_COUNT_LOC>,
                        <HISTORICAL_COUNT_DOL>{ data($row/HISTORICAL_LOC_USD) }</HISTORICAL_COUNT_DOL>
                        }
                    </REFERENCE>
                    )else()
                    }
                    {
                    if (not(empty($orig/OBLIGATIONS_BEHAVIOR/ACTIVE_REFERENCES_b/IDESTUDIOTUCA))) then(
                    for $row at $post in $orig/OBLIGATIONS_BEHAVIOR/ACTIVE_REFERENCES_b
                    return
                    <REFERENCE>
                       {
                            if(data($row/IDESTUDIOTUCA) != "") then (
                        <QUERY_ID>{ data($row/IDESTUDIOTUCA) }</QUERY_ID>
                        )else()
                        }
                        <CREDITOR>{ fn-bea:trim(data($row/ENTITY)) }</CREDITOR>
                        <REFERENCE_NUMBER>{ fn-bea:trim(data($row/NUMBER)) }</REFERENCE_NUMBER>
                        <TYPE>{data($row/TYPE)}</TYPE>
                        <OBLIGATION_TYPE>{ fn-bea:trim(data($row/SECTOR)) }</OBLIGATION_TYPE>
                        <CREDIT_TYPE>{ fn-bea:trim(data($row/TYPE_OBS)) }</CREDIT_TYPE>
                        <STATUS>{ fn-bea:trim(data($row/STATUS)) }</STATUS>
                        <LIMIT>{ xs:float(data($row/LIMIT)) }</LIMIT>
                        <CURRENCY>{ fn-bea:trim(data($row/CURRENCY)) }</CURRENCY>
                        <BALANCE>{ xs:float(data($row/CURRENT_BALANCE)) }</BALANCE>
                        <PAYMENT_METHOD>{ data($row/PERIOD) }</PAYMENT_METHOD>
                        <GUARANTEE>{ xs:float(data($row/GUARANTEE)) }</GUARANTEE>
                        <GUARANTEE_TYPE>{fn-bea:trim( data($row/GUARANTEE_TYPE)) }</GUARANTEE_TYPE>
                        <ARREAR_BALANCE>{ xs:float(data($row/DELINQUENCY_BALANCE)) }</ARREAR_BALANCE>
                        <ARREAR_LEVEL>{ data($row/DUE) }</ARREAR_LEVEL>
                        <DUE_BALANCE>{ data($row/DUE_BALANCE) }</DUE_BALANCE>
                        <IN_EXECUTION>{ data($row/IN_EXECUTION) }</IN_EXECUTION>
                        <PUNISHED_BALANCE>{data($row/PUNISHED_BALANCE) }</PUNISHED_BALANCE>
                        <PERIOD>{ data($row/BEHAVIOR_DATE) }</PERIOD>
                        <OPENING_DATE>{fn-bea:date-from-string-with-format("yyyy-MM-dd", data($row/OPENING_DATE)) }</OPENING_DATE>
                        {
                         if(data($row/LAST_DATE) != "00/00/0000")then (
                        <CANCELATION_DATE>{fn-bea:date-from-string-with-format("yyyy-MM-dd", data($row/LAST_DATE)) }</CANCELATION_DATE>
                        )else()
                        }
                        {
                        if(data($row/LAST_DATE) != "00/00/0000")then (
                        <EXPIRATION_DATE>{fn-bea:date-from-string-with-format("yyyy-MM-dd", data($row/LAST_DATE)) }</EXPIRATION_DATE>
                        )else()
                        }
                        <INSTALLMENT>{ data($row/INSTALLMENT) }</INSTALLMENT>
                        {
                        for $rowb in $orig/OBLIGATIONS_BEHAVIOR/ACTIVE_REFERENCES_b/NUMBER = $row/NUMBER
                        return
                        <HISTORICAL_ARREAR>{ data($row/BEHAVIOR) }</HISTORICAL_ARREAR>,
                        <HISTORICAL_COUNT_LOC>{ data($row/HISTORICAL_LOC_HNL) }</HISTORICAL_COUNT_LOC>,
                        <HISTORICAL_COUNT_DOL>{ data($row/HISTORICAL_LOC_USD) }</HISTORICAL_COUNT_DOL>
                        }
                    </REFERENCE>
                    )else()
                    }
                    {
                    if (not(empty($orig/OBLIGATIONS_BEHAVIOR/ACTIVE_REFERENCES_c/IDESTUDIOTUCA))) then(
                    for $row at $post in $orig/OBLIGATIONS_BEHAVIOR/ACTIVE_REFERENCES_c
                    return
                    <REFERENCE>
                        {
                            if(data($row/IDESTUDIOTUCA) != "") then (
                        <QUERY_ID>{ data($row/IDESTUDIOTUCA) }</QUERY_ID>
                        )else()
                        }
                        <CREDITOR>{ fn-bea:trim(data($row/ENTITY)) }</CREDITOR>
                        <REFERENCE_NUMBER>{ fn-bea:trim(data($row/NUMBER)) }</REFERENCE_NUMBER>
                        <TYPE>{data($row/TYPE)}</TYPE>
                        <OBLIGATION_TYPE>{ fn-bea:trim(data($row/SECTOR)) }</OBLIGATION_TYPE>
                        <CREDIT_TYPE>{ fn-bea:trim(data($row/TYPE_OBS)) }</CREDIT_TYPE>
                        <STATUS>{ fn-bea:trim(data($row/STATUS)) }</STATUS>
                        <LIMIT>{ xs:float(data($row/LIMIT)) }</LIMIT>
                        <CURRENCY>{ fn-bea:trim(data($row/CURRENCY)) }</CURRENCY>
                        <BALANCE>{ xs:float(data($row/CURRENT_BALANCE)) }</BALANCE>
                        <PAYMENT_METHOD>{ data($row/PERIOD) }</PAYMENT_METHOD>
                        <GUARANTEE>{ xs:float(data($row/GUARANTEE)) }</GUARANTEE>
                        <GUARANTEE_TYPE>{fn-bea:trim( data($row/GUARANTEE_TYPE)) }</GUARANTEE_TYPE>
                        <ARREAR_BALANCE>{ xs:float(data($row/DELINQUENCY_BALANCE)) }</ARREAR_BALANCE>
                        <ARREAR_LEVEL>{ data($row/DUE) }</ARREAR_LEVEL>
                        <DUE_BALANCE>{ data($row/DUE_BALANCE) }</DUE_BALANCE>
                        <IN_EXECUTION>{ data($row/IN_EXECUTION) }</IN_EXECUTION>
                        <PUNISHED_BALANCE>{data($row/PUNISHED_BALANCE) }</PUNISHED_BALANCE>
                        <PERIOD>{ data($row/BEHAVIOR_DATE) }</PERIOD>
                        <OPENING_DATE>{fn-bea:date-from-string-with-format("yyyy-MM-dd", data($row/OPENING_DATE)) }</OPENING_DATE>
                        {
                         if(data($row/LAST_DATE) != "00/00/0000")then (
                        <CANCELATION_DATE>{fn-bea:date-from-string-with-format("yyyy-MM-dd", data($row/LAST_DATE)) }</CANCELATION_DATE>
                        )else()
                        }
                        {
                        if(data($row/LAST_DATE) != "00/00/0000")then (
                        <EXPIRATION_DATE>{fn-bea:date-from-string-with-format("yyyy-MM-dd", data($row/LAST_DATE)) }</EXPIRATION_DATE>
                        )else()
                        }
                        <INSTALLMENT>{ data($row/INSTALLMENT) }</INSTALLMENT>
                         {
                        for $rowb in $orig/OBLIGATIONS_BEHAVIOR/ACTIVE_REFERENCES_c/NUMBER = $row/NUMBER
                        return
                        <HISTORICAL_ARREAR>{ data($row/BEHAVIOR) }</HISTORICAL_ARREAR>,
                        <HISTORICAL_COUNT_LOC>{ data($row/HISTORICAL_LOC_HNL) }</HISTORICAL_COUNT_LOC>,
                        <HISTORICAL_COUNT_DOL>{ data($row/HISTORICAL_LOC_USD) }</HISTORICAL_COUNT_DOL>
                        }
                    </REFERENCE>
                    )else()
                    }
                    {
                    if (not(empty($orig/OBLIGATIONS_BEHAVIOR/ACTIVE_REFERENCES_e/IDESTUDIOTUCA))) then(
                    for $row at $post in $orig/OBLIGATIONS_BEHAVIOR/ACTIVE_REFERENCES_e
                    return
                    <REFERENCE>
                       {
                            if(data($row/IDESTUDIOTUCA) != "") then (
                        <QUERY_ID>{ data($row/IDESTUDIOTUCA) }</QUERY_ID>
                        )else()
                        }
                        <CREDITOR>{ fn-bea:trim(data($row/ENTITY)) }</CREDITOR>
                        <REFERENCE_NUMBER>{ fn-bea:trim(data($row/NUMBER)) }</REFERENCE_NUMBER>
                        <TYPE>{data($row/TYPE)}</TYPE>
                        <OBLIGATION_TYPE>{ fn-bea:trim(data($row/SECTOR)) }</OBLIGATION_TYPE>
                        <CREDIT_TYPE>{ fn-bea:trim(data($row/TYPE_OBS)) }</CREDIT_TYPE>
                        <STATUS>{ fn-bea:trim(data($row/STATUS)) }</STATUS>
                        <LIMIT>{ xs:float(data($row/LIMIT)) }</LIMIT>
                        <CURRENCY>{ fn-bea:trim(data($row/CURRENCY)) }</CURRENCY>
                        <BALANCE>{ xs:float(data($row/CURRENT_BALANCE)) }</BALANCE>
                        <PAYMENT_METHOD>{ data($row/PERIOD) }</PAYMENT_METHOD>
                        <GUARANTEE>{ xs:float(data($row/GUARANTEE)) }</GUARANTEE>
                        <GUARANTEE_TYPE>{fn-bea:trim( data($row/GUARANTEE_TYPE)) }</GUARANTEE_TYPE>
                        <ARREAR_BALANCE>{ xs:float(data($row/DELINQUENCY_BALANCE)) }</ARREAR_BALANCE>
                        <ARREAR_LEVEL>{ data($row/DUE) }</ARREAR_LEVEL>
                        <DUE_BALANCE>{ data($row/DUE_BALANCE) }</DUE_BALANCE>
                        <IN_EXECUTION>{ data($row/IN_EXECUTION) }</IN_EXECUTION>
                        <PUNISHED_BALANCE>{data($row/PUNISHED_BALANCE) }</PUNISHED_BALANCE>
                        <PERIOD>{ data($row/BEHAVIOR_DATE) }</PERIOD>
                        <OPENING_DATE>{fn-bea:date-from-string-with-format("yyyy-MM-dd", data($row/OPENING_DATE)) }</OPENING_DATE>
                        {
                         if(data($row/LAST_DATE) != "00/00/0000")then (
                        <CANCELATION_DATE>{fn-bea:date-from-string-with-format("yyyy-MM-dd", data($row/LAST_DATE)) }</CANCELATION_DATE>
                        )else()
                        }
                        {
                        if(data($row/LAST_DATE) != "00/00/0000")then (
                        <EXPIRATION_DATE>{fn-bea:date-from-string-with-format("yyyy-MM-dd", data($row/LAST_DATE)) }</EXPIRATION_DATE>
                        )else()
                        }
                        <INSTALLMENT>{ data($row/INSTALLMENT) }</INSTALLMENT>
                         {
                        for $rowb in $orig/OBLIGATIONS_BEHAVIOR/ACTIVE_REFERENCES_e/NUMBER = $row/NUMBER
                        return
                        <HISTORICAL_ARREAR>{ data($row/BEHAVIOR) }</HISTORICAL_ARREAR>,
                        <HISTORICAL_COUNT_LOC>{ data($row/HISTORICAL_LOC_HNL) }</HISTORICAL_COUNT_LOC>,
                        <HISTORICAL_COUNT_DOL>{ data($row/HISTORICAL_LOC_USD) }</HISTORICAL_COUNT_DOL>
                        }
                    </REFERENCE>
                    )else()
                    }
                </ACTIVE_REFERENCES>
              
                 
                <HISTORICAL_REFERENCES>
                 {
                  if (not(empty($orig/OBLIGATIONS_BEHAVIOR/HISTORICAL_REFERENCES_t/IDESTUDIOTUCA))) then(
                  for $row at $post in $orig/OBLIGATIONS_BEHAVIOR/HISTORICAL_REFERENCES_t
                  return
                    <REFERENCE>
                        {
                            if(data($row/IDESTUDIOTUCA) != "") then (
                        <QUERY_ID>{ data($row/IDESTUDIOTUCA) }</QUERY_ID>
                        )else()
                        }
                        <CREDITOR>{ fn-bea:trim(data($row/ENTITY)) }</CREDITOR>
                        <REFERENCE_NUMBER>{ fn-bea:trim(data($row/NUMBER)) }</REFERENCE_NUMBER>
                        <TYPE>{data($row/TYPE)}</TYPE>
                        <CREDIT_TYPE>{ fn-bea:trim(data($row/TYPE_OBS)) }</CREDIT_TYPE>
                        <STATUS>{ fn-bea:trim(data($row/STATUS)) }</STATUS>
                        <LIMIT>{ xs:float(data($row/LIMIT)) }</LIMIT>
                        <TERM>{ data($row/TERM) }</TERM>
                        <CURRENCY>{ fn-bea:trim(data($row/CURRENCY)) }</CURRENCY>
                        <PAYMENT_METHOD>{ data($row/PERIOD) }</PAYMENT_METHOD>
                        <GUARANTEE>{ xs:float(data($row/GUARANTEE)) }</GUARANTEE>
                        <GUARANTEE_TYPE>{fn-bea:trim( data($row/GUARANTEE_TYPE)) }</GUARANTEE_TYPE>
                        <ARREAR_BALANCE>{ xs:float(data($row/DELINQUENCY_BALANCE)) }</ARREAR_BALANCE>
                        <ARREAR_LEVEL>{ data($row/DUE) }</ARREAR_LEVEL>
                        <DUE_BALANCE>{ data($row/DUE_BALANCE) }</DUE_BALANCE>
                        <IN_EXECUTION>{ data($row/IN_EXECUTION) }</IN_EXECUTION>
                        <PUNISHED_BALANCE>{data($row/PUNISHED_BALANCE) }</PUNISHED_BALANCE>
                        <PERIOD>{ data($row/BEHAVIOR_DATE) }</PERIOD>
                        <OPENING_DATE>{fn-bea:date-from-string-with-format("yyyy-MM-dd",data($row/OPENING_DATE)) }</OPENING_DATE>
                        {
                        if(data($row/LAST_DATE) != "00/00/0000")then (
                          <CANCELATION_DATE>{fn-bea:date-from-string-with-format("yyyy-MM-dd", data($row/LAST_DATE)) }</CANCELATION_DATE>
                        )else()
                        }
                        {
                        if(data($row/LAST_DATE) != "00/00/0000")then (
                          <EXPIRATION_DATE>{fn-bea:date-from-string-with-format("yyyy-MM-dd", data($row/LAST_DATE)) }</EXPIRATION_DATE>
                        )else()
                        }
                        <INSTALLMENT>{ data($row/INSTALLMENT) }</INSTALLMENT>
                        <HISTORICAL_ARREAR>{ data($row/BEHAVIOR) }</HISTORICAL_ARREAR>
                        <HISTORICAL_COUNT_LOC>{ data($row/HISTORICAL_LOC_HNL) }</HISTORICAL_COUNT_LOC>
                        <HISTORICAL_COUNT_DOL>{ data($row/HISTORICAL_LOC_USD) }</HISTORICAL_COUNT_DOL>
                    </REFERENCE>
                    )else()
                    }
                    {
                    if (not(empty($orig/OBLIGATIONS_BEHAVIOR/HISTORICAL_REFERENCES_b/IDESTUDIOTUCA))) then(
                    for $row at $post in $orig/OBLIGATIONS_BEHAVIOR/HISTORICAL_REFERENCES_b
                    return
                    <REFERENCE>
                        {
                            if(data($row/IDESTUDIOTUCA) != "") then (
                        <QUERY_ID>{ data($row/IDESTUDIOTUCA) }</QUERY_ID>
                        )else()
                        }
                        <CREDITOR>{ fn-bea:trim(data($row/ENTITY)) }</CREDITOR>
                        <REFERENCE_NUMBER>{ fn-bea:trim(data($row/NUMBER)) }</REFERENCE_NUMBER>
                        <TYPE>{data($row/TYPE)}</TYPE>
                        <CREDIT_TYPE>{ fn-bea:trim(data($row/TYPE_OBS)) }</CREDIT_TYPE>
                        <STATUS>{ fn-bea:trim(data($row/STATUS)) }</STATUS>
                        <LIMIT>{ xs:float(data($row/LIMIT)) }</LIMIT>
                        <TERM>{ data($row/TERM) }</TERM>
                        <CURRENCY>{ fn-bea:trim(data($row/CURRENCY)) }</CURRENCY>
                        <EXCHANGE_FACTOR>{ data($row/EXCHANGE_FACTOR) }</EXCHANGE_FACTOR>
                        <PAYMENT_METHOD>{ data($row/PERIOD) }</PAYMENT_METHOD>
                        <GUARANTEE>{ xs:float(data($row/GUARANTEE)) }</GUARANTEE>
                        <GUARANTEE_TYPE>{fn-bea:trim( data($row/GUARANTEE_TYPE)) }</GUARANTEE_TYPE>
                        <ARREAR_BALANCE>{ xs:float(data($row/DELINQUENCY_BALANCE)) }</ARREAR_BALANCE>
                        <ARREAR_LEVEL>{ data($row/DUE) }</ARREAR_LEVEL>
                        <DUE_BALANCE>{ data($row/DUE_BALANCE) }</DUE_BALANCE>
                        <IN_EXECUTION>{ data($row/IN_EXECUTION) }</IN_EXECUTION>
                        <PUNISHED_BALANCE>{data($row/PUNISHED_BALANCE) }</PUNISHED_BALANCE>
                        <PERIOD>{ data($row/BEHAVIOR_DATE) }</PERIOD>
                        <OPENING_DATE>{fn-bea:date-from-string-with-format("yyyy-MM-dd",data($row/OPENING_DATE)) }</OPENING_DATE>
                        {
                        if(data($row/LAST_DATE) != "00/00/0000")then (
                          <CANCELATION_DATE>{fn-bea:date-from-string-with-format("yyyy-MM-dd", data($row/LAST_DATE)) }</CANCELATION_DATE>
                        )else()
                        }
                        {
                        if(data($row/LAST_DATE) != "00/00/0000")then (
                          <EXPIRATION_DATE>{fn-bea:date-from-string-with-format("yyyy-MM-dd", data($row/LAST_DATE)) }</EXPIRATION_DATE>
                        )else()
                        }
                        <INSTALLMENT>{ data($row/INSTALLMENT) }</INSTALLMENT>
                        <HISTORICAL_ARREAR>{ data($row/BEHAVIOR) }</HISTORICAL_ARREAR>
                        <HISTORICAL_COUNT_LOC>{ data($row/HISTORICAL_LOC_HNL) }</HISTORICAL_COUNT_LOC>
                        <HISTORICAL_COUNT_DOL>{ data($row/HISTORICAL_LOC_USD) }</HISTORICAL_COUNT_DOL>
                    </REFERENCE>
                    )else()
                    }
                    {
                    if (not(empty($orig/OBLIGATIONS_BEHAVIOR/HISTORICAL_REFERENCES_c/IDESTUDIOTUCA))) then(
                    for $row at $post in $orig/OBLIGATIONS_BEHAVIOR/HISTORICAL_REFERENCES_c
                    return
                    <REFERENCE>
                        {
                            if(data($row/IDESTUDIOTUCA) != "") then (
                        <QUERY_ID>{ data($row/IDESTUDIOTUCA) }</QUERY_ID>
                        )else()
                        }
                        <CREDITOR>{ fn-bea:trim(data($row/ENTITY)) }</CREDITOR>
                        <REFERENCE_NUMBER>{ fn-bea:trim(data($row/NUMBER)) }</REFERENCE_NUMBER>
                        <TYPE>{data($row/TYPE)}</TYPE>
                        <CREDIT_TYPE>{ fn-bea:trim(data($row/TYPE_OBS)) }</CREDIT_TYPE>
                        <STATUS>{ fn-bea:trim(data($row/STATUS)) }</STATUS>
                        <LIMIT>{ xs:float(data($row/LIMIT)) }</LIMIT>
                        <TERM>{ data($row/TERM) }</TERM>
                        <CURRENCY>{ fn-bea:trim(data($row/CURRENCY)) }</CURRENCY>
                        <EXCHANGE_FACTOR>{ data($row/EXCHANGE_FACTOR) }</EXCHANGE_FACTOR>
                        <PAYMENT_METHOD>{ data($row/PERIOD) }</PAYMENT_METHOD>
                        <GUARANTEE>{ xs:float(data($row/GUARANTEE)) }</GUARANTEE>
                        <GUARANTEE_TYPE>{fn-bea:trim( data($row/GUARANTEE_TYPE)) }</GUARANTEE_TYPE>
                        <ARREAR_BALANCE>{ xs:float(data($row/DELINQUENCY_BALANCE)) }</ARREAR_BALANCE>
                        <ARREAR_LEVEL>{ data($row/DUE) }</ARREAR_LEVEL>
                        <DUE_BALANCE>{ data($row/DUE_BALANCE) }</DUE_BALANCE>
                        <IN_EXECUTION>{ data($row/IN_EXECUTION) }</IN_EXECUTION>
                        <PUNISHED_BALANCE>{data($row/PUNISHED_BALANCE) }</PUNISHED_BALANCE>
                        <PERIOD>{ data($row/BEHAVIOR_DATE) }</PERIOD>
                        
                        <OPENING_DATE>{fn-bea:date-from-string-with-format("yyyy-MM-dd",data($row/OPENING_DATE)) }</OPENING_DATE>
                        {
                        if(data($row/LAST_DATE) != "00/00/0000")then (
                          <CANCELATION_DATE>{fn-bea:date-from-string-with-format("yyyy-MM-dd", data($row/LAST_DATE)) }</CANCELATION_DATE>
                        )else()
                        }
                        {
                        if(data($row/LAST_DATE) != "00/00/0000")then (
                          <EXPIRATION_DATE>{fn-bea:date-from-string-with-format("yyyy-MM-dd", data($row/LAST_DATE)) }</EXPIRATION_DATE>
                        )else()
                        }
                        <INSTALLMENT>{ data($row/INSTALLMENT) }</INSTALLMENT>
                        <HISTORICAL_ARREAR>{ data($row/BEHAVIOR) }</HISTORICAL_ARREAR>
                        <HISTORICAL_COUNT_LOC>{ data($row/HISTORICAL_LOC_HNL) }</HISTORICAL_COUNT_LOC>
                        <HISTORICAL_COUNT_DOL>{ data($row/HISTORICAL_LOC_USD) }</HISTORICAL_COUNT_DOL>
                    </REFERENCE>
                    )else()
                    }
                    {
                    if (not(empty($orig/OBLIGATIONS_BEHAVIOR/HISTORICAL_REFERENCES_e/IDESTUDIOTUCA))) then(
                    for $row at $post in $orig/OBLIGATIONS_BEHAVIOR/HISTORICAL_REFERENCES_e
                    return
                    <REFERENCE>
                        <QUERY_ID>{ data($row/IDESTUDIOTUCA) }</QUERY_ID>
                        <CREDITOR>{ data($row/ENTITY) }</CREDITOR>
                        <REFERENCE_NUMBER>{ data($row/NUMBER) }</REFERENCE_NUMBER>
                        <TYPE>{data($row/TYPE)}</TYPE>
                        <CREDIT_TYPE>{ data($row/TYPE_OBS) }</CREDIT_TYPE>
                        <STATUS>{ data($row/STATUS) }</STATUS>
                        <LIMIT>{ data($row/LIMIT) }</LIMIT>
                        <TERM>{ data($row/TERM) }</TERM>
                        <CURRENCY>{ data($row/CURRENCY) }</CURRENCY>
                        <EXCHANGE_FACTOR>{ data($row/EXCHANGE_FACTOR) }</EXCHANGE_FACTOR>
                        <BALANCE>{ data($row/CURRENT_BALANCE) }</BALANCE>
                        <PAYMENT_METHOD>{ data($row/PERIOD) }</PAYMENT_METHOD>
                        <GUARANTEE>{ data($row/GUARANTEE) }</GUARANTEE>
                        <GUARANTEE_TYPE>{ data($row/GUARANTEE_TYPE) }</GUARANTEE_TYPE>
                        <AMOUNT>{ data($row/AMOUNT) }</AMOUNT>
                        <ARREAR_BALANCE>{ data($row/DELINQUENCY_BALANCE) }</ARREAR_BALANCE>
                        <ARREAR_LEVEL>{ data($row/DUE) }</ARREAR_LEVEL>
                        <DUE_BALANCE>{ data($row/DUE_BALANCE) }</DUE_BALANCE>
                        <IN_EXECUTION>{ data($row/IN_EXECUTION) }</IN_EXECUTION>
                        <PUNISHED_BALANCE>{ data($row/PUNISHED_BALANCE) }</PUNISHED_BALANCE>
                        <PERIOD>{ data($row/BEHAVIOR_DATE) }</PERIOD>
                        <OPENING_DATE>{fn-bea:date-from-string-with-format("yyyy-MM-dd",data($row/OPENING_DATE)) }</OPENING_DATE>
                        {
                        if(data($row/LAST_DATE) != "00/00/0000")then (
                          <CANCELATION_DATE>{fn-bea:date-from-string-with-format("yyyy-MM-dd", data($row/LAST_DATE)) }</CANCELATION_DATE>
                        )else()
                        }
                        {
                        if(data($row/LAST_DATE) != "00/00/0000")then (
                          <EXPIRATION_DATE>{fn-bea:date-from-string-with-format("yyyy-MM-dd", data($row/LAST_DATE)) }</EXPIRATION_DATE>
                        )else()
                        }
                        <INSTALLMENT>{ data($row/INSTALLMENT) }</INSTALLMENT>
                        {
                        for $rowb in $orig/OBLIGATIONS_BEHAVIOR/ACTIVE_REFERENCES_e/NUMBER = $row/NUMBER
                        return
                        <HISTORICAL_ARREAR>{ data($row/BEHAVIOR) }</HISTORICAL_ARREAR>,
                        <HISTORICAL_COUNT_LOC>{ data($row/HISTORICAL_LOC_HNL) }</HISTORICAL_COUNT_LOC>,
                        <HISTORICAL_COUNT_DOL>{ data($row/HISTORICAL_LOC_USD) }</HISTORICAL_COUNT_DOL>
                        }
                    </REFERENCE>
                    )else()
                    }
                </HISTORICAL_REFERENCES>
                
            </REFERENCES_DETAILS>
        </LOAN_ORIGINATIONS>
        
    </ns1:consultaConsolidadaRiesgoClienteResponse>
};

local:func($InputJSConsultaConsolidadaRiegoCliente, $InputConsultaInformacionBuroTucaHN)]]></con:xquery>
    <con:dependencies>
        <con:importSchema location="../xsd/consultaConsolidadaRiesgoClienteTypes.xsd">
            <con:schema ref="Middleware/v2/Resources/ConsultaConsolidadaRiesgoCliente/xsd/consultaConsolidadaRiesgoClienteTypes"/>
        </con:importSchema>
    </con:dependencies>
</con:xqueryEntry>
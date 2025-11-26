xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="http://www.ficohsa.com.hn/middleware.services/consultaGeneralPrestamo";
(:: import schema at "../../../../../MWBanking/Loans/RequestorServices/XSD/getLoanDetails.xsd" ::)
declare namespace ns1="http://xmlns.oracle.com/pcbpel/adapter/db/sp/AmortizationSchedule_BS";
(:: import schema at "../../../../../LegacyCoreBankingHN/ProviderServices/XSD/CalculateAmortizationSchedule/AmortizationSchedule_BS_sp.xsd" ::)

declare namespace xq="http://www.w3.org/2005/xquery-local-functions";

declare namespace com = "http://www.ficohsa.com.hn/middleware.services/commonTypes";

declare variable $dbResponse as element() (:: schema-element(ns1:OutputParameters) ::) external;
declare variable $uuid as xs:string external;

declare function xq:Tx_DB_To_CalculaAmortizacionResponse($dbResponse as element() (:: schema-element(ns1:OutputParameters) ::), 
                                                         $uuid as xs:string) 
                                                         as element() (:: schema-element(ns2:amortizationScheduleResponse) ::) {
    <ns2:amortizationScheduleResponse>
        <ns2:StatusInfo>
            <com:Status>Success</com:Status>
            <com:ValueDate>{fn:substring(fn:string(fn:current-dateTime()),0,11)}</com:ValueDate>
            <com:DateTime>{fn:substring(fn:string(fn:current-dateTime()),0,20)}</com:DateTime>
            <com:GlobalId>{fn:data($uuid)}</com:GlobalId>
        </ns2:StatusInfo>
        <ns2:LoanInfo>
            {
                if ($dbResponse/ns1:TOTAL_CAPITAL)
                then <ns2:TotalCapital>{fn:data($dbResponse/ns1:TOTAL_CAPITAL)}</ns2:TotalCapital>
                else ()
            }
            {
                if ($dbResponse/ns1:TOTAL_INTERESTS)
                then <ns2:TotalInterests>{fn:data($dbResponse/ns1:TOTAL_INTERESTS)}</ns2:TotalInterests>
                else ()
            }
            <ns2:TotalInsuranceInfo>
                {
                    if ($dbResponse/ns1:TOTAL_LIFE_DEBT)
                    then <ns2:LifeDebt>{fn:data($dbResponse/ns1:TOTAL_LIFE_DEBT)}</ns2:LifeDebt>
                    else ()
                }
                {
                    if ($dbResponse/ns1:TOTAL_UNEMPLOYMENT)
                    then <ns2:Unemployment>{fn:data($dbResponse/ns1:TOTAL_UNEMPLOYMENT)}</ns2:Unemployment>
                    else ()
                }
            </ns2:TotalInsuranceInfo>
            {
                if ($dbResponse/ns1:TOTAL_PAYMENT)
                then <ns2:TotalPayment>{fn:data($dbResponse/ns1:TOTAL_PAYMENT)}</ns2:TotalPayment>
                else ()
            }
            {
                if ($dbResponse/ns1:TOTAL_ANNUAL_COST)
                then <ns2:TotalAnnualCost>{fn:data($dbResponse/ns1:TOTAL_ANNUAL_COST)}</ns2:TotalAnnualCost>
                else ()
            }
            {
                if ($dbResponse/ns1:INTERNAL_RATE_RETURN)
                then <ns2:InternalRateReturn>{fn:data($dbResponse/ns1:INTERNAL_RATE_RETURN)}</ns2:InternalRateReturn>
                else ()
            }
            {
                if ($dbResponse/ns1:FORMALIZATION_EXPENSE)
                then <ns2:FormalizationExpense>{fn:data($dbResponse/ns1:FORMALIZATION_EXPENSE)}</ns2:FormalizationExpense>
                else ()
            }
        </ns2:LoanInfo>
        <ns2:DisbursementInfo>
            {
                if ($dbResponse/ns1:DISBURSEMENT_AMOUNT)
                then <ns2:Amount>{fn:data($dbResponse/ns1:DISBURSEMENT_AMOUNT)}</ns2:Amount>
                else ()
            }
            {
                if ($dbResponse/ns1:DISBURSEMENT_FEE)
                then <ns2:Fee>{fn:data($dbResponse/ns1:DISBURSEMENT_FEE)}</ns2:Fee>
                else ()
            }
        </ns2:DisbursementInfo>
        <ns2:PrimeInsuranceInfo>
            {
                if ($dbResponse/ns1:PRIME_LIFE_DEBT)
                then <ns2:LifeDebt>{fn:data($dbResponse/ns1:PRIME_LIFE_DEBT)}</ns2:LifeDebt>
                else ()
            }
            {
                if ($dbResponse/ns1:PRIME_UNEMPLOYMENT)
                then <ns2:Unemployment>{fn:data($dbResponse/ns1:PRIME_UNEMPLOYMENT)}</ns2:Unemployment>
                else ()
            }
        </ns2:PrimeInsuranceInfo>
            {
                for $LOAN_PAYMENTS in $dbResponse/ns1:LOAN_PAYMENTS/ns1:LOAN_PAYMENTS_ITEM
                return        
     <ns2:PaymentPlan>
         {
             if ($LOAN_PAYMENTS/ns1:PAYMENT_ORDER)
             then <ns2:Order>{fn:data($LOAN_PAYMENTS/ns1:PAYMENT_ORDER)}</ns2:Order>
             else ()
         }
         {
             if ($LOAN_PAYMENTS/ns1:PAYMENT_DATE)
             then <ns2:Date>{fn:concat(fn:substring(fn:data($LOAN_PAYMENTS/ns1:PAYMENT_DATE),0,5),'-',fn:substring(fn:data($LOAN_PAYMENTS/ns1:PAYMENT_DATE),5,2),'-',fn:substring(fn:data($LOAN_PAYMENTS/ns1:PAYMENT_DATE),7,2))}
             </ns2:Date>
             else ()
         }
         {
             if ($LOAN_PAYMENTS/ns1:DAYS_IN_PERIOD)
             then <ns2:DaysInPeriod>{fn:data($LOAN_PAYMENTS/ns1:DAYS_IN_PERIOD)}</ns2:DaysInPeriod>
             else ()
         }
         {
             if ($LOAN_PAYMENTS/ns1:PAYMENT_CAPITAL)
             then <ns2:Capital>{fn:data($LOAN_PAYMENTS/ns1:PAYMENT_CAPITAL)}</ns2:Capital>
             else ()
         }
         {
             if ($LOAN_PAYMENTS/ns1:PAYMENT_INTERESTS)
             then <ns2:Interests>{fn:data($LOAN_PAYMENTS/ns1:PAYMENT_INTERESTS)}</ns2:Interests>
             else ()
         }
         <ns2:InsuranceInfo>
             {
                 if ($LOAN_PAYMENTS/ns1:INSURANCE_LIFE_DEBT)
                 then <ns2:LifeDebt>{fn:data($LOAN_PAYMENTS/ns1:INSURANCE_LIFE_DEBT)}</ns2:LifeDebt>
                 else ()
             }
             {
                 if ($LOAN_PAYMENTS/ns1:INSURANCE_UNEMPLOYMENT)
                 then <ns2:Unemployment>{fn:data($LOAN_PAYMENTS/ns1:INSURANCE_UNEMPLOYMENT)}</ns2:Unemployment>
                 else ()
             }
         </ns2:InsuranceInfo>
         {
             if ($LOAN_PAYMENTS/ns1:PAYMENT_TOTAL)
             then <ns2:Total>{fn:data($LOAN_PAYMENTS/ns1:PAYMENT_TOTAL)}</ns2:Total>
             else ()
         }
         {
             if ($LOAN_PAYMENTS/ns1:PRINCIPAL_BALANCE)
             then <ns2:PrincipalBalance>{fn:data($LOAN_PAYMENTS/ns1:PRINCIPAL_BALANCE)}</ns2:PrincipalBalance>
             else ()
         }</ns2:PaymentPlan>
     }    
     </ns2:amortizationScheduleResponse>
};

xq:Tx_DB_To_CalculaAmortizacionResponse($dbResponse, $uuid)
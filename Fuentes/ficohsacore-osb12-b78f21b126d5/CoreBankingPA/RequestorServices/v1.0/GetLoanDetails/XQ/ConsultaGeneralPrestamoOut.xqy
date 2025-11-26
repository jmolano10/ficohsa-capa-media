xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns3="http://www.ficohsa.com.hn/middleware.services/consultaGeneralPrestamo";
(:: import schema at "../../../../../MWBanking/Loans/RequestorServices/XSD/getLoanDetails.xsd" ::)
declare namespace ns1="http://xmlns.oracle.com/pcbpel/adapter/db/sp/GetLoanDetailsPA_BS";
(:: import schema at "../../../../../CoreBankingPA/ProviderServices/XSD/GetLoanDetails/GetLoanDetailsPA_BS_sp.xsd" ::)

declare namespace ns2="http://www.ficohsa.com/middleware.services/ConsultaGeneralPrestamoOut";

declare namespace dyn = "http://www.ficohsa.com.hn/middleware.services/dynamoTypes";

declare variable $ConsultaGeneralPrestamoRSP as element() (:: schema-element(ns1:OutputParameters) ::) external;
declare variable $uuid as xs:string external;
declare function ns2:consultaGeneralPrestamoOut($ConsultaGeneralPrestamoRSP as element() (:: schema-element(ns1:OutputParameters) ::), $uuid as xs:string) as element() (:: schema-element(ns3:getLoanDetailsResponse) ::) {
    <ns3:getLoanDetailsResponse>
        <ns3:StatusInfo>
            {
                if ($ConsultaGeneralPrestamoRSP/ns1:ERROR_CODE='SUCCESS')
                then <dyn:Status>Success</dyn:Status>
                else
               <dyn:Status>{fn:data($ConsultaGeneralPrestamoRSP/ns1:ERROR_CODE)}</dyn:Status>
            }
            <dyn:TransactionId></dyn:TransactionId>
            <dyn:ValueDate>{fn:substring(fn:string(fn:current-dateTime()),0,11)}</dyn:ValueDate>
            <dyn:DateTime>{fn:substring(fn:string(fn:current-dateTime()),0,20)}</dyn:DateTime>
            <dyn:GlobalId>{fn:data($uuid)}</dyn:GlobalId>
        </ns3:StatusInfo>
        <ns3:LoanDetails>
            {
                if ($ConsultaGeneralPrestamoRSP/ns1:LOAN_CUSTOMER_NAME)
                then <ns3:LoanCustomerName>{fn:data($ConsultaGeneralPrestamoRSP/ns1:LOAN_CUSTOMER_NAME)}</ns3:LoanCustomerName>
                else ()
            }
            {
                if ($ConsultaGeneralPrestamoRSP/ns1:CODIGO_CLIENTE)
                then <ns3:CustomerId>{fn:data($ConsultaGeneralPrestamoRSP/ns1:CODIGO_CLIENTE)}</ns3:CustomerId>
                else ()
            }
            {
                if ($ConsultaGeneralPrestamoRSP/ns1:EFFECTIVE_DATE)
                then <ns3:EffectiveDate>
                {
                fn:concat(fn:substring(fn:data($ConsultaGeneralPrestamoRSP/ns1:EFFECTIVE_DATE),0,5),'-',fn:substring(fn:data($ConsultaGeneralPrestamoRSP/ns1:EFFECTIVE_DATE),5,2),'-',fn:substring(fn:data($ConsultaGeneralPrestamoRSP/ns1:EFFECTIVE_DATE),7,2))
                }
                </ns3:EffectiveDate>
                else ()
            }
            {
                if ($ConsultaGeneralPrestamoRSP/ns1:MATURITY_DATE)
                then <ns3:MaturityDate>                {
                fn:concat(fn:substring(fn:data($ConsultaGeneralPrestamoRSP/ns1:MATURITY_DATE),0,5),'-',fn:substring(fn:data($ConsultaGeneralPrestamoRSP/ns1:MATURITY_DATE),5,2),'-',fn:substring(fn:data($ConsultaGeneralPrestamoRSP/ns1:MATURITY_DATE),7,2))
                }</ns3:MaturityDate>
                else ()
            }
            {
                if ($ConsultaGeneralPrestamoRSP/ns1:LASTDISBURSEMENTDATE)
                then <ns3:LastDisbursementDate>
                {
                fn:concat(fn:substring(fn:data($ConsultaGeneralPrestamoRSP/ns1:LASTDISBURSEMENTDATE),0,5),'-',fn:substring(fn:data($ConsultaGeneralPrestamoRSP/ns1:LASTDISBURSEMENTDATE),5,2),'-',fn:substring(fn:data($ConsultaGeneralPrestamoRSP/ns1:LASTDISBURSEMENTDATE),7,2))
                }
                </ns3:LastDisbursementDate>
                else ()
            }
            {
                if ($ConsultaGeneralPrestamoRSP/ns1:INTEREST_RATE)
                then <ns3:InterestRate>{fn:data($ConsultaGeneralPrestamoRSP/ns1:INTEREST_RATE)}</ns3:InterestRate>
                else ()
            }
            {
                if ($ConsultaGeneralPrestamoRSP/ns1:CURRENCY)
                then <ns3:Currency>{fn:data($ConsultaGeneralPrestamoRSP/ns1:CURRENCY)}</ns3:Currency>
                else ()
            }
            {
                if ($ConsultaGeneralPrestamoRSP/ns1:PRINCIPAL_INITIAL_AMT)
                then <ns3:PrincipalInitialAmount>{fn:data($ConsultaGeneralPrestamoRSP/ns1:PRINCIPAL_INITIAL_AMT)}</ns3:PrincipalInitialAmount>
                else ()
            }
            {
                if ($ConsultaGeneralPrestamoRSP/ns1:PRINCIPAL_DUE_AMT)
                then <ns3:PrincipalDueAmount>{fn:data($ConsultaGeneralPrestamoRSP/ns1:PRINCIPAL_DUE_AMT)}</ns3:PrincipalDueAmount>
                else ()
            }
            {
                if ($ConsultaGeneralPrestamoRSP/ns1:PRINCIPAL_OVERDUE_AMT)
                then <ns3:PrincipalOverdueAmount>{fn:data($ConsultaGeneralPrestamoRSP/ns1:PRINCIPAL_OVERDUE_AMT)}</ns3:PrincipalOverdueAmount>
                else ()
            }
            {
                if ($ConsultaGeneralPrestamoRSP/ns1:INTEREST_AMOUNT)
                then <ns3:InterestAmount>{fn:data($ConsultaGeneralPrestamoRSP/ns1:INTEREST_AMOUNT)}</ns3:InterestAmount>
                else ()
            }
            {
                if ($ConsultaGeneralPrestamoRSP/ns1:OVERDUE_INTEREST_AMOUNT)
                then <ns3:OverdueInterestAmount>{fn:data($ConsultaGeneralPrestamoRSP/ns1:OVERDUE_INTEREST_AMOUNT)}</ns3:OverdueInterestAmount>
                else ()
            }
            <ns3:ArrearsInterestAmount></ns3:ArrearsInterestAmount>
            {
                if ($ConsultaGeneralPrestamoRSP/ns1:COMISION_AMOUNT)
                then <ns3:CommissionAmount>{fn:data($ConsultaGeneralPrestamoRSP/ns1:COMISION_AMOUNT)}</ns3:CommissionAmount>
                else ()
            }
            {
                if ($ConsultaGeneralPrestamoRSP/ns1:TOTAL_DEBT)
                then <ns3:TotalDebt>{fn:data($ConsultaGeneralPrestamoRSP/ns1:TOTAL_DEBT)}</ns3:TotalDebt>
                else ()
            }
            {
                if ($ConsultaGeneralPrestamoRSP/ns1:NEXT_PAYMNT_ID)
                then <ns3:NextPaymentId>{fn:data($ConsultaGeneralPrestamoRSP/ns1:NEXT_PAYMNT_ID)}</ns3:NextPaymentId>
                else ()
            }
            {
                if ($ConsultaGeneralPrestamoRSP/ns1:NEXT_PAYMNT_MATURITY_DATE)
                then <ns3:NextPaymentMaturityDate>
                {
                fn:concat(fn:substring(fn:data($ConsultaGeneralPrestamoRSP/ns1:NEXT_PAYMNT_MATURITY_DATE),0,5),'-',fn:substring(fn:data($ConsultaGeneralPrestamoRSP/ns1:NEXT_PAYMNT_MATURITY_DATE),5,2),'-',fn:substring(fn:data($ConsultaGeneralPrestamoRSP/ns1:NEXT_PAYMNT_MATURITY_DATE),7,2))
                }
                </ns3:NextPaymentMaturityDate>
                else ()
            }
            {
                if ($ConsultaGeneralPrestamoRSP/ns1:OVERDUE_PAYMENTS)
                then <ns3:OverduePayments>{fn:data($ConsultaGeneralPrestamoRSP/ns1:OVERDUE_PAYMENTS)}</ns3:OverduePayments>
                else ()
            }
            {
                if ($ConsultaGeneralPrestamoRSP/ns1:NEXT_PAYMNT_PRINCIPAL_AMT)
                then <ns3:NextPaymentPrincipalAmount>{fn:data($ConsultaGeneralPrestamoRSP/ns1:NEXT_PAYMNT_PRINCIPAL_AMT)}</ns3:NextPaymentPrincipalAmount>
                else ()
            }
            {
                if ($ConsultaGeneralPrestamoRSP/ns1:NEXT_PAYMNT_INTEREST_AMT)
                then <ns3:NextPaymentInterestAmount>{fn:data($ConsultaGeneralPrestamoRSP/ns1:NEXT_PAYMNT_INTEREST_AMT)}</ns3:NextPaymentInterestAmount>
                else ()
            }
            {
                if ($ConsultaGeneralPrestamoRSP/ns1:NEXT_PAYMNT_INSURANCE_AMT)
                then <ns3:NextPaymentInsuranceAmount>{fn:data($ConsultaGeneralPrestamoRSP/ns1:NEXT_PAYMNT_INSURANCE_AMT)}</ns3:NextPaymentInsuranceAmount>
                else ()
            }
            {
                if ($ConsultaGeneralPrestamoRSP/ns1:NEXT_PAYMNT_TOTAL_AMT)
                then <ns3:NextPaymentTotalAmount>{fn:data($ConsultaGeneralPrestamoRSP/ns1:NEXT_PAYMNT_TOTAL_AMT)}</ns3:NextPaymentTotalAmount>
                else ()
            }
        </ns3:LoanDetails>
    </ns3:getLoanDetailsResponse>
};

ns2:consultaGeneralPrestamoOut($ConsultaGeneralPrestamoRSP,$uuid)
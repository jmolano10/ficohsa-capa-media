xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="http://www.ficohsa.com.hn/middleware.services/consultaGeneralPrestamo";
(:: import schema at "../../../../../MWBanking/Loans/RequestorServices/XSD/getLoanDetails.xsd" ::)
declare namespace ns1="http://xmlns.oracle.com/pcbpel/adapter/db/sp/GetLoanDetailsNI";
(:: import schema at "../../../../ProviderServices/XSD/GetLoanDetails/GetLoanDetailsNI_sp.xsd" ::)

declare namespace com = "http://www.ficohsa.com.hn/middleware.services/commonTypes";

declare variable $Response as element() (:: schema-element(ns1:OutputParameters) ::) external;
declare variable $uuid as xs:string external;

declare function local:func($Response as element() (:: schema-element(ns1:OutputParameters) ::),
$uuid as xs:string) as element() (:: schema-element(ns2:getLoanDetailsResponse) ::) {
    <ns2:getLoanDetailsResponse>
        <ns2:StatusInfo>
            <com:Status>Success</com:Status>
            <com:ValueDate>{fn:substring(fn:string(fn:current-dateTime()),0,11)}</com:ValueDate>
            <com:DateTime>{fn:substring(fn:string(fn:current-dateTime()),0,20)}</com:DateTime>
            <com:GlobalId>{$uuid}</com:GlobalId>
        </ns2:StatusInfo>
        <ns2:LoanDetails>
            <ns2:LoanCustomerName>{fn:data($Response/ns1:RowSet/ns1:Row/ns1:Column[@name = 'LOAN_CUSTOMER_NAME'])}</ns2:LoanCustomerName>
            <ns2:CustomerId>{fn:data($Response/ns1:RowSet/ns1:Row/ns1:Column[@name = 'CUSTOMER_ID'])}</ns2:CustomerId>
            <ns2:EffectiveDate>{fn:data($Response/ns1:RowSet/ns1:Row/ns1:Column[@name = 'EFFECTIVE_DATE'])}</ns2:EffectiveDate>
            <ns2:MaturityDate>{fn:data($Response/ns1:RowSet/ns1:Row/ns1:Column[@name = 'MATURITY_DATE'])}</ns2:MaturityDate>
            <ns2:LastDisbursementDate>{fn:data($Response/ns1:RowSet/ns1:Row/ns1:Column[@name = 'LAST_DISBURSEMENT_DAY'])}</ns2:LastDisbursementDate>
            <ns2:InterestRate>{fn-bea:format-number((xs:decimal(fn:data($Response/ns1:RowSet/ns1:Row/ns1:Column[@name = 'INTEREST_RATE']))),'0.00')}</ns2:InterestRate>
            <ns2:Currency>{fn:data($Response/ns1:RowSet/ns1:Row/ns1:Column[@name = 'CURRENCY'])}</ns2:Currency>
            <ns2:PrincipalInitialAmount>{fn-bea:format-number((xs:decimal(fn:data($Response/ns1:RowSet/ns1:Row/ns1:Column[@name = 'PRINCIPAL_INITIAL_AMT']))),'0.00')}</ns2:PrincipalInitialAmount>
            <ns2:PrincipalDueAmount>{fn-bea:format-number((xs:decimal(fn:data($Response/ns1:RowSet/ns1:Row/ns1:Column[@name = 'PRINCIPAL_DUE_AMT']))),'0.00')}</ns2:PrincipalDueAmount>
            <ns2:PrincipalOverdueAmount>{fn-bea:format-number((xs:decimal(fn:data($Response/ns1:RowSet/ns1:Row/ns1:Column[@name = 'PRINCIPAL_OVERDUE_AMT']))),'0.00')}</ns2:PrincipalOverdueAmount>
            <ns2:InterestAmount>{fn-bea:format-number((xs:decimal(fn:data($Response/ns1:RowSet/ns1:Row/ns1:Column[@name = 'INTEREST_AMOUNT']))),'0.00')}</ns2:InterestAmount>
            <ns2:OverdueInterestAmount>{fn-bea:format-number((xs:decimal(fn:data($Response/ns1:RowSet/ns1:Row/ns1:Column[@name = 'OVERDUE_INTEREST_AMOUNT']))),'0.00')}</ns2:OverdueInterestAmount>
            <ns2:CommissionAmount>{fn:data($Response/ns1:RowSet/ns1:Row/ns1:Column[@name = 'COMISION_AMOUNT'])}</ns2:CommissionAmount>
            <ns2:TotalDebt>{fn-bea:format-number((xs:decimal(fn:data($Response/ns1:RowSet/ns1:Row/ns1:Column[@name = 'TOTAL_DEBT']))),'0.00')}</ns2:TotalDebt>
            <ns2:NextPaymentId>{fn:data($Response/ns1:RowSet/ns1:Row/ns1:Column[@name = 'NEXT_PAYMNT_ID'])}</ns2:NextPaymentId>
            <ns2:NextPaymentMaturityDate>{fn:data($Response/ns1:RowSet/ns1:Row/ns1:Column[@name = 'NEXT_PAYMNT_MATURITY_DATE'])}</ns2:NextPaymentMaturityDate>
            <ns2:OverduePayments>{fn:data($Response/ns1:RowSet/ns1:Row/ns1:Column[@name = 'OVERDUE_PAYMENTS'])}</ns2:OverduePayments>
            <ns2:NextPaymentPrincipalAmount>{fn-bea:format-number((xs:decimal(fn:data($Response/ns1:RowSet/ns1:Row/ns1:Column[@name = 'NEXT_PAYMNT_PRINCIPAL_AMT']))),'0.00')}</ns2:NextPaymentPrincipalAmount>
            <ns2:NextPaymentInterestAmount>{fn-bea:format-number((xs:decimal(fn:data($Response/ns1:RowSet/ns1:Row/ns1:Column[@name = 'NEXT_PAYMNT_INTEREST_AMT']))),'0.00')}</ns2:NextPaymentInterestAmount>
            <ns2:NextPaymentInsuranceAmount>{fn-bea:format-number((xs:decimal(fn:data($Response/ns1:RowSet/ns1:Row/ns1:Column[@name = 'NEXT_PAYMNT_INSURANCE_AMT']))),'0.00')}</ns2:NextPaymentInsuranceAmount>
            <ns2:NextPaymentTotalAmount>{fn-bea:format-number((xs:decimal(fn:data($Response/ns1:RowSet/ns1:Row/ns1:Column[@name = 'NEXT_PAYMNT_TOTAL_AMT']))),'0.00')}</ns2:NextPaymentTotalAmount>
       </ns2:LoanDetails>
    </ns2:getLoanDetailsResponse>
};

local:func($Response, $uuid)
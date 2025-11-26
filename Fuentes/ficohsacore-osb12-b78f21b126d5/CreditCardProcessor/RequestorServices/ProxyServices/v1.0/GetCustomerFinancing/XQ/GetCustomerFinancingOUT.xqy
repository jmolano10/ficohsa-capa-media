xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns3="http://www.ficohsa.com.hn/middleware.services/getCustomerFinancingTypes";
(:: import schema at "../../../../../../MWBanking/CreditCards/RequestorServices/XSD/getCustomerFinancing.xsd" ::)
declare namespace ns2="http://www.procesa.com/fdcs";
(:: import schema at "../../../../../ProviderServices/XSD/visionPlus/XMLSchema_769155616.xsd" ::)

declare namespace ns1="http://wwwficohsa.hn/middleware.services/getCustomerFinancingOUT";

declare namespace com = "http://www.ficohsa.com.hn/middleware.services/commonTypes";

declare variable $uuid as xs:string external;
declare variable $loanCalculatorL8V2Response as element() (:: schema-element(ns2:LoanCalculatorL8V2Response) ::) external;

declare function ns1:getCustomerFinancingOUT($uuid as xs:string, 
                                              $loanCalculatorL8V2Response as element() (:: schema-element(ns2:LoanCalculatorL8V2Response) ::)) as element() (:: schema-element(ns3:getCustomerFinancingResponse) ::) {
    <ns3:getCustomerFinancingResponse>
        <ns3:StatusInfo>
            <com:Status>Success</com:Status>
            <com:ValueDate>{fn:substring(fn:string(fn:current-dateTime()),0,11)}</com:ValueDate>
            <com:DateTime>{fn:substring(fn:string(fn:current-dateTime()),0,20)}</com:DateTime>
            <com:GlobalId>{fn:data($uuid)}</com:GlobalId>
        </ns3:StatusInfo>
        <ns3:FinancingDetailsInfo>
            <ns3:Org>{fn:data($loanCalculatorL8V2Response/ARXLCO-ORG)}</ns3:Org>
            <ns3:Logo>{fn:data($loanCalculatorL8V2Response/ARXLCO-LOGO)}</ns3:Logo>
            {
                if ($loanCalculatorL8V2Response/ARXLCO-LOAN-TERM)
                then <ns3:LoanTermType>{fn:data($loanCalculatorL8V2Response/ARXLCO-LOAN-TERM)}</ns3:LoanTermType>
                else ()
            }
            {
                if ($loanCalculatorL8V2Response/ARXLCO-INT-RATE)
                then <ns3:InterestRate>{fn:data($loanCalculatorL8V2Response/ARXLCO-INT-RATE)}</ns3:InterestRate>
                else ()
            }
            {
                if ($loanCalculatorL8V2Response/ARXLCO-PRIN-AMT)
                then <ns3:PrincipalAmount>{fn:data($loanCalculatorL8V2Response/ARXLCO-PRIN-AMT)}</ns3:PrincipalAmount>
                else ()
            }
            {
                if ($loanCalculatorL8V2Response/ARXLCO-TOT-INT-AMT)
                then <ns3:InterestAmount>{fn:data($loanCalculatorL8V2Response/ARXLCO-TOT-INT-AMT)}</ns3:InterestAmount>
                else ()
            }
            {
                if ($loanCalculatorL8V2Response/ARXLCO-INS-AMT)
                then <ns3:InsuranceAmount>{fn:data($loanCalculatorL8V2Response/ARXLCO-INS-AMT)}</ns3:InsuranceAmount>
                else ()
            }
            {
                if ($loanCalculatorL8V2Response/ARXLCO-USER-FEES)
                then <ns3:CommissionAmount>{fn:data($loanCalculatorL8V2Response/ARXLCO-USER-FEES)}</ns3:CommissionAmount>
                else ()
            }
            {
                if ($loanCalculatorL8V2Response/ARXLCO-TOT-FIN-AMT)
                then <ns3:LoanAmount>{fn:data($loanCalculatorL8V2Response/ARXLCO-TOT-FIN-AMT)}</ns3:LoanAmount>
                else ()
            }
            {
                if ($loanCalculatorL8V2Response/ARXLCO-TOT-LOAN-AMT)
                then <ns3:TotalLoanAmount>{fn:data($loanCalculatorL8V2Response/ARXLCO-TOT-LOAN-AMT)}</ns3:TotalLoanAmount>
                else ()
            }
            {
                if ($loanCalculatorL8V2Response/ARXLCO-FIXED-PMT-AMT)
                then <ns3:MonthlyPayment>{fn:data($loanCalculatorL8V2Response/ARXLCO-FIXED-PMT-AMT)}</ns3:MonthlyPayment>
                else ()
            }
            <ns3:InsuranceAmtIncluded>{fn:data($loanCalculatorL8V2Response/ARXLCO-EXCL-INS-SW)}</ns3:InsuranceAmtIncluded>
            {
                if ($loanCalculatorL8V2Response/ARXLCO-FINAL-PMT-AMT)
                then <ns3:LastPaymentAmount>{fn:data($loanCalculatorL8V2Response/ARXLCO-FINAL-PMT-AMT)}</ns3:LastPaymentAmount>
                else ()
            }
            <ns3:PctCode>{fn:data($loanCalculatorL8V2Response/ARXLCO-PCT)}</ns3:PctCode>
            <ns3:InsuranceCode>{fn:data($loanCalculatorL8V2Response/ARXLCO-INS-PROD)}</ns3:InsuranceCode>
        </ns3:FinancingDetailsInfo>
    </ns3:getCustomerFinancingResponse>
};

ns1:getCustomerFinancingOUT($uuid, $loanCalculatorL8V2Response)
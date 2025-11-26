xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="http://www.ficohsa.com.hn/middleware.services/getCustomerFinancingTypes";
(:: import schema at "../../../../../../MWBanking/CreditCards/RequestorServices/XSD/getCustomerFinancing.xsd" ::)
declare namespace ns3="http://www.procesa.com/fdcs";
(:: import schema at "../../../../../ProviderServices/XSD/visionPlus/XMLSchema_769155616.xsd" ::)

declare namespace ns1="http://www.ficohsa.hn/middleware.services/loanCalculatorIn";

declare variable $getCustomerFinancingRequest as element() (:: schema-element(ns2:getCustomerFinancingRequest) ::) external;

declare function ns1:loanCalculatorIn($getCustomerFinancingRequest as element() (:: schema-element(ns2:getCustomerFinancingRequest) ::)) as element() (:: schema-element(ns3:LoanCalculatorL8V2Request) ::) {
    <ns3:LoanCalculatorL8V2Request>
        <ARXLCI-ORG>{fn:data($getCustomerFinancingRequest/ns2:Org)}</ARXLCI-ORG>
        <ARXLCI-LOGO>000</ARXLCI-LOGO>
        <ARXLCI-PCT>{fn:data($getCustomerFinancingRequest/ns2:PctCode)}</ARXLCI-PCT>
        <ARXLCI-INS-PROD>{fn:data($getCustomerFinancingRequest/ns2:InsuranceCode)}</ARXLCI-INS-PROD>
        <ARXLCI-EXCL-INS-SW></ARXLCI-EXCL-INS-SW>
        <ARXLCI-PRIN-AMT>{fn:data($getCustomerFinancingRequest/ns2:Amount)}</ARXLCI-PRIN-AMT>
        {
            if ($getCustomerFinancingRequest/ns2:InterestRate)
            then <ARXLCI-INT-RATE>{fn:data($getCustomerFinancingRequest/ns2:InterestRate)}</ARXLCI-INT-RATE>
            else ()
        }
        <ARXLCI-LOAN-TERM>{fn:data($getCustomerFinancingRequest/ns2:LoanTerm)}</ARXLCI-LOAN-TERM>
        <ARXLCI-FIXED-PMT-AMT>0</ARXLCI-FIXED-PMT-AMT>
        <ARXLCI-INT-METHOD>1</ARXLCI-INT-METHOD>
        <ARXLCI-ROUNDING-IND>0</ARXLCI-ROUNDING-IND>
        <ARXLCI-CURRENCY-NBR>{fn:data($getCustomerFinancingRequest/ns2:Currency)}</ARXLCI-CURRENCY-NBR>
        <ARXLCI-EXCL-COMM-SW>Y</ARXLCI-EXCL-COMM-SW>
    </ns3:LoanCalculatorL8V2Request>
};

ns1:loanCalculatorIn($getCustomerFinancingRequest)
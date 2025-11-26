xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://xmlns.oracle.com/Dynamo/MWBanking/GetLoanDetails_PS";
(:: import schema at "../WSDL/GetLoanDetailsNI_PS.wsdl" ::)
declare namespace ns2="http://xmlns.oracle.com/pcbpel/adapter/db/sp/GetLoanDetailsNI";
(:: import schema at "../../../../ProviderServices/XSD/GetLoanDetails/GetLoanDetailsNI_sp.xsd" ::)

declare variable $Input as element() (:: schema-element(ns1:getLoanDetails_params) ::) external;

declare function local:func($Input as element() (:: schema-element(ns1:getLoanDetails_params) ::)) as element() (:: schema-element(ns2:InputParameters) ::) {
    <ns2:InputParameters>
        <ns2:i_LOAN_ID>{fn:data($Input/ns1:loanId)}</ns2:i_LOAN_ID>
    </ns2:InputParameters>
};

local:func($Input)
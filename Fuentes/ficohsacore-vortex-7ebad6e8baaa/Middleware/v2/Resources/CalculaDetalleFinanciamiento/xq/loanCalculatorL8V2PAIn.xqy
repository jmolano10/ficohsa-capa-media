xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$calculaDetalleFinanciamiento1" element="ns1:calculaDetalleFinanciamiento" location="../xsd/calculaDetalleFinanciamientoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:LoanCalculatorL8V2Request" location="../../../BusinessServices/VisionPlus/visionPlus/xsd/XMLSchema_769155616.xsd" ::)

declare namespace ns0 = "http://www.procesa.com/fdcs";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/calculaDetalleFinanciamientoTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/CalculaDetalleFinanciamiento/xq/loanCalculatorL8V2PAIn/";

declare function xf:loanCalculatorL8V2PAIn($calculaDetalleFinanciamiento1 as element(ns1:calculaDetalleFinanciamiento))
    as element(ns0:LoanCalculatorL8V2Request) {
        <ns0:LoanCalculatorL8V2Request>
            <ARXLCI-ORG>{ data($calculaDetalleFinanciamiento1/ORG) }</ARXLCI-ORG>
            <ARXLCI-LOGO>000</ARXLCI-LOGO>
            <ARXLCI-PCT>{ data($calculaDetalleFinanciamiento1/PCT_CODE) }</ARXLCI-PCT>
            <ARXLCI-INS-PROD>{ data($calculaDetalleFinanciamiento1/INSURANCE_CODE) }</ARXLCI-INS-PROD>
            <ARXLCI-EXCL-INS-SW>Y</ARXLCI-EXCL-INS-SW>
            <ARXLCI-PRIN-AMT>{ data($calculaDetalleFinanciamiento1/AMOUNT) }</ARXLCI-PRIN-AMT>
            <ARXLCI-INT-RATE>{ data($calculaDetalleFinanciamiento1/INTEREST_RATE) }</ARXLCI-INT-RATE>
            <ARXLCI-LOAN-TERM>{ data($calculaDetalleFinanciamiento1/LOAN_TERM) }</ARXLCI-LOAN-TERM>
            <ARXLCI-FIXED-PMT-AMT>0</ARXLCI-FIXED-PMT-AMT>
            <ARXLCI-INT-METHOD>1</ARXLCI-INT-METHOD>
            <ARXLCI-ROUNDING-IND>0</ARXLCI-ROUNDING-IND>
            <ARXLCI-CURRENCY-NBR>{ data($calculaDetalleFinanciamiento1/CURRENCY) }</ARXLCI-CURRENCY-NBR>
            <ARXLCI-EXCL-COMM-SW>Y</ARXLCI-EXCL-COMM-SW>
        </ns0:LoanCalculatorL8V2Request>
};

declare variable $calculaDetalleFinanciamiento1 as element(ns1:calculaDetalleFinanciamiento) external;

xf:loanCalculatorL8V2PAIn($calculaDetalleFinanciamiento1)
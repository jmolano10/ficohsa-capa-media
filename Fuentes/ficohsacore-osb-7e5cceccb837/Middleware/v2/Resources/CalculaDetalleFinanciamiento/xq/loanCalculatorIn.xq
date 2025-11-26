(:: pragma bea:global-element-parameter parameter="$calculaDetalleFinanciamiento" element="ns1:calculaDetalleFinanciamiento" location="../xsd/calculaDetalleFinanciamientoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:LoanCalculatorRequest" location="../../../BusinessServices/VisionPlus/visionPlus/xsd/XMLSchema_769155616.xsd" ::)

declare namespace ns0 = "http://www.procesa.com/fdcs";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/calculaDetalleFinanciamientoTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/CalculaDetalleFinanciamiento/xq/loanCalculatorIn/";

declare function xf:loanCalculatorIn($calculaDetalleFinanciamiento as element(ns1:calculaDetalleFinanciamiento))
    as element(ns0:LoanCalculatorRequest) {
        <ns0:LoanCalculatorRequest>
        	<ARXLCI-CONTEXT></ARXLCI-CONTEXT>
        	<ARXLCI-SIGNON-NAME></ARXLCI-SIGNON-NAME>
            <ARXLCI-ORG>{ data($calculaDetalleFinanciamiento/ORG) }</ARXLCI-ORG>
            <ARXLCI-LOGO>000</ARXLCI-LOGO>
            <ARXLCI-PCT>{ data($calculaDetalleFinanciamiento/PCT_CODE) }</ARXLCI-PCT>
            <ARXLCI-INS-PROD>{ data($calculaDetalleFinanciamiento/INSURANCE_CODE) }</ARXLCI-INS-PROD>
            <ARXLCI-EXCL-INS-SW>Y</ARXLCI-EXCL-INS-SW>
            <ARXLCI-PRIN-AMT>{ data($calculaDetalleFinanciamiento/AMOUNT) }</ARXLCI-PRIN-AMT>
            <ARXLCI-INT-RATE>{ data($calculaDetalleFinanciamiento/INTEREST_RATE) }</ARXLCI-INT-RATE>
            <ARXLCI-LOAN-TERM>{ data($calculaDetalleFinanciamiento/LOAN_TERM) }</ARXLCI-LOAN-TERM>
            <ARXLCI-FIXED-PMT-AMT>0</ARXLCI-FIXED-PMT-AMT>
            <ARXLCI-INT-METHOD>1</ARXLCI-INT-METHOD>
            <ARXLCI-ROUNDING-IND>0</ARXLCI-ROUNDING-IND>
            <ARXLCI-CURRENCY-NBR>{ data($calculaDetalleFinanciamiento/CURRENCY) }</ARXLCI-CURRENCY-NBR>
        </ns0:LoanCalculatorRequest>
};
declare variable $calculaDetalleFinanciamiento as element(ns1:calculaDetalleFinanciamiento) external;

xf:loanCalculatorIn($calculaDetalleFinanciamiento)
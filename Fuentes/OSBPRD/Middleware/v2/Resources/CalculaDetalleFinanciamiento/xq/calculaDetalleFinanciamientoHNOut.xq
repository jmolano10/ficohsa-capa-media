xquery version "1.0" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$loanCalculatorL8V2Response" element="ns0:LoanCalculatorL8V2Response" location="../../../BusinessServices/VisionPlus/visionPlus/xsd/XMLSchema_769155616.xsd" ::)
(:: pragma bea:global-element-return element="ns1:calculaDetalleFinanciamientoResponse" location="../xsd/calculaDetalleFinanciamientoTypes.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/CalculaDetalleFinanciamiento/xq/calculaDetalleFinanciamientoHN1Out/";
declare namespace ns0 = "http://www.procesa.com/fdcs";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/calculaDetalleFinanciamientoTypes";

declare function xf:calculaDetalleFinanciamientoHN1Out($loanCalculatorL8V2Response as element(ns0:LoanCalculatorL8V2Response))
    as element(ns1:calculaDetalleFinanciamientoResponse) {
       <ns1:calculaDetalleFinanciamientoResponse>
            {
            	let $org := string($loanCalculatorL8V2Response/ARXLCO-ORG/text())
            	return
            		if($org != '')then(
            			<ORG>{$org}</ORG>
            		)else()
            }
            { 
            	let $logo := string($loanCalculatorL8V2Response/ARXLCO-LOGO/text())
            	return
            		if($logo != '')then(
            			<LOGO>{$logo}</LOGO>
            		)else()
            } 
            { 
            	let $loanTerm := string($loanCalculatorL8V2Response/ARXLCO-LOAN-TERM/text())
            	return
            		if($loanTerm != '')then(
            			<LOAN_TERM>{$loanTerm}</LOAN_TERM>
            		)else()
            }
            {
                let $interestRate := string($loanCalculatorL8V2Response/ARXLCO-INT-RATE/text())
                return
                	if($interestRate != '')then(
                    	<INTEREST_RATE>{ $interestRate }</INTEREST_RATE>
                    )else()
            }
            {
                let $prinAmount := string($loanCalculatorL8V2Response/ARXLCO-PRIN-AMT/text())
                return
                	if($prinAmount != '')then(
                    	<PRINCIPAL_AMOUNT>{ $prinAmount }</PRINCIPAL_AMOUNT>
                    )else()
            }
            {
                let $interestAmount := string($loanCalculatorL8V2Response/ARXLCO-TOT-INT-AMT/text())
                return
                	if($interestAmount != '')then(
                    	<INTEREST_AMOUNT>{ $interestAmount }</INTEREST_AMOUNT>
                    )else()
            }
            {
                let $insuranceAmount := string($loanCalculatorL8V2Response/ARXLCO-INS-AMT/text())
                return
                	if($insuranceAmount != '')then(
                    	<INSURANCE_AMOUNT>{ $insuranceAmount }</INSURANCE_AMOUNT>
                    )else()
            }
            {
                let $commissionAmount := string($loanCalculatorL8V2Response/ARXLCO-USER-FEES/text())
                return
                	if($commissionAmount != '')then(
                    	<COMMISSION_AMOUNT>{ $commissionAmount }</COMMISSION_AMOUNT>
                    )else()
            }
            {
                let $loanAmount := string($loanCalculatorL8V2Response/ARXLCO-TOT-FIN-AMT/text())
                return
                	if($loanAmount != '')then(
                    	<LOAN_AMOUNT>{ $loanAmount }</LOAN_AMOUNT>
                    )else()
            }
            {
                let $totalLoanAmount := string($loanCalculatorL8V2Response/ARXLCO-TOT-LOAN-AMT/text())
                return
                	if($totalLoanAmount != '')then(
                    	<TOTAL_LOAN_AMOUNT>{ $totalLoanAmount }</TOTAL_LOAN_AMOUNT>
                    )else()
            }
            {
                let $monthlyPayment := string($loanCalculatorL8V2Response/ARXLCO-FIXED-PMT-AMT/text())
                return
                	if($monthlyPayment != '')then(
                    	<MONTHLY_PAYMENT>{ $monthlyPayment }</MONTHLY_PAYMENT>
                    )else()
            }
            <INSURANCE_AMT_INCLUDED>{ data($loanCalculatorL8V2Response/ARXLCO-EXCL-INS-SW) }</INSURANCE_AMT_INCLUDED>
            {
                let $lastPaymentAmount := string($loanCalculatorL8V2Response/ARXLCO-FINAL-PMT-AMT/text())
                return
                	if($lastPaymentAmount != '')then(
                    	<LAST_PAYMENT_AMOUNT>{ $lastPaymentAmount }</LAST_PAYMENT_AMOUNT>
                    )else()
            }
            <PCT_CODE>{ data($loanCalculatorL8V2Response/ARXLCO-PCT) }</PCT_CODE>
            <INSURANCE_CODE>{ data($loanCalculatorL8V2Response/ARXLCO-INS-PROD) }</INSURANCE_CODE>
        </ns1:calculaDetalleFinanciamientoResponse>
};

declare variable $loanCalculatorL8V2Response as element(ns0:LoanCalculatorL8V2Response) external;

xf:calculaDetalleFinanciamientoHN1Out($loanCalculatorL8V2Response)
(:: pragma bea:global-element-parameter parameter="$creaFinanciamiento" element="ns0:creaFinanciamiento" location="../xsd/creaFinanciamientoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:AddLoanPlanRequest" location="../../../BusinessServices/VisionPlus/visionPlus/xsd/XMLSchema_769155616.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/creaFinanciamientoTypes";
declare namespace ns1 = "http://www.procesa.com/fdcs";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/CreaFinanciamiento/xq/addLoanPlanNIIn/";

declare function interestRate($valor as xs:decimal)
{
	fn-bea:pad-left(fn:string(xs:int($valor * 100000)), 7, '0')

};

declare function xf:addLoanPlanNIIn($creaFinanciamiento as element(ns0:creaFinanciamiento))
    as element(ns1:AddLoanPlanRequest) {
        <ns1:AddLoanPlanRequest>
            <ARXLPI-ORG>{ data($creaFinanciamiento/ORG) }</ARXLPI-ORG>
            <ARXLPI-ACCT-NBR>{ data($creaFinanciamiento/ACCOUNT_NUMBER) }</ARXLPI-ACCT-NBR>
            <ARXLPI-PLAN-NBR>{ data($creaFinanciamiento/PLAN_CODE) }</ARXLPI-PLAN-NBR>
            <ARXLPI-LP-LOAN-SCHED-FLAG>1</ARXLPI-LP-LOAN-SCHED-FLAG>
            <ARXLPI-L1-PLAN-DESC>{ data($creaFinanciamiento/PLAN_DESCRIPTION) }</ARXLPI-L1-PLAN-DESC>
            <ARXLPI-L1-SI-ORG>{ data($creaFinanciamiento/ORG) }</ARXLPI-L1-SI-ORG>
            <ARXLPI-L1-SI-NBR>999999998</ARXLPI-L1-SI-NBR>
            <ARXLPI-L1-PRODUCT-CODE>{ data($creaFinanciamiento/PLAN_NUMBER) }</ARXLPI-L1-PRODUCT-CODE>
            <ARXLPI-L1-PLAN-DATE>{ data($creaFinanciamiento/START_DATE_PLAN) }</ARXLPI-L1-PLAN-DATE>
            <ARXLPI-L1-FIXED-PMT-AMT>{ data($creaFinanciamiento/FIXED_LEVELED_FEE) }</ARXLPI-L1-FIXED-PMT-AMT>
            <ARXLPI-L1-PMT-FLAG>F</ARXLPI-L1-PMT-FLAG>
            <ARXLPI-L2-CEL-AGRMNT-DATE>{ data($creaFinanciamiento/FORMALIZATION_DATE) }</ARXLPI-L2-CEL-AGRMNT-DATE>
            <ARXLPI-L2-CEL-INT-APR>{ interestRate(data($creaFinanciamiento/INTEREST_RATE)) }</ARXLPI-L2-CEL-INT-APR>
            <ARXLPI-L2-CEL-ORIG-TERM>{ data($creaFinanciamiento/LOAN_TERM) }</ARXLPI-L2-CEL-ORIG-TERM>
            <ARXLPI-L2-CEL-DISPERSALMETHOD>0</ARXLPI-L2-CEL-DISPERSALMETHOD>
            <ARXLPI-L2-CEL-ORIG-DSCLSDLOAN>{ data($creaFinanciamiento/TOTAL_AMOUNT) }</ARXLPI-L2-CEL-ORIG-DSCLSDLOAN>
            <ARXLPI-L2-CEL-ORIG-DSCLSDPRIN>{ data($creaFinanciamiento/PRINCIPAL_AMOUNT) }</ARXLPI-L2-CEL-ORIG-DSCLSDPRIN>
            <ARXLPI-L2-CEL-ORIG-DSCLSDINT>{ data($creaFinanciamiento/INTEREST_AMOUNT) }</ARXLPI-L2-CEL-ORIG-DSCLSDINT>
            <ARXLPI-L2-CEL-ORIG-DSCLSD-INS>{ data($creaFinanciamiento/INSURANCE_AMOUNT) }</ARXLPI-L2-CEL-ORIG-DSCLSD-INS>
            <ARXLPI-L2-CEL-ORIG-DSCLSDUSR1>0</ARXLPI-L2-CEL-ORIG-DSCLSDUSR1>
            <ARXLPI-L2-CEL-ORIG-DSCLSDUSR2>0</ARXLPI-L2-CEL-ORIG-DSCLSDUSR2>
            <ARXLPI-L2-CEL-ORIG-DSCLSDUSR3>{ data($creaFinanciamiento/DISBURSEMENT_COMMISSION) }</ARXLPI-L2-CEL-ORIG-DSCLSDUSR3>
            <ARXLPI-L2-CEL-ORIG-DSCLSDUSR4>0</ARXLPI-L2-CEL-ORIG-DSCLSDUSR4>
            <ARXLPI-L2-CEL-ORIG-DSCLSDUSR5>0</ARXLPI-L2-CEL-ORIG-DSCLSDUSR5>
            <ARXLPI-L2-CEL-ORIG-DSCLSDUSR6>0</ARXLPI-L2-CEL-ORIG-DSCLSDUSR6>
            <ARXLPI-L2-CEL-INTEREST-CAPIND>1</ARXLPI-L2-CEL-INTEREST-CAPIND>
            <ARXLPI-L2-CEL-INS-CAP-IND>0</ARXLPI-L2-CEL-INS-CAP-IND>
            <ARXLPI-L2-CEL-USR1-FEE-CAPIND>0</ARXLPI-L2-CEL-USR1-FEE-CAPIND>
            <ARXLPI-L2-CEL-USR2-FEE-CAPIND>0</ARXLPI-L2-CEL-USR2-FEE-CAPIND>
            <ARXLPI-L2-CEL-USR3-FEE-CAPIND>2</ARXLPI-L2-CEL-USR3-FEE-CAPIND>
            <ARXLPI-L2-CEL-US4-FEE-CAP-IND>0</ARXLPI-L2-CEL-US4-FEE-CAP-IND>
            <ARXLPI-L2-CEL-US5-FEE-CAP-IND>0</ARXLPI-L2-CEL-US5-FEE-CAP-IND>
            <ARXLPI-L2-CEL-USR6-FEE-CAPIND>0</ARXLPI-L2-CEL-USR6-FEE-CAPIND>
            <ARXLPI-L2-CEL-INTEREST-CCIIND>0</ARXLPI-L2-CEL-INTEREST-CCIIND>
            <ARXLPI-L2-CEL-INS-CCI-IND>0</ARXLPI-L2-CEL-INS-CCI-IND>
            <ARXLPI-L2-CEL-USR1-FEE-CCIIND>0</ARXLPI-L2-CEL-USR1-FEE-CCIIND>
            <ARXLPI-L2-CEL-USR2-FEE-CCIIND>0</ARXLPI-L2-CEL-USR2-FEE-CCIIND>
            <ARXLPI-L2-CEL-USR3-FEE-CCIIND>1</ARXLPI-L2-CEL-USR3-FEE-CCIIND>
            <ARXLPI-L2-CEL-USR4-FEE-CCIIND>0</ARXLPI-L2-CEL-USR4-FEE-CCIIND>
            <ARXLPI-L2-CEL-USR5-FEE-CCIIND>0</ARXLPI-L2-CEL-USR5-FEE-CCIIND>
            <ARXLPI-L2-CEL-USR6-FEE-CCIIND>0</ARXLPI-L2-CEL-USR6-FEE-CCIIND>
            <ARXLPI-L2-CEL-INT-RATE>{ interestRate(data($creaFinanciamiento/INTEREST_RATE)) }</ARXLPI-L2-CEL-INT-RATE>
            <ARXLPI-L2-CEL-NEXT-INT-RATE>0</ARXLPI-L2-CEL-NEXT-INT-RATE>
        </ns1:AddLoanPlanRequest>
};

declare variable $creaFinanciamiento as element(ns0:creaFinanciamiento) external;

xf:addLoanPlanNIIn($creaFinanciamiento)
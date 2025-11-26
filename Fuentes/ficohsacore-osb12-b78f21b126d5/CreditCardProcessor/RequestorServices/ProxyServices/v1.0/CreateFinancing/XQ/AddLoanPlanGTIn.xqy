xquery version "1.0" encoding "utf-8";
(:: OracleAnnotationVersion "1.0" ::)
declare namespace ns2="http://www.ficohsa.com.hn/middleware.services/createFinancingTypes";
(:: import schema at "../../../../../../MWBanking/CreditCards/RequestorServices/XSD/createFinancingTypes.xsd" ::)
declare namespace ns3="http://www.procesa.com/fdcs";
(:: import schema at "../../../../../ProviderServices/XSD/visionPlus/XMLSchema_769155616.xsd" ::)
declare namespace xq="http://www.w3.org/2005/xquery-local-functions";
declare namespace ns1="http://www.ficohsa.com.hn/middleware.services/addLoanPlanGTIn";
declare variable $createFinancing as element() (:: schema-element(ns2:createFinancing) ::) external;

declare function xq:interestRate($valor as xs:decimal)
{
	fn-bea:pad-left(fn:string(xs:int($valor * 100000)), 7, '0')

};
declare function ns1:addLoanPlanGTIn($createFinancing as element() (:: schema-element(ns2:createFinancing) ::)) as element() (:: schema-element(ns3:AddLoanPlanL8V1Request) ::) {


<ns3:AddLoanPlanL8V1Request>
	<ARXLPI-ORG>{fn:data($createFinancing/Org)}</ARXLPI-ORG>
	<ARXLPI-ACCT-NBR>{fn:data($createFinancing/AccountNumber)}</ARXLPI-ACCT-NBR>
	<ARXLPI-PLAN-NBR>{fn:data($createFinancing/PlanCode)}</ARXLPI-PLAN-NBR>
	<ARXLPI-LP-LOAN-SCHED-FLAG>1</ARXLPI-LP-LOAN-SCHED-FLAG>
	<ARXLPI-L1-PLAN-DESC>{fn:data($createFinancing/PlanDescription)}</ARXLPI-L1-PLAN-DESC>
	<ARXLPI-L1-SI-ORG>000</ARXLPI-L1-SI-ORG>
	<ARXLPI-L1-SI-NBR>000000000</ARXLPI-L1-SI-NBR>
	<ARXLPI-L1-PRODUCT-CODE>{fn:data($createFinancing/PlanNumber)}</ARXLPI-L1-PRODUCT-CODE>
	<ARXLPI-L1-PLAN-DATE>{fn:data($createFinancing/StartDatePlan)}</ARXLPI-L1-PLAN-DATE>
	<ARXLPI-L1-FIXED-PMT-AMT>{fn:data($createFinancing/FixedLeveledFee)}</ARXLPI-L1-FIXED-PMT-AMT>
	<ARXLPI-L1-PMT-FLAG>F</ARXLPI-L1-PMT-FLAG>
	<ARXLPI-L2-CEL-AGRMNT-DATE>{fn:data($createFinancing/FormalizationDate)}</ARXLPI-L2-CEL-AGRMNT-DATE>
	<ARXLPI-L2-CEL-INT-APR>{xq:interestRate(fn:data($createFinancing/InterestRate))}</ARXLPI-L2-CEL-INT-APR>
	<ARXLPI-L2-CEL-ORIG-TERM>{fn:data($createFinancing/LoanTerm)}</ARXLPI-L2-CEL-ORIG-TERM>
	<ARXLPI-L2-CEL-DISPERSALMETHOD>0</ARXLPI-L2-CEL-DISPERSALMETHOD>
	<ARXLPI-L2-CEL-ORIG-DSCLSDLOAN>{fn:data($createFinancing/TotalAmount)}</ARXLPI-L2-CEL-ORIG-DSCLSDLOAN>
	<ARXLPI-L2-CEL-ORIG-DSCLSDPRIN>{fn:data($createFinancing/PrincipalAmount)}</ARXLPI-L2-CEL-ORIG-DSCLSDPRIN>
	<ARXLPI-L2-CEL-ORIG-DSCLSDINT>{fn:data($createFinancing/InterestAmount)}</ARXLPI-L2-CEL-ORIG-DSCLSDINT>
	<ARXLPI-L2-CEL-ORIG-DSCLSD-INS>{fn:data($createFinancing/InsuranceAmount)}</ARXLPI-L2-CEL-ORIG-DSCLSD-INS>
	<ARXLPI-L2-CEL-ORIG-DSCLSDUSR1>0</ARXLPI-L2-CEL-ORIG-DSCLSDUSR1>
	<ARXLPI-L2-CEL-ORIG-DSCLSDUSR2>0</ARXLPI-L2-CEL-ORIG-DSCLSDUSR2>
	<ARXLPI-L2-CEL-ORIG-DSCLSDUSR3>{fn:data($createFinancing/DisbursementComission)}</ARXLPI-L2-CEL-ORIG-DSCLSDUSR3>
	<ARXLPI-L2-CEL-ORIG-DSCLSDUSR4>0</ARXLPI-L2-CEL-ORIG-DSCLSDUSR4>
	<ARXLPI-L2-CEL-ORIG-DSCLSDUSR5>0</ARXLPI-L2-CEL-ORIG-DSCLSDUSR5>
	<ARXLPI-L2-CEL-ORIG-DSCLSDUSR6>0</ARXLPI-L2-CEL-ORIG-DSCLSDUSR6>
	<ARXLPI-L2-CEL-INTEREST-CAPIND>1</ARXLPI-L2-CEL-INTEREST-CAPIND>
	<ARXLPI-L2-CEL-INS-CAP-IND>1</ARXLPI-L2-CEL-INS-CAP-IND>
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
	<ARXLPI-L2-CEL-INT-RATE>{xq:interestRate(fn:data($createFinancing/InterestRate))}</ARXLPI-L2-CEL-INT-RATE>
	<ARXLPI-L2-CEL-NEXT-INT-RATE>0</ARXLPI-L2-CEL-NEXT-INT-RATE>
	<ARXLPI-AMORT-DATA>
		{
		for $AmortEntry in $createFinancing/AmortData/AmortEntry
		return
		<ARXLPI-AMORT-ENTRY>
			<ARXLPI-L3-AD-TERM>{fn:data($AmortEntry/DataTerma)}</ARXLPI-L3-AD-TERM>
			<ARXLPI-L3-AD-TABLE>{fn:data($AmortEntry/DataTable)}</ARXLPI-L3-AD-TABLE>
			<ARXLPI-L3-AD-METHOD>{fn:data($AmortEntry/DataMethod)}</ARXLPI-L3-AD-METHOD>
			<ARXLPI-L3-AD-START-IND>{fn:data($AmortEntry/DataStartInd)}</ARXLPI-L3-AD-START-IND>
			<ARXLPI-L3-AD-START-MTH>{fn:data($AmortEntry/DataStartMonth)}</ARXLPI-L3-AD-START-MTH>
			<ARXLPI-L3-AD-START-DAYS>{fn:data($AmortEntry/DataStartDay)}</ARXLPI-L3-AD-START-DAYS>
			<ARXLPI-L3-AD-ROUNDING>{fn:data($AmortEntry/DataRoundType)}</ARXLPI-L3-AD-ROUNDING>
			<ARXLPI-L3-AD-FIX-AMT>{fn:data($AmortEntry/DataAmount)}</ARXLPI-L3-AD-FIX-AMT>
		</ARXLPI-AMORT-ENTRY>
		}
	</ARXLPI-AMORT-DATA>
</ns3:AddLoanPlanL8V1Request>
};
ns1:addLoanPlanGTIn($createFinancing)
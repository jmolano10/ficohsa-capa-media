xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://www.ficohsa.com.hn/middleware.services/creditCardsTypes";
(:: import schema at "../../../../../../MWBanking/CreditCards/RequestorServices/XSD/creditCardsTypes.xsd" ::)
declare namespace ns2="http://www.procesa.com/fdcs";
(:: import schema at "../../../../../ProviderServices/XSD/visionPlus/XMLSchema_769155616.xsd" ::)
declare namespace xf = "http://tempuri.org/CreditCardProcessor/v2/Resources/CreacionCuentaFinanciamiento/xq/accountAddGTIn/";

declare function xf:stringEmpty() as xs:string {
		let $empty := ""	
		return $empty
	};
declare function xf:nvl( $arg as item()? , $value as item())  
	as item(){
	if (string($arg) != '') then 
		data($arg)
  	else 
  		$value
};

declare variable $createFinancingAccountRequest as element() (:: schema-element(ns1:createFinancingAccountRequest) ::) external;

declare function local:func($createFinancingAccountRequest as element() (:: schema-element(ns1:createFinancingAccountRequest) ::)) as element() (:: schema-element(ns2:AccountAddRequest) ::) {
    <ns2:AccountAddRequest>
       <ARXAAI-ORG>{ data($createFinancingAccountRequest/ns1:Org) }</ARXAAI-ORG> 
            <ARXAAI-LOGO>{ data($createFinancingAccountRequest/ns1:Logo) }</ARXAAI-LOGO>
            <ARXAAI-ACCOUNT-NBR>{ xf:stringEmpty() }</ARXAAI-ACCOUNT-NBR>
            <ARXAAI-BILLING-ACCT-IND>0</ARXAAI-BILLING-ACCT-IND>
            <ARXAAI-REL-PRIM-ACCT-FLAG>{ xf:stringEmpty() }</ARXAAI-REL-PRIM-ACCT-FLAG>
            <ARXAAI-REL-NBR>{ xf:stringEmpty() }</ARXAAI-REL-NBR>
            <ARXAAI-SHORT-NAME>{ data($createFinancingAccountRequest/ns1:ShortName) }</ARXAAI-SHORT-NAME>
            <ARXAAI-CREDIT-LIMIT>{ xs:int(fn:replace(data($createFinancingAccountRequest/ns1:CreditLimitLcy),'\.','')) }</ARXAAI-CREDIT-LIMIT>
            <ARXAAI-CUST-NBR>{ data($createFinancingAccountRequest/ns1:CustomerId) }</ARXAAI-CUST-NBR>
            <ARXAAI-DATE-CARD-FEE>{ fn:adjust-date-to-timezone((fn:current-date() + xs:yearMonthDuration('P1Y')),()) }</ARXAAI-DATE-CARD-FEE>
            <ARXAAI-USER-ACCT-NBR>{ xf:stringEmpty() }</ARXAAI-USER-ACCT-NBR>
            <ARXAAI-BILLING-CURR>000</ARXAAI-BILLING-CURR>
            <ARXAAI-REL-BILL-LVL>1</ARXAAI-REL-BILL-LVL>
            <ARXAAI-DUAL-BILLING-FL>{ data($createFinancingAccountRequest/ns1:BillingType) }</ARXAAI-DUAL-BILLING-FL>
            <ARXAAI-ALT-CUST-NBR-FLAG>{ xf:stringEmpty() }</ARXAAI-ALT-CUST-NBR-FLAG>
            <ARXAAI-ALT-CUST-NBR>{ xf:stringEmpty() }</ARXAAI-ALT-CUST-NBR>
            <ARXAAI-COLAT-CODE>{ xf:stringEmpty() }</ARXAAI-COLAT-CODE>
            <ARXAAI-FLEX-BILL-FLAG>N</ARXAAI-FLEX-BILL-FLAG>
            {
                for $openingDate in $createFinancingAccountRequest/ns1:OpeningDate
                return
                    <ARXAAI-DATE-OPENED>{ data($openingDate) }</ARXAAI-DATE-OPENED>
            }
            <ARXAAI-REL-CARD-SCHEME>3</ARXAAI-REL-CARD-SCHEME>
            <ARXAAI-CUST-SEL-DUE-DAY>00</ARXAAI-CUST-SEL-DUE-DAY>
            <ARXAAI-BILLING-CYCLE>{ data($createFinancingAccountRequest/ns1:AccountCycle) }</ARXAAI-BILLING-CYCLE>
            <ARXAAI-STATEMENT-FLAG>{ data($createFinancingAccountRequest/ns1:StatementIndicator) }</ARXAAI-STATEMENT-FLAG>
            <ARXAAI-STATEMENT-FREQ>01</ARXAAI-STATEMENT-FREQ>
            <ARXAAI-BLOCK-CODE-1>{ xf:stringEmpty() }</ARXAAI-BLOCK-CODE-1>
            <ARXAAI-BLOCK-CODE-2>{ xf:stringEmpty() }</ARXAAI-BLOCK-CODE-2>
            <ARXAAI-OWNER-CODE>{ xf:stringEmpty() }</ARXAAI-OWNER-CODE>
            <ARXAAI-EMPLOYEE-CODE>{ xf:stringEmpty() }</ARXAAI-EMPLOYEE-CODE>
            <ARXAAI-CUST-STMT-FLAG>1</ARXAAI-CUST-STMT-FLAG>
            <ARXAAI-CUST-LTR-FLAG>0</ARXAAI-CUST-LTR-FLAG>
            <ARXAAI-INCOME>{ data($createFinancingAccountRequest/ns1:CustomerIncomeAmount) }</ARXAAI-INCOME>
            <ARXAAI-DATE-CARD-EXPR>{ data($createFinancingAccountRequest/ns1:CardExpDate) }</ARXAAI-DATE-CARD-EXPR>
            <ARXAAI-LETTER-REQ>{ xf:stringEmpty() }</ARXAAI-LETTER-REQ>
            <ARXAAI-LIABILITY-INDICATOR>0</ARXAAI-LIABILITY-INDICATOR>
            <ARXAAI-CORRES-CUST-NBR>{ xf:stringEmpty() }</ARXAAI-CORRES-CUST-NBR>
            <ARXAAI-CB-CR-SCORE>0</ARXAAI-CB-CR-SCORE>
            <ARXAAI-APPL-CR-SCORE>0</ARXAAI-APPL-CR-SCORE>
            <ARXAAI-MISC-CR-SCORE>0</ARXAAI-MISC-CR-SCORE>
            <ARXAAI-TERM-COND>0</ARXAAI-TERM-COND>
            {
                for $openingDate in $createFinancingAccountRequest/ns1:OpeningDate
                return
                    <ARXAAI-TERM-COND-DATE>{ data($openingDate) }</ARXAAI-TERM-COND-DATE>
            }
            <ARXAAI-WARN-CODE-6>0</ARXAAI-WARN-CODE-6>
            <ARXAAI-AUTH-CRITERIA-TABLE>AAA</ARXAAI-AUTH-CRITERIA-TABLE>
            <ARXAAI-SPND-LIMIT-TBL>{ xf:stringEmpty() }</ARXAAI-SPND-LIMIT-TBL>
            <ARXAAI-ASSOC-NBR-OCCURS>0</ARXAAI-ASSOC-NBR-OCCURS>
            <ARXAAI-ASSOC-ARRAY>
                <ARXAAI-ASSOC-ELEMENT>
                    <ARXAAI-ASSOC-TYPE>0</ARXAAI-ASSOC-TYPE>
                    <ARXAAI-ASSOC-ACCT-NO>{ xf:stringEmpty() }</ARXAAI-ASSOC-ACCT-NO>
                    <ARXAAI-ASSOC-REL-TYPE>0</ARXAAI-ASSOC-REL-TYPE>
                    <ARXAAI-ASSOC-AMT>0</ARXAAI-ASSOC-AMT>
                </ARXAAI-ASSOC-ELEMENT>
            </ARXAAI-ASSOC-ARRAY>
            <ARXAAI-ASSOC-STMT-FLAG-1>0</ARXAAI-ASSOC-STMT-FLAG-1>
            <ARXAAI-ASSOC-LTR-FLAG-1>0</ARXAAI-ASSOC-LTR-FLAG-1>
            <ARXAAI-ASSOC-STMT-FLAG-2>0</ARXAAI-ASSOC-STMT-FLAG-2>
            <ARXAAI-ASSOC-LTR-FLAG-2>0</ARXAAI-ASSOC-LTR-FLAG-2>
            <ARXAAI-ASSOC-STMT-FLAG-3>0</ARXAAI-ASSOC-STMT-FLAG-3>
            <ARXAAI-ASSOC-LTR-FLAG-3>0</ARXAAI-ASSOC-LTR-FLAG-3>
            <ARXAAI-ASSOC-LTR-FEE-1>0</ARXAAI-ASSOC-LTR-FEE-1>
            <ARXAAI-ASSOC-LTR-FEE-2>0</ARXAAI-ASSOC-LTR-FEE-2>
            <ARXAAI-ASSOC-LTR-FEE-3>0</ARXAAI-ASSOC-LTR-FEE-3>
            <ARXAAI-STATE-OF-RESID>{ xs:int(data($createFinancingAccountRequest/ns1:PctStateOfResidence)) }</ARXAAI-STATE-OF-RESID>
            <ARXAAI-STATE-OF-ISSUE>{ data($createFinancingAccountRequest/ns1:PctStateOfIssue) }</ARXAAI-STATE-OF-ISSUE>
            <ARXAAI-PCT-CTL-ID>{ xs:string(data($createFinancingAccountRequest/ns1:PctCode)) }</ARXAAI-PCT-CTL-ID>
            {
            	let $pctCode := string($createFinancingAccountRequest/ns1:PctCode/text())
            	return
            	if(string($pctCode) != "")then(
            		<ARXAAI-PCT-LEVEL>O</ARXAAI-PCT-LEVEL>
            	)else(
            		<ARXAAI-PCT-LEVEL>{ fn:string('') }</ARXAAI-PCT-LEVEL>
            	)
            }
            <ARXAAI-OWN-REL-FLAG>0</ARXAAI-OWN-REL-FLAG>
            <ARXAAI-OFFICER-CODE>{ xf:stringEmpty() }</ARXAAI-OFFICER-CODE>
            <ARXAAI-PMT-SKIP-FLAG>Z</ARXAAI-PMT-SKIP-FLAG>
            <ARXAAI-FS-FLAG>{ data($createFinancingAccountRequest/ns1:AccumulationIndicator) }</ARXAAI-FS-FLAG>
            <ARXAAI-FRAUD-REPORTING-FLAG>Y</ARXAAI-FRAUD-REPORTING-FLAG>
            <ARXAAI-WAIVE-CASH-AVAIL-CR>{ data($createFinancingAccountRequest/ns1:WithdrawalIndicator) }</ARXAAI-WAIVE-CASH-AVAIL-CR>
            <ARXAAI-PREPAY-ALLOWED>0</ARXAAI-PREPAY-ALLOWED>
            <ARXAAI-PREPAY-MONTHS>0</ARXAAI-PREPAY-MONTHS>
            <ARXAAI-PREPAY-ZERO>0</ARXAAI-PREPAY-ZERO>
            <ARXAAI-LOAN-LIMIT>Y</ARXAAI-LOAN-LIMIT>
            <ARXAAI-INT-VAR-OCCURS>0</ARXAAI-INT-VAR-OCCURS>
            <ARXAAI-INT-VAR-ARRAY>
                <ARXAAI-INT-VAR>0</ARXAAI-INT-VAR>
            </ARXAAI-INT-VAR-ARRAY>
            <ARXAAI-CASH-PLAN-NBR>{ data($createFinancingAccountRequest/ns1:CashPlanNumber) }</ARXAAI-CASH-PLAN-NBR>
            <ARXAAI-RETAIL-PLAN-NBR>{ data($createFinancingAccountRequest/ns1:PurchasePlanCode) }</ARXAAI-RETAIL-PLAN-NBR>
            <ARXAAI-PROMO-PLAN-NBR>{ data($createFinancingAccountRequest/ns1:PromoPlanNumber) }</ARXAAI-PROMO-PLAN-NBR>
            <ARXAAI-DISC-CYCLE-IND>0</ARXAAI-DISC-CYCLE-IND>
            <ARXAAI-PLAN-PMT-OVRD-FLAG>{ xf:stringEmpty() }</ARXAAI-PLAN-PMT-OVRD-FLAG>
            <ARXAAI-FIXED-PMT-AMT-PCT>0</ARXAAI-FIXED-PMT-AMT-PCT>
            <ARXAAI-1098-FLAG>0</ARXAAI-1098-FLAG>
            <ARXAAI-CB-SPEC-COMMENT>{ xf:stringEmpty() }</ARXAAI-CB-SPEC-COMMENT>
            <ARXAAI-PMT-HOLD>0</ARXAAI-PMT-HOLD>
            <ARXAAI-INCL-ACCT-UPDTR-SW>0</ARXAAI-INCL-ACCT-UPDTR-SW>
            <ARXAAI-DDA-RTNG-NBR>0</ARXAAI-DDA-RTNG-NBR>
            <ARXAAI-DDA-ACCT-NBR>{ xf:stringEmpty() }</ARXAAI-DDA-ACCT-NBR>
            <ARXAAI-SAV-RTNG-NBR>0</ARXAAI-SAV-RTNG-NBR>
            <ARXAAI-SAV-ACCT-NBR>{ xf:stringEmpty() }</ARXAAI-SAV-ACCT-NBR>
            <ARXAAI-USR-ACCT-NBR>{ xf:stringEmpty() }</ARXAAI-USR-ACCT-NBR>
            <ARXAAI-CARD-TECHNOLOGY>{ data($createFinancingAccountRequest/ns1:CardTechnology) }</ARXAAI-CARD-TECHNOLOGY>
            <ARXAAI-TEMP-CRLIM>0</ARXAAI-TEMP-CRLIM>
            <ARXAAI-ON-DEMAND-DC-TYPE>D</ARXAAI-ON-DEMAND-DC-TYPE>
            <ARXAAI-ON-DEMAND-ACH-DC-NBR>{ xf:stringEmpty() }</ARXAAI-ON-DEMAND-ACH-DC-NBR>
            <ARXAAI-ON-DEMAND-DC-IBAN>{ xf:stringEmpty() }</ARXAAI-ON-DEMAND-DC-IBAN>
            <ARXAAI-DD-IBAN>{ xf:stringEmpty() }</ARXAAI-DD-IBAN>
            <ARXAAI-DC-IBAN>{ xf:stringEmpty() }</ARXAAI-DC-IBAN>
            <ARXAAI-PREFER-MIN-AMT>0</ARXAAI-PREFER-MIN-AMT>
            <ARXAAI-PREFER-INT-DAYS>0</ARXAAI-PREFER-INT-DAYS>
            <ARXAAI-SWEEP-ACCT-NBR>{ xf:stringEmpty() }</ARXAAI-SWEEP-ACCT-NBR>
            <ARXAAI-SWEEP-ACCT-IND>0</ARXAAI-SWEEP-ACCT-IND>
            <ARXAAI-DD-INTERIM-PMTS>0</ARXAAI-DD-INTERIM-PMTS>
            <ARXAAI-PAY-REMIT-METHOD>0</ARXAAI-PAY-REMIT-METHOD>
            <ARXAAI-DD-DAILY-FREQ>0</ARXAAI-DD-DAILY-FREQ>
            <ARXAAI-DD-CREDIT-BAL>0</ARXAAI-DD-CREDIT-BAL>
            <ARXAAI-DC-ACH-PLAN>0</ARXAAI-DC-ACH-PLAN>
            <ARXAAI-PMT-ACH-RT-NBR>0</ARXAAI-PMT-ACH-RT-NBR>
            <ARXAAI-PMT-ACH-DB-TYPE>D</ARXAAI-PMT-ACH-DB-TYPE>
            <ARXAAI-PMT-ACH-DB-NBR>{ xf:stringEmpty() }</ARXAAI-PMT-ACH-DB-NBR>
            <ARXAAI-DD-ACH-REQ-DAY>0</ARXAAI-DD-ACH-REQ-DAY>
            <ARXAAI-PMT-DC-ACH-DB-TYPE>S</ARXAAI-PMT-DC-ACH-DB-TYPE>
            <ARXAAI-PMT-DC-ACH-DB-NBR>{ xf:stringEmpty() }</ARXAAI-PMT-DC-ACH-DB-NBR>
            <ARXAAI-DC-ACH-REQ-DAY-IND>0</ARXAAI-DC-ACH-REQ-DAY-IND>
            <ARXAAI-DC-ACH-REQ-DAY>0</ARXAAI-DC-ACH-REQ-DAY>
            <ARXAAI-PMT-ACH-FLAG>0</ARXAAI-PMT-ACH-FLAG>
            <ARXAAI-DC-ACH-AMT>0</ARXAAI-DC-ACH-AMT>
            <ARXAAI-MAX-ACH-AMT>0</ARXAAI-MAX-ACH-AMT>
            <ARXAAI-NOM-ACH-AMT-PCT-FLAG>0</ARXAAI-NOM-ACH-AMT-PCT-FLAG>
            <ARXAAI-NOM-ACH-PCT-AMT>0</ARXAAI-NOM-ACH-PCT-AMT>
            <ARXAAI-SUPP-LTR>0</ARXAAI-SUPP-LTR>
            <ARXAAI-LTR-HOLD>{ xf:stringEmpty() }</ARXAAI-LTR-HOLD>
            <ARXAAI-USER-MSG1-IND>0</ARXAAI-USER-MSG1-IND>
            <ARXAAI-USER-MSG2-IND>0</ARXAAI-USER-MSG2-IND>
            <ARXAAI-USER-MSG3-IND>0</ARXAAI-USER-MSG3-IND>
            <ARXAAI-RPT-LEVEL-ARRAY>
                <ARXAAI-RPT-LEVEL>{ xf:stringEmpty() }</ARXAAI-RPT-LEVEL>
            </ARXAAI-RPT-LEVEL-ARRAY>
            <ARXAAI-PROMO-NBR-OCCURS>0</ARXAAI-PROMO-NBR-OCCURS>
            <ARXAAI-PROMO-ARRAY>
                <ARXAAI-PROMO-ELEMENT>
                    <ARXAAI-PROMO>{ xf:stringEmpty() }</ARXAAI-PROMO>
                    <ARXAAI-PROMO-STATUS>0</ARXAAI-PROMO-STATUS>
                </ARXAAI-PROMO-ELEMENT>
            </ARXAAI-PROMO-ARRAY>
            <ARXAAI-AUTH-LIMIT-OVRRD-FLAG>{ data($createFinancingAccountRequest/ns1:AuthLimitOvrrdInd) }</ARXAAI-AUTH-LIMIT-OVRRD-FLAG>
            <ARXAAI-OWNING-BRANCH-NBR>{ xs:int(data($createFinancingAccountRequest/ns1:Branch)) }</ARXAAI-OWNING-BRANCH-NBR>
            <ARXAAI-USER-CODE-1>{ fn:string($createFinancingAccountRequest/ns1:UserCode[ns1:Ind=1]/ns1:Value/text()) }</ARXAAI-USER-CODE-1>
            <ARXAAI-USER-CODE-2>{ fn:string($createFinancingAccountRequest/ns1:UserCode[ns1:Ind=2]/ns1:Value/text()) }</ARXAAI-USER-CODE-2>
            <ARXAAI-USER-CODE-3>{ fn:string($createFinancingAccountRequest/ns1:UserCode[ns1:Ind=3]/ns1:Value/text()) }</ARXAAI-USER-CODE-3>
            <ARXAAI-USER-CODE-4>{ fn:string($createFinancingAccountRequest/ns1:UserCode[ns1:Ind=4]/ns1:Value/text()) }</ARXAAI-USER-CODE-4>
            <ARXAAI-USER-CODE-5>{ fn:string($createFinancingAccountRequest/ns1:UserCode[ns1:Ind=5]/ns1:Value/text()) }</ARXAAI-USER-CODE-5>
            <ARXAAI-USER-CODE-6>{ fn:string($createFinancingAccountRequest/ns1:UserCode[ns1:Ind=6]/ns1:Value/text()) }</ARXAAI-USER-CODE-6>
            <ARXAAI-USER-CODE-7>{ fn:string($createFinancingAccountRequest/ns1:UserCode[ns1:Ind=7]/ns1:Value/text()) }</ARXAAI-USER-CODE-7>
            <ARXAAI-USER-CODE-8>{ fn:string($createFinancingAccountRequest/ns1:UserCode[ns1:Ind=8]/ns1:Value/text()) }</ARXAAI-USER-CODE-8>
            <ARXAAI-USER-CODE-9>{ fn:string($createFinancingAccountRequest/ns1:UserCode[ns1:Ind=9]/ns1:Value/text()) }</ARXAAI-USER-CODE-9>
            <ARXAAI-USER-CODE-10>{ fn:string($createFinancingAccountRequest/ns1:UserCode[ns1:Ind=10]/ns1:Value/text()) }</ARXAAI-USER-CODE-10>
            <ARXAAI-USER-CODE-11>{ fn:string($createFinancingAccountRequest/ns1:UserCode[ns1:Ind=11]/ns1:Value/text()) }</ARXAAI-USER-CODE-11>
            <ARXAAI-USER-CODE-12>{ fn:string($createFinancingAccountRequest/ns1:UserCode[ns1:Ind=12]/ns1:Value/text()) }</ARXAAI-USER-CODE-12>
            <ARXAAI-USER-CODE-13>{ fn:string($createFinancingAccountRequest/ns1:UserCode[ns1:Ind=13]/ns1:Value/text()) }</ARXAAI-USER-CODE-13>
            <ARXAAI-USER-CODE-14>{ fn:string($createFinancingAccountRequest/ns1:UserCode[ns1:Ind=14]/ns1:Value/text()) }</ARXAAI-USER-CODE-14>
             
            {
                for $userDate in $createFinancingAccountRequest/ns1:UserDate[ns1:Ind=1]/ns1:Value
                return
                    <ARXAAI-USER-DATE-1>{ data($userDate) }</ARXAAI-USER-DATE-1>
            }
            
            {
                for $userDate in $createFinancingAccountRequest/ns1:UserDate[ns1:Ind=2]/ns1:Value
                return
                    <ARXAAI-USER-DATE-2>{ data($userDate) }</ARXAAI-USER-DATE-2>
            }
            
            {
                for $userDate in $createFinancingAccountRequest/ns1:UserDate[ns1:Ind=3]/ns1:Value
                return
                    <ARXAAI-USER-DATE-3>{ data($userDate) }</ARXAAI-USER-DATE-3>
            }
            
            {
                for $userDate in $createFinancingAccountRequest/ns1:UserDate[ns1:Ind=4]/ns1:Value
                return
                    <ARXAAI-USER-DATE-4>{ data($userDate) }</ARXAAI-USER-DATE-4>
            }
            
            {
                for $userDate in $createFinancingAccountRequest/ns1:UserDate[ns1:Ind=5]/ns1:Value
                return
                    <ARXAAI-USER-DATE-5>{ data($userDate) }</ARXAAI-USER-DATE-5>
            }
            
            {
                for $userDate in $createFinancingAccountRequest/ns1:UserDate[ns1:Ind=6]/ns1:Value
                return
                    <ARXAAI-USER-DATE-6>{ data($userDate) }</ARXAAI-USER-DATE-6>
            }
            
            {
                for $userDate in $createFinancingAccountRequest/ns1:UserDate[ns1:Ind=7]/ns1:Value
                return
                    <ARXAAI-USER-DATE-7>{ data($userDate) }</ARXAAI-USER-DATE-7>
            }
            
            {
                for $userDate in $createFinancingAccountRequest/ns1:UserDate[ns1:Ind=8]/ns1:Value
                return
                    <ARXAAI-USER-DATE-8>{ data($userDate) }</ARXAAI-USER-DATE-8>
            }
            
            {
                for $userDate in $createFinancingAccountRequest/ns1:UserDate[ns1:Ind=9]/ns1:Value
                return
                    <ARXAAI-USER-DATE-9>{ data($userDate) }</ARXAAI-USER-DATE-9>
            }
            
            {
                for $userDate in $createFinancingAccountRequest/ns1:UserDate[ns1:Ind=10]/ns1:Value
                return
                    <ARXAAI-USER-DATE-10>{ data($userDate) }</ARXAAI-USER-DATE-10>
            }
            
            {
                for $userDate in $createFinancingAccountRequest/ns1:UserDate[ns1:Ind=11]/ns1:Value
                return
                    <ARXAAI-USER-DATE-11>{ data($userDate) }</ARXAAI-USER-DATE-11>
            }
            
            {
                for $userDate in $createFinancingAccountRequest/ns1:UserDate[ns1:Ind=12]/ns1:Value
                return
                    <ARXAAI-USER-DATE-12>{ data($userDate) }</ARXAAI-USER-DATE-12>
            }
            
            {
                for $userDate in $createFinancingAccountRequest/ns1:UserDate[ns1:Ind=13]/ns1:Value
                return
                    <ARXAAI-USER-DATE-13>{ data($userDate) }</ARXAAI-USER-DATE-13>
            }
            
            {
                for $userDate in $createFinancingAccountRequest/ns1:UserDate[ns1:Ind=14]/ns1:Value
                return
                    <ARXAAI-USER-DATE-14>{ data($userDate) }</ARXAAI-USER-DATE-14>
            }
            
            
            <ARXAAI-USER-AMT-1>{ xf:nvl($createFinancingAccountRequest/ns1:UserAmount[ns1:Ind=1]/ns1:Value, 0) }</ARXAAI-USER-AMT-1>
            <ARXAAI-USER-AMT-2>{ xf:nvl($createFinancingAccountRequest/ns1:UserAmount[ns1:Ind=2]/ns1:Value, 0) }</ARXAAI-USER-AMT-2>
            <ARXAAI-USER-AMT-3>{ xf:nvl($createFinancingAccountRequest/ns1:UserAmount[ns1:Ind=3]/ns1:Value, 0) }</ARXAAI-USER-AMT-3>
            <ARXAAI-USER-AMT-4>{ xf:nvl($createFinancingAccountRequest/ns1:UserAmount[ns1:Ind=4]/ns1:Value, 0) }</ARXAAI-USER-AMT-4>
            <ARXAAI-USER-AMT-5>{ xf:nvl($createFinancingAccountRequest/ns1:UserAmount[ns1:Ind=5]/ns1:Value, 0) }</ARXAAI-USER-AMT-5>
            <ARXAAI-USER-AMT-6>{ xf:nvl($createFinancingAccountRequest/ns1:UserAmount[ns1:Ind=6]/ns1:Value, 0) }</ARXAAI-USER-AMT-6>
            <ARXAAI-USER-AMT-7>{ xf:nvl($createFinancingAccountRequest/ns1:UserAmount[ns1:Ind=7]/ns1:Value, 0) }</ARXAAI-USER-AMT-7>
            <ARXAAI-USER-AMT-8>{ xf:nvl($createFinancingAccountRequest/ns1:UserAmount[ns1:Ind=8]/ns1:Value, 0) }</ARXAAI-USER-AMT-8>
            <ARXAAI-USER-AMT-9>{ xf:nvl($createFinancingAccountRequest/ns1:UserAmount[ns1:Ind=9]/ns1:Value, 0) }</ARXAAI-USER-AMT-9>
            <ARXAAI-USER-AMT-10>{ xf:nvl($createFinancingAccountRequest/ns1:UserAmount[ns1:Ind=10]/ns1:Value, 0) }</ARXAAI-USER-AMT-10>
            <ARXAAI-USER-AMT-11>{ xf:nvl($createFinancingAccountRequest/ns1:UserAmount[ns1:Ind=11]/ns1:Value, 0) }</ARXAAI-USER-AMT-11>
            <ARXAAI-USER-AMT-12>{ xf:nvl($createFinancingAccountRequest/ns1:UserAmount[ns1:Ind=12]/ns1:Value, 0) }</ARXAAI-USER-AMT-12>
            <ARXAAI-USER-AMT-13>{ xf:nvl($createFinancingAccountRequest/ns1:UserAmount[ns1:Ind=13]/ns1:Value, 0) }</ARXAAI-USER-AMT-13>
            <ARXAAI-USER-AMT-14>{ xf:nvl($createFinancingAccountRequest/ns1:UserAmount[ns1:Ind=14]/ns1:Value, 0) }</ARXAAI-USER-AMT-14>
            <ARXAAI-SOURCE-CODE>{ xf:stringEmpty() }</ARXAAI-SOURCE-CODE>
            <ARXAAI-APPL-USER-1>{ xf:stringEmpty() }</ARXAAI-APPL-USER-1>
            <ARXAAI-APPL-USER-2>{ xf:stringEmpty() }</ARXAAI-APPL-USER-2>
            <ARXAAI-APPL-USER-3>{ xf:stringEmpty() }</ARXAAI-APPL-USER-3>
            <ARXAAI-MISC-USER-1>{ xf:stringEmpty() }</ARXAAI-MISC-USER-1>
            <ARXAAI-MISC-USER-2>{ xf:stringEmpty() }</ARXAAI-MISC-USER-2>
            <ARXAAI-MISC-USER-3>{ xf:stringEmpty() }</ARXAAI-MISC-USER-3>
            <ARXAAI-MISC-USER-4>{ xf:stringEmpty() }</ARXAAI-MISC-USER-4>
            <ARXAAI-MISC-USER-5>{ xf:stringEmpty() }</ARXAAI-MISC-USER-5>
            <ARXAAI-MISC-USER-6>{ xf:stringEmpty() }</ARXAAI-MISC-USER-6>
            <ARXAAI-MISC-USER-7>{ xf:stringEmpty() }</ARXAAI-MISC-USER-7>
            <ARXAAI-MISC-USER-8>{ xf:stringEmpty() }</ARXAAI-MISC-USER-8>
            <ARXAAI-MISC-USER-9>{ xf:stringEmpty() }</ARXAAI-MISC-USER-9>
            <ARXAAI-MISC-USER-10>{ xf:stringEmpty() }</ARXAAI-MISC-USER-10>
            <ARXAAI-MISC-USER-11>{ xf:stringEmpty() }</ARXAAI-MISC-USER-11>
            <ARXAAI-MISC-USER-12>{ xf:stringEmpty() }</ARXAAI-MISC-USER-12>
            <ARXAAI-WAIVE-INTR-CHG>0</ARXAAI-WAIVE-INTR-CHG>
            <ARXAAI-WAIVE-LATE-CHG>0</ARXAAI-WAIVE-LATE-CHG>
            <ARXAAI-WAIVE-LATE-NOTC>0</ARXAAI-WAIVE-LATE-NOTC>
            <ARXAAI-WAIVE-FEE-CHG>0</ARXAAI-WAIVE-FEE-CHG>
            <ARXAAI-WAIVE-LTR-CHG>0</ARXAAI-WAIVE-LTR-CHG>
            <ARXAAI-WAIVE-OVLM>0</ARXAAI-WAIVE-OVLM>
            <ARXAAI-WAIVE-OVLM-NOTC>0</ARXAAI-WAIVE-OVLM-NOTC>
            <ARXAAI-WAIVE-NSF-FEE-IND>0</ARXAAI-WAIVE-NSF-FEE-IND>
            <ARXAAI-WAIVE-CARD-FEE-IND>0</ARXAAI-WAIVE-CARD-FEE-IND>
            <ARXAAI-WVE-SVC-CHG-OCCUR>0</ARXAAI-WVE-SVC-CHG-OCCUR>
            <ARXAAI-WAIVE-SVC-CHG-ARRAY>
                <ARXAAI-WAIVE-SVC-CHG>0</ARXAAI-WAIVE-SVC-CHG>
            </ARXAAI-WAIVE-SVC-CHG-ARRAY>
            <ARXAAI-WVE-CASH-ADV-FEE-OCCUR>0</ARXAAI-WVE-CASH-ADV-FEE-OCCUR>
            <ARXAAI-WAIVE-CASH-ADV-FEE-ARRAY>
                <ARXAAI-WAIVE-CASH-ADV-FEE>0</ARXAAI-WAIVE-CASH-ADV-FEE>
            </ARXAAI-WAIVE-CASH-ADV-FEE-ARRAY>
            <ARXAAI-WAIVE-USER-FEE-1>0</ARXAAI-WAIVE-USER-FEE-1>
            <ARXAAI-WAIVE-USER-FEE-2>0</ARXAAI-WAIVE-USER-FEE-2>
            <ARXAAI-WAIVE-USER-FEE-3>0</ARXAAI-WAIVE-USER-FEE-3>
            <ARXAAI-WAIVE-USER-FEE-4>0</ARXAAI-WAIVE-USER-FEE-4>
            <ARXAAI-WAIVE-USER-FEE-5>0</ARXAAI-WAIVE-USER-FEE-5>
            <ARXAAI-WAIVE-USER-FEE-6>0</ARXAAI-WAIVE-USER-FEE-6>
            <ARXAAI-WAIVE-MORA-INT>0</ARXAAI-WAIVE-MORA-INT>
            <ARXAAI-WAIVE-DORM-FEE>0</ARXAAI-WAIVE-DORM-FEE>
            <ARXAAI-WAIVE-REFUND-FEE>0</ARXAAI-WAIVE-REFUND-FEE>
            <ARXAAI-WAIVE-STMT-FEE>0</ARXAAI-WAIVE-STMT-FEE>
            <ARXAAI-WAIVE-TXN-FEE-ARRAY>
                <ARXAAI-WAIVE-TXN-FEE>0</ARXAAI-WAIVE-TXN-FEE>
            </ARXAAI-WAIVE-TXN-FEE-ARRAY>
            <ARXAAI-PREPAID-PLAN-NBR>0</ARXAAI-PREPAID-PLAN-NBR>
            <ARXAAI-PREPAID-LOAD-FREQ>0</ARXAAI-PREPAID-LOAD-FREQ>
            <ARXAAI-PREPAID-LOAD-NBR>0</ARXAAI-PREPAID-LOAD-NBR>
            <ARXAAI-PREPAID-LOAD-AMT>0</ARXAAI-PREPAID-LOAD-AMT>
            <ARXAAI-MIN-SNGL-LOAD-AMT>0</ARXAAI-MIN-SNGL-LOAD-AMT>
            <ARXAAI-MAX-SNGL-LOAD-AMT>0</ARXAAI-MAX-SNGL-LOAD-AMT>
            <ARXAAI-IR-PMT-RETL-PLAN>0</ARXAAI-IR-PMT-RETL-PLAN>
            <ARXAAI-IR-PMT-CASH-PLAN>0</ARXAAI-IR-PMT-CASH-PLAN>
            <ARXAAI-INTL-CASH-PLAN>0</ARXAAI-INTL-CASH-PLAN>
            <ARXAAI-INTL-RETAIL-PLAN>0</ARXAAI-INTL-RETAIL-PLAN>
            <ARXAAI-INTL-INST-PLAN>0</ARXAAI-INTL-INST-PLAN>
            {
                for $withdrawalLimit in $createFinancingAccountRequest/ns1:WithdrawalLimit
                return
                    <ARXAAI-IB-ISS-CASH-PLAN>{ xs:int(fn:replace(data($withdrawalLimit),'\.','')) }</ARXAAI-IB-ISS-CASH-PLAN>
            }
            {
                for $installmentPlanCode in $createFinancingAccountRequest/ns1:InstallmentPlanCode
                return
                    <ARXAAI-IB-ISS-RETAIL-PLAN>{ data($installmentPlanCode) }</ARXAAI-IB-ISS-RETAIL-PLAN>
            }
            <ARXAAI-GLOBAL-QUAL>{ xf:stringEmpty() }</ARXAAI-GLOBAL-QUAL>
            <ARXAAI-FEE-MTH-ORIDE>0</ARXAAI-FEE-MTH-ORIDE>
            <ARXAAI-AFFL-EMBLM>0</ARXAAI-AFFL-EMBLM>
            <ARXAAI-IB-RET-CRLMT-FLAG>2</ARXAAI-IB-RET-CRLMT-FLAG>
            <ARXAAI-IB-CASH-CRLMTFLAG>1</ARXAAI-IB-CASH-CRLMTFLAG>
            <AZXAAI-BLACKLST-MARK>{ xf:stringEmpty() }</AZXAAI-BLACKLST-MARK>
            <AZXAAI-IB-CFIN-CRLMT-FLAG>1</AZXAAI-IB-CFIN-CRLMT-FLAG>
            <AZXAAI-IB-CFIN-LIMIT>0</AZXAAI-IB-CFIN-LIMIT>
            <AZXAAI-IB-CFIN-AVAIL>0</AZXAAI-IB-CFIN-AVAIL>
            <AZXAAI-SMS-IND>0</AZXAAI-SMS-IND>
            <AZXAAI-SMS-GROUP>{ xf:stringEmpty() }</AZXAAI-SMS-GROUP>
            <AZXAAI-SMS-GROUP-STATUS>0</AZXAAI-SMS-GROUP-STATUS>
            <AZXAAI-EVENT-FLAGS>0</AZXAAI-EVENT-FLAGS>
            <AZXAAI-EVENT-2-BEF-DAYS>0</AZXAAI-EVENT-2-BEF-DAYS>
            <AZXAAI-EVENT-1-THRESH-AMT>0</AZXAAI-EVENT-1-THRESH-AMT>
            <AZXAAI-EVENT-1-TYPE>0</AZXAAI-EVENT-1-TYPE>
            <AZXAAI-EVENT-3-BAL-THRESH>0</AZXAAI-EVENT-3-BAL-THRESH>
    </ns2:AccountAddRequest>
};

local:func($createFinancingAccountRequest)
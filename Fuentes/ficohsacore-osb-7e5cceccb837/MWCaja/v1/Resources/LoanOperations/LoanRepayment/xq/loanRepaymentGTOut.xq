(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns0:OutputParameters" location="../../../../BusinessServices/AbanksGT/PagoPrestamo/xsd/MCPagoPrestamo_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns2:loanRepaymentResponse" location="../../xsd/LoanOperationsTypes.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/MCPagoPrestamo";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/loanOperationsTypes";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/generalTypes";
declare namespace xf = "http://tempuri.org/MWCaja/v1/Resources/LoanOperations/LoanRepayment/xq/loanRepaymentGTOut/";
declare namespace ns3 = "http://www.ficohsa.com.hn/middleware.services/loanTypes";

declare function xf:loanRepaymentGTOut($outputParameters as element(ns0:OutputParameters))
    as element(ns2:loanRepaymentResponse) {
        <ns2:loanRepaymentResponse>
            {
                for $PR_PAYMENT_DETAILS in $outputParameters/ns0:PR_PAYMENT_DETAILS
                return
                    <ns2:PAYMENT_DETAILS>
                        <ns3:LOAN_NUMBER>{ xs:string(data($PR_PAYMENT_DETAILS/ns0:LOAN_NUMBER)) }</ns3:LOAN_NUMBER>
                        <ns3:NAME>{ data($PR_PAYMENT_DETAILS/ns0:NAME) }</ns3:NAME>
                        <ns3:INSTALLMENTS>{ data($PR_PAYMENT_DETAILS/ns0:INSTALLMENTS) }</ns3:INSTALLMENTS>
                        <ns3:INTEREST_RATE>{ data($PR_PAYMENT_DETAILS/ns0:INTEREST_RATE) }</ns3:INTEREST_RATE>
                        <ns3:INITIAL_DATE>{ data($PR_PAYMENT_DETAILS/ns0:INITIAL_DATE) }</ns3:INITIAL_DATE>
                        <ns3:MATURITY_DATE>{ data($PR_PAYMENT_DETAILS/ns0:MATURITY_DATE) }</ns3:MATURITY_DATE>
                        <ns3:PREVIOUS_PRINCIPAL>{ data($PR_PAYMENT_DETAILS/ns0:PREVIOUS_PRINCIPAL) }</ns3:PREVIOUS_PRINCIPAL>
                        <ns3:CURRENT_PRINCIPAL>{ data($PR_PAYMENT_DETAILS/ns0:CURRENT_PRINCIPAL) }</ns3:CURRENT_PRINCIPAL>
                        {
                            let $BALANCE := $PR_PAYMENT_DETAILS/ns0:BALANCE
                            return
                                <ns3:BALANCES>
                                    {
                                        for $BALANCE_ITEM in $BALANCE/ns0:BALANCE_ITEM
                                        return
                                            <ns3:BALANCE>
                                                <ns3:TYPE>{ data($BALANCE_ITEM/ns0:TYPE) }</ns3:TYPE>
                                                <ns3:DESCRIPTION>{ data($BALANCE_ITEM/ns0:DESCRIPTION) }</ns3:DESCRIPTION>
                                                <ns3:AMOUNT>{ data($BALANCE_ITEM/ns0:AMOUNT) }</ns3:AMOUNT>
                                            </ns3:BALANCE>
                                    }
                                </ns3:BALANCES>
                        }
                        <ns3:TOTAL_AMOUNT>{ data($PR_PAYMENT_DETAILS/ns0:TOTAL_AMOUNT) }</ns3:TOTAL_AMOUNT>
                    </ns2:PAYMENT_DETAILS>
            }
            {
                for $PR_TRANSACTION_INFO in $outputParameters/ns0:PR_TRANSACTION_INFO
                return
                	if( empty($PR_TRANSACTION_INFO/*) )then(
                	
                	)else(
		                <ns2:TRANSACTION_INFO>
		                    {
		                        for $DEALSLIP in $PR_TRANSACTION_INFO/ns0:DEALSLIP
		                        return
		                            <ns1:DEALSLIP>
		                                {
		                                    for $DS_RECORD_ITEM in $DEALSLIP/ns0:DS_RECORD/ns0:DS_RECORD_ITEM
		                                    return
		                                        <ns1:DS_RECORD>{ data($DS_RECORD_ITEM) }</ns1:DS_RECORD>
		                                }
		                            </ns1:DEALSLIP>
		                    }
		                    <ns1:TXN_REF_ID>{ xs:integer(data($PR_TRANSACTION_INFO/ns0:TXN_REF_ID)) }</ns1:TXN_REF_ID>
		                    <ns1:TXN_TYPE_ID>{ xs:integer(data($PR_TRANSACTION_INFO/ns0:TXN_TYPE_ID)) }</ns1:TXN_TYPE_ID>
		                    <ns1:TXN_DATE>{ data($PR_TRANSACTION_INFO/ns0:TXN_DATE) }</ns1:TXN_DATE>
		                    <ns1:CURRENCY>{ data($PR_TRANSACTION_INFO/ns0:CURRENCY) }</ns1:CURRENCY>
		                    <ns1:AMOUNT>{ data($PR_TRANSACTION_INFO/ns0:AMOUNT) }</ns1:AMOUNT>
		                    <ns1:DATE_TIME>{ data($PR_TRANSACTION_INFO/ns0:DATE_TIME) }</ns1:DATE_TIME>
		                    <ns1:USER>{ data($PR_TRANSACTION_INFO/ns0:USER_TX) }</ns1:USER>
		                    <ns1:BRANCH_ID>{ xs:integer(data($PR_TRANSACTION_INFO/ns0:BRANCH_ID)) }</ns1:BRANCH_ID>
		                    <ns1:BRANCH_NAME>{ data($PR_TRANSACTION_INFO/ns0:BRANCH_NAME) }</ns1:BRANCH_NAME>
		                    <ns1:REQUIRES_CTR>{ data($PR_TRANSACTION_INFO/ns0:REQUIRES_CTR) }</ns1:REQUIRES_CTR>
		                    {
		                        for $DEALSLIP_URL in $PR_TRANSACTION_INFO/ns0:DEALSLIP_URL
		                        return
		                            <ns1:DEALSLIP_URL>{ data($DEALSLIP_URL) }</ns1:DEALSLIP_URL>
		                    }
		                </ns2:TRANSACTION_INFO>
		              )
            }
        </ns2:loanRepaymentResponse>
};

declare variable $outputParameters as element(ns0:OutputParameters) external;

xf:loanRepaymentGTOut($outputParameters)

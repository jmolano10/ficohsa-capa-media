(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns2:OutputParameters" location="../../../../BusinessServices/AbanksGT/RetiroCuenta/xsd/MCRetiroCuenta_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns1:accountWithdrawalResponse" location="../../xsd/AccountOperationsTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/generalTypes";
declare namespace ns2 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/MCRetiroCuenta";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/AccountOperationsTypes";
declare namespace xf = "http://tempuri.org/MWCaja/v1/Resources/AccountOperations/AccountWithdrawal/xq/accountWithdrawalGTOut/";

declare function xf:accountWithdrawalGTOut($outputParameters as element(ns2:OutputParameters))
    as element(ns1:accountWithdrawalResponse) {
        <ns1:accountWithdrawalResponse>
            {
                for $PV_ACCOUNT_NUMBER in $outputParameters/ns2:PV_ACCOUNT_NUMBER
                return
                    <ns1:ACCOUNT_NUMBER>{ data($PV_ACCOUNT_NUMBER) }</ns1:ACCOUNT_NUMBER>
            }
            {
                for $PV_ACCOUNT_NAME in $outputParameters/ns2:PV_ACCOUNT_NAME
                return
                    <ns1:ACCOUNT_NAME>{ data($PV_ACCOUNT_NAME) }</ns1:ACCOUNT_NAME>
            }
            {
                for $PV_DEBIT_CURRENCY in $outputParameters/ns2:PV_DEBIT_CURRENCY
                return
                    <ns1:DEBIT_CURRENCY>{ data($PV_DEBIT_CURRENCY) }</ns1:DEBIT_CURRENCY>
            }
            {
                for $PV_DEBIT_AMOUNT in $outputParameters/ns2:PV_DEBIT_AMOUNT
                return
                    <ns1:DEBIT_AMOUNT>{ xs:decimal(data($PV_DEBIT_AMOUNT)) }</ns1:DEBIT_AMOUNT>
            }
            {
                for $PV_WITHDRAWAL_CURRENCY in $outputParameters/ns2:PV_WITHDRAWAL_CURRENCY
                return
                    <ns1:WITHDRAWAL_CURRENCY>{ data($PV_WITHDRAWAL_CURRENCY) }</ns1:WITHDRAWAL_CURRENCY>
            }
            {
                for $PN_WITHDRAWAL_AMOUNT in $outputParameters/ns2:PN_WITHDRAWAL_AMOUNT
                return
                    <ns1:WITHDRAWAL_AMOUNT>{ data($PN_WITHDRAWAL_AMOUNT) }</ns1:WITHDRAWAL_AMOUNT>
            }
            {
                for $PR_PASSBOOK_RECORDS in $outputParameters/ns2:PR_PASSBOOK_RECORDS
                return
                    <ns1:PASSBOOK_RECORDS>
                        {
                            for $PRINTABLE_RECORD_ITEM in $PR_PASSBOOK_RECORDS/ns2:PRINTABLE_RECORD/ns2:PRINTABLE_RECORD_ITEM
                            return
                            	if( empty($PRINTABLE_RECORD_ITEM/*) )then(
                            	
                            	)else(
                            		<ns1:PASSBOOK_RECORD>
	                                    <ns1:ID>{ xs:integer(data($PRINTABLE_RECORD_ITEM/ns2:ID)) }</ns1:ID>
	                                    <ns1:RECORD>{ data($PRINTABLE_RECORD_ITEM/ns2:RECORD) }</ns1:RECORD>
                                	</ns1:PASSBOOK_RECORD>
                            	)
                                
                        }
                    </ns1:PASSBOOK_RECORDS>
            }
            {
                for $PR_TRANSACTION_INFO in $outputParameters/ns2:PR_TRANSACTION_INFO
                return
                	if( empty($PR_TRANSACTION_INFO/*) )then(
                	
                	)else(
                		<ns1:TRANSACTION_INFO>
	                        {
	                            for $DEALSLIP in $PR_TRANSACTION_INFO/ns2:DEALSLIP
	                            return
	                                <ns0:DEALSLIP>
	                                    {
	                                        for $DS_RECORD_ITEM in $DEALSLIP/ns2:DS_RECORD/ns2:DS_RECORD_ITEM
	                                        return
	                                            <ns0:DS_RECORD>{ data($DS_RECORD_ITEM) }</ns0:DS_RECORD>
	                                    }
	                                </ns0:DEALSLIP>
	                        }
	                        <ns0:TXN_REF_ID>{ xs:integer(data($PR_TRANSACTION_INFO/ns2:TXN_REF_ID)) }</ns0:TXN_REF_ID>
	                        <ns0:TXN_TYPE_ID>{ xs:integer(data($PR_TRANSACTION_INFO/ns2:TXN_TYPE_ID)) }</ns0:TXN_TYPE_ID>
	                        <ns0:TXN_DATE>{ data($PR_TRANSACTION_INFO/ns2:TXN_DATE) }</ns0:TXN_DATE>
	                        <ns0:CURRENCY>{ data($PR_TRANSACTION_INFO/ns2:CURRENCY) }</ns0:CURRENCY>
	                        <ns0:AMOUNT>{ data($PR_TRANSACTION_INFO/ns2:AMOUNT) }</ns0:AMOUNT>
	                        <ns0:DATE_TIME>{ data($PR_TRANSACTION_INFO/ns2:DATE_TIME) }</ns0:DATE_TIME>
	                        <ns0:USER>{ data($PR_TRANSACTION_INFO/ns2:USER_TX) }</ns0:USER>
	                        <ns0:BRANCH_ID>{ xs:integer(data($PR_TRANSACTION_INFO/ns2:BRANCH_ID)) }</ns0:BRANCH_ID>
	                        <ns0:BRANCH_NAME>{ data($PR_TRANSACTION_INFO/ns2:BRANCH_NAME) }</ns0:BRANCH_NAME>
	                        <ns0:REQUIRES_CTR>{ data($PR_TRANSACTION_INFO/ns2:REQUIRES_CTR) }</ns0:REQUIRES_CTR>
	                        {
	                            for $DEALSLIP_URL in $PR_TRANSACTION_INFO/ns2:DEALSLIP_URL
	                            return
	                                <ns0:DEALSLIP_URL>{ data($DEALSLIP_URL) }</ns0:DEALSLIP_URL>
	                        }
                    	</ns1:TRANSACTION_INFO>
                	)
                    
            }
        </ns1:accountWithdrawalResponse>
};

declare variable $outputParameters as element(ns2:OutputParameters) external;

xf:accountWithdrawalGTOut($outputParameters)

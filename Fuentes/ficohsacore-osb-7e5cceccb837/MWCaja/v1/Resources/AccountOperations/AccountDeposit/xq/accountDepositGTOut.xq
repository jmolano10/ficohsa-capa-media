(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns2:OutputParameters" location="../../../../BusinessServices/AbanksGT/DepositoCuenta/xsd/MCDepositoCuenta_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns1:accountDepositResponse" location="../../xsd/AccountOperationsTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/generalTypes";
declare namespace ns2 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/MCDepositoCuenta";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/AccountOperationsTypes";
declare namespace xf = "http://tempuri.org/MWCaja/v1/Resources/AccountOperations/AccountDeposit/xq/accountDepositGTOut/";

declare function xf:accountDepositGTOut($outputParameters as element(ns2:OutputParameters))
    as element(ns1:accountDepositResponse) {
        <ns1:accountDepositResponse>
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
                for $PV_CREDIT_CURRENCY in $outputParameters/ns2:PV_CREDIT_CURRENCY
                return
                    <ns1:CREDIT_CURRENCY>{ data($PV_CREDIT_CURRENCY) }</ns1:CREDIT_CURRENCY>
            }
            {
                for $PV_CREDIT_AMOUNT in $outputParameters/ns2:PV_CREDIT_AMOUNT
                return
                    <ns1:CREDIT_AMOUNT>{ data($PV_CREDIT_AMOUNT) }</ns1:CREDIT_AMOUNT>
            }
            {
                for $PR_DEPOSIT_SUMMARY in $outputParameters/ns2:PR_DEPOSIT_SUMMARY
                return
                	if( empty($PR_DEPOSIT_SUMMARY/*) )then(
                	
                	)else(
	                		<ns1:DEPOSIT_SUMMARY>
	                        {
	                            for $PAY_ITEM_ITEM in $PR_DEPOSIT_SUMMARY/ns2:PAY_ITEM/ns2:PAY_ITEM_ITEM
	                            return
	                                <ns1:DEPOSIT_ITEM>
	                                    <ns0:TYPE>{ data($PAY_ITEM_ITEM/ns2:TYPE) }</ns0:TYPE>
	                                    <ns0:CURRENCY>{ data($PAY_ITEM_ITEM/ns2:CURRENCY) }</ns0:CURRENCY>
	                                    {
	                                        for $AMOUNT in $PAY_ITEM_ITEM/ns2:AMOUNT
	                                        return
	                                            <ns0:AMOUNT>{ data($AMOUNT) }</ns0:AMOUNT>
	                                    }
	                                    {
	                                        for $MORE_INFO in $PAY_ITEM_ITEM/ns2:MORE_INFO
	                                        return
	                                            <ns0:MORE_INFO>
	                                                {
	                                                    for $ACCOUNT in $MORE_INFO/ns2:ACCOUNT                                 
	                                                    return
	                                                    	if( $ACCOUNT/ns2:ACCOUNT_NUMBER/text() != "" )then (
		                                                        <ns0:ACCOUNT>
		                                                            <ns0:NUMBER>{ data($ACCOUNT/ns2:ACCOUNT_NUMBER) }</ns0:NUMBER>
		                                                        </ns0:ACCOUNT>
		                                                    )else()
	                                                }
	                                                {
	                                                    for $CHECK_INFO in $MORE_INFO/ns2:CHECK_INFO
	                                                    return
	                                                    	if( $CHECK_INFO/ns2:CHECK_NUMBER/text() != "" )then(
		                                                        <ns0:CHECK>
		                                                            <ns0:CHECK_NUMBER>{ data($CHECK_INFO/ns2:CHECK_NUMBER) }</ns0:CHECK_NUMBER>
		                                                            <ns0:ACCOUNT_NUMBER>{ data($CHECK_INFO/ns2:ACCOUNT_NUMBER) }</ns0:ACCOUNT_NUMBER>
		                                                            {
		                                                                for $BANK_CODE in $CHECK_INFO/ns2:BANK_CODE
		                                                                return
		                                                                    <ns0:BANK_CODE>{ data($BANK_CODE) }</ns0:BANK_CODE>
		                                                            }
		                                                            {
		                                                                for $BANK_DESCRIPTION in $CHECK_INFO/ns2:BANK_DESCRIPTION
		                                                                return
		                                                                    <ns0:BANK_DESCRIPTION>{ data($BANK_DESCRIPTION) }</ns0:BANK_DESCRIPTION>
		                                                            }
		                                                        </ns0:CHECK>
		                                                     )else()
	                                                }
	                                                {
	                                                    for $CREDIT_CARD in $MORE_INFO/ns2:CREDIT_CARD
	                                                    return
	                                                    	if( $CREDIT_CARD/ns2:EXPIRATION_DATE/text() != "" )then(
		                                                        <ns0:CREDIT_CARD>
		                                                            <ns0:CARD_NUMBER>{ data($CREDIT_CARD/ns2:CARD_NUMBER) }</ns0:CARD_NUMBER>
		                                                            <ns0:EXPIRATION_DATE>{ data($CREDIT_CARD/ns2:EXPIRATION_DATE) }</ns0:EXPIRATION_DATE>
		                                                            <ns0:VERIFICATION_CODE>{ data($CREDIT_CARD/ns2:VERIFICATION_CODE) }</ns0:VERIFICATION_CODE>
		                                                        </ns0:CREDIT_CARD>
	                                                       	)else()
	                                                }
	                                                {
	                                                    for $DEBIT_CARD in $MORE_INFO/ns2:DEBIT_CARD
	                                                    return
	                                                    	if( $DEBIT_CARD/ns2:EXPIRATION_DATE/text() !="" )then(
		                                                        <ns0:DEBIT_CARD>
		                                                            <ns0:CARD_NUMBER>{ data($DEBIT_CARD/ns2:CARD_NUMBER) }</ns0:CARD_NUMBER>
		                                                            <ns0:EXPIRATION_DATE>{ data($DEBIT_CARD/ns2:EXPIRATION_DATE) }</ns0:EXPIRATION_DATE>
		                                                            <ns0:VERIFICATION_CODE>{ data($DEBIT_CARD/ns2:VERIFICATION_CODE) }</ns0:VERIFICATION_CODE>
		                                                        </ns0:DEBIT_CARD>
		                                                     )else()
	                                                }
	                                            </ns0:MORE_INFO>
	                                    }
	                                </ns1:DEPOSIT_ITEM>
	                        	}
	                    	</ns1:DEPOSIT_SUMMARY>
                	)
                    
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
		                            		  <ns1:ID>{ data($PRINTABLE_RECORD_ITEM/ns2:ID) }</ns1:ID>
			                                  <ns1:RECORD>{ data($PRINTABLE_RECORD_ITEM/ns2:RECORD) }</ns1:RECORD>                             
                            			</ns1:PASSBOOK_RECORD>
                            		)	     
                            	
                            	
                                
                        }
                    </ns1:PASSBOOK_RECORDS>
            }
            {
                for $PR_TRANSACTION_INFO in $outputParameters/ns2:PR_TRANSACTION_INFO
                return
                	if( empty($PR_TRANSACTION_INFO) )then(
                	
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
                        <ns0:TXN_REF_ID>{ data($PR_TRANSACTION_INFO/ns2:TXN_REF_ID) }</ns0:TXN_REF_ID>
                        <ns0:TXN_TYPE_ID>{ data($PR_TRANSACTION_INFO/ns2:TXN_TYPE_ID) }</ns0:TXN_TYPE_ID>
                        <ns0:TXN_DATE>{ data($PR_TRANSACTION_INFO/ns2:TXN_DATE) }</ns0:TXN_DATE>
                        <ns0:CURRENCY>{ data($PR_TRANSACTION_INFO/ns2:CURRENCY) }</ns0:CURRENCY>
                        <ns0:AMOUNT>{ data($PR_TRANSACTION_INFO/ns2:AMOUNT) }</ns0:AMOUNT>
                        <ns0:DATE_TIME>{ data($PR_TRANSACTION_INFO/ns2:DATE_TIME) }</ns0:DATE_TIME>
                        <ns0:USER>{ data($PR_TRANSACTION_INFO/ns2:USER_TX) }</ns0:USER>
                        <ns0:BRANCH_ID>{ data($PR_TRANSACTION_INFO/ns2:BRANCH_ID) }</ns0:BRANCH_ID>
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
        </ns1:accountDepositResponse>
};

declare variable $outputParameters as element(ns2:OutputParameters) external;

xf:accountDepositGTOut($outputParameters)

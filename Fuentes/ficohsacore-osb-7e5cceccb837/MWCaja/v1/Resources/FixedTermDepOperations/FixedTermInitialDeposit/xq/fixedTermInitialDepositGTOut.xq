(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns0:OutputParameters" location="../../../../BusinessServices/AbanksGT/DepositoInicial/xsd/MCDepositoCD_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns2:fixedTermInitialDepositResponse" location="../../xsd/FixedTermDepOperationsTypes.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/MCDepositoCD";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/fixedTermDepOperationsTypes";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/generalTypes";
declare namespace xf = "http://tempuri.org/MWCaja/v1/Resources/FixedTermDepOperations/FixedTermInitialDeposit/xq/fixedTermInitialDepositGTOut/";

declare function xf:fixedTermInitialDepositGTOut($outputParameters as element(ns0:OutputParameters))
    as element(ns2:fixedTermInitialDepositResponse) {
        <ns2:fixedTermInitialDepositResponse>
            {
                for $PN_ACCOUNT_NUMBER in $outputParameters/ns0:PN_ACCOUNT_NUMBER
                return
                    <ns2:ACCOUNT_NUMBER>{ data($PN_ACCOUNT_NUMBER) }</ns2:ACCOUNT_NUMBER>
            }
            {
                for $PV_ACCOUNT_NAME in $outputParameters/ns0:PV_ACCOUNT_NAME
                return
                    <ns2:ACCOUNT_NAME>{ data($PV_ACCOUNT_NAME) }</ns2:ACCOUNT_NAME>
            }
            {
                for $PR_DEPOSIT_SUMMARY in $outputParameters/ns0:PR_DEPOSIT_SUMMARY
                return
                    <ns2:DEPOSIT_SUMMARY>
                        {
                            for $PAY_ITEM_ITEM in $PR_DEPOSIT_SUMMARY/ns0:PAY_ITEM/ns0:PAY_ITEM_ITEM
                            return
                                <ns2:DEPOSIT_ITEM>
                                    <ns1:TYPE>{ data($PAY_ITEM_ITEM/ns0:TYPE) }</ns1:TYPE>
                                    <ns1:CURRENCY>{ data($PAY_ITEM_ITEM/ns0:CURRENCY) }</ns1:CURRENCY>
                                    {
                                        for $AMOUNT in $PAY_ITEM_ITEM/ns0:AMOUNT
                                        return
                                            <ns1:AMOUNT>{ data($AMOUNT) }</ns1:AMOUNT>
                                    }
                                    {
                                        for $MORE_INFO in $PAY_ITEM_ITEM/ns0:MORE_INFO
                                        return
                                            <ns1:MORE_INFO>
                                                {
                                                    for $ACCOUNT in $MORE_INFO/ns0:ACCOUNT
                                                    return
                                                    	if($ACCOUNT/ns0:ACCOUNT_NUMBER/text() != "")then(
                                                    		<ns1:ACCOUNT>
                                                            <ns1:NUMBER>{ data($ACCOUNT/ns0:ACCOUNT_NUMBER) }</ns1:NUMBER>
                                                        	</ns1:ACCOUNT>
                                                    	)else()
                                                        
                                                }
                                                {
                                                    for $CHECK_INFO in $MORE_INFO/ns0:CHECK_INFO
                                                    return
                                                    	if($CHECK_INFO/ns0:CHECK_NUMBER/text())then(
                                                    		<ns1:CHECK>
	                                                            <ns1:CHECK_NUMBER>{ data($CHECK_INFO/ns0:CHECK_NUMBER) }</ns1:CHECK_NUMBER>
	                                                            <ns1:ACCOUNT_NUMBER>{ data($CHECK_INFO/ns0:ACCOUNT_NUMBER) }</ns1:ACCOUNT_NUMBER>
	                                                            {
	                                                                for $BANK_CODE in $CHECK_INFO/ns0:BANK_CODE
	                                                                return
	                                                                    <ns1:BANK_CODE>{ data($BANK_CODE) }</ns1:BANK_CODE>
	                                                            }
	                                                            {
	                                                                for $BANK_DESCRIPTION in $CHECK_INFO/ns0:BANK_DESCRIPTION
	                                                                return
	                                                                    <ns1:BANK_DESCRIPTION>{ data($BANK_DESCRIPTION) }</ns1:BANK_DESCRIPTION>
	                                                            }
                                                        </ns1:CHECK>
                                                    	)else()
                                                        
                                                }
                                                {
                                                    for $CREDIT_CARD in $MORE_INFO/ns0:CREDIT_CARD
                                                    return
                                                    	if($CREDIT_CARD/ns0:EXPIRATION_DATE/text() != "")then(
                                                    		 <ns1:CREDIT_CARD>
                                                            <ns1:CARD_NUMBER>{ data($CREDIT_CARD/ns0:CARD_NUMBER) }</ns1:CARD_NUMBER>
                                                            <ns1:EXPIRATION_DATE>{ data($CREDIT_CARD/ns0:EXPIRATION_DATE) }</ns1:EXPIRATION_DATE>
                                                            <ns1:VERIFICATION_CODE>{ data($CREDIT_CARD/ns0:VERIFICATION_CODE) }</ns1:VERIFICATION_CODE>
                                                        </ns1:CREDIT_CARD>
                                                    	)else()
                                                       
                                                }
                                                {
                                                    for $DEBIT_CARD in $MORE_INFO/ns0:DEBIT_CARD
                                                    return
                                                    	if($DEBIT_CARD/ns0:EXPIRATION_DATE/text() != "")then (
                                                    	<ns1:DEBIT_CARD>
                                                            <ns1:CARD_NUMBER>{ data($DEBIT_CARD/ns0:CARD_NUMBER) }</ns1:CARD_NUMBER>
                                                            <ns1:EXPIRATION_DATE>{ data($DEBIT_CARD/ns0:EXPIRATION_DATE) }</ns1:EXPIRATION_DATE>
                                                            <ns1:VERIFICATION_CODE>{ data($DEBIT_CARD/ns0:VERIFICATION_CODE) }</ns1:VERIFICATION_CODE>
                                                        </ns1:DEBIT_CARD>
                                                    	)else()
                                                        
                                                }
                                            </ns1:MORE_INFO>
                                    }
                                </ns2:DEPOSIT_ITEM>
                        }
                    </ns2:DEPOSIT_SUMMARY>
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
		                    <ns1:TXN_REF_ID>{ data($PR_TRANSACTION_INFO/ns0:TXN_REF_ID) }</ns1:TXN_REF_ID>
		                    <ns1:TXN_TYPE_ID>{ data($PR_TRANSACTION_INFO/ns0:TXN_TYPE_ID) }</ns1:TXN_TYPE_ID>
		                    <ns1:TXN_DATE>{ data($PR_TRANSACTION_INFO/ns0:TXN_DATE) }</ns1:TXN_DATE>
		                    <ns1:CURRENCY>{ data($PR_TRANSACTION_INFO/ns0:CURRENCY) }</ns1:CURRENCY>
		                    <ns1:AMOUNT>{ data($PR_TRANSACTION_INFO/ns0:AMOUNT) }</ns1:AMOUNT>
		                    <ns1:DATE_TIME>{ data($PR_TRANSACTION_INFO/ns0:DATE_TIME) }</ns1:DATE_TIME>
		                    <ns1:USER>{ data($PR_TRANSACTION_INFO/ns0:USER_TX) }</ns1:USER>
		                    <ns1:BRANCH_ID>{ data($PR_TRANSACTION_INFO/ns0:BRANCH_ID) }</ns1:BRANCH_ID>
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
        </ns2:fixedTermInitialDepositResponse>
};

declare variable $outputParameters as element(ns0:OutputParameters) external;

xf:fixedTermInitialDepositGTOut($outputParameters)

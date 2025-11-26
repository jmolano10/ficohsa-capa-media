(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns1:OutputParameters" location="../../../../BusinessServices/AbanksGT/RegistroIVE/xsd/MC_REGISTRO_IVE_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns2:cashTransactionRecordResponse" location="../../xsd/CashTxnRecordOperationsTypes.xsd" ::)

declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/cashTxnRecordOperationsTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/MC_REGISTRO_IVE";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/generalTypes";
declare namespace xf = "http://tempuri.org/MWCaja/v1/Resources/CashTxnRecordOperations/CashTransactionRecord/xq/cashTransactionRecordGTOut/";

declare function xf:cashTransactionRecordGTOut($outputParameters as element(ns1:OutputParameters))
    as element(ns2:cashTransactionRecordResponse) {
        <ns2:cashTransactionRecordResponse>
            {
                for $PR_TRANSACTION_INFO in $outputParameters/ns1:PR_TRANSACTION_INFO
                return
                if(empty($PR_TRANSACTION_INFO/*))then(
                )else(
                    <ns2:TRANSACTION_INFO>
                        {
                            for $DEALSLIP in $PR_TRANSACTION_INFO/ns1:DEALSLIP
                            return
                                <ns0:DEALSLIP>
                                    {
                                        for $DS_RECORD_ITEM in $DEALSLIP/ns1:DS_RECORD/ns1:DS_RECORD_ITEM
                                        return
                                            <ns0:DS_RECORD>{ data($DS_RECORD_ITEM) }</ns0:DS_RECORD>
                                    }
                                </ns0:DEALSLIP>
                        }
                        <ns0:TXN_REF_ID>{ xs:integer(data($PR_TRANSACTION_INFO/ns1:TXN_REF_ID)) }</ns0:TXN_REF_ID>
                        <ns0:TXN_TYPE_ID>{ xs:integer(data($PR_TRANSACTION_INFO/ns1:TXN_TYPE_ID)) }</ns0:TXN_TYPE_ID>
                        <ns0:TXN_DATE>{ data($PR_TRANSACTION_INFO/ns1:TXN_DATE) }</ns0:TXN_DATE>
                        <ns0:CURRENCY>{ data($PR_TRANSACTION_INFO/ns1:CURRENCY) }</ns0:CURRENCY>
                        <ns0:AMOUNT>{ data($PR_TRANSACTION_INFO/ns1:AMOUNT) }</ns0:AMOUNT>
                        <ns0:DATE_TIME>{ data($PR_TRANSACTION_INFO/ns1:DATE_TIME) }</ns0:DATE_TIME>
                        <ns0:USER>{ data($PR_TRANSACTION_INFO/ns1:USER_TX) }</ns0:USER>
                        <ns0:BRANCH_ID>{ xs:integer(data($PR_TRANSACTION_INFO/ns1:BRANCH_ID)) }</ns0:BRANCH_ID>
                        <ns0:BRANCH_NAME>{ data($PR_TRANSACTION_INFO/ns1:BRANCH_NAME) }</ns0:BRANCH_NAME>
                        <ns0:REQUIRES_CTR>{ data($PR_TRANSACTION_INFO/ns1:REQUIRES_CTR) }</ns0:REQUIRES_CTR>
                        {
                        	for $DEALSLIP_URL in $PR_TRANSACTION_INFO/ns1:DEALSLIP_URL
                        	return
                        		<ns0:DEALSLIP_URL>{ data($DEALSLIP_URL) }</ns0:DEALSLIP_URL>
                        }                        
                    </ns2:TRANSACTION_INFO>
            	)
            }
            {
                for $PR_TRANSACTION_DETAILS in $outputParameters/ns1:PR_TRANSACTION_DETAILS
                return
                if(empty($PR_TRANSACTION_DETAILS/*))then(
                )else(
                    <ns2:TRANSACTION_DETAILS>
                        {
                            for $DETAILS in $PR_TRANSACTION_DETAILS/ns1:DETAILS
                            return
                                <ns0:DETAILS>
                                    {
                                        for $CURRENCY_ITEM in $DETAILS/ns1:CURRENCY/ns1:CURRENCY_ITEM
                                        return
                                            <ns0:CURRENCY>{ data($CURRENCY_ITEM) }</ns0:CURRENCY>
                                    }
                                    {
                                        for $AMOUNT_ITEM in $DETAILS/ns1:AMOUNT/ns1:AMOUNT_ITEM
                                        return
                                            <ns0:AMOUNT>{ data($AMOUNT_ITEM) }</ns0:AMOUNT>
                                    }
                                </ns0:DETAILS>
                        }
                    </ns2:TRANSACTION_DETAILS>
                )
            }
            {
                for $PR_TRANSACTION_CODES in $outputParameters/ns1:PR_TRANSACTION_CODES
                return
                if(empty($PR_TRANSACTION_CODES/*))then(
            	)else(
                    <ns2:TRANSACTION_CODES>
                        {
                            for $CODES in $PR_TRANSACTION_CODES/ns1:CODES
                            return
                                <ns0:CODES>
                                	{
	                                	for $TXN_TYPE_ID_ITEM in $CODES/ns1:TXN_TYPE_ID/ns1:AMOUNT_ITEM
	                                	return
	                                		<ns0:TXN_TYPE_ID>{ xs:integer(data($TXN_TYPE_ID_ITEM)) }</ns0:TXN_TYPE_ID>
	                                }                                    
                                </ns0:CODES>
                        }
                    </ns2:TRANSACTION_CODES>
            	)
            }
        </ns2:cashTransactionRecordResponse>
};

declare variable $outputParameters as element(ns1:OutputParameters) external;

xf:cashTransactionRecordGTOut($outputParameters)

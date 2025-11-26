(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns2:OutputParameters" location="../../../../BusinessServices/AbanksGT/PagoFactura/xsd/MCPagoFactura_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns0:billPaymentResponse" location="../../xsd/BillOperationsTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/billOperationsTypes";
declare namespace ns2 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/MCPagoFactura";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/generalTypes";
declare namespace xf = "http://tempuri.org/MWCaja/v1/Resources/BillOperations/BillPayment/xq/billPaymentGTOut/";

declare function xf:billPaymentGTOut($outputParameters as element(ns2:OutputParameters))
    as element(ns0:billPaymentResponse) {
        <ns0:billPaymentResponse>
        	{
        		for $CONTRACT_ID in $outputParameters/ns2:PV_CONTRACT_ID
        		return
        			<ns0:CONTRACT_ID>{ data($outputParameters/ns2:PV_CONTRACT_ID) }</ns0:CONTRACT_ID>
        	}
            
            {
                for $PV_CONTRACT_NAME in $outputParameters/ns2:PV_CONTRACT_NAME
                return
                    <ns0:CONTRACT_NAME>{ data($PV_CONTRACT_NAME) }</ns0:CONTRACT_NAME>
            }
            {
            	for $DEBTOR_CODE in $outputParameters/ns2:PV_DEBTOR_CODE
            	return
            		<ns0:DEBTOR_CODE>{ data($DEBTOR_CODE) }</ns0:DEBTOR_CODE>
            }
            
            {
                for $PV_DEBTOR_NAME in $outputParameters/ns2:PV_DEBTOR_NAME
                return
                    <ns0:DEBTOR_NAME>{ data($PV_DEBTOR_NAME) }</ns0:DEBTOR_NAME>
            }
            {
                for $PR_BILLS_PAID in $outputParameters/ns2:PR_BILLS_PAID
                return
		                <ns0:BILLS_PAID>
		                    {
		                        for $BILL_ID_ITEM in $PR_BILLS_PAID/ns2:BILL_ID/ns2:BILL_ID_ITEM
		                        return
		                        	if( empty($BILL_ID_ITEM/*) )then(
                    				)else(
		                            	<ns0:BILL_ID>{ data($BILL_ID_ITEM) }</ns0:BILL_ID>	
		                           )	                           		                            
		                    }
		                </ns0:BILLS_PAID>
		            
            }
            {
                for $PR_TRANSACTION_INFO in $outputParameters/ns2:PR_TRANSACTION_INFO
                return
                	if( empty($PR_TRANSACTION_INFO/*) )then(
                	)else(
                		<ns0:TRANSACTION_INFO>
                        {
                            for $DEALSLIP in $PR_TRANSACTION_INFO/ns2:DEALSLIP
                            return
                                <ns1:DEALSLIP>
                                    {
                                        for $DS_RECORD_ITEM in $DEALSLIP/ns2:DS_RECORD/ns2:DS_RECORD_ITEM
                                        return
                                            <ns1:DS_RECORD>{ data($DS_RECORD_ITEM) }</ns1:DS_RECORD>
                                    }
                                </ns1:DEALSLIP>
                        }
                        <ns1:TXN_REF_ID>{ data($PR_TRANSACTION_INFO/ns2:TXN_REF_ID) }</ns1:TXN_REF_ID>
                        <ns1:TXN_TYPE_ID>{ data($PR_TRANSACTION_INFO/ns2:TXN_TYPE_ID) }</ns1:TXN_TYPE_ID>
                        <ns1:TXN_DATE>{ data($PR_TRANSACTION_INFO/ns2:TXN_DATE) }</ns1:TXN_DATE>
                        <ns1:CURRENCY>{ data($PR_TRANSACTION_INFO/ns2:CURRENCY) }</ns1:CURRENCY>
                        <ns1:AMOUNT>{ data($PR_TRANSACTION_INFO/ns2:AMOUNT) }</ns1:AMOUNT>
                        <ns1:DATE_TIME>{ data($PR_TRANSACTION_INFO/ns2:DATE_TIME) }</ns1:DATE_TIME>
                        <ns1:USER>{ data($PR_TRANSACTION_INFO/ns2:USER_TX) }</ns1:USER>
                        <ns1:BRANCH_ID>{ data($PR_TRANSACTION_INFO/ns2:BRANCH_ID) }</ns1:BRANCH_ID>
                        <ns1:BRANCH_NAME>{ data($PR_TRANSACTION_INFO/ns2:BRANCH_NAME) }</ns1:BRANCH_NAME>
                        <ns1:REQUIRES_CTR>{ data($PR_TRANSACTION_INFO/ns2:REQUIRES_CTR) }</ns1:REQUIRES_CTR>
                        {
                            for $DEALSLIP_URL in $PR_TRANSACTION_INFO/ns2:DEALSLIP_URL
                            return
                                <ns1:DEALSLIP_URL>{ data($DEALSLIP_URL) }</ns1:DEALSLIP_URL>
                        }
                    </ns0:TRANSACTION_INFO>
 
                	)
                               }
        </ns0:billPaymentResponse>
};

declare variable $outputParameters as element(ns2:OutputParameters) external;

xf:billPaymentGTOut($outputParameters)

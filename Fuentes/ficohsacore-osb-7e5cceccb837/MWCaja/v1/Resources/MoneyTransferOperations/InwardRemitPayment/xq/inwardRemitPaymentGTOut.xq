(:: pragma bea:global-element-parameter parameter="$paymentRemittanceResponse" element="ns2:PaymentRemittanceResponse" location="../../../../BusinessServices/MoneyTransferOperations/wsdl/SwitchRemittanceService.asmx.wsdl" ::)
(:: pragma bea:global-element-return element="ns1:inwardRemitPaymentResponse" location="../../xsd/MoneyTransferOperationsTypes.xsd" ::)

declare namespace ns2 = "http://tempuri.org/";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/moneyTransferOperationsTypes";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/generalTypes";
declare namespace xf = "http://tempuri.org/MWCaja/v1/Resources/MoneyTransferOperations/InwardRemitPayment/xq/inwardRemitPaymentGTOut/";

declare function xf:inwardRemitPaymentGTOut($paymentRemittanceResponse as element(ns2:PaymentRemittanceResponse))
    as element(ns1:inwardRemitPaymentResponse) {
        <ns1:inwardRemitPaymentResponse>
        	{
        		for $Sequency in $paymentRemittanceResponse/ns2:ResponsePaymentRemittance/ns2:Sequency
        		return
        			<ns1:SEQUENCY>{ data($Sequency) }</ns1:SEQUENCY>
        	}            
            {
                for $TransactionInfo in $paymentRemittanceResponse/ns2:ResponsePaymentRemittance/ns2:TransactionInfo
                return
                	if( empty($TransactionInfo/*) )then(
	                	
                	)else(
		                    <ns1:TRANSACTION_INFO>
		                        <ns0:DEALSLIP>
		                            {
		                                for $DealSlip in $TransactionInfo/ns2:DealSlip
		                                return
		                                    <ns0:DS_RECORD/>
		                            }
		                        </ns0:DEALSLIP>
		                        <ns0:TXN_REF_ID>{ data($TransactionInfo/ns2:TxnRefID) }</ns0:TXN_REF_ID>
		                        <ns0:TXN_TYPE_ID>{ data($TransactionInfo/ns2:TxnTypeID) }</ns0:TXN_TYPE_ID>
		                        <ns0:TXN_DATE>{ data($TransactionInfo/ns2:TxnDate) }</ns0:TXN_DATE>
		                        <ns0:CURRENCY>{ data($TransactionInfo/ns2:Currency) }</ns0:CURRENCY>
		                        <ns0:AMOUNT>{ data($TransactionInfo/ns2:Amount) }</ns0:AMOUNT>
		                        <ns0:DATE_TIME>{ data($TransactionInfo/ns2:DateTime) }</ns0:DATE_TIME>
		                        <ns0:USER>{ data($TransactionInfo/ns2:User) }</ns0:USER>
		                        <ns0:BRANCH_ID>{ data($TransactionInfo/ns2:BranchID) }</ns0:BRANCH_ID>
		                        <ns0:BRANCH_NAME>{ data($TransactionInfo/ns2:BranchName) }</ns0:BRANCH_NAME>
		                        <ns0:REQUIRES_CTR>{ data($TransactionInfo/ns2:RequiresCTR) }</ns0:REQUIRES_CTR>
		                        {
		                            for $DealSlipURL in $TransactionInfo/ns2:DealSlipURL
		                            return
		                                <ns0:DEALSLIP_URL>{ data($DealSlipURL) }</ns0:DEALSLIP_URL>
		                        }
                    		</ns1:TRANSACTION_INFO>
            			)
            }
            {
            	for $ResponseCode in $paymentRemittanceResponse/ns2:ResponsePaymentRemittance/ns2:ResponseCode
            	return
            		<ns1:RESPONSE_CODE>{ data($ResponseCode) }</ns1:RESPONSE_CODE>
            		
            }            
            {
                for $ResponseMessage in $paymentRemittanceResponse/ns2:ResponsePaymentRemittance/ns2:ResponseMessage
                return
                    <ns1:RESPONSE_MESSAGE>{ data($ResponseMessage) }</ns1:RESPONSE_MESSAGE>
            }
        </ns1:inwardRemitPaymentResponse>
};

declare variable $paymentRemittanceResponse as element(ns2:PaymentRemittanceResponse) external;

xf:inwardRemitPaymentGTOut($paymentRemittanceResponse)
(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns0:OutputParameters" location="../../../BusinessServices/DesembolsoLineaCredito/consultaSolicitudesCliente/xsd/consultaSolicitudesCliente_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaSolicitudesClienteResponse" location="../../DesembolsoLineaCredito/xsd/desembolsoLineaCreditoTypes.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/desembolsoLineaCreditoTypes";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaSolicitudesCliente";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaSolicitudesCliente/xq/consultaSolicitudesClienteHNOut/";
declare function convertirFecha($date as xs:dateTime) 
    as xs:string {
        fn-bea:dateTime-to-string-with-format("yyyyMMdd",$date)
};

declare function xf:consultaSolicitudesClienteHNOut($outputParameters as element(ns0:OutputParameters), 
$TICKET as xs:string, $CUSTOMER_ID as xs:string, $INITIAL_RECORD as xs:string)
    as element(ns1:consultaSolicitudesClienteResponse) {
        <ns1:consultaSolicitudesClienteResponse>
        	<CUSTOMER_ID>{ xs:int($CUSTOMER_ID) }</CUSTOMER_ID>
            {
    			let $customerName := $outputParameters/ns0:P_CUSTOMER_NAME/ns0:P_CUSTOMER_NAME_ITEM[1]
    				return
    					<CUSTOMER_NAME>{ data($customerName) }</CUSTOMER_NAME>
    
			}
            <RECORDS_INFO>
            	{
            		if( $INITIAL_RECORD != "" )then(
            			<INITIAL_RECORD>{ xs:int($INITIAL_RECORD) }</INITIAL_RECORD>
            		)else()
            	}
            	{
            		for $RECORDS_RETURNED in $outputParameters/ns0:P_RECORDS_RETURNED
            		return 
            			if( data($RECORDS_RETURNED) != "" )then(
            				<RECORDS_RETURNED>{ data($RECORDS_RETURNED) }</RECORDS_RETURNED>
            			)else()
            	}
            	{
            		for $RECORDS_TOTAL in $outputParameters/ns0:P_RECORDS_TOTAL
            		return
            			if( data($RECORDS_TOTAL) != "" )then(
            				<RECORDS_TOTAL>{ data($RECORDS_TOTAL) }</RECORDS_TOTAL>
            			)else()
            	}            	
    			<TICKET>{ $TICKET }</TICKET>            	            	                                                
            </RECORDS_INFO>
            {
        		let $id := data($outputParameters/ns0:P_REQUEST_ID/ns0:P_REQUEST_ID_ITEM)
        		let $incomeDate := data($outputParameters/ns0:P_INCOME_DATE/ns0:P_INCOME_DATE_ITEM)
        		let $status := data($outputParameters/ns0:PT_STATUS/ns0:P_REQUEST_ID_ITEM)
        		let $statusDescription := data($outputParameters/ns0:P_STATUS_DESCRIPTION/ns0:P_STATUS_DESCRIPTION_ITEM)
        		let $creditLineId := data($outputParameters/ns0:P_CREDIT_LINE_ID/ns0:P_CREDIT_LINE_ID_ITEM)
        		let $destinationProductId := data($outputParameters/ns0:P_DESTINATION_PRODUCT_ID/ns0:P_CREDIT_LINE_ID_ITEM)
        		let $destinationProductType := data($outputParameters/ns0:P_DESTINATION_PRODUCT_TYPE/ns0:P_DESTINATION_PRODUCT_TYPE_ITEM)
        		let $loanCurrency := data($outputParameters/ns0:P_LOAN_CURRENCY/ns0:P_DESTINATION_PRODUCT_TYPE_ITEM)
        		let $paymentTerm := data($outputParameters/ns0:P_PAYMENT_TERMS/ns0:P_REQUEST_ID_ITEM)
        		let $requestAmount := data($outputParameters/ns0:P_REQUEST_AMOUNT/ns0:P_CREDIT_LINE_ID_ITEM)
        		let $debitAccountId := data($outputParameters/ns0:P_DEBIT_ACCOUNT_ID/ns0:P_CREDIT_LINE_ID_ITEM)
        		let $loanNumber := data($outputParameters/ns0:P_LOAN_NUMBER/ns0:P_CREDIT_LINE_ID_ITEM)
        		let $creditAmount := data($outputParameters/ns0:P_CREDIT_AMOUNT/ns0:P_CREDIT_LINE_ID_ITEM)
        		let $transactionId := data($outputParameters/ns0:P_TRANSACTION_ID/ns0:P_TRANSACTION_ID_ITEM)
        		let $installmentValue := data($outputParameters/ns0:P_INSTALLMENT_VALUE/ns0:P_CREDIT_LINE_ID_ITEM)                                       
            	let $applicationDate := data($outputParameters/ns0:P_APPLICATION_DATE/ns0:P_INCOME_DATE_ITEM)
            	let $paymentVoucher := data($outputParameters/ns0:P_PAYMENT_VOUCHER/ns0:P_PAYMENT_VOUCHER_ITEM)
            	let $channelId := data($outputParameters/ns0:P_CHANNEL_ID/ns0:P_CREDIT_LINE_ID_ITEM)
            	let $requestUser := data($outputParameters/ns0:P_REQUEST_USER/ns0:P_CREDIT_LINE_ID_ITEM)
            	let $authorizationUser := data($outputParameters/ns0:P_AUTHORIZATION_USER/ns0:P_CREDIT_LINE_ID_ITEM) 
            	let $errorCode := data($outputParameters/ns0:P_ERROR_CODE/ns0:P_REQUEST_ID_ITEM)
            	let $errorDescription := data($outputParameters/ns0:P_ERROR_DESCRIPTION/ns0:P_ERROR_DESCRIPTION_ITEM)
            	return 
	            	 if (count($id) < 1) then (
	    			
					 )else(	           	                    		                                                   		                  		                      	
					        <REQUEST_DETAILS>
		                       {
		                            for $i in (1 to count($id))
		                            return
		                                <REQUEST>                                	
		                        			<ID>{ $id[$i] }</ID>
		                        			{
		                        				if( $incomeDate[$i] != "")then(
		                        					<INCOME_DATE>{ convertirFecha($incomeDate[$i]) }</INCOME_DATE>
		                        				)else()
		                        			}
		                        			{
		                        				if( $status[$i] != "")then(
		                        					 <STATUS>{ $status[$i] }</STATUS>
		                        				)else()
		                        			}	
	                        				<STATUS_DESCRIPTION>{ $statusDescription[$i] }</STATUS_DESCRIPTION>                              		                                				            	                                  		                                    		                                   
		                                    <CREDIT_LINE_ID>{ $creditLineId[$i] }</CREDIT_LINE_ID>		                                		                                    		                                    				                    				                				                   				              
		                                    <DESTINATION_PRODUCT_ID>{ $destinationProductId[$i] }</DESTINATION_PRODUCT_ID>				                    				                
		                                    <DESTINATION_PRODUCT_TYPE>{ $destinationProductType[$i] }</DESTINATION_PRODUCT_TYPE>				               				                
		                                    <LOAN_CURRENCY>{ $loanCurrency[$i] }</LOAN_CURRENCY>
		                                    {
		                                    	if( $paymentTerm[$i] != "")then(
		                                    		<PAYMENT_TERM>{ $paymentTerm[$i] }</PAYMENT_TERM>
		                                    	)else()
		                                    }				                   		                                    
		                                    <REQUEST_AMOUNT>{ $requestAmount[$i] }</REQUEST_AMOUNT>				                
		                                    <DEBIT_ACCOUNT_ID>{ $debitAccountId[$i] }</DEBIT_ACCOUNT_ID>				                    
		                                    <LOAN_NUMBER>{ $loanNumber[$i] }</LOAN_NUMBER>
		                                    <CREDIT_AMOUNT>{ $creditAmount[$i] }</CREDIT_AMOUNT>				                
		                                    <TRANSACTION_ID>{ $transactionId[$i] }</TRANSACTION_ID>				                   				                
		                                    <INSTALLMENT_VALUE>{ $installmentValue[$i] }</INSTALLMENT_VALUE>
		                                    {
		                                    	if( $applicationDate[$i] != "")then(
		                                    		<APPLICATION_DATE>{ convertirFecha($applicationDate[$i]) }</APPLICATION_DATE>
		                                    	)else()
		                                    }				                    		                                    				                
		                                    <PAYMENT_VOUCHER>{ $paymentVoucher[$i] }</PAYMENT_VOUCHER>				                   				                
		                                    <CHANNEL_ID>{ $channelId[$i] }</CHANNEL_ID>				                   				                
		                                    <REQUEST_USER>{ $requestUser[$i] }</REQUEST_USER>				                    
		                                    <AUTHORIZATION_USER>{ $authorizationUser[$i] }</AUTHORIZATION_USER>
		                                    {
		                                    	if( $errorCode[$i] != "")then(
		                                    		<ERROR_CODE>{ $errorCode[$i] }</ERROR_CODE>	
		                                    	)else()
		                                    }		                                    			                
		                                    <P_ERROR_DESCRIPTION>{ $errorDescription[$i] }</P_ERROR_DESCRIPTION>				                    
		                                </REQUEST>
		                        }
					        </REQUEST_DETAILS>
			        	)
	       }
        </ns1:consultaSolicitudesClienteResponse>
};

declare variable $outputParameters as element(ns0:OutputParameters) external;
declare variable $TICKET as xs:string external;
declare variable $CUSTOMER_ID as xs:string external;
declare variable $INITIAL_RECORD as xs:string external;

xf:consultaSolicitudesClienteHNOut($outputParameters, $TICKET, $CUSTOMER_ID, $INITIAL_RECORD)
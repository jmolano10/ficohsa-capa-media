xquery version "1.0" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns1:OutputParameters" location="../../../BusinessServices/DesembolsoLineaCredito/consultaInformacionSolicitudes/xsd/consultaInformacionSolicitud_sp.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultaInformacionSolicitudes" element="ns0:consultaInformacionSolicitudes" location="../../DesembolsoLineaCredito/xsd/desembolsoLineaCreditoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultaInformacionSolicitudesResponse" location="../../DesembolsoLineaCredito/xsd/desembolsoLineaCreditoTypes.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaInformacionSolicitudes/xq/consultaInformacionSolicitudOut/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/desembolsoLineaCreditoTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaInformacionSolicitud";

declare function convertirFecha($date as xs:dateTime) 
    as xs:string {
        fn-bea:dateTime-to-string-with-format("yyyyMMdd",$date)
};

declare function xf:consultaInformacionSolicitudesHNOut($outputParameters as element(ns1:OutputParameters),
    $consultaInformacionSolicitudes as element(ns0:consultaInformacionSolicitudes))
    as element(ns0:consultaInformacionSolicitudesResponse) {
        <ns0:consultaInformacionSolicitudesResponse>
            <CUSTOMER_ID>{ data($consultaInformacionSolicitudes/CUSTOMER_ID) }</CUSTOMER_ID> 
            {
                for $P_CUSTOMER_NAME in $outputParameters/ns1:P_CUSTOMER_NAME
                return
                    <CUSTOMER_NAME>{ data($P_CUSTOMER_NAME) }</CUSTOMER_NAME>
            }
            {      	
            	let $request := $consultaInformacionSolicitudes/REQUEST_DETAILS/REQUEST
        		let $incomeDate := data($outputParameters/ns1:P_INCOME_DATE/ns1:P_INCOME_DATE_ITEM)
        		let $status := data($outputParameters/ns1:P_STATUS/ns1:P_REQUEST_ID_ITEM)
        		let $statusDescription := data($outputParameters/ns1:P_STATUS_DESCRIPTION/ns1:P_STATUS_DESCRIPTION_ITEM)
        		let $creditLineId := data($outputParameters/ns1:P_CREDIT_LINE_ID/ns1:P_CREDIT_LINE_ID_ITEM)
        		let $destinationProductId := data($outputParameters/ns1:P_DESTINATION_PRODUCT_ID/ns1:P_CREDIT_LINE_ID_ITEM)
        		let $destinationProductType := data($outputParameters/ns1:P_DESTINATION_PRODUCT_TYPE/ns1:P_DESTINATION_PRODUCT_TYPE_ITEM)
        		let $loanCurrency := data($outputParameters/ns1:P_LOAN_CURRENCY/ns1:P_DESTINATION_PRODUCT_TYPE_ITEM)
        		let $paymentTerm := data($outputParameters/ns1:P_PAYMENT_TERMS/ns1:P_REQUEST_ID_ITEM)
        		let $requestAmount := data($outputParameters/ns1:P_REQUEST_AMOUNT/ns1:P_CREDIT_LINE_ID_ITEM)
        		let $debitAccountId := data($outputParameters/ns1:P_DEBIT_ACCOUNT_ID/ns1:P_CREDIT_LINE_ID_ITEM)
        		let $loanNumber := data($outputParameters/ns1:P_LOAN_NUMBER/ns1:P_CREDIT_LINE_ID_ITEM)
        		let $creditAmount := data($outputParameters/ns1:P_CREDIT_AMOUNT/ns1:P_CREDIT_LINE_ID_ITEM)
        		let $transactionId := data($outputParameters/ns1:P_TRANSACTION_ID/ns1:P_TRANSACTION_ID_ITEM)
        		let $installmentValue := data($outputParameters/ns1:P_INSTALLMENT_VALUE/ns1:P_CREDIT_LINE_ID_ITEM)                                       
            	let $applicationDate := data($outputParameters/ns1:P_APPLICATION_DATE/ns1:P_INCOME_DATE_ITEM)
            	let $paymentVoucher := data($outputParameters/ns1:P_PAYMENT_VOUCHER/ns1:P_PAYMENT_VOUCHER_ITEM)
            	let $channelId := data($outputParameters/ns1:P_CHANNEL_ID/ns1:P_CREDIT_LINE_ID_ITEM)
            	let $requestUser := data($outputParameters/ns1:P_REQUEST_USER/ns1:P_CREDIT_LINE_ID_ITEM)
            	let $authorizationUser := data($outputParameters/ns1:P_AUTHORIZATION_USER/ns1:P_CREDIT_LINE_ID_ITEM) 
            	let $errorCode := data($outputParameters/ns1:P_ERROR_CODE/ns1:P_ERROR_CODE_ITEM)
            	let $errorDescription := data($outputParameters/ns1:P_ERROR_DESCRIPTION/ns1:P_ERROR_CODE_ITEM)
            	return
	            	 if (count($incomeDate) < 1) then (
	    				<ns1:consultaInformacionSolicitudesResponse/>
					 )else(
					        <REQUEST_DETAILS>
		                       {
		                            for $i in (1 to count($incomeDate))
		                            return
		                                <REQUEST>
		                                	{
		                                		<ID>{ data($request[$i]/ID) }</ID> 
		                                	}		                                                               	
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
		                                    <CHANNEL_ID>{ $channelId[$i] }</CHANNEL_ID>				                   				                
		                                    <REQUEST_USER>{ $requestUser[$i] }</REQUEST_USER>				                    
		                                    <AUTHORIZATION_USER>{ $authorizationUser[$i] }</AUTHORIZATION_USER>
		                                    <ERROR_CODE>{ $errorCode[$i] }</ERROR_CODE>
		                                    <ERROR_DESCRIPTION>{ $errorDescription[$i] }</ERROR_DESCRIPTION>                                    			                			                    
		                                </REQUEST>
		                        }
					        </REQUEST_DETAILS>
			        	)
				}			        			                                    			                        							                                					 	                  	                          	
        </ns0:consultaInformacionSolicitudesResponse>
};

declare variable $outputParameters as element(ns1:OutputParameters) external;
declare variable $consultaInformacionSolicitudes as element(ns0:consultaInformacionSolicitudes) external;

xf:consultaInformacionSolicitudesHNOut($outputParameters,
    $consultaInformacionSolicitudes)
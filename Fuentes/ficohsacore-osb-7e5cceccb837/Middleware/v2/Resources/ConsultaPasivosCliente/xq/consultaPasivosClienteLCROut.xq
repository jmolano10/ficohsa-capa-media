(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns0:OutputParameters" location="../../../BusinessServices/ABK/consultaLineasCreditoCliente/xsd/consultaLineasCreditoCliente_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaPasivosClienteResponse" location="../xsd/consultaPasivosClienteTypes.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaLineasCreditoCliente";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaClientesTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaPasivosCliente/xq/consultaPasivosClienteLCROut/";

declare function xf:consultaPasivosClienteLCROut($outputParameters as element(ns0:OutputParameters),
    $sourceBank as xs:string)
    as element(ns1:consultaPasivosClienteResponse) {
        <ns1:consultaPasivosClienteResponse>
            <ns1:consultaPasivosClienteLCRResponseType>
            {
            	let $CUSTOMER_NAME := $outputParameters/ns0:P_CUSTOMER_NAME
            	let $CREDIT_LINE_ID :=  $outputParameters/ns0:P_CREDIT_LINE_ID/ns0:P_CREDIT_LINE_ID_ITEM
            	let $CREDIT_LINE_CURRENCY :=  $outputParameters/ns0:P_CREDIT_LINE_CURRENCY/ns0:P_CREDIT_LINE_CURRENCY_ITEM
            	let $EXPIRY_DATE :=  $outputParameters/ns0:P_EXPIRY_DATE/ns0:P_CREDIT_LINE_ID_ITEM
            	let $AMOUNT :=  $outputParameters/ns0:P_AMOUNT/ns0:P_CREDIT_LINE_ID_ITEM
            	let $USED_AMOUNT :=  $outputParameters/ns0:P_USED_AMOUNT/ns0:P_CREDIT_LINE_ID_ITEM
            	let $AVAILABLE_AMOUNT :=  $outputParameters/ns0:P_AVAILABLE_AMOUNT/ns0:P_CREDIT_LINE_ID_ITEM
            	for $i in 1 to count($CREDIT_LINE_ID)
            		return
            		(
		                <ns1:consultaPasivosClienteResponseRecordType>
                    		<LIABILITY_NUMBER>{ data($CREDIT_LINE_ID[$i]) }</LIABILITY_NUMBER>
                    		<LIABILITY_CUST_NAME>{ data($CUSTOMER_NAME) }</LIABILITY_CUST_NAME>
                    		<LIABILITY_CURRENCY_1>{ data($CREDIT_LINE_CURRENCY[$i]) }</LIABILITY_CURRENCY_1>
               		 		<LIABILITY_PRINCIPAL_AMT_1>{ data($AMOUNT[$i]) }</LIABILITY_PRINCIPAL_AMT_1>	                  
                   		 	<LIABILITY_TOTAL_AMT_1>{ data($AVAILABLE_AMOUNT[$i]) }</LIABILITY_TOTAL_AMT_1>               	
                    		<LIABILITY_TOTAL_AMT>{ data($USED_AMOUNT[$i]) }</LIABILITY_TOTAL_AMT>                 
                    		{
                                if(data($EXPIRY_DATE[$i]) != '') then(
                                    <ns1:LIABILITY_PAYMENT_DATE>{ data($EXPIRY_DATE[$i]) }</ns1:LIABILITY_PAYMENT_DATE>
                                )else()
                            }                  
                    	    <LIABILITY_SOURCE_BANK>{ $sourceBank }</LIABILITY_SOURCE_BANK>		             
		                </ns1:consultaPasivosClienteResponseRecordType>
		             )
		     }
            </ns1:consultaPasivosClienteLCRResponseType>
        </ns1:consultaPasivosClienteResponse>
};

declare variable $outputParameters as element(ns0:OutputParameters) external;
declare variable $sourceBank as xs:string external;

xf:consultaPasivosClienteLCROut($outputParameters,
    $sourceBank)
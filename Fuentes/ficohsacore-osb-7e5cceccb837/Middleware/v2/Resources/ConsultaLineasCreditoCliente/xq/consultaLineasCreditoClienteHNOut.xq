xquery version "1.0" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns0:OutputParameters" location="../../../BusinessServices/ABK/consultaLineasCreditoCliente/xsd/consultaLineasCreditoCliente_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaLineasCreditoClienteResponse" location="../../ConsultaProductosLineasCredito/xsd/consultaProductosLineasCreditoTypes.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaLineasCreditoCliente/xq/consultaLineasCreditoClienteHNOut/";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaProductosLineasCreditoTypes";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaLineasCreditoCliente";

declare function xf:consultaLineasCreditoClienteHNOut($outputParameters as element(ns0:OutputParameters))
    as element(ns1:consultaLineasCreditoClienteResponse) {
         <ns1:consultaLineasCreditoClienteResponse>
            <CREDIT_LINES>
                {
                    for $CUSTOMER_NAME in $outputParameters/ns0:P_CUSTOMER_NAME
                    return
                        <CUSTOMER_NAME>{ data($CUSTOMER_NAME) }</CUSTOMER_NAME>
                }
				{
	            	let $CREDIT_LINE_ID :=  $outputParameters/ns0:P_CREDIT_LINE_ID/ns0:P_CREDIT_LINE_ID_ITEM
	            	let $CREDIT_LINE_CURRENCY :=  $outputParameters/ns0:P_CREDIT_LINE_CURRENCY/ns0:P_CREDIT_LINE_CURRENCY_ITEM
	            	let $OPENING_DATE :=  $outputParameters/ns0:P_OPENING_DATE/ns0:P_CREDIT_LINE_ID_ITEM
	            	let $EXPIRY_DATE :=  $outputParameters/ns0:P_EXPIRY_DATE/ns0:P_CREDIT_LINE_ID_ITEM
	            	let $AMOUNT :=  $outputParameters/ns0:P_AMOUNT/ns0:P_CREDIT_LINE_ID_ITEM
	            	let $USED_AMOUNT :=  $outputParameters/ns0:P_USED_AMOUNT/ns0:P_CREDIT_LINE_ID_ITEM
	            	let $AVAILABLE_AMOUNT :=  $outputParameters/ns0:P_AVAILABLE_AMOUNT/ns0:P_CREDIT_LINE_ID_ITEM
	            	let $STATUS :=  $outputParameters/ns0:P_STATUS/ns0:P_STATUS_ITEM
	            	let $DESCRIPTION :=  $outputParameters/ns0:P_DESCRIPTION/ns0:P_DESCRIPTION_ITEM
	            	for $i in 1 to count($CREDIT_LINE_ID)
	            	return(            	            	
		            	<CREDIT_LINE>
	                    	<ID>{ data($CREDIT_LINE_ID[$i]) }</ID>
	   						<TYPE>LCR</TYPE>  				
	                    	<CURRENCY>{ data($CREDIT_LINE_CURRENCY[$i]) }</CURRENCY>
	   						<OPENING_DATE>{ data($OPENING_DATE[$i]) }</OPENING_DATE>
	   						<EXPIRY_DATE>{ data($EXPIRY_DATE[$i]) }</EXPIRY_DATE>
	   						<AMOUNT>{ (data($AMOUNT[$i])) }</AMOUNT>
	   						<USED_AMOUNT>{ data($USED_AMOUNT[$i]) }</USED_AMOUNT>
	   						<AVAILABLE_AMOUNT>{ data($AVAILABLE_AMOUNT[$i]) }</AVAILABLE_AMOUNT>
	   						<STATUS>{ data($STATUS[$i]) }</STATUS> 
	   						<DESCRIPTION>{ data($DESCRIPTION[$i]) }</DESCRIPTION>  					 				                    
		            	</CREDIT_LINE>             	
		            )
                }                                     
            </CREDIT_LINES>
        </ns1:consultaLineasCreditoClienteResponse>
};

declare variable $outputParameters as element(ns0:OutputParameters) external;

xf:consultaLineasCreditoClienteHNOut($outputParameters)
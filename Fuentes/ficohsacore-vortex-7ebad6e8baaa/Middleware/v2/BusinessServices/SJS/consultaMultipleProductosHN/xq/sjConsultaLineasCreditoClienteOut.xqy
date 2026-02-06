xquery version "2004-draft" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns0:OutputParameters" location="../../../ABK/consultaLineasCreditoCliente/xsd/consultaLineasCreditoCliente_sp.xsd" ::)
(:: pragma bea:local-element-return type="ns1:sjConsultaMultipleProductosHNResponse/ns1:LIABILITIES/ns1:LIABILITY" location="../xsd/sjConsultaMultipleProductosHN.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/BusinessServices/SJS/consultaMultipleProductosHN/xq/sjConsultaLineasCreditoClienteOut1/";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaLineasCreditoCliente";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/sjConsultaMultipleProductosHN";

declare function formatearFecha($entrada as xs:string?){
let $fechaDateFormat := fn-bea:date-from-string-with-format("yyyyMMdd", $entrada)
         return
         fn-bea:date-to-string-with-format("yyyy-MM-dd", $fechaDateFormat)
};
declare function xf:sjConsultaLineasCreditoClienteOut1($outputParameters as element(ns0:OutputParameters))
    as element() {
 	if(string($outputParameters/ns0:P_SUCCESSINDICATOR/text()) = "SUCCESS") then
    (
     	if(count($outputParameters/ns0:P_CREDIT_LINE_ID/ns0:P_CREDIT_LINE_ID_ITEM) > 0)then(
	    	
	    	let $CREDIT_LINE_ID :=  $outputParameters/ns0:P_CREDIT_LINE_ID/ns0:P_CREDIT_LINE_ID_ITEM
	     	let $CUSTOMER_NAME :=  	$outputParameters/ns0:P_CUSTOMER_NAME
	     	let $CREDIT_LINE_CURRENCY :=  $outputParameters/ns0:P_CREDIT_LINE_CURRENCY/ns0:P_CREDIT_LINE_CURRENCY_ITEM
	     	let $AMOUNT :=  $outputParameters/ns0:P_AMOUNT/ns0:P_CREDIT_LINE_ID_ITEM
	     	let $EXPIRY_DATE :=  $outputParameters/ns0:P_EXPIRY_DATE/ns0:P_CREDIT_LINE_ID_ITEM
	     	let $AVAILABLE_AMOUNT :=  $outputParameters/ns0:P_AVAILABLE_AMOUNT/ns0:P_CREDIT_LINE_ID_ITEM
	     	let $USED_AMOUNT :=  $outputParameters/ns0:P_USED_AMOUNT/ns0:P_CREDIT_LINE_ID_ITEM
	     	let $OPENING_DATE :=  $outputParameters/ns0:P_OPENING_DATE/ns0:P_CREDIT_LINE_ID_ITEM
	     	for $i in 1 to count($CREDIT_LINE_ID)
				return(
					<ns1:LIABILITY>
						 <ns1:ID>{ data($CREDIT_LINE_ID [$i]) }</ns1:ID>
		        		 <ns1:PRODUCT_NAME>{ data($CUSTOMER_NAME) }</ns1:PRODUCT_NAME>
		        		 <ns1:BALANCES>
		                    <ns1:BALANCE>
		                        <ns1:CURRENCY>{ data($CREDIT_LINE_CURRENCY[$i]) }</ns1:CURRENCY>
		                        <ns1:TOTAL>{ data($AMOUNT[$i]) }</ns1:TOTAL>
		                    </ns1:BALANCE>
		                </ns1:BALANCES>
		                <ns1:NEXT_PAYMENT_DATE>{  formatearFecha(data($EXPIRY_DATE)) }</ns1:NEXT_PAYMENT_DATE>
		                <ns1:TSTANDING_TOTAL>{ data($AVAILABLE_AMOUNT[$i]) }</ns1:TSTANDING_TOTAL>
		                <ns1:TOTAL_AMOUNT>{ data($USED_AMOUNT[$i]) }</ns1:TOTAL_AMOUNT>
		                <ns1:TYPE>LCR</ns1:TYPE>
		                <ns1:OPENING_DATE>{  formatearFecha(data($OPENING_DATE[$i])) }</ns1:OPENING_DATE>
		           		<ns1:SOURCE_BANK>HN01</ns1:SOURCE_BANK>
			            <ns1:SUCCESS_INDICATOR>SUCCESS</ns1:SUCCESS_INDICATOR>
		            </ns1:LIABILITY>    
		    )
	    )else(
            <ns1:SOURCE_BANK>HN01</ns1:SOURCE_BANK>,
            <ns1:SUCCESS_INDICATOR>NO RECORDS</ns1:SUCCESS_INDICATOR>,
            <ns1:ERROR_MESSAGE>PRODUCTO NO ENCONTRADO</ns1:ERROR_MESSAGE>
	  )
	)else(
	  	<ns1:LIABILITY>
		    <ns1:SOURCE_BANK>HN01</ns1:SOURCE_BANK>
		    <ns1:SUCCESS_INDICATOR>{ data($outputParameters/ns0:P_SUCCESSINDICATOR) }</ns1:SUCCESS_INDICATOR>
            {
                for $ERROR_MESSAGE in $outputParameters/ns0:P_MESSAGES
                return
                    <ns1:ERROR_MESSAGE>{ data($ERROR_MESSAGE) }</ns1:ERROR_MESSAGE>
            }
	  	</ns1:LIABILITY>  
    )
};

declare variable $outputParameters as element(ns0:OutputParameters) external;

xf:sjConsultaLineasCreditoClienteOut1($outputParameters)
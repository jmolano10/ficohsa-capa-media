xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns1:OutputParameters" location="../../../BusinessServices/ABK/consultaProductosLineaCredito/xsd/consultaProductosLineaCredito_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultaProductosLineaCreditoMovimientosResponse" location="../../ConsultaProductosLineasCredito/xsd/consultaProductosLineasCreditoTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaProductosLineasCreditoTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaProductosLineaCredito";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaProductosLineaCreditoMovimientos/xq/consultaProductosLineaCreditoMovimientos/";

declare function convertirMoneda($moneda as xs:integer) as xs:string {
	
	if($moneda=1)then
		'HNL'
	else if($moneda=2)then
		'USD'
	else if($moneda=3)then
		'EUR'
	else
		''	
};

declare function xf:consultaProductosLineaCreditoMovimientos($outputParameters as element(ns1:OutputParameters),
    $initialRecord as xs:string)
    as element(ns0:consultaProductosLineaCreditoMovimientosResponse) {
        <ns0:consultaProductosLineaCreditoMovimientosResponse>
        {
        	let $LOAN_NUMBER :=  $outputParameters/ns1:P_LOAN_NUMBER/ns1:P_LOAN_NUMBER_ITEM
        	let $DATE := $outputParameters/ns1:P_DATE/ns1:P_DATE_ITEM
        	let $LOAN_STATUS :=  $outputParameters/ns1:P_LOAN_STATUS/ns1:P_LOAN_STATUS_ITEM
        	let $DESCRIPTION :=  $outputParameters/ns1:P_DESCRIPTION/ns1:P_DESCRIPTION_ITEM
        	let $INITIAL_AMOUNT :=  $outputParameters/ns1:P_INITIAL_AMOUNT/ns1:P_LOAN_NUMBER_ITEM
        	let $CURRENT_BALANCE :=  $outputParameters/ns1:P_CURRENT_BALANCE/ns1:P_LOAN_NUMBER_ITEM
        	let $CURRENCY :=  $outputParameters/ns1:P_CURRENCY/ns1:P_LOAN_NUMBER_ITEM
        	for $i in 1 to count($LOAN_NUMBER)
        	return(            	            	
	            <PRODUCT_LINE>
	                <LOAN_NUMBER>{ data($LOAN_NUMBER[$i]) }</LOAN_NUMBER>
	                <PRODUCT_DATE>{ fn-bea:date-to-string-with-format("yyyyMMdd",fn-bea:date-from-dateTime(data($DATE[$i])),()) }</PRODUCT_DATE>
	                <LOAN_STATUS>{ data($LOAN_STATUS[$i]) }</LOAN_STATUS>
	                <DESCRIPTION>{ data($DESCRIPTION[$i]) }</DESCRIPTION>
	                <INITIAL_AMOUNT>{ data($INITIAL_AMOUNT[$i]) }</INITIAL_AMOUNT>
	                <CURRENT_BALANCE>{ data($CURRENT_BALANCE[$i]) }</CURRENT_BALANCE>
	                <CURRENCY>{ convertirMoneda(data($CURRENCY[$i]))}</CURRENCY>
	            </PRODUCT_LINE> 
            )		
         }  
	     	<PAGING_INFO>
	     		<INITIAL_RECORD>{ data($initialRecord) }</INITIAL_RECORD>
	            <RECORDS_RETURNED>{ data($outputParameters/ns1:P_TOTAL_RECORDS_RETURNED) }</RECORDS_RETURNED>
	            <RECORDS_TOTAL>{ data($outputParameters/ns1:P_TOTAL_RECORD) }</RECORDS_TOTAL>
	        </PAGING_INFO>
        </ns0:consultaProductosLineaCreditoMovimientosResponse>
};

declare variable $outputParameters as element(ns1:OutputParameters) external;
declare variable $initialRecord as xs:string external;

xf:consultaProductosLineaCreditoMovimientos($outputParameters,
    $initialRecord)
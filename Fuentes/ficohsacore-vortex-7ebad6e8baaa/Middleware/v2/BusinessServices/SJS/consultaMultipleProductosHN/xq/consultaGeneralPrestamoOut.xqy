xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns0:OutputParameters" location="../../../../../Business_Resources/consultaGeneralPrestamo/Resources/ConsultaGeneralPrestamo/xsd/ORA_BANK_OSB_CON_GENERAL_PRESTAMO.xsd" ::)
(:: pragma bea:local-element-return type="ns1:sjConsultaMultipleProductosHNResponse/ns1:LIABILITIES/ns1:LIABILITY" location="../xsd/sjConsultaMultipleProductosHN.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/ORA_BANK/OSB_CON_GENERAL_PRESTAMO/";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/sjConsultaMultipleProductosHN";
declare namespace xf = "http://tempuri.org/Middleware/v2/BusinessServices/SJS/consultaMultipleProductosHN/xq/consultaGeneralPrestamoOut/";

declare function numIsNull($item as item()?) as xs:decimal {
	if (fn:string($item/text()) != '' ) then (
		round-half-to-even( xs:decimal(data($item)), 2 )
	) else (0.0)
};

declare function xf:consultaGeneralPrestamoOut($outputParameters as element(ns0:OutputParameters),
    $ID as xs:string,
    $TYPE as xs:string)
    as element() {
        <ns1:LIABILITY>
	        {
	        	if(string($outputParameters/ns0:ERROR_CODE/text()) = "SUCCESS") then
	        	(
	        		if(count($outputParameters/ns0:LOAN_CUSTOMER_NAME) > 0)then(
			            <ns1:ID>{ $ID }</ns1:ID>,
			            
			            for $LOAN_CUSTOMER_NAME in $outputParameters/ns0:LOAN_CUSTOMER_NAME
			            return
		                	<ns1:PRODUCT_NAME>{ data($LOAN_CUSTOMER_NAME) }</ns1:PRODUCT_NAME>,
		                	
			            <ns1:BALANCES>
			                <ns1:BALANCE>
			                    <ns1:CURRENCY>{ data($outputParameters/ns0:CURRENCY) }</ns1:CURRENCY>
			                    <ns1:PRINCIPAL>{ numIsNull($outputParameters/ns0:NEXT_PAYMNT_PRINCIPAL_AMT) }</ns1:PRINCIPAL>
			                    <ns1:INT_COMM>{ numIsNull( $outputParameters/ns0:NEXT_PAYMNT_INTEREST_AMT ) + numIsNull( $outputParameters/ns0:NEXT_PAYMNT_INSURANCE_AMT ) }</ns1:INT_COMM>
			                    <ns1:TOTAL>{ numIsNull($outputParameters/ns0:NEXT_PAYMNT_TOTAL_AMT) }</ns1:TOTAL>			                    
			        		</ns1:BALANCE>
			            </ns1:BALANCES>,
			            
		                for $NEXT_PAYMNT_MATURITY_DATE in $outputParameters/ns0:NEXT_PAYMNT_MATURITY_DATE
                        return
                        if(data($NEXT_PAYMNT_MATURITY_DATE) != '')then(
                        	<ns1:NEXT_PAYMENT_DATE>{ fn-bea:date-from-string-with-format("yyyyMMdd",data($NEXT_PAYMNT_MATURITY_DATE)) }</ns1:NEXT_PAYMENT_DATE>
                        )else(),
                        
                        <ns1:TSTANDING_TOTAL>{ numIsNull($outputParameters/ns0:NEXT_PAYMNT_TOTAL_AMT) }</ns1:TSTANDING_TOTAL>,
			        	<ns1:CANCELATION_TOTAL>{ numIsNull($outputParameters/ns0:TOTAL_DEBT) + numIsNull($outputParameters/ns0:NEXT_PAYMNT_INSURANCE_AMT) }</ns1:CANCELATION_TOTAL>,
			            <ns1:TOTAL_AMOUNT>{ numIsNull($outputParameters/ns0:NEXT_PAYMNT_TOTAL_AMT) }</ns1:TOTAL_AMOUNT>,
			            <ns1:TYPE>{ $TYPE }</ns1:TYPE>,
			            
			            for $EFFECTIVE_DATE in $outputParameters/ns0:EFFECTIVE_DATE
			            return
			            if (data($EFFECTIVE_DATE) != '') then(
			            	<ns1:OPENING_DATE>{ fn-bea:date-from-string-with-format("yyyyMMdd",data($EFFECTIVE_DATE)) }</ns1:OPENING_DATE>
			            )else(
			            	<ns1:OPENING_DATE>{ fn:adjust-date-to-timezone(fn:current-date(), ()) }</ns1:OPENING_DATE>
			            ),
			            <ns1:SOURCE_BANK>HN01</ns1:SOURCE_BANK>,
			            <ns1:SUCCESS_INDICATOR>SUCCESS</ns1:SUCCESS_INDICATOR>
			        )else(
			        	<ns1:ID>{ $ID }</ns1:ID>,
		            	<ns1:TYPE>{ $TYPE }</ns1:TYPE>,
		            	<ns1:SOURCE_BANK>HN01</ns1:SOURCE_BANK>,
		            	<ns1:SUCCESS_INDICATOR>NO RECORDS</ns1:SUCCESS_INDICATOR>,
		                <ns1:ERROR_MESSAGE>PRODUCTO NO ENCONTRADO</ns1:ERROR_MESSAGE>
				    )
		        )
	            else
	            (
	            	<ns1:ID>{ $ID }</ns1:ID>,
	            	<ns1:TYPE>{ $TYPE }</ns1:TYPE>,
	            	<ns1:SOURCE_BANK>HN01</ns1:SOURCE_BANK>,
	            	<ns1:SUCCESS_INDICATOR>{ data($outputParameters/ns0:ERROR_CODE) }</ns1:SUCCESS_INDICATOR>,
	                for $ERROR_MESSAGE in $outputParameters/ns0:ERROR_MESSAGE
	                return
	                    <ns1:ERROR_MESSAGE>{ data($ERROR_MESSAGE) }</ns1:ERROR_MESSAGE>
	            )
	        }
        </ns1:LIABILITY>
};

declare variable $outputParameters as element(ns0:OutputParameters) external;
declare variable $ID as xs:string external;
declare variable $TYPE as xs:string external;

xf:consultaGeneralPrestamoOut($outputParameters,
    $ID,
    $TYPE)
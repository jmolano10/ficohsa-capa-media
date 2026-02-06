xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns1:OutputParameters" location="../../../ABKGT/consultaGeneralPrestamo/xsd/ConsultaGeneralPrestamo_sp.xsd" ::)
(:: pragma bea:local-element-return type="ns0:sjConsultaMultipleProductosGTResponse/ns0:LIABILITIES/ns0:LIABILITY" location="../xsd/sjConsultaMultipleProductosGT.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/sjConsultaMultipleProductosGT";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/ConsultaGeneralPrestamo";
declare namespace xf = "http://tempuri.org/Middleware/v2/BusinessServices/SJS/consultaMultipleProductosGT/xq/consultaGeneralPrestamoOut/";

declare function numIsNull($item as item()?) as xs:decimal {
	if (fn:string($item/text()) != '' ) then (
		round-half-to-even( xs:decimal(data($item)), 2 )
	) else (0.0)
};

declare function xf:consultaGeneralPrestamoOut($outputParameters as element(ns1:OutputParameters),
    $ID as xs:string,
    $TYPE as xs:string)
    as element() {
        <ns0:LIABILITY>
        	<ns0:ID>{ $ID }</ns0:ID>
            {
            if(string($outputParameters/ns1:ERROR_CODE/text()) = "SUCCESS") then(
                <ns0:PRODUCT_NAME>{ data($outputParameters/ns1:LOAN_CUSTOMER_NAME) }</ns0:PRODUCT_NAME>,
                <ns0:BALANCES>
                    <ns0:BALANCE>
					 	<ns0:CURRENCY>{ data($outputParameters/ns1:CURRENCY) }</ns0:CURRENCY>,
					 	<ns0:PRINCIPAL>{ numIsNull($outputParameters/ns1:NEXT_PAYMNT_PRINCIPAL_AMT) }</ns0:PRINCIPAL>,
					 	<ns0:INT_COMM>{ numIsNull($outputParameters/ns1:NEXT_PAYMNT_INSURANCE_AMT) + numIsNull($outputParameters/ns1:NEXT_PAYMNT_INTEREST_AMT) }</ns0:INT_COMM>,
					 	<ns0:TOTAL>{ numIsNull($outputParameters/ns1:NEXT_PAYMNT_TOTAL_AMT) }</ns0:TOTAL>
					</ns0:BALANCE>
                </ns0:BALANCES>,
                
                if(fn:string($outputParameters/ns1:NEXT_PAYMNT_MATURITY_DATE/text()) != '') then(
                	<ns0:NEXT_PAYMENT_DATE>{ fn-bea:date-from-string-with-format('yyyyMMdd', data($outputParameters/ns1:NEXT_PAYMNT_MATURITY_DATE)) }</ns0:NEXT_PAYMENT_DATE>
                ) else(),
                
                <ns0:TSTANDING_TOTAL>{ numIsNull($outputParameters/ns1:TOTAL_DEBT) }</ns0:TSTANDING_TOTAL>,
                <ns0:CANCELATION_TOTAL>{ numIsNull($outputParameters/ns1:TOTAL_DEBT) + numIsNull($outputParameters/ns1:NEXT_PAYMNT_INSURANCE_AMT) }</ns0:CANCELATION_TOTAL>,
                <ns0:TOTAL_AMOUNT>0.0</ns0:TOTAL_AMOUNT>,            
                <ns0:TYPE>{ $TYPE }</ns0:TYPE>,
                if(fn:string($outputParameters/ns1:EFFECTIVE_DATE/text()) != '') then(
                	<ns0:OPENING_DATE>{ fn-bea:date-from-string-with-format('yyyyMMdd', (data($outputParameters/ns1:EFFECTIVE_DATE))) }</ns0:OPENING_DATE>
               	)else(
               		<ns0:OPENING_DATE>{ fn:adjust-date-to-timezone(fn:current-date(), ()) }</ns0:OPENING_DATE>
               	),
                <ns0:SOURCE_BANK>GT01</ns0:SOURCE_BANK>,
                <ns0:SUCCESS_INDICATOR>{ data($outputParameters/ns1:ERROR_CODE) }</ns0:SUCCESS_INDICATOR>
            )
            else
            (
                <ns0:TYPE>{ $TYPE }</ns0:TYPE>,
                <ns0:SOURCE_BANK>GT01</ns0:SOURCE_BANK>,
                <ns0:SUCCESS_INDICATOR>{ data($outputParameters/ns1:ERROR_CODE) }</ns0:SUCCESS_INDICATOR>,
                <ns0:ERROR_MESSAGE>{ data($outputParameters/ns1:ERROR_MESSAGE) }</ns0:ERROR_MESSAGE>
            )
        }
        </ns0:LIABILITY>
};

declare variable $outputParameters as element(ns1:OutputParameters) external;
declare variable $ID as xs:string external;
declare variable $TYPE as xs:string external;

xf:consultaGeneralPrestamoOut($outputParameters,
    $ID,
    $TYPE)
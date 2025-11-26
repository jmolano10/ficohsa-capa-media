(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns1:OutputParameters" location="../../../ABKPA/consultaGeneralPrestamo/xsd/consultaGeneralPrestamo_sp.xsd" ::)
(:: pragma bea:local-element-return type="ns0:sjConsultaMultiplesProductosPAResponse/ns0:LIABILITIES/ns0:LIABILITY" location="../xsd/sjConsultaMultipleProductosPA.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/sjConsultaMultiplesProductosPA";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaGeneralPrestamo";
declare namespace xf = "http://tempuri.org/Middleware/v2/BusinessServices/SJS/consultaMultipleProductosPA/xq/consultaGeneralPrestamosOut/";

declare function numIsNull($item as item()?) as xs:decimal {
	if (fn:string($item/text()) != '' ) then (
		round-half-to-even( xs:decimal(data($item)), 2 )
	) else (0.0)
};


declare function xf:consultaGeneralPrestamosOut($outputParameters as element(ns1:OutputParameters),
    $ID as xs:string,
    $Type as xs:string)
    as element() 
{
    if ( upper-case(data($outputParameters/ns1:ERROR_CODE)) = 'SUCCESS') then (
        <ns0:LIABILITY>
            <ns0:ID>{ $ID }</ns0:ID>
            <ns0:PRODUCT_NAME>{ data($outputParameters/ns1:LOAN_CUSTOMER_NAME) }</ns0:PRODUCT_NAME>
            <ns0:BALANCES>
                <ns0:BALANCE>
                    <ns0:CURRENCY>{ data($outputParameters/ns1:CURRENCY) }</ns0:CURRENCY>
                    <ns0:PRINCIPAL>{ numIsNull($outputParameters/ns1:NEXT_PAYMNT_PRINCIPAL_AMT) }</ns0:PRINCIPAL>
                    <ns0:INT_COMM>{ numIsNull($outputParameters/ns1:NEXT_PAYMNT_INTEREST_AMT) + numIsNull($outputParameters/ns1:NEXT_PAYMNT_INSURANCE_AMT) }</ns0:INT_COMM>
                    <ns0:TOTAL>{ numIsNull($outputParameters/ns1:NEXT_PAYMNT_TOTAL_AMT) }</ns0:TOTAL>
                </ns0:BALANCE>
            </ns0:BALANCES>
            {
	            if (data($outputParameters/ns1:NEXT_PAYMNT_MATURITY_DATE) != '') then (
	            	<ns0:NEXT_PAYMENT_DATE>{ fn-bea:date-from-string-with-format('yyyyMMdd',data($outputParameters/ns1:NEXT_PAYMNT_MATURITY_DATE)) }</ns0:NEXT_PAYMENT_DATE>
	            )
	            else ()
            }
            <ns0:TSTANDING_TOTAL>{ numIsNull($outputParameters/ns1:NEXT_PAYMNT_TOTAL_AMT) }</ns0:TSTANDING_TOTAL>
            <ns0:CANCELATION_TOTAL>{ numIsNull($outputParameters/ns1:TOTAL_DEBT) + numIsNull($outputParameters/ns1:NEXT_PAYMNT_INSURANCE_AMT) }</ns0:CANCELATION_TOTAL>
            <ns0:TOTAL_AMOUNT>0.0</ns0:TOTAL_AMOUNT>
            <ns0:TYPE>{ $Type }</ns0:TYPE>
            {
	            if (data($outputParameters/ns1:EFFECTIVE_DATE) != '') then (
	            	<ns0:OPENING_DATE>{  fn-bea:date-from-string-with-format("yyyyMMdd",data($outputParameters/ns1:EFFECTIVE_DATE)) }</ns0:OPENING_DATE>
	            )
	            else (
	            	<ns0:OPENING_DATE>{ fn:adjust-date-to-timezone(fn:current-date(), ()) }</ns0:OPENING_DATE>
	            )
            }
            <ns0:SOURCE_BANK>PA01</ns0:SOURCE_BANK>
            <ns0:SUCCESS_INDICATOR>{ data($outputParameters/ns1:ERROR_CODE) }</ns0:SUCCESS_INDICATOR>
        </ns0:LIABILITY>
    )
    else (
        <ns0:LIABILITY>
        	<ns0:ID>{ $ID }</ns0:ID>,
            <ns0:TYPE>{ $Type }</ns0:TYPE>,
            <ns0:SOURCE_BANK>PA01</ns0:SOURCE_BANK>,
            <ns0:SUCCESS_INDICATOR>{ upper-case(data($outputParameters/ns1:ERROR_CODE)) }</ns0:SUCCESS_INDICATOR>,
            <ns0:ERROR_MESSAGE>{data($outputParameters/ns1:ERROR_MESSAGE) }</ns0:ERROR_MESSAGE>
        </ns0:LIABILITY>
	)
};

declare variable $outputParameters as element(ns1:OutputParameters) external;
declare variable $ID as xs:string external;
declare variable $Type as xs:string external;

xf:consultaGeneralPrestamosOut($outputParameters,
    $ID,
    $Type)
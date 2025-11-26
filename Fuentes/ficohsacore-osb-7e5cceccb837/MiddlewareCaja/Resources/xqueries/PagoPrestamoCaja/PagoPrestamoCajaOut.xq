(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns1:OutputParameters" location="../../xsds/PagoPrestamoCaja/pagoPrestamoCajaAbanks/ORA_BANK_OSB_K_PAGO_PRESTAMO_TOPLEVEL-24OSB_PAG_PRESTAMO_CAJ.xsd" ::)
(:: pragma bea:global-element-return element="ns0:pagoPrestamoResponse" location="../../xsds/PagoPrestamoCaja/PagoPrestamoCaja.xsd" ::)

declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/ORA_BANK/OSB_K_PAGO_PRESTAMO/TOPLEVEL-24OSB_PAG_PRESTAMO_CAJ/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/pagoPrestamoTypes";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/PagoPrestamoCaja/PagoPrestamoCajaOut/";

declare function xf:PagoPrestamoCajaOut($error as xs:string,
	$monedaPrestamo as xs:string,
    $outputParameters as element(ns1:OutputParameters),
    $rteform as xs:string,
    $responseLoanNumber as xs:string)
    as element(ns0:pagoPrestamoResponse) {
    	if ( $error = "" ) then (
	        <ns0:pagoPrestamoResponse>
	            <DATE_TIME>{ data($outputParameters/ns1:DATE_TIME) }</DATE_TIME>
	            <LOAN_NUMBER>{ $responseLoanNumber }</LOAN_NUMBER>
	            <DUE_ID>{ data($outputParameters/ns1:DUE_ID) }</DUE_ID>
	            <PAYMENT_CURRENCY>{ $monedaPrestamo }</PAYMENT_CURRENCY>
	            <PAYMENT_AMOUNT>{ data($outputParameters/ns1:PAYMENT_AMOUNT) }</PAYMENT_AMOUNT>
	            <PAYMENT_SUBTOTAL_AMOUNT>{ data($outputParameters/ns1:PAYMENT_SUBTOTAL) }</PAYMENT_SUBTOTAL_AMOUNT>
	            <PAYMENT_ADVANCE>{ data($outputParameters/ns1:PAYMENT_ADVANCE) }</PAYMENT_ADVANCE>
	            <LOAN_CUSTOMER_NAME>{ data($outputParameters/ns1:LOAN_CUSTOMER_NAME) }</LOAN_CUSTOMER_NAME>
	            <INTEREST_RATE>{ data($outputParameters/ns1:INTEREST_RATE) }</INTEREST_RATE>
	            <EFFECTIVE_DATE>{ data($outputParameters/ns1:EFFECTIVE_DATE) }</EFFECTIVE_DATE>
	            <MATURITY_DATE>{ data($outputParameters/ns1:MATURITY_DATE) }</MATURITY_DATE>
	            <INTEREST_BALANCE>{ data($outputParameters/ns1:INTEREST_BALANCE) }</INTEREST_BALANCE>
	            <CURRENT_PRINCIPAL_BALANCE>{ data($outputParameters/ns1:CURRENT_PRINCIPAL_BALANCE) }</CURRENT_PRINCIPAL_BALANCE>
	            <PREVIOUS_PRINCIPAL_BALANCE>{ data($outputParameters/ns1:PREVIOUS_PRINCIPAL_BALANCE) }</PREVIOUS_PRINCIPAL_BALANCE>
	            <BILL_NUMBER>{ data($outputParameters/ns1:BILL_NUMBER) }</BILL_NUMBER>
	            <RTEFORM>{ $rteform }</RTEFORM>
	            <PAYMENT_DETAILS>
	                {
	                	let $labels := $outputParameters/ns1:DETAIL_LABELS/ns1:ITEM/text()
	                    let $values := $outputParameters/ns1:DETAIL_VALUES/ns1:ITEM/text()
	                    for $ITEM at $i in $labels
	                    return
	                    	if ( exists($labels[$i]) ) then (
		                        <DETAIL_RECORD>
		                            <LABEL>{ $labels[$i] }</LABEL>
		                            <VALUE>{ $values[$i] }</VALUE>
		                        </DETAIL_RECORD>
		                    ) else ()
	                }
	            </PAYMENT_DETAILS>
	        </ns0:pagoPrestamoResponse>
        ) else (
        	<ns0:pagoPrestamoResponse/>
        )
};

declare variable $error as xs:string external;
declare variable $monedaPrestamo as xs:string external;
declare variable $outputParameters as element(ns1:OutputParameters) external;
declare variable $rteform as xs:string external;
declare variable $responseLoanNumber as xs:string external;

xf:PagoPrestamoCajaOut($error,
	$monedaPrestamo,
    $outputParameters,
    $rteform,
    $responseLoanNumber)
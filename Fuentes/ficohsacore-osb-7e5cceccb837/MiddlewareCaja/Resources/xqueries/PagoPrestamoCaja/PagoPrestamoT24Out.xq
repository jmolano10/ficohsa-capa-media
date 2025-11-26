(:: pragma bea:global-element-parameter parameter="$pagoaprestamoAAResponse1" element="ns1:PagoaprestamoAAResponse" location="../../xsds/ConsultaGeneralPrestamo/consultaPrestamoT24/XMLSchema_448646516.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$sjConsultaPrestamoResponse1" element="ns2:sjConsultaPrestamoResponse" location="../../xsds/PagoPrestamoCaja/sjConsultaPrestamo.xsd" ::)
(:: pragma bea:global-element-return element="ns0:pagoPrestamoResponse" location="../../xsds/PagoPrestamoCaja/PagoPrestamoCaja.xsd" ::)

declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/sjConsultaPrestamoTypes";
declare namespace ns1 = "T24WebServicesImpl";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/pagoPrestamoTypes";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/PagoPrestamoCaja/PagoPrestamoT24Out/";

declare function xf:PagoPrestamoT24Out($pagoaprestamoAAResponse1 as element(ns1:PagoaprestamoAAResponse),
    $sjConsultaPrestamoResponse1 as element(ns2:sjConsultaPrestamoResponse))
    as element(ns0:pagoPrestamoResponse) {
        <ns0:pagoPrestamoResponse>
            <DATE_TIME>{ fn:concat("20",data($pagoaprestamoAAResponse1/TELLERFINANCIALSERVICESType/gDATETIME/DATETIME[1])) }</DATE_TIME>
            <LOAN_NUMBER>{ data($sjConsultaPrestamoResponse1/ns2:sjConsultaPrestamoResponseType/ns2:consultaPagoPrestamo/LOAN_NUMBER) }</LOAN_NUMBER>
            <DUE_ID>
            { 
            	let $PAID_INSTALLMENT_NO := fn:string($sjConsultaPrestamoResponse1/ns2:sjConsultaPrestamoResponseType/ns2:consultaPagoPrestamo/PAID_INSTALLMENT_NO/text())
            	return
            		if ($PAID_INSTALLMENT_NO != "") then (
            			$PAID_INSTALLMENT_NO
            		) else (
            			"OTROS PAGOS"
            		) 
            }</DUE_ID>
            <PAYMENT_CURRENCY>{ data($sjConsultaPrestamoResponse1/ns2:sjConsultaPrestamoResponseType/ns2:consultaDatosPrestamo/CURRENCY) }</PAYMENT_CURRENCY>
            <PAYMENT_AMOUNT>{ data($sjConsultaPrestamoResponse1/ns2:sjConsultaPrestamoResponseType/ns2:consultaPagoPrestamo/TOTAL_PAYMENT) }</PAYMENT_AMOUNT>
            <PAYMENT_SUBTOTAL_AMOUNT>{ data($sjConsultaPrestamoResponse1/ns2:sjConsultaPrestamoResponseType/ns2:consultaPagoPrestamo/TOTAL_PAYMENT) }</PAYMENT_SUBTOTAL_AMOUNT>
            <PAYMENT_ADVANCE>0.00</PAYMENT_ADVANCE>
            <LOAN_CUSTOMER_NAME>{ data($sjConsultaPrestamoResponse1/ns2:sjConsultaPrestamoResponseType/ns2:consultaDatosPrestamo/CUSTOMER_NAME) }</LOAN_CUSTOMER_NAME>
            <INTEREST_RATE>{ data($sjConsultaPrestamoResponse1/ns2:sjConsultaPrestamoResponseType/ns2:consultaDatosPrestamo/INTEREST_RATE) }</INTEREST_RATE>
            <EFFECTIVE_DATE>{ data($sjConsultaPrestamoResponse1/ns2:sjConsultaPrestamoResponseType/ns2:consultaDatosPrestamo/OPENING_DATE) }</EFFECTIVE_DATE>
            <MATURITY_DATE>{ data($sjConsultaPrestamoResponse1/ns2:sjConsultaPrestamoResponseType/ns2:consultaDatosPrestamo/MATURITY_DATE) }</MATURITY_DATE>
            <INTEREST_BALANCE>{ data($sjConsultaPrestamoResponse1/ns2:sjConsultaPrestamoResponseType/ns2:consultaDatosPrestamo/INTEREST_AMOUNT) }</INTEREST_BALANCE>
            <CURRENT_PRINCIPAL_BALANCE>{ data($sjConsultaPrestamoResponse1/ns2:sjConsultaPrestamoResponseType/ns2:consultaDatosPrestamo/CURRENT_PRIN_AMOUNT) }</CURRENT_PRINCIPAL_BALANCE>
            <PREVIOUS_PRINCIPAL_BALANCE>{ data($sjConsultaPrestamoResponse1/ns2:sjConsultaPrestamoResponseType/ns2:consultaDatosPrestamo/CURRENT_PRIN_AMOUNT) }</PREVIOUS_PRINCIPAL_BALANCE>
            <BILL_NUMBER>
            { 
            	let $PAID_INSTALLMENT_NO := fn:string($sjConsultaPrestamoResponse1/ns2:sjConsultaPrestamoResponseType/ns2:consultaPagoPrestamo/PAID_INSTALLMENT_NO/text())
            	return
            		if ($PAID_INSTALLMENT_NO != "") then (
            			$PAID_INSTALLMENT_NO
            		) else (
            			"OTROS PAGOS"
            		)              
            }</BILL_NUMBER>
            <RTEFORM>{ data($pagoaprestamoAAResponse1/TELLERFINANCIALSERVICESType/RTEFORM) }</RTEFORM>
            <PAYMENT_DETAILS>
                <DETAIL_RECORD>
                    <LABEL>CAPITAL</LABEL>
                    {
                        for $PRINCIPAL_AMOUNT in $sjConsultaPrestamoResponse1/ns2:sjConsultaPrestamoResponseType/ns2:consultaPagoPrestamo/PAYMENT_DETAILS/PAYMENT_DETAIL[PAYMENT_TYPE="PRINCIPAL"]/PAYMENT_VALUE
                        return
                            <VALUE>{ fn-bea:format-number(data($PRINCIPAL_AMOUNT),"###.00") }</VALUE>
                    }
                </DETAIL_RECORD>
                <DETAIL_RECORD>
                    <LABEL>INTERESES</LABEL>
                    {
	                    let $PRINCIPAL_INT := fn:string($sjConsultaPrestamoResponse1/ns2:sjConsultaPrestamoResponseType/ns2:consultaPagoPrestamo/PAYMENT_DETAILS/PAYMENT_DETAIL[PAYMENT_TYPE="PRINCIPAL_INT"]/PAYMENT_VALUE/text())
	                    let $PENALTY_INT := fn:string($sjConsultaPrestamoResponse1/ns2:sjConsultaPrestamoResponseType/ns2:consultaPagoPrestamo/PAYMENT_DETAILS/PAYMENT_DETAIL[PAYMENT_TYPE="PENALTY_INT"]/PAYMENT_VALUE/text())
	                    return
	                    	<VALUE>{ fn-bea:format-number(fn:number($PRINCIPAL_INT)+fn:number($PENALTY_INT),"###.00") }</VALUE>
                    }
                </DETAIL_RECORD>                
            </PAYMENT_DETAILS>
        </ns0:pagoPrestamoResponse>
};

declare variable $pagoaprestamoAAResponse1 as element(ns1:PagoaprestamoAAResponse) external;
declare variable $sjConsultaPrestamoResponse1 as element(ns2:sjConsultaPrestamoResponse) external;

xf:PagoPrestamoT24Out($pagoaprestamoAAResponse1,
    $sjConsultaPrestamoResponse1)
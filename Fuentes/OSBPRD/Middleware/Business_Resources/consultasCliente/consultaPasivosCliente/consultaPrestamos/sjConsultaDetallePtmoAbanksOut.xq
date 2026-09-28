(:: pragma bea:global-element-parameter parameter="$consultaGeneralPrestamo1" element="ns1:consultaGeneralPrestamo" location="../../../consultaGeneralPrestamo/consultaGeneralPrestamoTypes.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultaGeneralPrestamoResponse1" element="ns1:consultaGeneralPrestamoResponse" location="../../../consultaGeneralPrestamo/consultaGeneralPrestamoTypes.xsd" ::)
(:: pragma bea:local-element-return type="ns0:ConsultaPrestamoTypeResponse/ns0:LOAN_DETAILS/ns0:LOAN_DETAIL" location="ConsultaPrestamosCliente.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaGeneralPrestamoTypes";
declare namespace ns0 = "ConsultaPrestamosCliente";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/consultasCliente/consultaPasivosCliente/consultaPrestamos/sjConsultaDetallePtmoAbanksOut/";

declare function xf:sjConsultaDetallePtmoAbanksOut($consultaGeneralPrestamo1 as element(ns1:consultaGeneralPrestamo),
    $consultaGeneralPrestamoResponse1 as element(ns1:consultaGeneralPrestamoResponse))
    as element() {
        <ns0:LOAN_DETAIL>
        	<ns0:RESPONSE_HEADER>
        		{
        			if (fn:string($consultaGeneralPrestamoResponse1/ns1:consultaGeneralPrestamoResponseType/ns1:consultaGeneralPrestamoResponseRecordType/LOAN_CUSTOMER_NAME/text()) != "") then (
        				<SUCCESS_INDICATOR>Success</SUCCESS_INDICATOR>
        			) else (
        				<SUCCESS_INDICATOR>ERROR</SUCCESS_INDICATOR>
        			)
        		}
        	</ns0:RESPONSE_HEADER>
            <ns0:RESPONSE_BODY>
                <ns0:LOAN_ID>{ data($consultaGeneralPrestamo1/LOAN_ID) }</ns0:LOAN_ID>
                {
                    for $LOAN_CUSTOMER_NAME in $consultaGeneralPrestamoResponse1/ns1:consultaGeneralPrestamoResponseType/ns1:consultaGeneralPrestamoResponseRecordType/LOAN_CUSTOMER_NAME
                    return
                        <ns0:LOAN_CUSTOMER_NAME>{ data($LOAN_CUSTOMER_NAME) }</ns0:LOAN_CUSTOMER_NAME>
                }
                {
                    for $EFFECTIVE_DATE in $consultaGeneralPrestamoResponse1/ns1:consultaGeneralPrestamoResponseType/ns1:consultaGeneralPrestamoResponseRecordType/EFFECTIVE_DATE
                    return
                        <ns0:EFFECTIVE_DATE>{ data($EFFECTIVE_DATE) }</ns0:EFFECTIVE_DATE>
                }
                {
                    for $MATURITY_DATE in $consultaGeneralPrestamoResponse1/ns1:consultaGeneralPrestamoResponseType/ns1:consultaGeneralPrestamoResponseRecordType/MATURITY_DATE
                    return
                        <ns0:MATURITY_DATE>{ data($MATURITY_DATE) }</ns0:MATURITY_DATE>
                }
                {
                    for $INTEREST_RATE in $consultaGeneralPrestamoResponse1/ns1:consultaGeneralPrestamoResponseType/ns1:consultaGeneralPrestamoResponseRecordType/INTEREST_RATE
                    return
                        <ns0:INTEREST_RATE>{ data($INTEREST_RATE) }</ns0:INTEREST_RATE>
                }
                {
                    for $PRINCIPAL_INITIAL_AMT in $consultaGeneralPrestamoResponse1/ns1:consultaGeneralPrestamoResponseType/ns1:consultaGeneralPrestamoResponseRecordType/PRINCIPAL_INITIAL_AMT
                    return
                        <ns0:PRINCIPAL_INITIAL_AMT>{ data($PRINCIPAL_INITIAL_AMT) }</ns0:PRINCIPAL_INITIAL_AMT>
                }
                {
                    for $PRINCIPAL_DUE_AMT in $consultaGeneralPrestamoResponse1/ns1:consultaGeneralPrestamoResponseType/ns1:consultaGeneralPrestamoResponseRecordType/PRINCIPAL_DUE_AMT
                    return
                        <ns0:PRINCIPAL_DUE_AMT>{ data($PRINCIPAL_DUE_AMT) }</ns0:PRINCIPAL_DUE_AMT>
                }
                {
                    for $PRINCIPAL_OVERDUE_AMT in $consultaGeneralPrestamoResponse1/ns1:consultaGeneralPrestamoResponseType/ns1:consultaGeneralPrestamoResponseRecordType/PRINCIPAL_OVERDUE_AMT
                    return
                        <ns0:PRINCIPAL_OVERDUE_AMT>{ data($PRINCIPAL_OVERDUE_AMT) }</ns0:PRINCIPAL_OVERDUE_AMT>
                }
                {
                    for $INTEREST_AMOUNT in $consultaGeneralPrestamoResponse1/ns1:consultaGeneralPrestamoResponseType/ns1:consultaGeneralPrestamoResponseRecordType/INTEREST_AMOUNT
                    return
                        <ns0:INTEREST_AMOUNT>{ data($INTEREST_AMOUNT) }</ns0:INTEREST_AMOUNT>
                }
                {
                    for $OVERDUE_INTEREST_AMOUNT in $consultaGeneralPrestamoResponse1/ns1:consultaGeneralPrestamoResponseType/ns1:consultaGeneralPrestamoResponseRecordType/OVERDUE_INTEREST_AMOUNT
                    return
                        <ns0:OVERDUE_INTEREST_AMOUNT>{ data($OVERDUE_INTEREST_AMOUNT) }</ns0:OVERDUE_INTEREST_AMOUNT>
                }
                {
                    for $COMISION_AMOUNT in $consultaGeneralPrestamoResponse1/ns1:consultaGeneralPrestamoResponseType/ns1:consultaGeneralPrestamoResponseRecordType/COMISION_AMOUNT
                    return
                        <ns0:COMISION_AMOUNT>{ data($COMISION_AMOUNT) }</ns0:COMISION_AMOUNT>
                }
                {
                    for $TOTAL_DEBT in $consultaGeneralPrestamoResponse1/ns1:consultaGeneralPrestamoResponseType/ns1:consultaGeneralPrestamoResponseRecordType/TOTAL_DEBT
                    return
                        <ns0:TOTAL_DEBT>{ data($TOTAL_DEBT) }</ns0:TOTAL_DEBT>
                }
                {
                    for $NEXT_PAYMNT_ID in $consultaGeneralPrestamoResponse1/ns1:consultaGeneralPrestamoResponseType/ns1:consultaGeneralPrestamoResponseRecordType/NEXT_PAYMNT_ID
                    return
                        <ns0:NEXT_PAYMNT_ID>{ data($NEXT_PAYMNT_ID) }</ns0:NEXT_PAYMNT_ID>
                }
                {
                    for $NEXT_PAYMNT_MATURITY_DATE in $consultaGeneralPrestamoResponse1/ns1:consultaGeneralPrestamoResponseType/ns1:consultaGeneralPrestamoResponseRecordType/NEXT_PAYMNT_MATURITY_DATE
                    return
                        <ns0:NEXT_PAYMNT_MATURITY_DATE>{ data($NEXT_PAYMNT_MATURITY_DATE) }</ns0:NEXT_PAYMNT_MATURITY_DATE>
                }
                {
                    for $OVERDUE_PAYMENTS in $consultaGeneralPrestamoResponse1/ns1:consultaGeneralPrestamoResponseType/ns1:consultaGeneralPrestamoResponseRecordType/OVERDUE_PAYMENTS
                    return
                        <ns0:OVERDUE_PAYMENTS>{ data($OVERDUE_PAYMENTS) }</ns0:OVERDUE_PAYMENTS>
                }
                {
                    for $NEXT_PAYMNT_PRINCIPAL_AMT in $consultaGeneralPrestamoResponse1/ns1:consultaGeneralPrestamoResponseType/ns1:consultaGeneralPrestamoResponseRecordType/NEXT_PAYMNT_PRINCIPAL_AMT
                    return
                        <ns0:NEXT_PAYMNT_PRINCIPAL_AMT>{ data($NEXT_PAYMNT_PRINCIPAL_AMT) }</ns0:NEXT_PAYMNT_PRINCIPAL_AMT>
                }
                {
                    for $NEXT_PAYMNT_INTEREST_AMT in $consultaGeneralPrestamoResponse1/ns1:consultaGeneralPrestamoResponseType/ns1:consultaGeneralPrestamoResponseRecordType/NEXT_PAYMNT_INTEREST_AMT
                    return
                        <ns0:NEXT_PAYMNT_INTEREST_AMT>{ data($NEXT_PAYMNT_INTEREST_AMT) }</ns0:NEXT_PAYMNT_INTEREST_AMT>
                }
                {
                    for $NEXT_PAYMNT_INSURANCE_AMT in $consultaGeneralPrestamoResponse1/ns1:consultaGeneralPrestamoResponseType/ns1:consultaGeneralPrestamoResponseRecordType/NEXT_PAYMNT_INSURANCE_AMT
                    return
                        <ns0:NEXT_PAYMNT_INSURANCE_AMT>{ data($NEXT_PAYMNT_INSURANCE_AMT) }</ns0:NEXT_PAYMNT_INSURANCE_AMT>
                }
                {
                    for $NEXT_PAYMNT_TOTAL_AMT in $consultaGeneralPrestamoResponse1/ns1:consultaGeneralPrestamoResponseType/ns1:consultaGeneralPrestamoResponseRecordType/NEXT_PAYMNT_TOTAL_AMT
                    return
                        <ns0:NEXT_PAYMNT_TOTAL_AMT>{ data($NEXT_PAYMNT_TOTAL_AMT) }</ns0:NEXT_PAYMNT_TOTAL_AMT>
                }
                {
                    for $CURRENCY in $consultaGeneralPrestamoResponse1/ns1:consultaGeneralPrestamoResponseType/ns1:consultaGeneralPrestamoResponseRecordType/CURRENCY
                    return
                        <ns0:CURRENCY>{ data($CURRENCY) }</ns0:CURRENCY>
                }
            </ns0:RESPONSE_BODY>
        </ns0:LOAN_DETAIL>
};

declare variable $consultaGeneralPrestamo1 as element(ns1:consultaGeneralPrestamo) external;
declare variable $consultaGeneralPrestamoResponse1 as element(ns1:consultaGeneralPrestamoResponse) external;

xf:sjConsultaDetallePtmoAbanksOut($consultaGeneralPrestamo1,
    $consultaGeneralPrestamoResponse1)
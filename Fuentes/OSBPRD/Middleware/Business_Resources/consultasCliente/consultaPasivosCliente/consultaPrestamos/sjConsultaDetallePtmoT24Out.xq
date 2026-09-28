(:: pragma bea:global-element-parameter parameter="$consultadesaldodeprestamoResponse1" element="ns0:ConsultadesaldodeprestamoResponse" location="../../../consultaGeneralPrestamo/Resources/consultaPrestamoT24/XMLSchema_448646516.xsd" ::)
(:: pragma bea:local-element-return type="ns1:ConsultaPrestamoTypeResponse/ns1:LOAN_DETAILS/ns1:LOAN_DETAIL" location="ConsultaPrestamosCliente.xsd" ::)

declare namespace ns1 = "ConsultaPrestamosCliente";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/consultasCliente/consultaPasivosCliente/consultaPrestamos/sjConsultaDetallePtmoT24Out2/";

declare function xf:sjConsultaDetallePtmoT24Out2($loanNumber as xs:string,
    $consultadesaldodeprestamoResponse1 as element(ns0:ConsultadesaldodeprestamoResponse))
    as element() {
        <ns1:LOAN_DETAIL>
            <ns1:RESPONSE_HEADER>
                <ns1:SUCCESS_INDICATOR>{ data($consultadesaldodeprestamoResponse1/Status/successIndicator) }</ns1:SUCCESS_INDICATOR>
            </ns1:RESPONSE_HEADER>
            <ns1:RESPONSE_BODY>
                <ns1:LOAN_ID>{ $loanNumber }</ns1:LOAN_ID>
                {
                    for $CUSTOMERNAME in $consultadesaldodeprestamoResponse1/WSLOANDETAILSAAType[1]/gWSLOANDETAILSAADetailType/mWSLOANDETAILSAADetailType[1]/CUSTOMERNAME
                    return
                        <ns1:LOAN_CUSTOMER_NAME>{ data($CUSTOMERNAME) }</ns1:LOAN_CUSTOMER_NAME>
                }
                {
                    for $OPENINGDATE in $consultadesaldodeprestamoResponse1/WSLOANDETAILSAAType[1]/gWSLOANDETAILSAADetailType/mWSLOANDETAILSAADetailType[1]/OPENINGDATE
                    return
                        <ns1:EFFECTIVE_DATE>{ data($OPENINGDATE) }</ns1:EFFECTIVE_DATE>
                }
                {
                    for $MATURITYDATE in $consultadesaldodeprestamoResponse1/WSLOANDETAILSAAType[1]/gWSLOANDETAILSAADetailType/mWSLOANDETAILSAADetailType[1]/MATURITYDATE
                    return
                        <ns1:MATURITY_DATE>{ data($MATURITYDATE) }</ns1:MATURITY_DATE>
                }
                {
                    for $INTERESTRATE in $consultadesaldodeprestamoResponse1/WSLOANDETAILSAAType[1]/gWSLOANDETAILSAADetailType/mWSLOANDETAILSAADetailType[1]/INTERESTRATE
                    return
                        <ns1:INTEREST_RATE>{ data($INTERESTRATE) }</ns1:INTEREST_RATE>
                }
                {
                    for $INITPRINAMT in $consultadesaldodeprestamoResponse1/WSLOANDETAILSAAType[1]/gWSLOANDETAILSAADetailType/mWSLOANDETAILSAADetailType[1]/INITPRINAMT
                    return
                        <ns1:PRINCIPAL_INITIAL_AMT>{ data($INITPRINAMT) }</ns1:PRINCIPAL_INITIAL_AMT>
                }
                {
                    for $CURPRINAMT in $consultadesaldodeprestamoResponse1/WSLOANDETAILSAAType[1]/gWSLOANDETAILSAADetailType/mWSLOANDETAILSAADetailType[1]/CURPRINAMT
                    return
                        <ns1:PRINCIPAL_DUE_AMT>{ data($CURPRINAMT) }</ns1:PRINCIPAL_DUE_AMT>
                }
                {
                    for $PASTDUEPRIN in $consultadesaldodeprestamoResponse1/WSLOANDETAILSAAType[1]/gWSLOANDETAILSAADetailType/mWSLOANDETAILSAADetailType[1]/PASTDUEPRIN
                    return
                        <ns1:PRINCIPAL_OVERDUE_AMT>{ data($PASTDUEPRIN) }</ns1:PRINCIPAL_OVERDUE_AMT>
                }
                {
                    for $INTERESTAMOUNT in $consultadesaldodeprestamoResponse1/WSLOANDETAILSAAType[1]/gWSLOANDETAILSAADetailType/mWSLOANDETAILSAADetailType[1]/INTERESTAMOUNT
                    return
                        <ns1:INTEREST_AMOUNT>{ data($INTERESTAMOUNT) }</ns1:INTEREST_AMOUNT>
                }
                {
                    for $ARRINTAMOUNT in $consultadesaldodeprestamoResponse1/WSLOANDETAILSAAType[1]/gWSLOANDETAILSAADetailType/mWSLOANDETAILSAADetailType[1]/ARRINTAMOUNT
                    return
                        <ns1:OVERDUE_INTEREST_AMOUNT>{ data($ARRINTAMOUNT) }</ns1:OVERDUE_INTEREST_AMOUNT>
                }
                {
                    for $COMMAMOUNT in $consultadesaldodeprestamoResponse1/WSLOANDETAILSAAType[1]/gWSLOANDETAILSAADetailType/mWSLOANDETAILSAADetailType[1]/COMMAMOUNT
                    return
                        <ns1:COMISION_AMOUNT>{ data($COMMAMOUNT) }</ns1:COMISION_AMOUNT>
                }
                {
                    for $TOTDEBITAMOUNT in $consultadesaldodeprestamoResponse1/WSLOANDETAILSAAType[1]/gWSLOANDETAILSAADetailType/mWSLOANDETAILSAADetailType[1]/TOTDEBITAMOUNT
                    return
                        <ns1:TOTAL_DEBT>{ data($TOTDEBITAMOUNT) }</ns1:TOTAL_DEBT>
                }
                {
                    for $PAIDINSNO in $consultadesaldodeprestamoResponse1/WSLOANDETAILSAAType[1]/gWSLOANDETAILSAADetailType/mWSLOANDETAILSAADetailType[1]/PAIDINSNO
                    return
                        <ns1:NEXT_PAYMNT_ID>{ data($PAIDINSNO) }</ns1:NEXT_PAYMNT_ID>
                }
                {
                    for $INSTDUEDATE in $consultadesaldodeprestamoResponse1/WSLOANDETAILSAAType[1]/gWSLOANDETAILSAADetailType/mWSLOANDETAILSAADetailType[1]/INSTDUEDATE
                    return
                        <ns1:NEXT_PAYMNT_MATURITY_DATE>{ data($INSTDUEDATE) }</ns1:NEXT_PAYMNT_MATURITY_DATE>
                }
                {
                    for $UNPAIDINSTNO in $consultadesaldodeprestamoResponse1/WSLOANDETAILSAAType[1]/gWSLOANDETAILSAADetailType/mWSLOANDETAILSAADetailType[1]/UNPAIDINSTNO
                    return
                        <ns1:OVERDUE_PAYMENTS>{ data($UNPAIDINSTNO) }</ns1:OVERDUE_PAYMENTS>
                }
                {
                    for $CURINSPRINAMT in $consultadesaldodeprestamoResponse1/WSLOANDETAILSAAType[1]/gWSLOANDETAILSAADetailType/mWSLOANDETAILSAADetailType[1]/CURINSPRINAMT
                    return
                        <ns1:NEXT_PAYMNT_PRINCIPAL_AMT>{ data($CURINSPRINAMT) }</ns1:NEXT_PAYMNT_PRINCIPAL_AMT>
                }
                {
                    for $CURINSINTEREST in $consultadesaldodeprestamoResponse1/WSLOANDETAILSAAType[1]/gWSLOANDETAILSAADetailType/mWSLOANDETAILSAADetailType[1]/CURINSINTEREST
                    return
                        <ns1:NEXT_PAYMNT_INTEREST_AMT>{ data($CURINSINTEREST) }</ns1:NEXT_PAYMNT_INTEREST_AMT>
                }
                {
                    for $CURINSINSUR in $consultadesaldodeprestamoResponse1/WSLOANDETAILSAAType[1]/gWSLOANDETAILSAADetailType/mWSLOANDETAILSAADetailType[1]/CURINSINSUR
                    return
                        <ns1:NEXT_PAYMNT_INSURANCE_AMT>{ data($CURINSINSUR) }</ns1:NEXT_PAYMNT_INSURANCE_AMT>
                }
                {
                    for $CURINSTOTAMT in $consultadesaldodeprestamoResponse1/WSLOANDETAILSAAType[1]/gWSLOANDETAILSAADetailType/mWSLOANDETAILSAADetailType[1]/CURINSTOTAMT
                    return
                        <ns1:NEXT_PAYMNT_TOTAL_AMT>{ data($CURINSTOTAMT) }</ns1:NEXT_PAYMNT_TOTAL_AMT>
                }
                {
                    for $CURRENCY in $consultadesaldodeprestamoResponse1/WSLOANDETAILSAAType[1]/gWSLOANDETAILSAADetailType/mWSLOANDETAILSAADetailType[1]/CURRENCY
                    return
                        <ns1:CURRENCY>{ data($CURRENCY) }</ns1:CURRENCY>
                }
            </ns1:RESPONSE_BODY>
        </ns1:LOAN_DETAIL>
};

declare variable $loanNumber as xs:string external;
declare variable $consultadesaldodeprestamoResponse1 as element(ns0:ConsultadesaldodeprestamoResponse) external;

xf:sjConsultaDetallePtmoT24Out2($loanNumber,
    $consultadesaldodeprestamoResponse1)
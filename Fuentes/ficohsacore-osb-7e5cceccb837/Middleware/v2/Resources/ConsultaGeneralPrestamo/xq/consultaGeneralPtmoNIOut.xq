(:: pragma bea:global-element-parameter parameter="$opConsultaPrestamoRespuesta" element="ns2:opConsultaPrestamoRespuesta" location="../../../BusinessServices/CTS/prestamo/xsd/services.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaGeneralPrestamoResponse" location="../xsd/consultaGeneralPrestamoTypes.xsd" ::)

declare namespace ns2 = "http://service.srvaplcobisprestamo.ecobis.cobiscorp";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaGeneralPrestamoTypes";
declare namespace ns0 = "http://dto.srvaplcobisentidades.ecobis.cobiscorp";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaGeneralPrestamo/xq/consultaGeneralPtmoNIOut/";

declare function convertirFecha($date as element(*)?) 
    as xs:string {
        if (fn-bea:trim(xs:string($date)) != '') then
            fn-bea:dateTime-to-string-with-format("yyyyMMdd", $date)  
        else ("")
};

declare function redondear($valor as element(*)?) 
    as xs:string {
        if (fn-bea:trim(xs:string(data($valor))) != '') then
            xs:string(fn:round-half-to-even(xs:decimal($valor), 2)) 
        else ("")
};

declare function convertirStringFechaString($stringDate as xs:string?)
    as xs:string {
        if (fn-bea:trim($stringDate) != '') then 
            let $date := fn-bea:date-from-string-with-format("yyyy-MM-dd", $stringDate)
            return fn-bea:date-to-string-with-format("yyyyMMdd", $date)  
        else ("")
};

declare function xf:consultaGeneralPtmoNIOut($opConsultaPrestamoRespuesta as element(ns2:opConsultaPrestamoRespuesta))
    as element(ns1:consultaGeneralPrestamoResponse) {
        <ns1:consultaGeneralPrestamoResponse>
            <ns1:consultaGeneralPrestamoResponseType>
                <ns1:consultaGeneralPrestamoResponseRecordType>
                    <LOAN_CUSTOMER_NAME>{ data($opConsultaPrestamoRespuesta/ns0:prestamo/ns0:cliente/ns0:nombreCompleto) }</LOAN_CUSTOMER_NAME>
                    <EFFECTIVE_DATE>{ convertirFecha($opConsultaPrestamoRespuesta/ns0:prestamo/ns0:fecAprobacion) }</EFFECTIVE_DATE>
                    <MATURITY_DATE>{ convertirFecha($opConsultaPrestamoRespuesta/ns0:prestamo/ns0:fecVencimiento) }</MATURITY_DATE>
                    <INTEREST_RATE>{ redondear($opConsultaPrestamoRespuesta/ns0:prestamo/ns0:tasaInteres) }</INTEREST_RATE>
                    <PRINCIPAL_INITIAL_AMT>{ redondear($opConsultaPrestamoRespuesta/ns0:prestamo/ns0:valInicialPrestamo) }</PRINCIPAL_INITIAL_AMT>
                    <PRINCIPAL_DUE_AMT>{ redondear($opConsultaPrestamoRespuesta/ns0:prestamo/ns0:valDeudaPrincipal) }</PRINCIPAL_DUE_AMT>
                    <PRINCIPAL_OVERDUE_AMT>{ redondear($opConsultaPrestamoRespuesta/ns0:prestamo/ns0:valVencidoPrincipal) }</PRINCIPAL_OVERDUE_AMT>
                    <INTEREST_AMOUNT>{ redondear($opConsultaPrestamoRespuesta/ns0:prestamo/ns0:valInteres) }</INTEREST_AMOUNT>
                    <OVERDUE_INTEREST_AMOUNT>{ redondear($opConsultaPrestamoRespuesta/ns0:prestamo/ns0:valInteresVencido) }</OVERDUE_INTEREST_AMOUNT>
                    <COMISION_AMOUNT>{ redondear($opConsultaPrestamoRespuesta/ns0:prestamo/ns0:valComision) }</COMISION_AMOUNT>
                    <TOTAL_DEBT>{ redondear($opConsultaPrestamoRespuesta/ns0:prestamo/ns0:valDeudaTotal) }</TOTAL_DEBT>
                    <NEXT_PAYMNT_ID>{ data($opConsultaPrestamoRespuesta/ns0:prestamo/ns0:idProximoPago) }</NEXT_PAYMNT_ID>
                    <NEXT_PAYMNT_MATURITY_DATE>{ convertirStringFechaString(data($opConsultaPrestamoRespuesta/ns0:prestamo/ns0:diaDePago)) }</NEXT_PAYMNT_MATURITY_DATE>
                    <OVERDUE_PAYMENTS>{ data($opConsultaPrestamoRespuesta/ns0:prestamo/ns0:nroPagosVencidos) }</OVERDUE_PAYMENTS>
                    <NEXT_PAYMNT_PRINCIPAL_AMT>{ redondear($opConsultaPrestamoRespuesta/ns0:prestamo/ns0:valCapProxPago) }</NEXT_PAYMNT_PRINCIPAL_AMT>
                    <NEXT_PAYMNT_INTEREST_AMT>{ redondear($opConsultaPrestamoRespuesta/ns0:prestamo/ns0:valIntProxPago) }</NEXT_PAYMNT_INTEREST_AMT>
                    <NEXT_PAYMNT_INSURANCE_AMT>{ redondear($opConsultaPrestamoRespuesta/ns0:prestamo/ns0:valSeguroProxPago) }</NEXT_PAYMNT_INSURANCE_AMT>
                    <NEXT_PAYMNT_TOTAL_AMT>{ redondear($opConsultaPrestamoRespuesta/ns0:prestamo/ns0:valTotProxPago) }</NEXT_PAYMNT_TOTAL_AMT>
                    <CURRENCY>{ data($opConsultaPrestamoRespuesta/ns0:prestamo/ns0:moneda/ns0:valTipoMoneda) }</CURRENCY>
                    <LAST_DISBURSEMENT_DATE>{ convertirFecha($opConsultaPrestamoRespuesta/ns0:prestamo/ns0:fecDesembolso) }</LAST_DISBURSEMENT_DATE>
                    <EXPIRED_INTEREST_AMOUNT>{ redondear($opConsultaPrestamoRespuesta/ns0:prestamo/ns0:valInteresMora) }</EXPIRED_INTEREST_AMOUNT>
                </ns1:consultaGeneralPrestamoResponseRecordType>
            </ns1:consultaGeneralPrestamoResponseType>
        </ns1:consultaGeneralPrestamoResponse>
};

declare variable $opConsultaPrestamoRespuesta as element(ns2:opConsultaPrestamoRespuesta) external;

xf:consultaGeneralPtmoNIOut($opConsultaPrestamoRespuesta)
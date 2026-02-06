xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$opConsultaPrestamoRespuesta1" element="ns5:opConsultaPrestamoRespuesta" location="../../../BusinessServices/CTS/prestamo/xsd/services.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$opConsultaPagoPrestamoRespuesta1" element="ns4:opConsultaPagoPrestamoRespuesta" location="../../../BusinessServices/CTS/consultaCuotaPagoPrestamo/xsd/services.xsd" ::)
(:: pragma bea:global-element-return element="ns3:consultaMovimientosPagoPrestamoResponse" location="../xsd/consultaMovimientosPagoPrestamoTypes.xsd" ::)

declare namespace ns2 = "http://dto2.commons.ecobis.cobiscorp";
declare namespace ns1 = "http://dto.srvaplcobisentidades.ecobis.cobiscorp";
declare namespace ns4 = "http://service.srvaplcobisconsultaprestamo.ecobis.cobiscorp";
declare namespace ns3 = "http://www.ficohsa.com.hn/middleware.services/consultaMovimientosPagoPrestamoTypes";
declare namespace ns0 = "http://dto2.sdf.cts.cobis.cobiscorp.com";
declare namespace ns5 = "http://service.srvaplcobisprestamo.ecobis.cobiscorp";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaMovimientosPagoPrestamo/xq/consultaMovPagoPrestamoNIOut/";


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
            let $date := fn-bea:date-from-string-with-format("dd/MM/yyyy", $stringDate)
            return fn-bea:date-to-string-with-format("yyyyMMdd", $date)  
        else ("")
};

declare function xf:consultaMovPagoPrestamoNIOut($opConsultaPrestamoRespuesta1 as element(ns5:opConsultaPrestamoRespuesta),
    $opConsultaPagoPrestamoRespuesta1 as element(ns4:opConsultaPagoPrestamoRespuesta),
    $lOAN_ID1 as xs:string)
    as element(ns3:consultaMovimientosPagoPrestamoResponse) {
        <ns3:consultaMovimientosPagoPrestamoResponse>
            <ns3:LOAN_ID>{ data($lOAN_ID1) }</ns3:LOAN_ID>
            <ns3:LOAN_CUSTOMER_NAME>{ fn:replace(data($opConsultaPrestamoRespuesta1/ns1:prestamo/ns1:cliente/ns1:nombreCompleto),"[Ññ]", "#")}</ns3:LOAN_CUSTOMER_NAME>
            <ns3:CURRENCY>{ data($opConsultaPrestamoRespuesta1/ns1:prestamo/ns1:moneda/ns1:valTipoMoneda) }</ns3:CURRENCY>
            <ns3:EFFECTIVE_DATE>{ convertirFecha($opConsultaPrestamoRespuesta1/ns1:prestamo/ns1:fecAprobacion) }</ns3:EFFECTIVE_DATE>
            <ns3:MATURITY_DATE>{ convertirFecha($opConsultaPrestamoRespuesta1/ns1:prestamo/ns1:fecVencimiento) }</ns3:MATURITY_DATE>
            <ns3:INTEREST_RATE>{ redondear($opConsultaPrestamoRespuesta1/ns1:prestamo/ns1:tasaInteres) }</ns3:INTEREST_RATE>
            <ns3:PRINCIPAL_INITIAL_AMT>{ redondear($opConsultaPrestamoRespuesta1/ns1:prestamo/ns1:valInicialPrestamo) }</ns3:PRINCIPAL_INITIAL_AMT>
            <ns3:consultaMovimientosPagoPrestamoType>
                {
                    for $prestamoPago in $opConsultaPagoPrestamoRespuesta1/ns1:prestamoPago
                    return
                        <ns3:consultaMovimientosPagoPrestamoResponseRecordType>
                            {
                                for $fechapago in $prestamoPago/ns1:fechapago
                                return
                                    <ns3:BILL_DATE>{ convertirStringFechaString($fechapago) }</ns3:BILL_DATE>
                            }
                            {
                                for $horaPago in $prestamoPago/ns1:horaPago
                                return
                                    <ns3:BILL_HOUR>{ data($horaPago) }</ns3:BILL_HOUR>
                            }
                            {
                                for $noCuota in $prestamoPago/ns1:noCuota
                                return
                                    <ns3:BILL_NUMBER>{ data($noCuota) }</ns3:BILL_NUMBER>
                            }
                            {
                                for $montoPagado in $prestamoPago/ns1:montoPagado
                                return
                                    <ns3:PAYMENT_AMOUNT>{ redondear($montoPagado) }</ns3:PAYMENT_AMOUNT>
                            }
                            {
                                for $capital in $prestamoPago/ns1:capital
                                return
                                    <ns3:CAPITAL_AMOUNT>{ redondear($capital) }</ns3:CAPITAL_AMOUNT>
                            }
                             {
                                for $interesCorriente in $prestamoPago/ns1:interesCorriente
                                return
                                    <ns3:INTEREST_AMOUNT>{ redondear($interesCorriente) }</ns3:INTEREST_AMOUNT>
                            }
                            {
                                for $interesMoratorio in $prestamoPago/ns1:interesMoratorio
                                return
                                    <ns3:OVERDUE_INTEREST_AMOUNT>{ redondear($interesMoratorio) }</ns3:OVERDUE_INTEREST_AMOUNT>
                            }
                            {
                                for $seguros in $prestamoPago/ns1:seguros
                                return
                                    <ns3:INSURANCE_AMOUNT>{ redondear($seguros) }</ns3:INSURANCE_AMOUNT>
                            }
                            {
                                for $otrosRubros in $prestamoPago/ns1:otrosRubros
                                return
                                    <ns3:OTHER_AMOUNT>{ redondear($otrosRubros) }</ns3:OTHER_AMOUNT>
                            }
                             {
                                for $noTransaccion in $prestamoPago/ns1:noTransaccion
                                return
                                    <ns3:BILL_REFERENCE>{ data($noTransaccion) }</ns3:BILL_REFERENCE>
                            }
                            {
                                for $descripcionCausa in $prestamoPago/ns1:descripcionCausa
                                return
                                    <ns3:DESCRIPTION>{ data($descripcionCausa) }</ns3:DESCRIPTION>
                            }
                            
                        </ns3:consultaMovimientosPagoPrestamoResponseRecordType>
                }
            </ns3:consultaMovimientosPagoPrestamoType>
        </ns3:consultaMovimientosPagoPrestamoResponse>
};

declare variable $opConsultaPrestamoRespuesta1 as element(ns5:opConsultaPrestamoRespuesta) external;
declare variable $opConsultaPagoPrestamoRespuesta1 as element(ns4:opConsultaPagoPrestamoRespuesta) external;
declare variable $lOAN_ID1 as xs:string external;

xf:consultaMovPagoPrestamoNIOut($opConsultaPrestamoRespuesta1,
    $opConsultaPagoPrestamoRespuesta1,
    $lOAN_ID1)
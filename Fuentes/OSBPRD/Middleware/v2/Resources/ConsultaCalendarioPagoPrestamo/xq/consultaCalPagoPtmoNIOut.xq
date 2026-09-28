(:: pragma bea:global-element-parameter parameter="$consultaCalendarioPagoPrestamo1" element="ns2:consultaCalendarioPagoPrestamo" location="../../../../Business_Resources/consultaCalendarioPagoPrestamo/consultaCalendarioPagoPrestamo/consultaCalendarioPagoPrestamoTypes.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$opConsultaCuotaPrestamoRespuesta1" element="ns5:opConsultaCuotaPrestamoRespuesta" location="../../../BusinessServices/CTS/consultaCuotaPagoPrestamo/xsd/services.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$opConsultaPrestamoRespuesta1" element="ns4:opConsultaPrestamoRespuesta" location="../../../BusinessServices/CTS/prestamo/xsd/services.xsd" ::)
(:: pragma bea:global-element-return element="ns2:consultaCalendarioPagoPrestamoResponse" location="../../../../Business_Resources/consultaCalendarioPagoPrestamo/consultaCalendarioPagoPrestamo/consultaCalendarioPagoPrestamoTypes.xsd" ::)

declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/consultaCalendarioPagoPrestamoTypes";
declare namespace ns1 = "http://dto.srvaplcobisentidades.ecobis.cobiscorp";
declare namespace ns4 = "http://service.srvaplcobisprestamo.ecobis.cobiscorp";
declare namespace ns3 = "http://dto2.commons.ecobis.cobiscorp";
declare namespace ns0 = "http://dto2.sdf.cts.cobis.cobiscorp.com";
declare namespace ns5 = "http://service.srvaplcobisconsultaprestamo.ecobis.cobiscorp";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaCalendarioPagoPrestamo/xq/consultaCalPagoPtmoNIOut/";

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
declare function getCuotas($isVigente as xs:string?,$noCuota as xs:string?,$ultimaCuota as xs:string?)
	as xs:string {
		if ($isVigente = 'Yes') then(
			let $i := xs:int($noCuota) - xs:int(3)
			let $ii := xs:int($noCuota) + xs:int(1)	
				return fn:concat($i,' ',$ii)	
		)
		else
		(
			let $i := (xs:int($ultimaCuota) - xs:int(5)) + 1
			let $ii := xs:int($ultimaCuota)
				return fn:concat($i,' ',$ii)	
		)
};

declare function xf:consultaCalPagoPtmoNIOut($opConsultaCuotaPrestamoRespuesta1 as element(ns5:opConsultaCuotaPrestamoRespuesta),
$isVigente as xs:string,$noCuota as xs:string,$ultimaCuota as xs:string,
$consultaCalendarioPagoPrestamo1 as element(ns2:consultaCalendarioPagoPrestamo))
    as element(ns2:consultaCalendarioPagoPrestamoResponse) {
        <ns2:consultaCalendarioPagoPrestamoResponse>
             <ns2:consultaCalendarioPagoPrestamoResponseType>
                {
                if(xs:int($ultimaCuota) > 0 and (fn:empty($consultaCalendarioPagoPrestamo1/PAGING_INFO/PAGING/text()) or $consultaCalendarioPagoPrestamo1/PAGING_INFO/PAGING/text() = "" or $consultaCalendarioPagoPrestamo1/PAGING_INFO/PAGING/text() != "NO")) then
                (
                let $begin := fn:substring-before(getCuotas($isVigente,$noCuota,$ultimaCuota),' ')
                let $end := fn:substring-after(getCuotas($isVigente,$noCuota,$ultimaCuota),' ')
                    for $prestamoCuota in $opConsultaCuotaPrestamoRespuesta1/ns1:prestamoCuota
                    return
                    if ((xs:int($prestamoCuota/ns1:noCuota) >= xs:int($begin)) and (xs:int($prestamoCuota/ns1:noCuota) <= xs:int($end)) ) then 
                    (
                        <ns2:consultaCalendarioPagoPrestamoResponseRecordType>
                            {
                                for $noCuota in $prestamoCuota/ns1:noCuota
                                return
                                    <BILL_NUMBER>{ data($noCuota) }</BILL_NUMBER>
                            }
                            {
                                for $fechavence in $prestamoCuota/ns1:fechaVence
                                return
                                    <BILL_DATE>{ convertirFecha($fechavence) }</BILL_DATE>
                            }
                            {
                                for $montoPagado in $prestamoCuota/ns1:montoPagado
                                return
                                    <PRINCIPAL_AMOUNT>{ redondear($montoPagado) }</PRINCIPAL_AMOUNT>
                            }
                            {
                                for $capitalPagado in $prestamoCuota/ns1:capitalPagado
                                return
                                    <CAPITAL_AMOUNT>{ redondear($capitalPagado) }</CAPITAL_AMOUNT>
                            }
                            {
                                for $interesCorrientePagado in $prestamoCuota/ns1:interesCorrientePagado
                                return
                                    <INTEREST_AMOUNT>{ redondear($interesCorrientePagado) }</INTEREST_AMOUNT>
                            }
                            {
                                for $interesMoratorioPagado in $prestamoCuota/ns1:interesMoratorioPagado
                                return
                                    <OVERDUE_INTEREST_AMOUNT>{ redondear($interesMoratorioPagado) }</OVERDUE_INTEREST_AMOUNT>
                            }
                            {
                                for $seguros in $prestamoCuota/ns1:seguros
                                return
                                    <INSURANCE_AMOUNT>{ redondear($seguros) }</INSURANCE_AMOUNT>
                            }
                            {
                                for $otros in $prestamoCuota/ns1:otros
                                return
                                    <OTHER_AMOUNT>{ redondear($otros) }</OTHER_AMOUNT>
                            }
                            {
                                for $estadoCuota in $prestamoCuota/ns1:estadoCuota
                                return
                                    <BILL_STATUS>{ data($estadoCuota) }</BILL_STATUS>
                            }
                        </ns2:consultaCalendarioPagoPrestamoResponseRecordType>
                     ) else()
                )else(
                for $prestamoCuota in $opConsultaCuotaPrestamoRespuesta1/ns1:prestamoCuota
                    return
                      <ns2:consultaCalendarioPagoPrestamoResponseRecordType>
                            {
                                for $noCuota in $prestamoCuota/ns1:noCuota
                                return
                                    <BILL_NUMBER>{ data($noCuota) }</BILL_NUMBER>
                            }
                            {
                                for $fechavence in $prestamoCuota/ns1:fechaVence
                                return
                                    <BILL_DATE>{ convertirFecha($fechavence) }</BILL_DATE>
                            }
                            {
                                for $montoPagado in $prestamoCuota/ns1:montoPagado
                                return
                                    <PRINCIPAL_AMOUNT>{ redondear($montoPagado) }</PRINCIPAL_AMOUNT>
                            }
                            {
                                for $capitalPagado in $prestamoCuota/ns1:capitalPagado
                                return
                                    <CAPITAL_AMOUNT>{ redondear($capitalPagado) }</CAPITAL_AMOUNT>
                            }
                            {
                                for $interesCorrientePagado in $prestamoCuota/ns1:interesCorrientePagado
                                return
                                    <INTEREST_AMOUNT>{ redondear($interesCorrientePagado) }</INTEREST_AMOUNT>
                            }
                            {
                                for $interesMoratorioPagado in $prestamoCuota/ns1:interesMoratorioPagado
                                return
                                    <OVERDUE_INTEREST_AMOUNT>{ redondear($interesMoratorioPagado) }</OVERDUE_INTEREST_AMOUNT>
                            }
                            {
                                for $seguros in $prestamoCuota/ns1:seguros
                                return
                                    <INSURANCE_AMOUNT>{ redondear($seguros) }</INSURANCE_AMOUNT>
                            }
                            {
                                for $otros in $prestamoCuota/ns1:otros
                                return
                                    <OTHER_AMOUNT>{ redondear($otros) }</OTHER_AMOUNT>
                            }
                            {
                                for $estadoCuota in $prestamoCuota/ns1:estadoCuota
                                return
                                    <BILL_STATUS>{ data($estadoCuota) }</BILL_STATUS>
                            }
                        </ns2:consultaCalendarioPagoPrestamoResponseRecordType>                
                )
                }             
            </ns2:consultaCalendarioPagoPrestamoResponseType>
        </ns2:consultaCalendarioPagoPrestamoResponse>
};

declare variable $consultaCalendarioPagoPrestamo1 as element(ns2:consultaCalendarioPagoPrestamo) external;
declare variable $opConsultaCuotaPrestamoRespuesta1 as element(ns5:opConsultaCuotaPrestamoRespuesta) external;
declare variable $isVigente as xs:string external;
declare variable $noCuota as xs:string external;
declare variable $ultimaCuota as xs:string external;

xf:consultaCalPagoPtmoNIOut($opConsultaCuotaPrestamoRespuesta1,$isVigente,$noCuota,$ultimaCuota,$consultaCalendarioPagoPrestamo1)
(:: pragma bea:global-element-parameter parameter="$consultadedetallederecaudoResponse" element="ns0:ConsultadedetallederecaudoResponse" location="../../../../Business_Resources/recaudos/Resources/XMLSchema_-1599652964.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultadeparametroscoreResponse" element="ns0:ConsultadeparametroscoreResponse" location="../../../../Business_Resources/Core/Resources/XMLSchema_1632682327.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultaRecaudo" element="ns1:consultaRecaudo" location="../xsd/consultaRecaudoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaRecaudoResponse" location="../xsd/consultaRecaudoTypes.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaRecaudoTypes";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/recaudos/consultaRecaudo/consultaRecaudoOut/";

(: Se encarga de calcular el monto total en moneda local. Se asume que las monedas solo pueden ser en moneda local (monedaPais) y en USD :)
declare function xf:obtenerMontoTotalLocal($montoFactura as xs:string, 
	$monedaFactura as xs:string, $monedaConsulta as xs:string,
	$tasaCompra as xs:string, $tasaVenta as xs:string) as xs:string {
	let $monedaPais := 'HNL'
	let $montoTotal := (
		if ($monedaConsulta = $monedaPais) then (
			number($montoFactura)
		) else if ($monedaFactura = $monedaPais) then (
			number($montoFactura) * number($tasaCompra)
		) else (
			number($montoFactura) * number($tasaVenta)
		)
	)
	return
		fn-bea:fail-over(
			fn-bea:format-number(
				round-half-to-even($montoTotal, 2), "######0.00"), '0.00') 
};

(: Se encarga de calcular el monto total en dólares. Se asume que las monedas solo pueden ser en moneda local (monedaPais) y en USD :)
declare function xf:obtenerMontoTotalUSD($montoFactura as xs:string, 
	$monedaFactura as xs:string, $monedaConsulta as xs:string,
	$tasaCompra as xs:string, $tasaVenta as xs:string) as xs:string {
	let $monedaPais := 'HNL'
	let $montoTotal := (
		if ($monedaConsulta = 'USD') then (
			number($montoFactura)
		) else if ($monedaFactura = $monedaPais) then (
			number($montoFactura) div number($tasaCompra)
		) else (
			number($montoFactura) div number($tasaVenta)
		)
	)
	return
		fn-bea:fail-over(
			fn-bea:format-number(
				round-half-to-even($montoTotal, 2), "######0.00"), '0.00') 
};

declare function xf:consultaRecaudoOut($consultaRecaudo as element(ns1:consultaRecaudo),
	$consultadedetallederecaudoResponse as element(ns0:ConsultadedetallederecaudoResponse),
	$consultadeparametroscoreResponse as element(ns0:ConsultadeparametroscoreResponse))
    as element(ns1:consultaRecaudoResponse) {
        <ns1:consultaRecaudoResponse>
            {
                for $SERVICEID in $consultadedetallederecaudoResponse/LATAMAGWSPENDINGBILLSType[1]/gLATAMAGWSPENDINGBILLSDetailType/mLATAMAGWSPENDINGBILLSDetailType[1]/SERVICEID
                return
                    <CONTRACT_ID>{ data($SERVICEID) }</CONTRACT_ID>
            }
            {
                for $SERVICENAME in $consultadedetallederecaudoResponse/LATAMAGWSPENDINGBILLSType[1]/gLATAMAGWSPENDINGBILLSDetailType/mLATAMAGWSPENDINGBILLSDetailType[1]/SERVICENAME
                return
                    <CONTRACT_NAME>{ data($SERVICENAME) }</CONTRACT_NAME>
            }
            {
                for $DEBTORCODE in $consultadedetallederecaudoResponse/LATAMAGWSPENDINGBILLSType[1]/gLATAMAGWSPENDINGBILLSDetailType/mLATAMAGWSPENDINGBILLSDetailType[1]/DEBTORCODE
                return
                    <DEBTOR_CODE>{ data($DEBTORCODE) }</DEBTOR_CODE>
            }
            {
                for $DEBTORNAME in $consultadedetallederecaudoResponse/LATAMAGWSPENDINGBILLSType[1]/gLATAMAGWSPENDINGBILLSDetailType/mLATAMAGWSPENDINGBILLSDetailType[1]/DEBTORNAME
                return
                    <DEBTOR_NAME>{ data($DEBTORNAME) }</DEBTOR_NAME>
            }
            <BILL_DETAIL></BILL_DETAIL>
            {
                let $result :=
                    for $LATAMAGWSPENDINGBILLSType in $consultadedetallederecaudoResponse/LATAMAGWSPENDINGBILLSType
                    return
                        <BILLS>
                            {
                                for $mLATAMAGWSPENDINGBILLSDetailType in $LATAMAGWSPENDINGBILLSType/gLATAMAGWSPENDINGBILLSDetailType/mLATAMAGWSPENDINGBILLSDetailType
                                return
                                    <BILL_RECORD>
                                        {
                                            for $BILLNUMBER in $mLATAMAGWSPENDINGBILLSDetailType/BILLNUMBER
                                            return
                                                <BILL_NUMBER>{ data($BILLNUMBER) }</BILL_NUMBER>
                                        }
                                        {
                                            for $CURRENCY in $mLATAMAGWSPENDINGBILLSDetailType/BILLCCY
                                            return
                                                <BILL_CURRENCY>{ data($CURRENCY) }</BILL_CURRENCY>
                                        }
                                        {
                                            for $BILLDATE in $mLATAMAGWSPENDINGBILLSDetailType/BILLDATE
                                            return
                                                <BILL_DATE>{ data($BILLDATE) }</BILL_DATE>
                                        }
                                        {
                                            for $DUEDATE in $mLATAMAGWSPENDINGBILLSDetailType/DUEDATE
                                            return
                                                <DUE_DATE>{ data($DUEDATE) }</DUE_DATE>
                                        }
                                        {
                                            for $BILLAMOUNT in $mLATAMAGWSPENDINGBILLSDetailType/BILLAMOUNT
                                            return
                                                <BILL_AMOUNT>{ data($BILLAMOUNT) }</BILL_AMOUNT>
                                        }
                                        {
                                            for $LATEFEE in $mLATAMAGWSPENDINGBILLSDetailType/LATEFEE
                                            return
                                                <LATE_FEE>{ data($LATEFEE) }</LATE_FEE>
                                        }
                                        {
                                        	for $montoFactura in $mLATAMAGWSPENDINGBILLSDetailType/TOTALAMOUNT
                                        	let $monedaFactura := $mLATAMAGWSPENDINGBILLSDetailType/BILLCCY
                                        	let $monedaConsulta := data($consultaRecaudo/CURRENCY)
                                        	let $tasaCompra := $consultadeparametroscoreResponse/WSCOREPARAMETERSType[1]/gWSCOREPARAMETERSDetailType/mWSCOREPARAMETERSDetailType[1]/BUYRATE
                                        	let $tasaVenta := $consultadeparametroscoreResponse/WSCOREPARAMETERSType[1]/gWSCOREPARAMETERSDetailType/mWSCOREPARAMETERSDetailType[1]/SELLRATE
                                        	let $montoTotalLocal := xf:obtenerMontoTotalLocal($montoFactura, $monedaFactura, $monedaConsulta, $tasaCompra, $tasaVenta)
                                        	let $montoTotalUSD := xf:obtenerMontoTotalUSD($montoFactura, $monedaFactura, $monedaConsulta, $tasaCompra, $tasaVenta)
                                        	return (
                                                <TOTAL_AMOUNT_LOC>{ data($montoTotalLocal) }</TOTAL_AMOUNT_LOC>,
                                                <TOTAL_AMOUNT_USD>{ data($montoTotalUSD) }</TOTAL_AMOUNT_USD>
                                            )
                                        }
                                        {
                                            for $DESCRIPTION in $mLATAMAGWSPENDINGBILLSDetailType/DESCRIPTION
                                            return
                                                <DESCRIPTION>{ data($DESCRIPTION) }</DESCRIPTION>
                                        }                                        
                                    </BILL_RECORD>
                            }
                        </BILLS>
                return
                    $result[1]
            }
        </ns1:consultaRecaudoResponse>
};

declare variable $consultaRecaudo as element(ns1:consultaRecaudo) external;
declare variable $consultadedetallederecaudoResponse as element(ns0:ConsultadedetallederecaudoResponse) external;
declare variable $consultadeparametroscoreResponse as element(ns0:ConsultadeparametroscoreResponse) external;

xf:consultaRecaudoOut($consultaRecaudo,
	$consultadedetallederecaudoResponse,
	$consultadeparametroscoreResponse)
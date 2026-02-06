xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultadeparametroscoreResponseIN" element="ns0:ConsultadeparametroscoreResponse" location="../../../../Business_Resources/Core/Resources/XMLSchema_1632682327.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$calculoCobranzasReferenciadasResponseIN" element="ns0:CalculoCobranzasReferenciadasResponse" location="../../../../Business_Resources/recaudos/Resources/XMLSchema_-1599652964.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultaRecaudoIN" element="ns2:consultaRecaudo" location="../xsd/consultaRecaudoTypes.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultaDetalleContratoRecaudosResponseIN" element="ns1:consultaDetalleContratoRecaudosResponse" location="../../../BusinessServices/OSB/ConsultaDetalleContratoRecaudo_v2/xsd/XMLSchema_-1149530574.xsd" ::)
(:: pragma bea:global-element-return element="ns2:consultaRecaudoResponse" location="../xsd/consultaRecaudoTypes.xsd" ::)

declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/consultaRecaudoTypes";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaDetalleContratoRecaudosTypes";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaRecaudo/xq/consultaRecaudoReferenciadoOut/";

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





declare function xf:consultaRecaudoReferenciadoOut($consultadeparametroscoreResponseIN as element(ns0:ConsultadeparametroscoreResponse),
    $calculoCobranzasReferenciadasResponseIN as element(ns0:CalculoCobranzasReferenciadasResponse),
    $consultaRecaudoIN as element(ns2:consultaRecaudo),
    $consultaDetalleContratoRecaudosResponseIN as element(ns1:consultaDetalleContratoRecaudosResponse))
    as element(ns2:consultaRecaudoResponse) {
        <ns2:consultaRecaudoResponse>
            <CONTRACT_ID>{ data($consultaRecaudoIN/CONTRACT_ID) }</CONTRACT_ID>
            {
                for $CONTRACT_NAME in $consultaDetalleContratoRecaudosResponseIN/ns1:consultaDetalleContratoRecaudosResponseType/ns1:consultaDetalleContratoRecaudosResponseRecordType[1]/CONTRACT_NAME
                return
                    <CONTRACT_NAME>{ data($CONTRACT_NAME) }</CONTRACT_NAME>
            }
            <DEBTOR_CODE>{ data($consultaRecaudoIN/DEBTOR_CODE) }</DEBTOR_CODE>
            {
            if(string($consultaRecaudoIN/ADDITIONAL_INFO/DATA[4]/text())!='') then (
            <DEBTOR_NAME>{  data($consultaRecaudoIN/ADDITIONAL_INFO/DATA[4]) }</DEBTOR_NAME>
            )else()
             }
            <BILLS>
                {
                    let $gNOFILELATAMCALCREFDUEWSDetailType := $calculoCobranzasReferenciadasResponseIN/NOFILELATAMCALCREFDUEWSType[1]/gNOFILELATAMCALCREFDUEWSDetailType,
                        $consultaRecaudo := $consultaRecaudoIN
                    return
                        <BILL_RECORD>
                            {
                            if(string($consultaRecaudoIN/ADDITIONAL_INFO/DATA[1]/text())='') then (
                            <BILL_NUMBER>{  data($consultaRecaudoIN/DEBTOR_CODE) }</BILL_NUMBER>
                            )else(
                            <BILL_NUMBER>{  data($consultaRecaudoIN/ADDITIONAL_INFO/DATA[1]) }</BILL_NUMBER>
                            )
                            }
                            <BILL_CURRENCY>{ data($consultaRecaudo/CURRENCY) }</BILL_CURRENCY>
                            {
                                for $BILL_DATE in $consultaRecaudo/BILL_DATE
                                return
                                    <BILL_DATE>{ data($BILL_DATE) }</BILL_DATE>
                            }
                            {
                                for $BILL_DATE in $consultaRecaudo/BILL_DATE
                                return
                                    <DUE_DATE>{ data($BILL_DATE) }</DUE_DATE>
                            }
                            {
                                for $BILL_AMOUNT in $consultaRecaudo/BILL_AMOUNT
                                let $LRAMT := fn:string($BILL_AMOUNT/text())
                                return
                                    <BILL_AMOUNT>{ fn-bea:format-number(xs:double($LRAMT),"######0.00") }</BILL_AMOUNT>
                            }
                            {
	                        let $NETAMOUNT :=  substring(fn:string($gNOFILELATAMCALCREFDUEWSDetailType/mNOFILELATAMCALCREFDUEWSDetailType[1]/TOTALAMOUNT/text()),4)
	                        let $LRAMT := fn:string($consultaRecaudo/BILL_AMOUNT/text())
	                        return
	                            <LATE_FEE>{ fn-bea:fail-over(fn-bea:format-number(round-half-to-even((xs:double($NETAMOUNT) - xs:double($LRAMT)),2),"######0.00"),-1) }</LATE_FEE>
	                    }
                        {
                        	for $montoFactura in substring(fn:string($gNOFILELATAMCALCREFDUEWSDetailType/mNOFILELATAMCALCREFDUEWSDetailType[1]/TOTALAMOUNT/text()),4)
                        	let $monedaFactura := $consultaRecaudo/CURRENCY
                        	let $monedaConsulta := data($consultaRecaudoIN/CURRENCY)
                        	let $tasaCompra := $consultadeparametroscoreResponseIN/WSCOREPARAMETERSType[1]/gWSCOREPARAMETERSDetailType/mWSCOREPARAMETERSDetailType[1]/BUYRATE
                        	let $tasaVenta := $consultadeparametroscoreResponseIN/WSCOREPARAMETERSType[1]/gWSCOREPARAMETERSDetailType/mWSCOREPARAMETERSDetailType[1]/SELLRATE
                        	let $montoTotalLocal := xf:obtenerMontoTotalLocal($montoFactura, $monedaFactura, $monedaConsulta, $tasaCompra, $tasaVenta)
                        	let $montoTotalUSD := xf:obtenerMontoTotalUSD($montoFactura, $monedaFactura, $monedaConsulta, $tasaCompra, $tasaVenta)
                        	return (
                                <TOTAL_AMOUNT_LOC>{ data($montoTotalLocal) }</TOTAL_AMOUNT_LOC>,
                                <TOTAL_AMOUNT_USD>{ data($montoTotalUSD) }</TOTAL_AMOUNT_USD>
                            )
                        }
                        </BILL_RECORD>
                }
            </BILLS>
        </ns2:consultaRecaudoResponse>
};

declare variable $consultadeparametroscoreResponseIN as element(ns0:ConsultadeparametroscoreResponse) external;
declare variable $calculoCobranzasReferenciadasResponseIN as element(ns0:CalculoCobranzasReferenciadasResponse) external;
declare variable $consultaRecaudoIN as element(ns2:consultaRecaudo) external;
declare variable $consultaDetalleContratoRecaudosResponseIN as element(ns1:consultaDetalleContratoRecaudosResponse) external;

xf:consultaRecaudoReferenciadoOut($consultadeparametroscoreResponseIN,
    $calculoCobranzasReferenciadasResponseIN,
    $consultaRecaudoIN,
    $consultaDetalleContratoRecaudosResponseIN)
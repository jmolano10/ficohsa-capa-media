xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns2:OutputParameters" location="../../../../v3/BusinessServices/ABKGT/ConsultaRecaudo/xsd/ConsultaRecaudo_sp.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultaRecaudo" element="ns1:consultaRecaudo" location="../xsd/consultaRecaudoTypes.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$RSPConsultaTasaCambio" element="ns0:OutputParameters" location="../../../BusinessServices/ABKGT/consultaTasaCambio/xsd/ConsultaTasaCambio_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaRecaudoResponse" location="../xsd/consultaRecaudoTypes.xsd" ::)

declare namespace ns2 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/ConsultaRecaudo";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaRecaudoTypes";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/ConsultaTasaCambio";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaRecaudo/xq/consultaRecaudoGTOut/";

(: Se encarga de calcular el monto total en moneda local. Se asume que las monedas solo pueden ser en moneda local (monedaPais) y en USD :)
declare function xf:obtenerMontoTotalLocal($montoFactura as xs:string, 
	$monedaFactura as xs:string, $monedaConsulta as xs:string,
	$tasaCompra as xs:string, $tasaVenta as xs:string) as xs:string {
	let $monedaPais := 'GTQ'
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
	let $monedaPais := 'GTQ'
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

declare function xf:consultaRecaudoGTOut($outputParameters as element(ns2:OutputParameters),
    $consultaRecaudo as element(ns1:consultaRecaudo),
    $RSPConsultaTasaCambio as element(ns0:OutputParameters))
    as element(ns1:consultaRecaudoResponse) {
        <ns1:consultaRecaudoResponse>
            <CONTRACT_ID>{ data($consultaRecaudo/CONTRACT_ID) }</CONTRACT_ID>
            {
                for $PV_CONTRACT_NAME in $outputParameters/ns2:PV_CONTRACT_NAME
                return
                    <CONTRACT_NAME>{ data($PV_CONTRACT_NAME) }</CONTRACT_NAME>
            }
            {
                for $PV_DEBTOR_CODE_OUT in $outputParameters/ns2:PV_DEBTOR_CODE_OUT
                return
                    <DEBTOR_CODE>{ data($PV_DEBTOR_CODE_OUT) }</DEBTOR_CODE>
            }
            {
                for $PV_DEBTOR_NAME in $outputParameters/ns2:PV_DEBTOR_NAME
                return
                    <DEBTOR_NAME>{ data($PV_DEBTOR_NAME) }</DEBTOR_NAME>
            }
            {
                for $PV_BILL_DETAIL in $outputParameters/ns2:PV_BILL_DETAIL
                return
                    <BILL_DETAIL>{ data($PV_BILL_DETAIL) }</BILL_DETAIL>
            }
            <BILLS>
                <BILL_RECORD>
                    {
                        let $result :=
                            for $PV_BILL_NUMBER_ITEM in $outputParameters/ns2:PV_BILL_NUMBER/ns2:PV_BILL_NUMBER_ITEM
                            return
                                <BILL_NUMBER>{ data($PV_BILL_NUMBER_ITEM) }</BILL_NUMBER>
                        return
                            $result[1]
                    }
                    {
                        let $result :=
                            for $PV_BILL_CURRENCY_ITEM in $outputParameters/ns2:PV_BILL_CURRENCY/ns2:PV_BILL_CURRENCY_ITEM
                            return
                                <BILL_CURRENCY>{ data($PV_BILL_CURRENCY_ITEM) }</BILL_CURRENCY>
                        return
                            $result[1]
                    }
                    {
                        let $result :=
                            for $PV_BILL_NUMBER_ITEM in $outputParameters/ns2:PV_BILL_DATE_OUT/ns2:PV_BILL_NUMBER_ITEM
                            return
                                <BILL_DATE>{ data($PV_BILL_NUMBER_ITEM) }</BILL_DATE>
                        return
                            $result[1]
                    }
                    {
                        let $result :=
                            for $PV_BILL_NUMBER_ITEM in $outputParameters/ns2:PV_DUE_DATE/ns2:PV_BILL_NUMBER_ITEM
                            return
                                <DUE_DATE>{ data($PV_BILL_NUMBER_ITEM) }</DUE_DATE>
                        return
                            $result[1]
                    }
                    {
                        let $result :=
                            for $PV_BILL_NUMBER_ITEM in $outputParameters/ns2:PV_BILL_AMOUNT_OUT/ns2:PV_BILL_NUMBER_ITEM
                            return
                                <BILL_AMOUNT>{ data($PV_BILL_NUMBER_ITEM) }</BILL_AMOUNT>
                        return
                            $result[1]
                    }
                    {
                        let $result :=
                            for $PV_BILL_NUMBER_ITEM in $outputParameters/ns2:PV_LATE_FEE/ns2:PV_BILL_NUMBER_ITEM
                            return
                                <LATE_FEE>{ data($PV_BILL_NUMBER_ITEM) }</LATE_FEE>
                        return
                            $result[1]
                    }
                    {
                    	for $montoFactura in $outputParameters/ns2:PV_TOTAL_AMOUNT
                    	let $monedaFactura := $outputParameters/ns2:PV_BILL_CURRENCY
                    	let $monedaConsulta := data($consultaRecaudo/CURRENCY)
                    	let $tasaCompra := $RSPConsultaTasaCambio/ns0:BUY_RATE
                    	let $tasaVenta := $RSPConsultaTasaCambio/ns0:SELL_RATE
                    	let $montoTotalLocal := xf:obtenerMontoTotalLocal($montoFactura, $monedaFactura, $monedaConsulta, $tasaCompra, $tasaVenta)
                    	let $montoTotalUSD := xf:obtenerMontoTotalUSD($montoFactura, $monedaFactura, $monedaConsulta, $tasaCompra, $tasaVenta)
                    	return (
                            <TOTAL_AMOUNT_LOC>{ data($montoTotalLocal) }</TOTAL_AMOUNT_LOC>,
                            <TOTAL_AMOUNT_USD>{ data($montoTotalUSD) }</TOTAL_AMOUNT_USD>
                        )
                    }
                </BILL_RECORD>
            </BILLS>
        </ns1:consultaRecaudoResponse>
};

declare variable $outputParameters as element(ns2:OutputParameters) external;
declare variable $consultaRecaudo as element(ns1:consultaRecaudo) external;
declare variable $RSPConsultaTasaCambio as element(ns0:OutputParameters) external;

xf:consultaRecaudoGTOut($outputParameters,
    $consultaRecaudo,
    $RSPConsultaTasaCambio)
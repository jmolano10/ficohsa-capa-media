(:: pragma bea:global-element-parameter parameter="$consultaRecaudo" element="ns3:consultaRecaudo" location="../xsd/consultaRecaudoTypes.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns2:OutputParameters" location="../../../../v3/BusinessServices/ABKGT/ConsultaRecaudo/xsd/ConsultaRecaudo_sp.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$RSPConsultaTasaCambio" element="ns0:OutputParameters" location="../../../BusinessServices/ABKGT/consultaTasaCambio/xsd/ConsultaTasaCambio_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../../v3/BusinessServices/ABKGT/RegistrarRelacionOpRecaudo/xsd/registrarRelacionOperacionRecaudo_sp.xsd" ::)

declare namespace ns2 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/ConsultaRecaudo";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/registrarRelacionOperacionRecaudo";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/ConsultaTasaCambio";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaRecaudo/xq/consultaRegistroRelacionOperacionGTIn/";
declare namespace ns3 = "http://www.ficohsa.com.hn/middleware.services/consultaRecaudoTypes";

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

declare function xf:consultaRegistroRelacionOperacionGTIn(
	$consultaRecaudo as element(ns3:consultaRecaudo),
	$outputParameters as element(ns2:OutputParameters),
    $RSPConsultaTasaCambio as element(ns0:OutputParameters),
    $estado as xs:string,
    $esMonedaLocal as xs:boolean)
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            
             {
                for $PV_CONTRACT_ID_OUT in $outputParameters/ns2:PV_CONTRACT_ID_OUT
                return
                    <ns1:CODIGO_CONTRATO>{ data($PV_CONTRACT_ID_OUT) }</ns1:CODIGO_CONTRATO>
            }
            {
                for $PV_DEBTOR_CODE_OUT in $outputParameters/ns2:PV_DEBTOR_CODE_OUT
                return
                    <ns1:CODIGO_DEUDOR>{ data($PV_DEBTOR_CODE_OUT) }</ns1:CODIGO_DEUDOR>
            }
            <ns1:CODIGO_FACTURA>
                {
                    for $PV_BILL_NUMBER_ITEM in $outputParameters/ns2:PV_BILL_NUMBER/ns2:PV_BILL_NUMBER_ITEM
                    return
                        <ns1:CODIGO_FACTURA_ITEM>{ data($PV_BILL_NUMBER_ITEM) }</ns1:CODIGO_FACTURA_ITEM>
                }
            </ns1:CODIGO_FACTURA>
            <ns1:MONEDA_FACTURA>
                {
                    for $PV_BILL_CURRENCY_ITEM in $outputParameters/ns2:PV_BILL_CURRENCY/ns2:PV_BILL_CURRENCY_ITEM
                    return
                        <ns1:CODIGO_FACTURA_ITEM>{ data($PV_BILL_CURRENCY_ITEM) }</ns1:CODIGO_FACTURA_ITEM>
                }
            </ns1:MONEDA_FACTURA>
            <ns1:FECHA_FACTURA>
                {
                    for $PV_BILL_NUMBER_ITEM in $outputParameters/ns2:PV_BILL_DATE_OUT/ns2:PV_BILL_NUMBER_ITEM
                    return
                        <ns1:CODIGO_FACTURA_ITEM>{ data($PV_BILL_NUMBER_ITEM) }</ns1:CODIGO_FACTURA_ITEM>
                }
            </ns1:FECHA_FACTURA>
            <ns1:FECHA_VENCIMIENTO>
                {
                    for $PV_BILL_NUMBER_ITEM in $outputParameters/ns2:PV_DUE_DATE/ns2:PV_BILL_NUMBER_ITEM
                    return
                        <ns1:CODIGO_FACTURA_ITEM>{ data($PV_BILL_NUMBER_ITEM) }</ns1:CODIGO_FACTURA_ITEM>
                }
            </ns1:FECHA_VENCIMIENTO>
            <ns1:MONTO_FACTURA>
                {
                    for $PV_BILL_NUMBER_ITEM in $outputParameters/ns2:PV_BILL_AMOUNT_OUT/ns2:PV_BILL_NUMBER_ITEM
                    return
                        <ns1:CODIGO_FACTURA_ITEM>{ data($PV_BILL_NUMBER_ITEM) }</ns1:CODIGO_FACTURA_ITEM>
                }
            </ns1:MONTO_FACTURA>
            <ns1:MORA>
                {
                    for $PV_BILL_NUMBER_ITEM in $outputParameters/ns2:PV_LATE_FEE/ns2:PV_BILL_NUMBER_ITEM
                    return
                        <ns1:CODIGO_FACTURA_ITEM>{ data($PV_BILL_NUMBER_ITEM) }</ns1:CODIGO_FACTURA_ITEM>
                }
            </ns1:MORA>
            <ns1:MONTO_TOTAL>
                {
                	let $tasaCompra := $RSPConsultaTasaCambio/ns0:BUY_RATE
                	let $tasaVenta := $RSPConsultaTasaCambio/ns0:SELL_RATE
                	let $montos := $outputParameters/ns2:PV_TOTAL_AMOUNT
                	let $monedasFacturas := $outputParameters/ns2:PV_BILL_CURRENCY
                	let $monedasConsulta := $consultaRecaudo/CURRENCY
                	
                	for $montoFactura at $i in $montos
                	let $monedaFactura := $monedasFacturas[$i]
                	let $monedaConsulta := $monedasConsulta
                	let $montoTotalReg := (
                		if ($esMonedaLocal) then (
                			xf:obtenerMontoTotalLocal($montoFactura, $monedaFactura, $monedaConsulta, $tasaCompra, $tasaVenta)
                		) else (
                			xf:obtenerMontoTotalUSD($montoFactura, $monedaFactura, $monedaConsulta, $tasaCompra, $tasaVenta)
                		)
                	) return (
                        <ns1:ITEM>{ data($montoTotalReg) }</ns1:ITEM>
                    )
                }
            </ns1:MONTO_TOTAL>
            <ns1:MONEDA_SOLICITUD>
            {
                for $PV_BILL_CURRENCY_ITEM in $outputParameters/ns2:PV_BILL_CURRENCY/ns2:PV_BILL_CURRENCY_ITEM
                return
                    <ns1:CODIGO_FACTURA_ITEM>{ 
						if ($esMonedaLocal) then (
                			'GTQ'
                		) else (
                			'USD'
                		)
					 }</ns1:CODIGO_FACTURA_ITEM>
            } 
            </ns1:MONEDA_SOLICITUD>
            <ns1:ESTADO>{ $estado }</ns1:ESTADO>
            {
                for $PV_DEBTOR_NAME in $outputParameters/ns2:PV_DEBTOR_NAME
                return
                    <ns1:LISTA_VALORES>{ data($PV_DEBTOR_NAME) }</ns1:LISTA_VALORES>
            }
        </ns1:InputParameters>
};

declare variable $consultaRecaudo as element(ns3:consultaRecaudo) external;
declare variable $outputParameters as element(ns2:OutputParameters) external;
declare variable $RSPConsultaTasaCambio as element(ns0:OutputParameters) external;
declare variable $estado as xs:string external;
declare variable $esMonedaLocal as xs:boolean external;

xf:consultaRegistroRelacionOperacionGTIn(
	$consultaRecaudo,
	$outputParameters,
    $RSPConsultaTasaCambio,
    $estado,
    $esMonedaLocal)
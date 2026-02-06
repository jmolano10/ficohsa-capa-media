xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultadedetallederecaudoResponse" element="ns0:ConsultadedetallederecaudoResponse" location="../../../../Business_Resources/recaudos/Resources/XMLSchema_-1599652964.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultadeparametroscoreResponse" element="ns0:ConsultadeparametroscoreResponse" location="../../../../Business_Resources/Core/Resources/XMLSchema_1632682327.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../../Business_Resources/recaudos/Resources/RegistrarRelacionOperacionRecaudo/xsd/FLINK_OSB_REGISTRAR_OPER_RECAUDO.xsd" ::)

declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/FLINK/OSB_REGISTRAR_OPER_RECAUDO/";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/recaudos/consultaRecaudo/consultaRecaudoRegistrarOperacionRecaudoIn/";

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

declare function xf:consultaRecaudoRegistrarOperacionRecaudoIn($consultadedetallederecaudoResponse as element(ns0:ConsultadedetallederecaudoResponse),
	$consultadeparametroscoreResponse as element(ns0:ConsultadeparametroscoreResponse),
    $estado as xs:string,
    $codigoDeudor as xs:string,
    $esMonedaLocal as xs:boolean,
    $nombreDeudor as xs:string )
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            {
                for $SERVICEID in $consultadedetallederecaudoResponse/LATAMAGWSPENDINGBILLSType[1]/gLATAMAGWSPENDINGBILLSDetailType/mLATAMAGWSPENDINGBILLSDetailType[1]/SERVICEID
                return
                    <ns1:CODIGO_CONTRATO>{ data($SERVICEID) }</ns1:CODIGO_CONTRATO>
            }
            <ns1:CODIGO_DEUDOR>{ $codigoDeudor }</ns1:CODIGO_DEUDOR>
            <ns1:CODIGO_FACTURA>
                {
                    for $BILLNUMBER in $consultadedetallederecaudoResponse/LATAMAGWSPENDINGBILLSType[1]/gLATAMAGWSPENDINGBILLSDetailType/mLATAMAGWSPENDINGBILLSDetailType/BILLNUMBER
                    return
                        <ns1:ITEM>{ data($BILLNUMBER) }</ns1:ITEM>
                }
            </ns1:CODIGO_FACTURA>
            <ns1:MONEDA_FACTURA>
                {
                    for $BILLCCY in $consultadedetallederecaudoResponse/LATAMAGWSPENDINGBILLSType[1]/gLATAMAGWSPENDINGBILLSDetailType/mLATAMAGWSPENDINGBILLSDetailType/BILLCCY
                    return
                        <ns1:ITEM>{ data($BILLCCY) }</ns1:ITEM>
                }
            </ns1:MONEDA_FACTURA>
            <ns1:FECHA_FACTURA>
                {
                    for $BILLDATE in $consultadedetallederecaudoResponse/LATAMAGWSPENDINGBILLSType[1]/gLATAMAGWSPENDINGBILLSDetailType/mLATAMAGWSPENDINGBILLSDetailType/BILLDATE
                    return
                        <ns1:ITEM>{ data($BILLDATE) }</ns1:ITEM>
                }
            </ns1:FECHA_FACTURA>
            <ns1:FECHA_VENCIMIENTO>
                {
                    for $DUEDATE in $consultadedetallederecaudoResponse/LATAMAGWSPENDINGBILLSType[1]/gLATAMAGWSPENDINGBILLSDetailType/mLATAMAGWSPENDINGBILLSDetailType/DUEDATE
                    return
                        <ns1:ITEM>{ data($DUEDATE) }</ns1:ITEM>
                }
            </ns1:FECHA_VENCIMIENTO>
            <ns1:MONTO_FACTURA>
                {
                    for $BILLAMOUNT in $consultadedetallederecaudoResponse/LATAMAGWSPENDINGBILLSType[1]/gLATAMAGWSPENDINGBILLSDetailType/mLATAMAGWSPENDINGBILLSDetailType/BILLAMOUNT
                    return
                        <ns1:ITEM>{ data($BILLAMOUNT) }</ns1:ITEM>
                }
            </ns1:MONTO_FACTURA>
            <ns1:MORA>
                {
                    for $LATEFEE in $consultadedetallederecaudoResponse/LATAMAGWSPENDINGBILLSType[1]/gLATAMAGWSPENDINGBILLSDetailType/mLATAMAGWSPENDINGBILLSDetailType/LATEFEE
                    return
                        <ns1:ITEM>{ data($LATEFEE) }</ns1:ITEM>
                }
            </ns1:MORA>
            <ns1:MONEDA_SOLICITUD>
                {
                    for $CURRENCY in $consultadedetallederecaudoResponse/LATAMAGWSPENDINGBILLSType[1]/gLATAMAGWSPENDINGBILLSDetailType/mLATAMAGWSPENDINGBILLSDetailType/CURRENCY
                    return
                        <ns1:ITEM>
                        	{
		                		if ($esMonedaLocal) then (
		                			'HNL'
		                		) else (
		                			'USD'
		                		)
		                	}
                		</ns1:ITEM>
                }
            </ns1:MONEDA_SOLICITUD>
            <ns1:MONTO_TOTAL>
                {
                	let $tasaCompra := $consultadeparametroscoreResponse/WSCOREPARAMETERSType[1]/gWSCOREPARAMETERSDetailType/mWSCOREPARAMETERSDetailType[1]/BUYRATE
                	let $tasaVenta := $consultadeparametroscoreResponse/WSCOREPARAMETERSType[1]/gWSCOREPARAMETERSDetailType/mWSCOREPARAMETERSDetailType[1]/SELLRATE
                	let $montos := $consultadedetallederecaudoResponse/LATAMAGWSPENDINGBILLSType[1]/gLATAMAGWSPENDINGBILLSDetailType/mLATAMAGWSPENDINGBILLSDetailType/TOTALAMOUNT
                	let $monedasFacturas := $consultadedetallederecaudoResponse/LATAMAGWSPENDINGBILLSType[1]/gLATAMAGWSPENDINGBILLSDetailType/mLATAMAGWSPENDINGBILLSDetailType/BILLCCY
                	let $monedasConsultas := $consultadedetallederecaudoResponse/LATAMAGWSPENDINGBILLSType[1]/gLATAMAGWSPENDINGBILLSDetailType/mLATAMAGWSPENDINGBILLSDetailType/CURRENCY
                	for $montoFactura at $i in $montos
                	let $monedaFactura := $monedasFacturas[$i]
                	let $monedaConsulta := $monedasConsultas[$i]
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
            <ns1:ESTADO>{ $estado }</ns1:ESTADO>
            <ns1:NOMBRE_DEUDOR>{ $nombreDeudor }</ns1:NOMBRE_DEUDOR>
        </ns1:InputParameters>
};

declare variable $consultadedetallederecaudoResponse as element(ns0:ConsultadedetallederecaudoResponse) external;
declare variable $consultadeparametroscoreResponse as element(ns0:ConsultadeparametroscoreResponse) external;
declare variable $estado as xs:string external;
declare variable $codigoDeudor as xs:string external;
declare variable $esMonedaLocal as xs:boolean external;
declare variable $nombreDeudor as xs:string external;

xf:consultaRecaudoRegistrarOperacionRecaudoIn($consultadedetallederecaudoResponse,
	$consultadeparametroscoreResponse,
    $estado,
    $codigoDeudor,
    $esMonedaLocal,
    $nombreDeudor)
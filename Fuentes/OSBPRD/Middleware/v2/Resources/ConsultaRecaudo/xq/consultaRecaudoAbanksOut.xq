(:: pragma bea:global-element-parameter parameter="$consultaRecaudo" element="ns1:consultaRecaudo" location="../xsd/consultaRecaudoTypes.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns0:OutputParameters" location="../../../BusinessServices/ABK/consultaRecaudosAbanks/xsd/consultaRecaudoAbanks_sp.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultadeparametroscoreResponse" element="ns2:ConsultadeparametroscoreResponse" location="../../../../Business_Resources/Core/Resources/XMLSchema_1632682327.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaRecaudoResponse" location="../xsd/consultaRecaudoTypes.xsd" ::)

declare namespace ns2 = "T24WebServicesImpl";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaRecaudoTypes";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaRecaudoAbanks";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaRecaudo/xq/consultaRecaudoAbanksOut/";

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

declare function xf:consultaRecaudoAbanksOut($consultaRecaudo as element(ns1:consultaRecaudo),
    $outputParameters as element(ns0:OutputParameters),
    $consultadeparametroscoreResponse as element(ns2:ConsultadeparametroscoreResponse))
    as element(ns1:consultaRecaudoResponse) {
        <ns1:consultaRecaudoResponse>
            <CONTRACT_ID>{ data($consultaRecaudo/CONTRACT_ID) }</CONTRACT_ID>
            {
                for $PV_DESCRIPCIONPLANILLA in $outputParameters/ns0:PV_DESCRIPCIONPLANILLA
                return
                    <CONTRACT_NAME>{ data($PV_DESCRIPCIONPLANILLA) }</CONTRACT_NAME>
            }
            <DEBTOR_CODE>{ data($consultaRecaudo/DEBTOR_CODE) }</DEBTOR_CODE>
            {
                for $PV_NOMBREDEUDOR in $outputParameters/ns0:PV_NOMBREDEUDOR
                return
                    <DEBTOR_NAME>{ data($PV_NOMBREDEUDOR) }</DEBTOR_NAME>
            }
            <BILLS>
                {
                    let $NUMDOC  := ($outputParameters/ns0:PT_NUMDOC/ns0:ITEM)  
                    let $MONEDA  := ($outputParameters/ns0:PT_MONEDA/ns0:ITEM)  
                    let $FECHAEMISION  := ($outputParameters/ns0:PT_FECHAEMISION/ns0:ITEM)  
                    let $FECHAVENC  := ($outputParameters/ns0:PT_FECHAVENC/ns0:ITEM)  
                    let $MONTO  := ($outputParameters/ns0:PT_MONTO/ns0:ITEM)  
                    let $MORA  := ($outputParameters/ns0:PT_MORA/ns0:ITEM)  
                    let $TOTAL  := ($outputParameters/ns0:PT_TOTAL/ns0:ITEM)  
                    let $DESCRIPCION := ($outputParameters/ns0:PT_DESCRIPCION/ns0:ITEM) 
                    return
                        for $i  in (1 to count($NUMDOC))  
                        return
                            (
                            <BILL_RECORD>
                                <BILL_NUMBER>{ data($NUMDOC[$i]) }</BILL_NUMBER>
	                            <BILL_CURRENCY>{ data($MONEDA[$i]) }</BILL_CURRENCY>
	                            <BILL_DATE>{ fn-bea:dateTime-to-string-with-format("yyyyMMdd",data($FECHAEMISION[$i])) }</BILL_DATE>
	                            <DUE_DATE>{ fn-bea:dateTime-to-string-with-format("yyyyMMdd",data($FECHAVENC[$i])) }</DUE_DATE>
	                            <BILL_AMOUNT>{ data($MONTO[$i]) }</BILL_AMOUNT>
	                            <LATE_FEE>{ data($MORA[$i]) }</LATE_FEE>
                                {
                                	let $montoFactura := data($TOTAL[$i])
                                	let $monedaFactura :=  data($MONEDA[$i])
                                	let $monedaConsulta :=  data($MONEDA[$i])
                                	let $tasaCompra := $consultadeparametroscoreResponse/WSCOREPARAMETERSType[1]/gWSCOREPARAMETERSDetailType/mWSCOREPARAMETERSDetailType[1]/BUYRATE
                                	let $tasaVenta := $consultadeparametroscoreResponse/WSCOREPARAMETERSType[1]/gWSCOREPARAMETERSDetailType/mWSCOREPARAMETERSDetailType[1]/SELLRATE
                                	let $montoTotalLocal := xf:obtenerMontoTotalLocal($montoFactura, $monedaFactura, $monedaConsulta, $tasaCompra, $tasaVenta)
                                	let $montoTotalUSD := xf:obtenerMontoTotalUSD($montoFactura, $monedaFactura, $monedaConsulta, $tasaCompra, $tasaVenta)
                                	return (
                                        <TOTAL_AMOUNT_LOC>{ data($montoTotalLocal) }</TOTAL_AMOUNT_LOC>,
                                        <TOTAL_AMOUNT_USD>{ data($montoTotalUSD) }</TOTAL_AMOUNT_USD>
                                    )
                                }
	                            <BILL_DESCRIPTION>{ data($DESCRIPCION[$i]) }</BILL_DESCRIPTION>
                            </BILL_RECORD>)
                }
			</BILLS>
        </ns1:consultaRecaudoResponse>
};

declare variable $consultaRecaudo as element(ns1:consultaRecaudo) external;
declare variable $outputParameters as element(ns0:OutputParameters) external;
declare variable $consultadeparametroscoreResponse as element(ns2:ConsultadeparametroscoreResponse) external;

xf:consultaRecaudoAbanksOut($consultaRecaudo,
    $outputParameters,
    $consultadeparametroscoreResponse)
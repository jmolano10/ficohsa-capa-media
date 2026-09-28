(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns1:OutputParameters" location="../../../BusinessServices/VASA/consultaOferta/xsd/consultaOferta_sp.xsd" ::)

declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaOferta";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/SolicitudFinanciamientoTC/xq/validaCondicionesCredito/";

declare function getErrorMessage($errorCode as xs:integer)
	as xs:string {
		if ($errorCode = 1) then ("Error, El monto solicitado supera al monto disponible para el plazo seleccionado") else 
		if ($errorCode = 2) then ("Error, No hay monto disponible para el plazo seleccionado") else 
		if ($errorCode = 3) then ("Error, No se encontró el plazo seleccionado para la moneda indicada") else 
		""
};

declare function xf:validaCondicionesCredito($numberOfPayments as xs:string,
	$totalAmount as xs:string,$currency as xs:string,
    $outputParameters as element(ns1:OutputParameters))
    as xs:string {
    	let $validations := 
    		for $row at $i in $outputParameters/ns1:RowSet/ns1:Row
    			let $plazo := $row/ns1:Column[@name='Pn_Plazo' and text() = $numberOfPayments]
				let $monto := fn:string($row/ns1:Column[@name='Pn_Monto'])
				let $moneda := $row/ns1:Column[@name='Pv_Moneda' and text() = $currency]
				return
					if (empty($plazo) or empty($moneda)) then (
						3
					) else if (number($monto) = 0 or $monto = "") then (
						2
					) else if (number($monto) < number($totalAmount)) then (
						1
					) 			
					else (
						0
					) 
		return getErrorMessage(min($validations))
};

declare variable $outputParameters as element(ns1:OutputParameters) external;
declare variable $numberOfPayments as xs:string external;
declare variable $totalAmount as xs:string external;
declare variable $currency as xs:string external;
xf:validaCondicionesCredito($numberOfPayments,
	$totalAmount,
	$currency,
    $outputParameters)
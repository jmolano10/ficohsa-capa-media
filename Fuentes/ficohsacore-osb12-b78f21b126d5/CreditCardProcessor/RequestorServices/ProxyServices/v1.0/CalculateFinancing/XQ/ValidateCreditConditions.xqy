xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://xmlns.oracle.com/pcbpel/adapter/db/sp/ConsultOffer_BS";
(:: import schema at "../../../../../ProviderServices/XSD/ConsultOffer/ConsultOffer_BS_sp.xsd" ::)

declare function local:getErrorMessage($errorCode as xs:integer)
	as xs:string {
		if ($errorCode = 1) then ("Error, El monto solicitado supera al monto disponible para el plazo seleccionado") else 
		if ($errorCode = 2) then ("Error, No hay monto disponible para el plazo seleccionado") else 
		if ($errorCode = 3) then ("Error, No se encontró el plazo seleccionado para la moneda indicada") else 
		""
};

declare variable $rspConsultOffer as element() (:: schema-element(ns1:OutputParameters) ::) external;
declare variable $totalAmount as xs:string external;
declare variable $numberOfPayments as xs:string external;
declare variable $currency as xs:string external;

declare function local:func($rspConsultOffer as element() (:: schema-element(ns1:OutputParameters) ::), 
                            $totalAmount as xs:string, 
                            $numberOfPayments as xs:string, 
                            $currency as xs:string) 
                            as xs:string {
    let $validations := 
    		for $row at $i in $rspConsultOffer/ns1:RowSet/ns1:Row
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
		return local:getErrorMessage(min($validations))
};

local:func($rspConsultOffer, $totalAmount, $numberOfPayments, $currency)
xquery version "1.0" encoding "Cp1252";
(:: pragma bea:global-element-return element="ns2:ConsumoNOR" location="../../../BusinessServices/transaccionesAlcance/wsdl/wsinfotarjetas.asmx.wsdl" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/pagoRecaudos/pagoRecaudoRegistroConsumoTC/";
declare namespace ns2 = "http://alcance.local/wsinfotarjetas/";

(: Función encargada de realizar el mapeo de usuario:)
declare function getUsername ($LDAPUsername as xs:string)  as xs:string { 
	let $data := fn-bea:lookupBasicCredentials(concat("Middleware/Security/", upper-case($LDAPUsername)))
  		return
		    $data/con:username/text()
 };

 
declare function xf:pagoRecaudoRegistroConsumoTC($usuarioCanal as xs:string, $numeroTarjetaCredito as xs:string
    ,$fechaexpiracionTC  as xs:string,  $montoConsumo as xs:string, $monedaConsumo as xs:string,
    $purchaseDescription as xs:string,
    $purchaseRefNumber as xs:string)
    as element(ns2:ConsumoNOR) {
    
        <ns2:ConsumoNOR>
              <ns2:noTarjetaCredito>{ data($numeroTarjetaCredito) }</ns2:noTarjetaCredito>
              <ns2:FechaExpiracion>{ data($fechaexpiracionTC) }</ns2:FechaExpiracion>
              <ns2:montoConsumo>{  data($montoConsumo) }</ns2:montoConsumo>
              <ns2:monedaConsumo>{
            	 let $PAYMENT_CURRENCY := $monedaConsumo
            	return
            	if ($PAYMENT_CURRENCY = "HNL") then (
            		340
            	) else if ($PAYMENT_CURRENCY = "USD") then (
            		840
            	) else (
            		0
            	)
								}
            </ns2:monedaConsumo>
            <ns2:DescripcionConsumo>{ fn:substring($purchaseDescription,1,25) }</ns2:DescripcionConsumo>
            <ns2:canalConsumo>{ fn-bea:fail-over( getUsername(data($usuarioCanal)),data($usuarioCanal)) }</ns2:canalConsumo>
            <ns2:fechaConsumo>{ fn-bea:date-to-string-with-format("yyyyMMdd",fn:current-date()) }</ns2:fechaConsumo>
            <ns2:idRefConsumo>{ $purchaseRefNumber }</ns2:idRefConsumo>
        </ns2:ConsumoNOR>
};


declare variable $montoConsumo as xs:string external;
declare variable $monedaConsumo as xs:string external;
declare variable $usuarioCanal as xs:string external;
declare variable $numeroTarjetaCredito as xs:string external;
declare variable $fechaexpiracionTC as xs:string external;
declare variable $purchaseDescription as xs:string external;
declare variable $purchaseRefNumber as xs:string external;

xf:pagoRecaudoRegistroConsumoTC(
    $usuarioCanal,
    $numeroTarjetaCredito,
    $fechaexpiracionTC,
    $montoConsumo,
    $monedaConsumo,
    $purchaseDescription,
    $purchaseRefNumber)
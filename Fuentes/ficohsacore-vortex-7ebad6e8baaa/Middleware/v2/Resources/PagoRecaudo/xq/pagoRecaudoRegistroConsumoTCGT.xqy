xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$requestHeader1" element="ns0:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$pagoRecaudo1" element="ns1:pagoRecaudo" location="../../../../Business_Resources/pagoRecaudos/PagoRecaudo/pagoRecaudoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns2:ConsumoNOR" location="../../../BusinessServices/ABKGT/transaccionesAlcance/wsdl/wsinfotarjetas.asmx.wsdl" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns2 = "http://alcance.local/wsinfotarjetas/";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/pagoRecaudoTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/PagoRecaudo/xq/pagoRecaudoRegistroConsumoTCGT/";

(: Función encargada de realizar el mapeo de usuario:)
declare function getUsername ($LDAPUsername as xs:string)  as xs:string { 
	let $data := fn-bea:lookupBasicCredentials(concat("Middleware/Security/", upper-case($LDAPUsername)))
  		return
		    $data/con:username/text()
 };

(: Función encargada de realizar el mapeo de contraseña:)
declare function getPassword ($LDAPUsername as xs:string)  as xs:string {      
	let $data := fn-bea:lookupBasicCredentials(concat("Middleware/Security/", upper-case($LDAPUsername)))
  		return
		    $data/con:password/text()
 };


declare function xf:pagoRecaudoRegistroConsumoTCGT($requestHeader1 as element(ns0:RequestHeader),
    $pagoRecaudo1 as element(ns1:pagoRecaudo),
    $purchaseDescription as xs:string,
    $purchaseRefNumber as xs:string)
    as element(ns2:ConsumoNOR) {
        <ns2:ConsumoNOR>
            {
                for $CREDIT_CARD_NUMBER in $pagoRecaudo1/PAYMENT_INFORMATION/CREDIT_CARD_NUMBER
                return
                    <ns2:noTarjetaCredito>{ data($CREDIT_CARD_NUMBER) }</ns2:noTarjetaCredito>
            }
            {
                for $EXPIRATION_DATE in $pagoRecaudo1/PAYMENT_INFORMATION/EXPIRATION_DATE
                return
                    <ns2:FechaExpiracion>{ data($EXPIRATION_DATE) }</ns2:FechaExpiracion>
            }
            <ns2:montoConsumo>{ fn:string($pagoRecaudo1/PAYMENT_INFORMATION/PAYMENT_AMOUNT/text()) }</ns2:montoConsumo>
            <ns2:monedaConsumo>{ 
            
            	let $PAYMENT_CURRENCY := fn:string($pagoRecaudo1/PAYMENT_INFORMATION/PAYMENT_CURRENCY/text())
            	return
            	if ($PAYMENT_CURRENCY = "GTQ") then (
            		320
            	) else if ($PAYMENT_CURRENCY = "USD") then (
            		840
            	) else (
            		0
            	)
								
			 }</ns2:monedaConsumo>
            <ns2:DescripcionConsumo>{ $purchaseDescription }</ns2:DescripcionConsumo>
            <ns2:canalConsumo>{ fn-bea:fail-over( getUsername(data($requestHeader1/Authentication/UserName)), 
									data($requestHeader1/Authentication/UserName)) }</ns2:canalConsumo>
			<ns2:fechaConsumo>{ fn-bea:date-to-string-with-format("yyyyMMdd",fn:current-date()) }</ns2:fechaConsumo>
            <ns2:idRefConsumo>{ $purchaseRefNumber }</ns2:idRefConsumo>
        </ns2:ConsumoNOR>
};

declare variable $requestHeader1 as element(ns0:RequestHeader) external;
declare variable $pagoRecaudo1 as element(ns1:pagoRecaudo) external;
declare variable $purchaseDescription as xs:string external;
declare variable $purchaseRefNumber as xs:string external;

xf:pagoRecaudoRegistroConsumoTCGT($requestHeader1,
    $pagoRecaudo1,
    $purchaseDescription,
    $purchaseRefNumber)
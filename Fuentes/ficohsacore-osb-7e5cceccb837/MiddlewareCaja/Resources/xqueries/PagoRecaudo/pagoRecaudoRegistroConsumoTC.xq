(:: pragma bea:global-element-parameter parameter="$requestHeader" element="ns0:AutenticacionRequestHeader" location="../../xsds/General/Autenticacion.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$pagoRecaudo" element="ns1:pagoRecaudo" location="../../xsds/PagoRecaudo/PagoRecaudo.xsd" ::)
(:: pragma bea:global-element-return element="ns2:registrarConsumo" location="../../wsdls/Alcance.wsdl" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns2 = "http://tempuri.org/";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/pagoRecaudoTypes";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/PagoRecaudo/pagoRecaudoRegistroConsumoTC/";

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

declare function xf:pagoRecaudoRegistroConsumoTC($requestHeader as element(ns0:AutenticacionRequestHeader),
    $pagoRecaudo as element(ns1:pagoRecaudo),
    $purchaseDescription as xs:string,
    $purchaseRefNumber as xs:string)
    as element(ns2:registrarConsumo) {
        <ns2:registrarConsumo>
            {
                for $CREDIT_CARD_NUMBER in $pagoRecaudo/PAYMENT_INFORMATION/CREDIT_CARD_NUMBER
                return
                    <ns2:noTarjetaCredito>{ data($CREDIT_CARD_NUMBER) }</ns2:noTarjetaCredito>
            }
            {
                for $EXPIRATION_DATE in $pagoRecaudo/PAYMENT_INFORMATION/EXPIRATION_DATE
                return
                    <ns2:FechaExpiracion>{ data($EXPIRATION_DATE) }</ns2:FechaExpiracion>
            }
            <ns2:montoConsumo>{ fn:string($pagoRecaudo/PAYMENT_INFORMATION/PAYMENT_AMOUNT/text()) }</ns2:montoConsumo>
            <ns2:monedaConsumo>
            {
            	 let $PAYMENT_CURRENCY := fn:string($pagoRecaudo/PAYMENT_INFORMATION/PAYMENT_CURRENCY/text())
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
            <ns2:canalConsumo>{ fn-bea:fail-over( getUsername(data($requestHeader/UserName)), 
									data($requestHeader/UserName)) }</ns2:canalConsumo>
            <ns2:fechaConsumo>{ fn-bea:date-to-string-with-format("yyyyMMdd",fn:current-date()) }</ns2:fechaConsumo>
            <ns2:idRefConsumo>{ $purchaseRefNumber }</ns2:idRefConsumo>
        </ns2:registrarConsumo>
};

declare variable $requestHeader as element(ns0:AutenticacionRequestHeader) external;
declare variable $pagoRecaudo as element(ns1:pagoRecaudo) external;
declare variable $purchaseDescription as xs:string external;
declare variable $purchaseRefNumber as xs:string external;

xf:pagoRecaudoRegistroConsumoTC($requestHeader,
    $pagoRecaudo,
    $purchaseDescription,
    $purchaseRefNumber)
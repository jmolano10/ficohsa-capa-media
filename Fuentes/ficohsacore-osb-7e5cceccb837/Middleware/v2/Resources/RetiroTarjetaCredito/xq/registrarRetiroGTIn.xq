(:: pragma bea:global-element-parameter parameter="$retiroTarjetaCredito" element="ns2:retiroTarjetaCredito" location="../xsd/retiroTarjetaCreditoTypes.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$requestHeader" element="ns0:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-return element="ns1:registrarRetiro" location="../../../BusinessServices/ALCN/tarjetaCredito/wsdl/TarjetaDeCredito.wsdl" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/retiroTarjetaCreditoTypes";
declare namespace ns1 = "http://tempuri.org/";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/RetiroTarjetaCredito/xq/registrarRetiroGTIn/";

declare function xf:registrarRetiroGTIn($retiroTarjetaCredito as element(ns2:retiroTarjetaCredito),
    $requestHeader as element(ns0:RequestHeader),
    $secuenciaIdRetiro as xs:string)
    as element(ns1:registrarRetiro) {
        <ns1:registrarRetiro>
            <ns1:noTarjetaCredito>{ data($retiroTarjetaCredito/CREDIT_CARD_INFO/VALUE) }</ns1:noTarjetaCredito>
            {
                for $EXPIRATION_DATE in $retiroTarjetaCredito/CREDIT_CARD_INFO/EXPIRATION_DATE
                return
                    <ns1:fechaExpiracion>{ data($EXPIRATION_DATE) }</ns1:fechaExpiracion>
            }
            <ns1:montoRetiro>{ data($retiroTarjetaCredito/AMOUNT) }</ns1:montoRetiro>
            <ns1:monedaRetiro>
            {
            	let $currency := fn:string($retiroTarjetaCredito/CURRENCY/text())
            	return
            		if ($currency = "GTQ") then 
            			(
            				320
            			) else if ($currency = "USD") then 
            				(
            					840
            				) else 
            					(
            						0
            					) 
            }
  			</ns1:monedaRetiro>
            <ns1:canalRetiro>{ data($requestHeader/Authentication/UserName) }</ns1:canalRetiro>
            <ns1:fechaRetiro>{ fn-bea:date-to-string-with-format('MMddyyyy', fn:current-date()) }</ns1:fechaRetiro>
            <ns1:idRefRetiro>{ data($secuenciaIdRetiro) }</ns1:idRefRetiro>
        </ns1:registrarRetiro>
};

declare variable $retiroTarjetaCredito as element(ns2:retiroTarjetaCredito) external;
declare variable $requestHeader as element(ns0:RequestHeader) external;
declare variable $secuenciaIdRetiro as xs:string external;

xf:registrarRetiroGTIn($retiroTarjetaCredito,
    $requestHeader,
    $secuenciaIdRetiro)
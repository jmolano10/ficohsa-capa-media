(:: pragma bea:global-element-return element="ns0:consultaDatosTarjetaCredito" location="../../../BusinessServices/OSB/ConsultaDatosTarjetaCredito_v3/xsd/XMLSchema_483373888.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaDatosTarjetaCreditoTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/PagoTC/xq/consultaDatosTarjetaIn/";

declare function xf:consultaDatosTarjetaIn($cardNumber as xs:string,
    $org as xs:string)
    as element(ns0:consultaDatosTarjetaCredito) {
        <ns0:consultaDatosTarjetaCredito>
            <CARD_NUMBER>{ $cardNumber }</CARD_NUMBER>
            {
            	if(string($org) != '') then (
					<ORG>{ data($org) }</ORG>
				) else()
            }
       	 </ns0:consultaDatosTarjetaCredito>
};

declare variable $cardNumber as xs:string external;
declare variable $org as xs:string external;

xf:consultaDatosTarjetaIn($cardNumber,
    $org)
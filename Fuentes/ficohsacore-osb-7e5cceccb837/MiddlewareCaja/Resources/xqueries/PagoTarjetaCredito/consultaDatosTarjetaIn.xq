(:: pragma bea:global-element-return element="ns0:consultaDatosTarjetaCredito" location="../../xsds/ConsultaDatosTarjetaCredito_v3/XMLSchema_-1080362392.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaDatosTarjetaCreditoTypes";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/PagoTarjetaCredito/consultaDatosTarjetaIn/";

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
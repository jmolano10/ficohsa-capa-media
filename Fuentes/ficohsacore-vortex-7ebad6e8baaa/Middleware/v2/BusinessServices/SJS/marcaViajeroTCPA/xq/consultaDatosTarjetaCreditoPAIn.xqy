xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:consultaDatosTarjetaCredito" location="../../../../../Business_Resources/tarjetaCredito/ConsultaDatosTarjetaCredito/consultaDatosTarjetaCreditoTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaDatosTarjetaCreditoTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/BusinessServices/SJS/marcaViajeroTCPA/xq/consultaDatosTarjetaCreditoPAIn/";

declare function xf:consultaDatosTarjetaCreditoPAIn($card as xs:string)
    as element(ns0:consultaDatosTarjetaCredito) {
        <ns0:consultaDatosTarjetaCredito>
            <CARD_NUMBER>{ $card }</CARD_NUMBER>
        </ns0:consultaDatosTarjetaCredito>
};

declare variable $card as xs:string external;

xf:consultaDatosTarjetaCreditoPAIn($card)
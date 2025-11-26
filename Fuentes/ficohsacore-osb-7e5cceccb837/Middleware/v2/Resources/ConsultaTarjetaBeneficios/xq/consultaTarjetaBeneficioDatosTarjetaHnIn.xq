(:: pragma bea:global-element-return element="ns0:consultaDatosTarjetaCredito" location="../../ConsultaDatosTarjetaCredito/xsd/consultaDatosTarjetaCreditoTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaDatosTarjetaCreditoTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaTarjetaBeneficios/xq/consultaTaarjetaBeneficioDatosTarjetaHnIn/";

declare function xf:consultaTaarjetaBeneficioDatosTarjetaHnIn($numeroTarjeta as xs:string)
    as element(ns0:consultaDatosTarjetaCredito) {
        <ns0:consultaDatosTarjetaCredito>
            <CARD_NUMBER>{ xs:string(data($numeroTarjeta)) }</CARD_NUMBER>
        </ns0:consultaDatosTarjetaCredito>
};

declare variable $numeroTarjeta as xs:string external;

xf:consultaTaarjetaBeneficioDatosTarjetaHnIn($numeroTarjeta)
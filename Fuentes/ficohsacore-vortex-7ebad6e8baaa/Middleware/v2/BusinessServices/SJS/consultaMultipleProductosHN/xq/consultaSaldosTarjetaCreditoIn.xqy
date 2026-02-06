xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:consultaDatosTarjetaCredito" location="../../../../Resources/ConsultaDatosTarjetaCredito/xsd/consultaDatosTarjetaCreditoTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaDatosTarjetaCreditoTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/BusinessServices/SJS/consultaMultipleProductosHN/xq/consultaSaldosTarjetaCreditoIn/";

declare function xf:consultaSaldosTarjetaCreditoIn($ID as xs:string)
    as element(ns0:consultaDatosTarjetaCredito) {
        <ns0:consultaDatosTarjetaCredito>
            <CARD_NUMBER>{ $ID }</CARD_NUMBER>
        </ns0:consultaDatosTarjetaCredito>
};

declare variable $ID as xs:string external;

xf:consultaSaldosTarjetaCreditoIn($ID)
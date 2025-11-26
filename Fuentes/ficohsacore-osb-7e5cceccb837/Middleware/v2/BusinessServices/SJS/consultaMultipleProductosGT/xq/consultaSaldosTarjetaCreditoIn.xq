(:: pragma bea:global-element-return element="ns0:consultaSaldosTarjetaCredito" location="../../../../Resources/ConsultaSaldosTarjetaCredito/xsd/consultaSaldosTarjetaCreditoTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaSaldosTarjetaCreditoTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/BusinessServices/SJS/consultaMultipleProductosGT/xq/consultaSaldosTarjetaCreditoIn/";

declare function xf:consultaSaldosTarjetaCreditoIn($card_number as xs:string)
    as element(ns0:consultaSaldosTarjetaCredito) {
        <ns0:consultaSaldosTarjetaCredito>
            <CARD_NUMBER>{ data($card_number) }</CARD_NUMBER>
        </ns0:consultaSaldosTarjetaCredito>
};

declare variable $card_number as xs:string external;

xf:consultaSaldosTarjetaCreditoIn($card_number)

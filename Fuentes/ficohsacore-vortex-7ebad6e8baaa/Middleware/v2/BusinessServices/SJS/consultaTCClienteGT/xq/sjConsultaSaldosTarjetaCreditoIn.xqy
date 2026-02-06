xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:consultaSaldosTarjetaCredito" location="../../../../Resources/ConsultaSaldosTarjetaCredito/xsd/consultaSaldosTarjetaCreditoTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaSaldosTarjetaCreditoTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/BusinessServices/SJS/consultaTCClienteGT/xq/sjConsultaSaldosTarjetaCreditoIn/";

declare function xf:sjConsultaSaldosTarjetaCreditoIn($cardNumber as xs:string)
    as element(ns0:consultaSaldosTarjetaCredito) {
        <ns0:consultaSaldosTarjetaCredito>
            <CARD_NUMBER>{ $cardNumber }</CARD_NUMBER>
        </ns0:consultaSaldosTarjetaCredito>
};

declare variable $cardNumber as xs:string external;

xf:sjConsultaSaldosTarjetaCreditoIn($cardNumber)
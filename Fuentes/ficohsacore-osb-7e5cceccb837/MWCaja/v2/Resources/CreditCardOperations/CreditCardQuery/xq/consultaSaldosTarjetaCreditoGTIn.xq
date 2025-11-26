(:: pragma bea:global-element-return element="ns0:consultaSaldosTarjetaCredito" location="../../../../../../Middleware/v2/Resources/ConsultaSaldosTarjetaCredito/xsd/consultaSaldosTarjetaCreditoTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaSaldosTarjetaCreditoTypes";
declare namespace xf = "http://tempuri.org/MWCaja/v1/Resources/CreditCardOperations/CreditCardQuery/xq/consultaSaldosTarjetaCreditoGTIn/";

declare function xf:consultaSaldosTarjetaCreditoGTIn($CARD_NUMBER as xs:string)
    as element(ns0:consultaSaldosTarjetaCredito) {
        <ns0:consultaSaldosTarjetaCredito>
            <CARD_NUMBER>{ $CARD_NUMBER }</CARD_NUMBER>
        </ns0:consultaSaldosTarjetaCredito>
};

declare variable $CARD_NUMBER as xs:string external;

xf:consultaSaldosTarjetaCreditoGTIn($CARD_NUMBER)

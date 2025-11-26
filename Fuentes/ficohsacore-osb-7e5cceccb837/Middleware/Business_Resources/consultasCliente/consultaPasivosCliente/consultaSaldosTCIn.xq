(:: pragma bea:global-element-return element="ns0:consultaSaldosTarjetaCredito" location="../../tarjetaCredito/ConsultaSaldosTarjetaCredito/consultaSaldosTarjetaCreditoTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaSaldosTarjetaCreditoTypes";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/consultasCliente/consultaPasivosCliente/consultaSaldosTCIn/";

declare function xf:consultaSaldosTCIn($CARD_NUMBER as xs:string)
    as element(ns0:consultaSaldosTarjetaCredito) {
        <ns0:consultaSaldosTarjetaCredito>
            <CARD_NUMBER>{ $CARD_NUMBER }</CARD_NUMBER>
        </ns0:consultaSaldosTarjetaCredito>
};

declare variable $CARD_NUMBER as xs:string external;

xf:consultaSaldosTCIn($CARD_NUMBER)
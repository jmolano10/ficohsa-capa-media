(:: pragma bea:global-element-return element="ns0:consultarSaldos" location="../../wsdls/Alcance.wsdl" ::)

declare namespace ns0 = "http://tempuri.org/";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/PagoTarjetaCreditoFicohsa/consultaTCIn/";

declare function xf:consultaTCIn($creditCardNumber as xs:string)
    as element(ns0:consultarSaldos) {
        <ns0:consultarSaldos>
            <ns0:noTarjetaCredito>{ $creditCardNumber }</ns0:noTarjetaCredito>
        </ns0:consultarSaldos>
};

declare variable $creditCardNumber as xs:string external;

xf:consultaTCIn($creditCardNumber)
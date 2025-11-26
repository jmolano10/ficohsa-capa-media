(:: pragma bea:global-element-return element="ns0:InformacionTarjeta" location="../../wsdls/Alcance.wsdl" ::)

declare namespace ns0 = "http://tempuri.org/";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/PagoTarjetaCreditoProxyCiti/consultaTCIn2/";

declare function xf:consultaTCIn2($creditCardNumber as xs:string)
    as element(ns0:InformacionTarjeta) {
        <ns0:InformacionTarjeta>
            <ns0:noTarjetaCredito>{ $creditCardNumber }</ns0:noTarjetaCredito>
        </ns0:InformacionTarjeta>
};

declare variable $creditCardNumber as xs:string external;

xf:consultaTCIn2($creditCardNumber)
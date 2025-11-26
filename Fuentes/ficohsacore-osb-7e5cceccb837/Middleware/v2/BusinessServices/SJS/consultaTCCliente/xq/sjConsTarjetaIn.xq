(:: pragma bea:global-element-return element="ns0:ConsultarSaldosVasa" location="../../../transaccionesAlcance/wsdl/wsinfotarjetas.asmx.wsdl" ::)

declare namespace ns0 = "http://alcance.local/wsinfotarjetas/";
declare namespace xf = "http://tempuri.org/Middleware/v2/BusinessServices/SJS/consultaTCCliente/xq/sjConsTarjetaIn/";

declare function xf:sjConsTarjetaIn($cardNumber as xs:string)
    as element(ns0:ConsultarSaldosVasa) {
        <ns0:ConsultarSaldosVasa>
            <ns0:noTarjetaCredito>{ $cardNumber }</ns0:noTarjetaCredito>
        </ns0:ConsultarSaldosVasa>
};

declare variable $cardNumber as xs:string external;

xf:sjConsTarjetaIn($cardNumber)
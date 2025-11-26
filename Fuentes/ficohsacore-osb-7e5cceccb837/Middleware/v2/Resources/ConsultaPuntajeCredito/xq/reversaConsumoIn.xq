(:: pragma bea:global-element-return element="ns0:ReservarNOR" location="../../../BusinessServices/transaccionesAlcance/wsdl/wsinfotarjetas.asmx.wsdl" ::)

declare namespace ns0 = "http://alcance.local/wsinfotarjetas/";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaPuntajeCredito/xq/reversaConsumoIn/";

declare function xf:reversaConsumoIn($cardNumber as xs:string,
    $amount as xs:double,
    $currency as xs:string,
    $description as xs:string,
    $channel as xs:string,
    $date as xs:string,
    $reference as xs:string,
    $expirationDate as xs:string,
    $consumeCode as xs:string)
    as element(ns0:ReservarNOR) {
        <ns0:ReservarNOR>
            <ns0:noTarjetaCredito>{ $cardNumber }</ns0:noTarjetaCredito>
            <ns0:montoConsumo>{ $amount }</ns0:montoConsumo>
            <ns0:monedaConsumo>{ $currency }</ns0:monedaConsumo>
            <ns0:descripcionConsumo>{ $description }</ns0:descripcionConsumo>
            <ns0:canalConsumo>{ $channel }</ns0:canalConsumo>
            <ns0:fechaConsumo>{ $date }</ns0:fechaConsumo>
            <ns0:idRefConsumo>{ $reference }</ns0:idRefConsumo>
            <ns0:FechaExpiracion>{ $expirationDate }</ns0:FechaExpiracion>
            <ns0:codigoConsumo>{ $consumeCode }</ns0:codigoConsumo>
        </ns0:ReservarNOR>
};

declare variable $cardNumber as xs:string external;
declare variable $amount as xs:double external;
declare variable $currency as xs:string external;
declare variable $description as xs:string external;
declare variable $channel as xs:string external;
declare variable $date as xs:string external;
declare variable $reference as xs:string external;
declare variable $expirationDate as xs:string external;
declare variable $consumeCode as xs:string external;

xf:reversaConsumoIn($cardNumber,
    $amount,
    $currency,
    $description,
    $channel,
    $date,
    $reference,
    $expirationDate,
    $consumeCode)

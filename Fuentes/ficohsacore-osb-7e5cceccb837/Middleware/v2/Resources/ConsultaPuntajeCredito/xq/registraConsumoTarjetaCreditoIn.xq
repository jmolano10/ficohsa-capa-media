(:: pragma bea:global-element-return element="ns0:ConsumoNOR" location="../../../BusinessServices/transaccionesAlcance/wsdl/wsinfotarjetas.asmx.wsdl" ::)

declare namespace ns0 = "http://alcance.local/wsinfotarjetas/";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaPuntajeCredito/xq/registraConsumoTarjetaCreditoIn/";

declare function xf:registraConsumoTarjetaCreditoIn($cardNumber as xs:string,
    $expirationDate as xs:string,
    $amount as xs:double,
    $currency as xs:string,
    $description as xs:string,
    $channel as xs:string,
    $date as xs:string,
    $reference as xs:string)
    as element(ns0:ConsumoNOR) {
        <ns0:ConsumoNOR>
            <ns0:noTarjetaCredito>{ $cardNumber }</ns0:noTarjetaCredito>
            <ns0:FechaExpiracion>{ $expirationDate }</ns0:FechaExpiracion>
            <ns0:montoConsumo>{ $amount }</ns0:montoConsumo>
            <ns0:monedaConsumo>{ $currency }</ns0:monedaConsumo>
            <ns0:DescripcionConsumo>{ $description }</ns0:DescripcionConsumo>
            <ns0:canalConsumo>{ $channel }</ns0:canalConsumo>
            <ns0:fechaConsumo>{ $date }</ns0:fechaConsumo>
            <ns0:idRefConsumo>{ $reference }</ns0:idRefConsumo>
        </ns0:ConsumoNOR>
};

declare variable $cardNumber as xs:string external;
declare variable $expirationDate as xs:string external;
declare variable $amount as xs:double external;
declare variable $currency as xs:string external;
declare variable $description as xs:string external;
declare variable $channel as xs:string external;
declare variable $date as xs:string external;
declare variable $reference as xs:string external;

xf:registraConsumoTarjetaCreditoIn($cardNumber,
    $expirationDate,
    $amount,
    $currency,
    $description,
    $channel,
    $date,
    $reference)

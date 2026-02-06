xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consumoNORResponse" element="ns0:ConsumoNORResponse" location="../../../BusinessServices/ABKGT/transaccionesAlcance/wsdl/wsinfotarjetas.asmx.wsdl" ::)
(:: pragma bea:global-element-parameter parameter="$pagoRecaudo1" element="ns1:pagoRecaudo" location="../../../../Business_Resources/pagoRecaudos/PagoRecaudo/pagoRecaudoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:ReservarNOR" location="../../../BusinessServices/ABKGT/transaccionesAlcance/wsdl/wsinfotarjetas.asmx.wsdl" ::)

declare namespace ns0 = "http://alcance.local/wsinfotarjetas/";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/pagoRecaudoTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/PagoRecaudo/xq/pagoRecaudoReversarConsumoTCGT/";

declare function xf:pagoRecaudoReversarConsumoTCGT($consumoNORResponse as element(ns0:ConsumoNORResponse),
    $pagoRecaudo1 as element(ns1:pagoRecaudo),
    $purchaseDescription as xs:string,
    $purchaseRefNumber as xs:string)
    as element(ns0:ReservarNOR) {
        <ns0:ReservarNOR>
            {
                for $CREDIT_CARD_NUMBER in $pagoRecaudo1/PAYMENT_INFORMATION/CREDIT_CARD_NUMBER
                return
                    <ns0:noTarjetaCredito>{ data($CREDIT_CARD_NUMBER) }</ns0:noTarjetaCredito>
            }
            <ns0:montoConsumo>{ fn:string($pagoRecaudo1/PAYMENT_INFORMATION/PAYMENT_AMOUNT/text()) }</ns0:montoConsumo>
            <ns0:monedaConsumo>               
            {
                    let $PAYMENT_CURRENCY  := (fn:string($pagoRecaudo1/PAYMENT_INFORMATION/PAYMENT_CURRENCY/text()))  
                    return
                        if ($PAYMENT_CURRENCY = "GTQ") then
                            (320)
                        else 
                            if ($PAYMENT_CURRENCY = "USD") then
                                (840)
                            else 
                                0
            }</ns0:monedaConsumo>
            <ns0:descripcionConsumo>{ $purchaseDescription }</ns0:descripcionConsumo>
            <ns0:canalConsumo>1</ns0:canalConsumo>
            <ns0:fechaConsumo>{ fn-bea:date-to-string-with-format("yyyyMMdd",fn:current-date()) }</ns0:fechaConsumo>
            <ns0:idRefConsumo>{ $purchaseRefNumber }</ns0:idRefConsumo>
            {
                for $EXPIRATION_DATE in $pagoRecaudo1/PAYMENT_INFORMATION/EXPIRATION_DATE
                return
                    <ns0:FechaExpiracion>{ data($EXPIRATION_DATE) }</ns0:FechaExpiracion>
            }
            {
                for $mensajeConfirmacion in $consumoNORResponse/ns0:ConsumoNORResult/ns0:mensajeConfirmacion
                return
                    <ns0:codigoConsumo>{ data($mensajeConfirmacion) }</ns0:codigoConsumo>
            }
        </ns0:ReservarNOR>
};

declare variable $consumoNORResponse as element(ns0:ConsumoNORResponse) external;
declare variable $pagoRecaudo1 as element(ns1:pagoRecaudo) external;
declare variable $purchaseDescription as xs:string external;
declare variable $purchaseRefNumber as xs:string external;

xf:pagoRecaudoReversarConsumoTCGT($consumoNORResponse,
    $pagoRecaudo1,
    $purchaseDescription,
    $purchaseRefNumber)
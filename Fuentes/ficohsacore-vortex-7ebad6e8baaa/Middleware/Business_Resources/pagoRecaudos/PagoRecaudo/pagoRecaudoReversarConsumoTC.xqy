xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$pagoRecaudo1" element="ns0:pagoRecaudo" location="pagoRecaudoTypes.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consumoNORResponse1" element="ns1:ConsumoNORResponse" location="../../../v2/BusinessServices/transaccionesAlcance/wsdl/wsinfotarjetas.asmx.wsdl" ::)
(:: pragma bea:global-element-return element="ns1:ReservarNOR" location="../../../v2/BusinessServices/transaccionesAlcance/wsdl/wsinfotarjetas.asmx.wsdl" ::)

declare namespace ns1 = "http://alcance.local/wsinfotarjetas/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/pagoRecaudoTypes";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/pagoRecaudos/PagoRecaudo/pagoRecaudoReversarConsumoTCNuevo/";

declare function xf:pagoRecaudoReversarConsumoTCNuevo($pagoRecaudo1 as element(ns0:pagoRecaudo),
    $consumoNORResponse1 as element(ns1:ConsumoNORResponse),
    $purchaseDescription as xs:string,
    $purchaseRefNumber as xs:string)
    as element(ns1:ReservarNOR) {
        <ns1:ReservarNOR>
            {
                for $CREDIT_CARD_NUMBER in $pagoRecaudo1/PAYMENT_INFORMATION/CREDIT_CARD_NUMBER
                return
                    <ns1:noTarjetaCredito>{ data($CREDIT_CARD_NUMBER) }</ns1:noTarjetaCredito>
            }
            <ns1:montoConsumo>{ fn:string($pagoRecaudo1/PAYMENT_INFORMATION/PAYMENT_AMOUNT/text()) }</ns1:montoConsumo>
            <ns1:monedaConsumo>
                {
                    let $PAYMENT_CURRENCY  := (fn:string($pagoRecaudo1/PAYMENT_INFORMATION/PAYMENT_CURRENCY/text()))  
                    return
                        if ($PAYMENT_CURRENCY = "HNL") then
                            (340)
                        else 
                            if ($PAYMENT_CURRENCY = "USD") then
                                (840)
                            else 
                                0
                }
</ns1:monedaConsumo>
            <ns1:descripcionConsumo>{ $purchaseDescription }</ns1:descripcionConsumo>
            <ns1:canalConsumo>1</ns1:canalConsumo>
            <ns1:fechaConsumo>{ fn-bea:date-to-string-with-format("yyyyMMdd",fn:current-date()) }</ns1:fechaConsumo>
            <ns1:idRefConsumo>{ $purchaseRefNumber }</ns1:idRefConsumo>
            {
                for $EXPIRATION_DATE in $pagoRecaudo1/PAYMENT_INFORMATION/EXPIRATION_DATE
                return
                    <ns1:FechaExpiracion>{ data($EXPIRATION_DATE) }</ns1:FechaExpiracion>
            }
            {
                for $mensajeConfirmacion in $consumoNORResponse1/ns1:ConsumoNORResult/ns1:mensajeConfirmacion
                return
                    <ns1:codigoConsumo>{ data($mensajeConfirmacion) }</ns1:codigoConsumo>
            }
        </ns1:ReservarNOR>
};

declare variable $pagoRecaudo1 as element(ns0:pagoRecaudo) external;
declare variable $consumoNORResponse1 as element(ns1:ConsumoNORResponse) external;
declare variable $purchaseDescription as xs:string external;
declare variable $purchaseRefNumber as xs:string external;

xf:pagoRecaudoReversarConsumoTCNuevo($pagoRecaudo1,
    $consumoNORResponse1,
    $purchaseDescription,
    $purchaseRefNumber)
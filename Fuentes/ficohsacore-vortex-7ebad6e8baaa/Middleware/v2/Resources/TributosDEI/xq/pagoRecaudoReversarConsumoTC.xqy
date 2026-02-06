xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns1:ReservarNOR" location="../../../BusinessServices/transaccionesAlcance/wsdl/wsinfotarjetas.asmx.wsdl" ::)

declare namespace ns1 = "http://alcance.local/wsinfotarjetas/";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/pagoRecaudos/PagoRecaudo/pagoRecaudoReversarConsumoTCNuevo/";

declare function xf:pagoRecaudoReversarConsumoTCNuevo($numeroTarjetaCredito as xs:string
    ,$fechaexpiracionTC  as xs:string,  $montoConsumo as xs:string, $monedaConsumo as xs:string,
    $mensajeConfirmacion  as xs:string,
    $purchaseDescription as xs:string,
    $purchaseRefNumber as xs:string)
    as element(ns1:ReservarNOR) {
        <ns1:ReservarNOR>
           <ns1:noTarjetaCredito>{ data( $numeroTarjetaCredito) }</ns1:noTarjetaCredito>
            <ns1:montoConsumo>{ fn:string($montoConsumo) }</ns1:montoConsumo>
            <ns1:monedaConsumo>
                {
                    let $PAYMENT_CURRENCY  := (fn:string($monedaConsumo))  
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
                    <ns1:FechaExpiracion>{ data($fechaexpiracionTC) }</ns1:FechaExpiracion>
                    <ns1:codigoConsumo>{ data($mensajeConfirmacion) }</ns1:codigoConsumo> 
        </ns1:ReservarNOR>
};

declare variable $montoConsumo as xs:string external;
declare variable $monedaConsumo as xs:string external;
declare variable $numeroTarjetaCredito as xs:string external;
declare variable $fechaexpiracionTC as xs:string external;
declare variable $mensajeConfirmacion as  xs:string external;
declare variable $purchaseDescription as xs:string external;
declare variable $purchaseRefNumber as xs:string external;

xf:pagoRecaudoReversarConsumoTCNuevo(
    $numeroTarjetaCredito,
    $fechaexpiracionTC,
    $montoConsumo,
    $monedaConsumo,
    $mensajeConfirmacion,
    $purchaseDescription,
    $purchaseRefNumber)
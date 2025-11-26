(:: pragma bea:global-element-parameter parameter="$pagoRecaudo1" element="ns0:pagoRecaudo" location="../../xsds/PagoRecaudo/PagoRecaudo.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$registrarConsumoResponse1" element="ns1:registrarConsumoResponse" location="../../wsdls/Alcance.wsdl" ::)
(:: pragma bea:global-element-return element="ns1:reversarConsumo" location="../../wsdls/Alcance.wsdl" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/pagoRecaudoTypes";
declare namespace ns1 = "http://tempuri.org/";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/PagoRecaudo/pagoRecaudoReversarConsumoTC/";

declare function xf:pagoRecaudoReversarConsumoTC($pagoRecaudo1 as element(ns0:pagoRecaudo),
    $registrarConsumoResponse1 as element(ns1:registrarConsumoResponse),
    $purchaseRefNumber as xs:string)
    as element(ns1:reversarConsumo) {
        <ns1:reversarConsumo>
            {
                for $CREDIT_CARD_NUMBER in $pagoRecaudo1/PAYMENT_INFORMATION/CREDIT_CARD_NUMBER
                return
                    <ns1:noTarjetaCredito>{ data($CREDIT_CARD_NUMBER) }</ns1:noTarjetaCredito>
            }
            {
                for $EXPIRATION_DATE in $pagoRecaudo1/PAYMENT_INFORMATION/EXPIRATION_DATE
                return
                    <ns1:fechaExpiracion>{ data($EXPIRATION_DATE) }</ns1:fechaExpiracion>
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
			<ns1:canalConsumo>1</ns1:canalConsumo>
			<ns1:fechaConsumo>{ fn:current-dateTime() }</ns1:fechaConsumo>
            <ns1:idRefConsumo>{ $purchaseRefNumber }</ns1:idRefConsumo>
            {
                for $mensajeConfirmacion in $registrarConsumoResponse1/ns1:registrarConsumoResult/ns1:mensajeConfirmacion
                return
                    <ns1:codigoConsumo>{ data($mensajeConfirmacion) }</ns1:codigoConsumo>
            }
        </ns1:reversarConsumo>
};

declare variable $pagoRecaudo1 as element(ns0:pagoRecaudo) external;
declare variable $registrarConsumoResponse1 as element(ns1:registrarConsumoResponse) external;
declare variable $purchaseRefNumber as xs:string external;

xf:pagoRecaudoReversarConsumoTC($pagoRecaudo1,
    $registrarConsumoResponse1,
    $purchaseRefNumber)
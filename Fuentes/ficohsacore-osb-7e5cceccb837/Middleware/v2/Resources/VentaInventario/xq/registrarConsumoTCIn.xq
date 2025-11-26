(:: pragma bea:global-element-parameter parameter="$ventaInventario1" element="ns0:ventaInventario" location="../xsd/ventaInventarioTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ConsumoNOR" location="../../../BusinessServices/transaccionesAlcance/wsdl/wsinfotarjetas.asmx.wsdl" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/ventaInventarioTypes";
declare namespace ns1 = "http://alcance.local/wsinfotarjetas/";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/VentaInventario/xq/registrarConsumoIn/";

declare function xf:registrarConsumoIn($ventaInventario1 as element(ns0:ventaInventario),
    $paymentAmount as xs:string,
    $purchaseDescription as xs:string,
    $purchaseRefNumber as xs:string)
    as element(ns1:ConsumoNOR) {
        <ns1:ConsumoNOR>
            {
                for $CREDIT_CARD_NUMBER in $ventaInventario1/PAYMENT_INFORMATION/CREDIT_CARD_NUMBER
                return
                    <ns1:noTarjetaCredito>{ data($CREDIT_CARD_NUMBER) }</ns1:noTarjetaCredito>
            }
            {
                for $EXPIRATION_DATE in $ventaInventario1/PAYMENT_INFORMATION/EXPIRATION_DATE
                return
                    <ns1:FechaExpiracion>{ data($EXPIRATION_DATE) }</ns1:FechaExpiracion>
            }
            <ns1:montoConsumo>{ $paymentAmount }</ns1:montoConsumo>
            <ns1:monedaConsumo>{
            	 let $PAYMENT_CURRENCY := fn:string($ventaInventario1/PAYMENT_INFORMATION/PAYMENT_CURRENCY/text())
            	return
            	if ($PAYMENT_CURRENCY = "HNL") then (
            		340
            	) else if ($PAYMENT_CURRENCY = "USD") then (
            		840
            	) else (
            		0
            	)
								}
            </ns1:monedaConsumo>
            <ns1:DescripcionConsumo>{ $purchaseDescription }</ns1:DescripcionConsumo>
            <ns1:canalConsumo>1</ns1:canalConsumo>
            <ns1:fechaConsumo>{ fn-bea:date-to-string-with-format("yyyyMMdd",fn:current-date()) }</ns1:fechaConsumo>
            <ns1:idRefConsumo>{ $purchaseRefNumber }</ns1:idRefConsumo>
        </ns1:ConsumoNOR>
};

declare variable $ventaInventario1 as element(ns0:ventaInventario) external;
declare variable $paymentAmount as xs:string external;
declare variable $purchaseDescription as xs:string external;
declare variable $purchaseRefNumber as xs:string external;

xf:registrarConsumoIn($ventaInventario1,
    $paymentAmount,
    $purchaseDescription,
    $purchaseRefNumber)
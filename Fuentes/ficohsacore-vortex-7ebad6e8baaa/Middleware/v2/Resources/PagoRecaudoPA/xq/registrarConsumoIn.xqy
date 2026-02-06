xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$pagoRecaudo" element="ns0:pagoRecaudo" location="../../../../Business_Resources/pagoRecaudos/PagoRecaudo/pagoRecaudoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ConsumoNOR" location="../../../BusinessServices/ABKPA/transaccionesAlcance/wsdl/wsinfotarjetas.asmx.wsdl" ::)

declare namespace ns1 = "http://alcance.local/wsinfotarjetas/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/pagoRecaudoTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/PagoRecaudoPA/xq/transaccionesAlcanceRegistrarConsumoIn/";

declare function xf:transaccionesAlcanceRegistrarConsumoIn($pagoRecaudo as element(ns0:pagoRecaudo),
    $nombreCobranza as xs:string,
    $secuencia as xs:string,
    $username as xs:string,
    $fecha as xs:date)
    as element(ns1:ConsumoNOR) {
        <ns1:ConsumoNOR>
            {
                for $CREDIT_CARD_NUMBER in $pagoRecaudo/PAYMENT_INFORMATION/CREDIT_CARD_NUMBER
                return
                    <ns1:noTarjetaCredito>{ data($CREDIT_CARD_NUMBER) }</ns1:noTarjetaCredito>
            }
            {
                for $EXPIRATION_DATE in $pagoRecaudo/PAYMENT_INFORMATION/EXPIRATION_DATE
                return
                    <ns1:FechaExpiracion>{ data($EXPIRATION_DATE) }</ns1:FechaExpiracion>
            }
            <ns1:montoConsumo>{ data($pagoRecaudo/PAYMENT_INFORMATION/PAYMENT_AMOUNT) }</ns1:montoConsumo>
            { 
            	for $paymentCurrency in $pagoRecaudo/PAYMENT_INFORMATION/PAYMENT_CURRENCY
            	return
            		<ns1:monedaConsumo>
            		{
            			if($paymentCurrency = 'USD') then(
		               		'840'
		               	)else ('')
            		}
            		</ns1:monedaConsumo>
            }
            <ns1:DescripcionConsumo>{ $nombreCobranza }</ns1:DescripcionConsumo>
            <ns1:canalConsumo>{ $username }</ns1:canalConsumo>
            <ns1:fechaConsumo>{ fn-bea:date-to-string-with-format("MMdd",$fecha)}</ns1:fechaConsumo>
            <ns1:idRefConsumo>{ $secuencia }</ns1:idRefConsumo>
        </ns1:ConsumoNOR>
};

declare variable $pagoRecaudo as element(ns0:pagoRecaudo) external;
declare variable $nombreCobranza as xs:string external;
declare variable $secuencia as xs:string external;
declare variable $username as xs:string external;
declare variable $fecha as xs:date external;

xf:transaccionesAlcanceRegistrarConsumoIn($pagoRecaudo,
    $nombreCobranza,
    $secuencia,
    $username,
    $fecha)
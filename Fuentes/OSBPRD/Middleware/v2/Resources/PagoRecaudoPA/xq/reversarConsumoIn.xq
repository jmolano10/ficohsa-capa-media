(:: pragma bea:global-element-parameter parameter="$pagoRecaudo" element="ns0:pagoRecaudo" location="../../../../Business_Resources/pagoRecaudos/PagoRecaudo/pagoRecaudoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ReservarNOR" location="../../../BusinessServices/ABKPA/transaccionesAlcance/wsdl/wsinfotarjetas.asmx.wsdl" ::)

declare namespace ns1 = "http://alcance.local/wsinfotarjetas/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/pagoRecaudoTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/PagoRecaudoPA/xq/transaccionesAlcanceReservarConsumoIn/";

declare function xf:transaccionesAlcanceReservarConsumoIn($pagoRecaudo as element(ns0:pagoRecaudo),
    $nombreCobranza as xs:string,
    $fechaSistema as xs:date,
    $usuario as xs:string,
    $secuencia as xs:string,
    $estatusConsumo as xs:string)
    as element(ns1:ReservarNOR) {
        <ns1:ReservarNOR>
            {
                for $CREDIT_CARD_NUMBER in $pagoRecaudo/PAYMENT_INFORMATION/CREDIT_CARD_NUMBER
                return
                    <ns1:noTarjetaCredito>{ data($CREDIT_CARD_NUMBER) }</ns1:noTarjetaCredito>
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
            <ns1:descripcionConsumo>{ $nombreCobranza }</ns1:descripcionConsumo>
            <ns1:canalConsumo>{ $usuario }</ns1:canalConsumo>
            <ns1:fechaConsumo>{ data($fechaSistema) }</ns1:fechaConsumo>
            <ns1:idRefConsumo>{ $secuencia }</ns1:idRefConsumo>
            {
                for $EXPIRATION_DATE in $pagoRecaudo/PAYMENT_INFORMATION/EXPIRATION_DATE
                return
                    <ns1:FechaExpiracion>{ data($EXPIRATION_DATE) }</ns1:FechaExpiracion>
            }
            <ns1:codigoConsumo>{ $estatusConsumo }</ns1:codigoConsumo>
        </ns1:ReservarNOR>
};

declare variable $pagoRecaudo as element(ns0:pagoRecaudo) external;
declare variable $nombreCobranza as xs:string external;
declare variable $fechaSistema as xs:date external;
declare variable $usuario as xs:string external;
declare variable $secuencia as xs:string external;
declare variable $estatusConsumo as xs:string external;

xf:transaccionesAlcanceReservarConsumoIn($pagoRecaudo,
    $nombreCobranza,
    $fechaSistema,
    $usuario,
    $secuencia,
    $estatusConsumo)
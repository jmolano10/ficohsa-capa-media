(:: pragma bea:global-element-parameter parameter="$reversionPagoTarjetaCredito" element="ns0:reversionPagoTarjetaCredito" location="reversionPagoTarjetaCreditoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:reversarPago" location="../Resources/TarjetaDeCredito.wsdl" ::)

declare namespace ns1 = "http://tempuri.org/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/reversionPagoTarjetaCreditoTypes";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/tarjetaCredito/ReversionPagoTarjetaCredito/reversionPagoTarjetaCreditoIn/";

declare function getISOMoneda($codigoMoneda as xs:string?) as xs:string
{
	if ($codigoMoneda = "HNL") then "340"
	else if ($codigoMoneda = "USD") then "840" 
	else( "" )

};

declare function xf:reversionPagoTarjetaCreditoIn($reversionPagoTarjetaCredito as element(ns0:reversionPagoTarjetaCredito))
    as element(ns1:reversarPago) {
        <ns1:reversarPago>
            <ns1:noTarjetaCredito>{ data($reversionPagoTarjetaCredito/CREDIT_CARD_NUMBER) }</ns1:noTarjetaCredito>
            <ns1:montoPago>{ number($reversionPagoTarjetaCredito/AMOUNT) }</ns1:montoPago>
            <ns1:monedaPago>{ getISOMoneda($reversionPagoTarjetaCredito/CURRENCY) }</ns1:monedaPago>
            <ns1:formaPago>{ data($reversionPagoTarjetaCredito/PAYMENT_TYPE) }</ns1:formaPago>
            <ns1:canalPago>{ data($reversionPagoTarjetaCredito/PAYMENT_CHANNEL) }</ns1:canalPago>
            <ns1:fechaPago>{ data($reversionPagoTarjetaCredito/PAYMENT_DATE) }</ns1:fechaPago>
            <ns1:idRefPago>{ data($reversionPagoTarjetaCredito/PAYMENT_REFERENCE) }</ns1:idRefPago>
            <ns1:codigoPago>{ data($reversionPagoTarjetaCredito/PAYMENT_CODE) }</ns1:codigoPago>
        </ns1:reversarPago>
};

declare variable $reversionPagoTarjetaCredito as element(ns0:reversionPagoTarjetaCredito) external;

xf:reversionPagoTarjetaCreditoIn($reversionPagoTarjetaCredito)
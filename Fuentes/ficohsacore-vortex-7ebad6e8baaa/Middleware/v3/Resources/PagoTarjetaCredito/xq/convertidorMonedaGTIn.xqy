xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$pagoTarjetaCredito" element="ns0:pagoTarjetaCredito" location="../xsd/pagoTarjetaCreditoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ConvertidorMoneda" location="../../../../v2/Resources/ConvertidorMoneda/xsd/ConvertidorMonedaTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/pagoTarjetaCreditoTypes";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/ConvertidorMonedaTypes";
declare namespace xf = "http://tempuri.org/Middleware/v3/Resources/PagoTarjetaCredito/xq/convertidorMonedaGTIn/";

declare function xf:convertidorMonedaGTIn($pagoTarjetaCredito as element(ns0:pagoTarjetaCredito),
    $externalCurrency as xs:string)
    as element(ns1:ConvertidorMoneda) {
        <ns1:ConvertidorMoneda>
            <SOURCE_CURRENCY>{ $externalCurrency }</SOURCE_CURRENCY>
            <TARGET_CURRENCY>{ data($pagoTarjetaCredito/BALANCE_CURRENCY) }</TARGET_CURRENCY>
            <SOURCE_AMOUNT>{ data($pagoTarjetaCredito/PAYMENT_AMOUNT) }</SOURCE_AMOUNT>
        </ns1:ConvertidorMoneda>
};

declare variable $pagoTarjetaCredito as element(ns0:pagoTarjetaCredito) external;
declare variable $externalCurrency as xs:string external;

xf:convertidorMonedaGTIn($pagoTarjetaCredito,
    $externalCurrency)
(:: pragma bea:global-element-return element="ns0:consultaTasaCambio" location="../../../../Business_Resources/Core/consultaTasaCambio/consultaTasaCambioTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaTasaCambioTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaPuntajeCredito/xq/consultaTasaCambioIn/";

declare function xf:consultaTasaCambioIn($sourceCurrency as xs:string,
    $targetCurrency as xs:string)
    as element(ns0:consultaTasaCambio) {
        <ns0:consultaTasaCambio>
            <SOURCE_CURRENCY>{ $sourceCurrency }</SOURCE_CURRENCY>
            <TARGET_CURRENCY>{ $targetCurrency }</TARGET_CURRENCY>
        </ns0:consultaTasaCambio>
};

declare variable $sourceCurrency as xs:string external;
declare variable $targetCurrency as xs:string external;

xf:consultaTasaCambioIn($sourceCurrency,
    $targetCurrency)

(:: pragma bea:global-element-return element="ns0:consultaTasaCambio" location="../../Core/consultaTasaCambio/consultaTasaCambioTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaTasaCambioTypes";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/consultasCliente/consultaPasivosCliente/consultaTasaCambioUSDIn/";

declare function xf:consultaTasaCambioUSDIn($monedaLocal as xs:string,
    $monedaExtranjera as xs:string)
    as element(ns0:consultaTasaCambio) {
        <ns0:consultaTasaCambio>
            <SOURCE_CURRENCY>{ $monedaLocal }</SOURCE_CURRENCY>
            <TARGET_CURRENCY>{ $monedaExtranjera }</TARGET_CURRENCY>
        </ns0:consultaTasaCambio>
};

declare variable $monedaLocal as xs:string external;
declare variable $monedaExtranjera as xs:string external;

xf:consultaTasaCambioUSDIn($monedaLocal,
    $monedaExtranjera)
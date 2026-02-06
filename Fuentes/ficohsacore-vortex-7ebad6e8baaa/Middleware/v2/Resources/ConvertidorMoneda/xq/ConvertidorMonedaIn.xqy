xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:ConvertidorMoneda" location="../xsd/ConvertidorMonedaTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/ConvertidorMonedaTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConvertidorMoneda/xq/ConvertidorMonedaIn/";

declare function xf:ConvertidorMonedaIn($SourceCurrency as xs:string,
    $SourceAmount as xs:string,
    $TargetCurrency as xs:string)
    as element(ns0:ConvertidorMoneda) {
        <ns0:ConvertidorMoneda>
            <SOURCE_CURRENCY>{ $SourceCurrency }</SOURCE_CURRENCY>
            <TARGET_CURRENCY>{ $TargetCurrency }</TARGET_CURRENCY>
            <SOURCE_AMOUNT>{ xs:decimal($SourceAmount) }</SOURCE_AMOUNT>
        </ns0:ConvertidorMoneda>
};

declare variable $SourceCurrency as xs:string external;
declare variable $SourceAmount as xs:string external;
declare variable $TargetCurrency as xs:string external;

xf:ConvertidorMonedaIn($SourceCurrency,
    $SourceAmount,
    $TargetCurrency)
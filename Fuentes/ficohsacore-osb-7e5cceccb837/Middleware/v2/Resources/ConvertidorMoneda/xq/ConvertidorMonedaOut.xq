(:: pragma bea:global-element-return element="ns0:ConvertidorMonedaResponse" location="../xsd/ConvertidorMonedaTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/ConvertidorMonedaTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConvertidorMoneda/xq/ConvertidorMonedaOut/";

declare function xf:ConvertidorMonedaOut($SOURCE_CURRENCY as xs:string,
    $TARGET_CURRENCY as xs:string,
    $SOURCE_AMOUNT as xs:decimal,
    $USD_SALES_RATE as xs:decimal,
    $USD_AMOUNT as xs:decimal,
    $USD_PURCHASE_RATE as xs:decimal,
    $TARGET_AMOUNT as xs:decimal)
    as element(ns0:ConvertidorMonedaResponse) {
        <ns0:ConvertidorMonedaResponse>
            <SOURCE_CURRENCY>{ $SOURCE_CURRENCY }</SOURCE_CURRENCY>
            <TARGET_CURRENCY>{ $TARGET_CURRENCY }</TARGET_CURRENCY>
            <SOURCE_AMOUNT>{ $SOURCE_AMOUNT }</SOURCE_AMOUNT>
            <USD_SALES_RATE_AT_SOURCE>{ $USD_SALES_RATE }</USD_SALES_RATE_AT_SOURCE>
            <USD_AMOUNT>{ $USD_AMOUNT }</USD_AMOUNT>
            <USD_PURCHASE_RATE_AT_DESTINATION>{ $USD_PURCHASE_RATE }</USD_PURCHASE_RATE_AT_DESTINATION>
            <TARGET_AMOUNT>{ $TARGET_AMOUNT }</TARGET_AMOUNT>
        </ns0:ConvertidorMonedaResponse>
};

declare variable $SOURCE_CURRENCY as xs:string external;
declare variable $TARGET_CURRENCY as xs:string external;
declare variable $SOURCE_AMOUNT as xs:decimal external;
declare variable $USD_SALES_RATE as xs:decimal external;
declare variable $USD_AMOUNT as xs:decimal external;
declare variable $USD_PURCHASE_RATE as xs:decimal external;
declare variable $TARGET_AMOUNT as xs:decimal external;

xf:ConvertidorMonedaOut($SOURCE_CURRENCY,
    $TARGET_CURRENCY,
    $SOURCE_AMOUNT,
    $USD_SALES_RATE,
    $USD_AMOUNT,
    $USD_PURCHASE_RATE,
    $TARGET_AMOUNT)
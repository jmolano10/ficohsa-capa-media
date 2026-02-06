xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:consultaMultiplesProductosRequest" location="../../../FPC/getMultipleProduct12c/xsd/GetMultipleProductTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaMultiplesProductosTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/BusinessServices/SJS/consultaMultipleProductosHN/xq/consultaMultiplesProductosIn/";

declare function xf:consultaMultiplesProductosIn($region as xs:string,
    $productType as xs:string,
    $productId as xs:string)
    as element(ns0:consultaMultiplesProductosRequest) {
        <ns0:consultaMultiplesProductosRequest>
            <PRODUCTS>
                <PRODUCT>
                    <TYPE>{ $productType }</TYPE>
                    <PRODUCT_ID>{ $productId }</PRODUCT_ID>
                    <PRODUCT_REGION>{ $region }</PRODUCT_REGION>
                </PRODUCT>
            </PRODUCTS>
        </ns0:consultaMultiplesProductosRequest>
};

declare variable $region as xs:string external;
declare variable $productType as xs:string external;
declare variable $productId as xs:string external;

xf:consultaMultiplesProductosIn($region,
    $productType,
    $productId)
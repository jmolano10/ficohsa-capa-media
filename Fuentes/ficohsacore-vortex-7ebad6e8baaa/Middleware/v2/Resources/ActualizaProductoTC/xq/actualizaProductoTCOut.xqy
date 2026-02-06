xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:actualizaProductoTCResponse" location="../xsd/actualizaProductoTCTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/actualizaProductoTCTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ActualizaProductoTC/xq/actualizaProductoTCOut/";

declare function xf:actualizaProductoTCOut($accountNumber as xs:string,
    $previusCardNumber as xs:string,
    $currentCardNumber as xs:string,
    $productType as xs:string)
    as element(ns0:actualizaProductoTCResponse) {
        <ns0:actualizaProductoTCResponse>
            <ACCOUNT_NUMBER>{ data($accountNumber) }</ACCOUNT_NUMBER>
            <PREVIUS_CARD_NUMBER>{ data($previusCardNumber) }</PREVIUS_CARD_NUMBER>
            <CURRENT_CARD_NUMBER>{ data($currentCardNumber) }</CURRENT_CARD_NUMBER>
            <PRODUCT_TYPE>{ data($productType) }</PRODUCT_TYPE>
        </ns0:actualizaProductoTCResponse>
};

declare variable $accountNumber as xs:string external;
declare variable $previusCardNumber as xs:string external;
declare variable $currentCardNumber as xs:string external;
declare variable $productType as xs:string external;

xf:actualizaProductoTCOut($accountNumber,
    $previusCardNumber,
    $currentCardNumber,
    $productType)
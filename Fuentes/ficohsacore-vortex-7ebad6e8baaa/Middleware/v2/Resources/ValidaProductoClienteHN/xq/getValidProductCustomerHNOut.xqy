xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$validaProductoClienteResponse" element="ns0:validaProductoClienteResponse" location="../../../BusinessServices/FPC/getValidProductCustomer12c/xsd/GetValidProductCustomer.xsd" ::)
(:: pragma bea:global-element-return element="ns0:validaProductoClienteResponse" location="../../ValidaProductoCliente/xsd/validaProductoClienteTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/validaProductoClienteTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ValidaProductoClienteHN/xq/getValidProductCustomerHNOut/";

declare function xf:getValidProductCustomerHNOut($validaProductoClienteResponse as element(ns0:validaProductoClienteResponse))
    as element(ns0:validaProductoClienteResponse) {
        <ns0:validaProductoClienteResponse>
            {
                for $PRODUCT_NAME in $validaProductoClienteResponse/PRODUCT_NAME
                return
                    <PRODUCT_NAME>{ data($PRODUCT_NAME) }</PRODUCT_NAME>
            }
            {
                for $CURRENCY in $validaProductoClienteResponse/CURRENCY
                return
                    <CURRENCY>{ data($CURRENCY) }</CURRENCY>
            }
            {
                for $OPENING_DATE in $validaProductoClienteResponse/OPENING_DATE
                return
                    <OPENING_DATE>{ data($OPENING_DATE) }</OPENING_DATE>
            }
        </ns0:validaProductoClienteResponse>
};

declare variable $validaProductoClienteResponse as element(ns0:validaProductoClienteResponse) external;

xf:getValidProductCustomerHNOut($validaProductoClienteResponse)
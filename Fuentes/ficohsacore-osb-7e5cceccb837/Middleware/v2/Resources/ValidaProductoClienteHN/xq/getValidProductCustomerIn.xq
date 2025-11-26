(:: pragma bea:global-element-parameter parameter="$validaProductoCliente" element="ns0:validaProductoCliente" location="../../ValidaProductoCliente/xsd/validaProductoClienteTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:validaProductoCliente" location="../../../BusinessServices/FPC/getValidProductCustomer12c/xsd/GetValidProductCustomer.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/validaProductoClienteTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ValidaProductoClienteHN/xq/getValidProductCustomerIn/";

declare function xf:getValidProductCustomerIn($validaProductoCliente as element(ns0:validaProductoCliente))
    as element(ns0:validaProductoCliente) {
        <ns0:validaProductoCliente>
            <CUSTOMER_ID>{ data($validaProductoCliente/CUSTOMER_ID) }</CUSTOMER_ID>
            <PRODUCT_NUMBER>{ data($validaProductoCliente/PRODUCT_NUMBER) }</PRODUCT_NUMBER>
            <PRODUCT_TYPE>{ data($validaProductoCliente/PRODUCT_TYPE) }</PRODUCT_TYPE>
        </ns0:validaProductoCliente>
};

declare variable $validaProductoCliente as element(ns0:validaProductoCliente) external;

xf:getValidProductCustomerIn($validaProductoCliente)

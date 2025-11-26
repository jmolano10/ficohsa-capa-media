(:: pragma bea:global-element-parameter parameter="$creaCuentaClienteIN" element="ns0:creaCuentaCliente" location="../../AperturaProductos/xsd/aperturaProductosTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:creaUsuarioSistema" location="../../AperturaProductos/xsd/aperturaProductosTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/aperturaProductosTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/CreaCuentaCliente/xq/creaUsuarioSistema/";

declare function xf:creaUsuarioSistema($creaCuentaClienteIN as element(ns0:creaCuentaCliente))
    as element(ns0:creaUsuarioSistema) {
        <ns0:creaUsuarioSistema>
            <DOCUMENT_TYPE_ID>{ data($creaCuentaClienteIN/USER_INFORMATION/DOCUMENT_TYPE_ID) }</DOCUMENT_TYPE_ID>
            <DOCUMENT_NUMBER>{ data($creaCuentaClienteIN/USER_INFORMATION/DOCUMENT_NUMBER) }</DOCUMENT_NUMBER>
            <CUSTOMER_NAMES>{ data($creaCuentaClienteIN/USER_INFORMATION/CUSTOMER_NAMES) }</CUSTOMER_NAMES>
            <CUSTOMER_LAST_NAMES>{ data($creaCuentaClienteIN/USER_INFORMATION/CUSTOMER_LAST_NAMES) }</CUSTOMER_LAST_NAMES>
            <EMAIL>{ data($creaCuentaClienteIN/USER_INFORMATION/EMAIL) }</EMAIL>
            <PHONE>{ data($creaCuentaClienteIN/USER_INFORMATION/PHONE) }</PHONE>
            <PRODUCT_TYPE_ID>{ data($creaCuentaClienteIN/USER_INFORMATION/PRODUCT_TYPE_ID) }</PRODUCT_TYPE_ID>
            <PRODUCT_NUMBER>{ data($creaCuentaClienteIN/USER_INFORMATION/PRODUCT_NUMBER) }</PRODUCT_NUMBER>
            <USER_NAME>{ data($creaCuentaClienteIN/USER_INFORMATION/USER_NAME) }</USER_NAME>
        </ns0:creaUsuarioSistema>
};

declare variable $creaCuentaClienteIN as element(ns0:creaCuentaCliente) external;

xf:creaUsuarioSistema($creaCuentaClienteIN)

(:: pragma bea:global-element-parameter parameter="$creaUsuarioSistemaIN" element="ns1:creaUsuarioSistema" location="../xsd/creaUsuarioSistemaTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:creaUsuarioSistema" location="../../AperturaProductos/xsd/aperturaProductosTypes.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/creaUsuarioSistemaTypes";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/aperturaProductosTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/CreacionUsuarioSistema/xq/CreaUsuarioSistemaIN/";

declare function xf:CreaUsuarioSistemaIN($creaUsuarioSistemaIN as element(ns1:creaUsuarioSistema))
    as element(ns0:creaUsuarioSistema) {
        <ns0:creaUsuarioSistema>
            <DOCUMENT_TYPE_ID>{ data($creaUsuarioSistemaIN/ns1:DOCUMENT_TYPE_ID) }</DOCUMENT_TYPE_ID>
            <DOCUMENT_NUMBER>{ data($creaUsuarioSistemaIN/ns1:DOCUMENT_NUMBER) }</DOCUMENT_NUMBER>
            <CUSTOMER_NAMES>{ data($creaUsuarioSistemaIN/ns1:CUSTOMER_NAMES) }</CUSTOMER_NAMES>
            <CUSTOMER_LAST_NAMES>{ data($creaUsuarioSistemaIN/ns1:CUSTOMER_LAST_NAMES) }</CUSTOMER_LAST_NAMES>
            <EMAIL>{ data($creaUsuarioSistemaIN/ns1:EMAIL) }</EMAIL>
            <PHONE>{ data($creaUsuarioSistemaIN/ns1:PHONE) }</PHONE>
            <PRODUCT_TYPE_ID>{ data($creaUsuarioSistemaIN/ns1:PRODUCT_TYPE_ID) }</PRODUCT_TYPE_ID>
            <PRODUCT_NUMBER>{ data($creaUsuarioSistemaIN/ns1:PRODUCT_NUMBER) }</PRODUCT_NUMBER>
            <USER_NAME>{ data($creaUsuarioSistemaIN/ns1:USER_NAME) }</USER_NAME>
        </ns0:creaUsuarioSistema>
};

declare variable $creaUsuarioSistemaIN as element(ns1:creaUsuarioSistema) external;

xf:CreaUsuarioSistemaIN($creaUsuarioSistemaIN)

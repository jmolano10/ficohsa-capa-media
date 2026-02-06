xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaProductoOnBase" element="ns0:consultaProductoOnBase" location="../../ConsultaProductoOnBase/xsd/consultaProductoOnBaseTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultaProductoOnBase" location="../../../BusinessServices/FPC/getProductOnbase12c/xsd/GetProductOnbaseTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaProductoOnBaseTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaProductoOnBaseHN/xq/getProductOnBaseIn/";

declare function xf:getProductOnBaseIn($consultaProductoOnBase as element(ns0:consultaProductoOnBase))
    as element(ns0:consultaProductoOnBase) {
        <ns0:consultaProductoOnBase>
            <CUSTOMER_ID>{ data($consultaProductoOnBase/CUSTOMER_ID) }</CUSTOMER_ID>
            <PRODUCT_NUMBER>{ data($consultaProductoOnBase/PRODUCT_NUMBER) }</PRODUCT_NUMBER>
            <PRODUCT_TYPE>{ data($consultaProductoOnBase/PRODUCT_TYPE) }</PRODUCT_TYPE>
        </ns0:consultaProductoOnBase>
};

declare variable $consultaProductoOnBase as element(ns0:consultaProductoOnBase) external;

xf:getProductOnBaseIn($consultaProductoOnBase)
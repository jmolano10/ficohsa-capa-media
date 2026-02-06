xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$validaProductoACH" element="ns0:validaProductoACH" location="../xsd/validaProductoACHTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaGeneralPrestamo" location="../../ConsultaGeneralPrestamo/xsd/consultaGeneralPrestamoTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/validaProductoACHTypes";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaGeneralPrestamoTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ValidaProductoACH/xq/validaPrestamoIn/";

declare function xf:validaPrestamoIn($validaProductoACH as element(ns0:validaProductoACH))
    as element(ns1:consultaGeneralPrestamo) {
        <ns1:consultaGeneralPrestamo>
            <LOAN_ID>{ data($validaProductoACH/PRODUCT_NUMBER) }</LOAN_ID>
        </ns1:consultaGeneralPrestamo>
};

declare variable $validaProductoACH as element(ns0:validaProductoACH) external;

xf:validaPrestamoIn($validaProductoACH)
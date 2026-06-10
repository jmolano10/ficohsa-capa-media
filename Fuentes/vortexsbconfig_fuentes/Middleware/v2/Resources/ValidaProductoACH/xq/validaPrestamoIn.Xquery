<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery>xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$validaProductoACH" element="ns0:validaProductoACH" location="../xsd/validaProductoACHTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaGeneralPrestamo" location="../../ConsultaGeneralPrestamo/xsd/consultaGeneralPrestamoTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/validaProductoACHTypes";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaGeneralPrestamoTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ValidaProductoACH/xq/validaPrestamoIn/";

declare function xf:validaPrestamoIn($validaProductoACH as element(ns0:validaProductoACH))
    as element(ns1:consultaGeneralPrestamo) {
        &lt;ns1:consultaGeneralPrestamo>
            &lt;LOAN_ID>{ data($validaProductoACH/PRODUCT_NUMBER) }&lt;/LOAN_ID>
        &lt;/ns1:consultaGeneralPrestamo>
};

declare variable $validaProductoACH as element(ns0:validaProductoACH) external;

xf:validaPrestamoIn($validaProductoACH)</con:xquery>
    <con:dependency location="../xsd/validaProductoACHTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/ValidaProductoACH/xsd/validaProductoACHTypes"/>
    </con:dependency>
    <con:dependency location="../../ConsultaGeneralPrestamo/xsd/consultaGeneralPrestamoTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/ConsultaGeneralPrestamo/xsd/consultaGeneralPrestamoTypes"/>
    </con:dependency>
</con:xqueryEntry>
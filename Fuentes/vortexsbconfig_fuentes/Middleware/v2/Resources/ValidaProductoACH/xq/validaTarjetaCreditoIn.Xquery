<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery>xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$validaProductoACH" element="ns0:validaProductoACH" location="../xsd/validaProductoACHTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaDatosTarjetaCredito" location="../../ConsultaDatosTarjetaCredito/xsd/consultaDatosTarjetaCreditoTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/validaProductoACHTypes";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaDatosTarjetaCreditoTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ValidaProductoACH/xq/validaTarjetaCreditoIn/";

declare function xf:validaTarjetaCreditoIn($validaProductoACH as element(ns0:validaProductoACH))
    as element(ns1:consultaDatosTarjetaCredito) {
        &lt;ns1:consultaDatosTarjetaCredito>
            &lt;CARD_NUMBER>{ data($validaProductoACH/PRODUCT_NUMBER) }&lt;/CARD_NUMBER>
        &lt;/ns1:consultaDatosTarjetaCredito>
};

declare variable $validaProductoACH as element(ns0:validaProductoACH) external;

xf:validaTarjetaCreditoIn($validaProductoACH)</con:xquery>
    <con:dependency location="../xsd/validaProductoACHTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/ValidaProductoACH/xsd/validaProductoACHTypes"/>
    </con:dependency>
    <con:dependency location="../../ConsultaDatosTarjetaCredito/xsd/consultaDatosTarjetaCreditoTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/ConsultaDatosTarjetaCredito/xsd/consultaDatosTarjetaCreditoTypes"/>
    </con:dependency>
</con:xqueryEntry>
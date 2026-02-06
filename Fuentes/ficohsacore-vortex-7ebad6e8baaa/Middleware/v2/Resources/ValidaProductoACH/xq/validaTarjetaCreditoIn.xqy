xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$validaProductoACH" element="ns0:validaProductoACH" location="../xsd/validaProductoACHTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaDatosTarjetaCredito" location="../../ConsultaDatosTarjetaCredito/xsd/consultaDatosTarjetaCreditoTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/validaProductoACHTypes";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaDatosTarjetaCreditoTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ValidaProductoACH/xq/validaTarjetaCreditoIn/";

declare function xf:validaTarjetaCreditoIn($validaProductoACH as element(ns0:validaProductoACH))
    as element(ns1:consultaDatosTarjetaCredito) {
        <ns1:consultaDatosTarjetaCredito>
            <CARD_NUMBER>{ data($validaProductoACH/PRODUCT_NUMBER) }</CARD_NUMBER>
        </ns1:consultaDatosTarjetaCredito>
};

declare variable $validaProductoACH as element(ns0:validaProductoACH) external;

xf:validaTarjetaCreditoIn($validaProductoACH)
xquery version "2004-draft" encoding "Cp1252";
(:: pragma bea:global-element-return element="ns0:ResponseHeader" location="../../../../v2/Resources/esquemas_generales/HeaderElements.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v4/Resources/PagoTarjetaCredito/xq/PagoTarjetaCreditoPrueba/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";

declare function xf:PagoTarjetaCreditoPrueba()
as element(ns0:ResponseHeader) {
    <ns0:ResponseHeader/>
};


xf:PagoTarjetaCreditoPrueba()
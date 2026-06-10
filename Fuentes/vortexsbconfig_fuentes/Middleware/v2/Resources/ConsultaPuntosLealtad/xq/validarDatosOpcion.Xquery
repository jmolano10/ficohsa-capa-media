<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery>xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:validarDatosOpcion" location="../../../BusinessServices/VASA/WSCRS/wsdl/WSCRS.wsdl" ::)

declare namespace ns0 = "http://tempuri.org/";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaPuntosLealtad/xq/validarDatosOpcion/";

declare function xf:validarDatosOpcion($cardNumber as xs:string)
    as element(ns0:validarDatosOpcion) {
        &lt;ns0:validarDatosOpcion>
            &lt;ns0:tarjeta>{ $cardNumber }&lt;/ns0:tarjeta>
        &lt;/ns0:validarDatosOpcion>
};

declare variable $cardNumber as xs:string external;

xf:validarDatosOpcion($cardNumber)</con:xquery>
    <con:dependency location="../../../BusinessServices/VASA/WSCRS/wsdl/WSCRS.wsdl">
        <con:wsdl ref="Middleware/v2/BusinessServices/VASA/WSCRS/wsdl/WSCRS"/>
    </con:dependency>
</con:xqueryEntry>
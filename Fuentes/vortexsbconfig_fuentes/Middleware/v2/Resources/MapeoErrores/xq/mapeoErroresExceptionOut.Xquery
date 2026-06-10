<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery>xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$mapeoErrores1" element="ns0:mapeoErrores" location="../wsdl/mapeoErroresProxy.wsdl" ::)
(:: pragma bea:global-element-return element="ns0:mapeoErroresResponse" location="../wsdl/mapeoErroresProxy.wsdl" ::)

declare namespace ns0 = "http://www.example.org/mapeoErroresProxy/";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/MapeoErrores/xq/mapeoErroresExceptionOut/";

declare function xf:mapeoErroresExceptionOut($mapeoErrores1 as element(ns0:mapeoErrores))
    as element(ns0:mapeoErroresResponse) {
        &lt;ns0:mapeoErroresResponse>
            &lt;MENSAJE_MAPEADO>{ data($mapeoErrores1/TEXTO_ERROR) }&lt;/MENSAJE_MAPEADO>
        &lt;/ns0:mapeoErroresResponse>
};

declare variable $mapeoErrores1 as element(ns0:mapeoErrores) external;

xf:mapeoErroresExceptionOut($mapeoErrores1)</con:xquery>
    <con:dependency location="../wsdl/mapeoErroresProxy.wsdl">
        <con:wsdl ref="Middleware/v2/Resources/MapeoErrores/wsdl/mapeoErroresProxy"/>
    </con:dependency>
</con:xqueryEntry>
<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:mapeoErrores" location="../../../BusinessServices/OSB/mapeoErrores/wsdl/MapeoErrores.WSDL" ::)

declare namespace ns0 = "http://www.example.org/mapeoErroresProxy/";
declare namespace xf = "http://tempuri.org/MWHostToHost/v1/Resources/Generales/xq/mapeoErroresUsageIn/";

declare function xf:mapeoErroresUsageIn($MENSAJE_ERROR as xs:string,
    $CODIGO_ERROR as xs:string)
    as element(ns0:mapeoErrores) {
        <ns0:mapeoErrores>
            <TEXTO_ERROR>{ $MENSAJE_ERROR }</TEXTO_ERROR>
            <CODIGO_ERROR>{ $CODIGO_ERROR }</CODIGO_ERROR>
        </ns0:mapeoErrores>
};

declare variable $MENSAJE_ERROR as xs:string external;
declare variable $CODIGO_ERROR as xs:string external;

xf:mapeoErroresUsageIn($MENSAJE_ERROR,
    $CODIGO_ERROR)]]></con:xquery>
    <con:dependency location="../../../BusinessServices/OSB/mapeoErrores/wsdl/MapeoErrores.WSDL">
        <con:wsdl ref="MWHostToHost/v1/BusinessServices/OSB/mapeoErrores/wsdl/MapeoErrores"/>
    </con:dependency>
</con:xqueryEntry>
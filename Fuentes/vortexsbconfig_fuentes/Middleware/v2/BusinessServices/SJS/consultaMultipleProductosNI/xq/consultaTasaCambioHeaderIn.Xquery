<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$sjConsultaMultipleProductosNI" element="ns0:sjConsultaMultipleProductosNI" location="../xsd/sjConsultaMultipleProductosNI.xsd" ::)
(:: pragma bea:global-element-return element="ns1:RequestHeader" location="../../../../Resources/esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/sjConsultaMultipleProductosNI";
declare namespace xf = "http://tempuri.org/Middleware/v2/BusinessServices/SJS/consultaMultipleProductosNI/xq/consultaTasaCambioHeaderIn/";

declare function xf:consultaTasaCambioHeaderIn($sjConsultaMultipleProductosNI as element(ns0:sjConsultaMultipleProductosNI))
    as element(ns1:RequestHeader) {
        <ns1:RequestHeader>
            <Authentication>
                <UserName>{ data($sjConsultaMultipleProductosNI/ns0:USERNAME) }</UserName>
                <Password>{ data($sjConsultaMultipleProductosNI/ns0:PASSWORD) }</Password>
            </Authentication>
            <Region>
                <SourceBank>NI01</SourceBank>
            </Region>
        </ns1:RequestHeader>
};

declare variable $sjConsultaMultipleProductosNI as element(ns0:sjConsultaMultipleProductosNI) external;

xf:consultaTasaCambioHeaderIn($sjConsultaMultipleProductosNI)]]></con:xquery>
    <con:dependency location="../xsd/sjConsultaMultipleProductosNI.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/SJS/consultaMultipleProductosNI/xsd/sjConsultaMultipleProductosNI"/>
    </con:dependency>
    <con:dependency location="../../../../Resources/esquemas_generales/HeaderElements.xsd">
        <con:schema ref="Middleware/v2/Resources/esquemas_generales/HeaderElements"/>
    </con:dependency>
</con:xqueryEntry>
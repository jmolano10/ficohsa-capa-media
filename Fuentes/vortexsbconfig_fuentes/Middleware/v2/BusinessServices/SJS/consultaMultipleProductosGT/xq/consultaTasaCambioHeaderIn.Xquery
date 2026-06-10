<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$sjConsultaMultipleProductosGT" element="ns0:sjConsultaMultipleProductosGT" location="../xsd/sjConsultaMultipleProductosGT.xsd" ::)
(:: pragma bea:global-element-return element="ns1:RequestHeader" location="../../../../Resources/esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/sjConsultaMultipleProductosGT";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace xf = "http://tempuri.org/Middleware/v2/BusinessServices/SJS/consultaMultipleProductosGT/xq/consultaTasaCambioHeaderIn/";

declare function xf:consultaTasaCambioHeaderIn($sjConsultaMultipleProductosGT as element(ns0:sjConsultaMultipleProductosGT))
    as element(ns1:RequestHeader) {
        <ns1:RequestHeader>
            <Authentication>
                <UserName>{ data($sjConsultaMultipleProductosGT/ns0:USERNAME) }</UserName>
                <Password>{ data($sjConsultaMultipleProductosGT/ns0:PASSWORD) }</Password>
            </Authentication>
            <Region>
                <SourceBank>GT01</SourceBank>
            </Region>
        </ns1:RequestHeader>
};

declare variable $sjConsultaMultipleProductosGT as element(ns0:sjConsultaMultipleProductosGT) external;

xf:consultaTasaCambioHeaderIn($sjConsultaMultipleProductosGT)]]></con:xquery>
    <con:dependency location="../xsd/sjConsultaMultipleProductosGT.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/SJS/consultaMultipleProductosGT/xsd/sjConsultaMultipleProductosGT"/>
    </con:dependency>
    <con:dependency location="../../../../Resources/esquemas_generales/HeaderElements.xsd">
        <con:schema ref="Middleware/v2/Resources/esquemas_generales/HeaderElements"/>
    </con:dependency>
</con:xqueryEntry>
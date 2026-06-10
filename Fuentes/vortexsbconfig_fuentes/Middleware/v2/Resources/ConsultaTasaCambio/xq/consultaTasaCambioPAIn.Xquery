<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaTasaCambio1" element="ns1:consultaTasaCambio" location="../../../../Business_Resources/Core/consultaTasaCambio/consultaTasaCambioTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/ABKPA/consultaTasaCambio/xsd/consultaTasaCambio_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaTasaCambio";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaTasaCambioTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/abanksPA/consultaTasaCambio/xq/consultaTasaCambioIn/";

declare function xf:consultaTasaCambioIn($consultaTasaCambio1 as element(ns1:consultaTasaCambio))
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:FROM_CURRENCY>{ data($consultaTasaCambio1/SOURCE_CURRENCY) }</ns0:FROM_CURRENCY>
            <ns0:TO_CURRENCY>{ data($consultaTasaCambio1/TARGET_CURRENCY) }</ns0:TO_CURRENCY>
        </ns0:InputParameters>
};

declare variable $consultaTasaCambio1 as element(ns1:consultaTasaCambio) external;

xf:consultaTasaCambioIn($consultaTasaCambio1)]]></con:xquery>
    <con:dependency location="../../../../Business_Resources/Core/consultaTasaCambio/consultaTasaCambioTypes.xsd">
        <con:schema ref="Middleware/Business_Resources/Core/consultaTasaCambio/consultaTasaCambioTypes"/>
    </con:dependency>
    <con:dependency location="../../../BusinessServices/ABKPA/consultaTasaCambio/xsd/consultaTasaCambio_sp.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/ABKPA/consultaTasaCambio/xsd/consultaTasaCambio_sp"/>
    </con:dependency>
</con:xqueryEntry>
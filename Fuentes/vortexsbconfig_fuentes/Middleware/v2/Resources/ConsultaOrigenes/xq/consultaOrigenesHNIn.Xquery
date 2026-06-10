<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaOrigenes" element="ns1:consultaOrigenes" location="../../CatalogosInfoCliente/xsd/catalogosInfoClienteTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/CatalogosInfoCliente/consultaOrigenes/xsd/consultaOrigenes_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaOrigenes";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/catalogosInfoClienteTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaOrigenes/xq/ConsultaOrigenesHNIn/";

declare function xf:ConsultaOrigenesHNIn($consultaOrigenes as element(ns1:consultaOrigenes))
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:P_ORIGIN_CODE>{ data($consultaOrigenes/QUERY_TYPE/ORIGIN_CODE) }</ns0:P_ORIGIN_CODE>
            <ns0:P_RETURN_SUB_ORIGIN>{ data($consultaOrigenes/QUERY_TYPE/RETURN_SUB_ORIGINS) }</ns0:P_RETURN_SUB_ORIGIN>
        </ns0:InputParameters>
};

declare variable $consultaOrigenes as element(ns1:consultaOrigenes) external;

xf:ConsultaOrigenesHNIn($consultaOrigenes)]]></con:xquery>
    <con:dependency location="../../CatalogosInfoCliente/xsd/catalogosInfoClienteTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/CatalogosInfoCliente/xsd/catalogosInfoClienteTypes"/>
    </con:dependency>
    <con:dependency location="../../../BusinessServices/CatalogosInfoCliente/consultaOrigenes/xsd/consultaOrigenes_sp.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/CatalogosInfoCliente/consultaOrigenes/xsd/consultaOrigenes_sp"/>
    </con:dependency>
</con:xqueryEntry>
<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery>xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaTiposRevisionesTasa" element="ns0:consultaTiposRevisionesTasa" location="../../CatalogosInfoPrestamo/xsd/catalogosInfoPrestamoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/CatalogosInfoPrestamo/consultaTiposRevisionesTasa/xsd/consultaTiposRevisionesTasa_sp.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/catalogosInfoPrestamoTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaTiposRevisionesTasa";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaTiposRevisionesTasa/xq/consultaTiposRevisionesTasaHNIn/";

declare function xf:consultaTiposRevisionesTasaHNIn($consultaTiposRevisionesTasa as element(ns0:consultaTiposRevisionesTasa))
    as element(ns1:InputParameters) {
        &lt;ns1:InputParameters>
            &lt;ns1:P_TYPE>{ data($consultaTiposRevisionesTasa/QUERY_TYPE/TYPE) }&lt;/ns1:P_TYPE>
        &lt;/ns1:InputParameters>
};

declare variable $consultaTiposRevisionesTasa as element(ns0:consultaTiposRevisionesTasa) external;

xf:consultaTiposRevisionesTasaHNIn($consultaTiposRevisionesTasa)</con:xquery>
    <con:dependency location="../../CatalogosInfoPrestamo/xsd/catalogosInfoPrestamoTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/CatalogosInfoPrestamo/xsd/catalogosInfoPrestamoTypes"/>
    </con:dependency>
    <con:dependency location="../../../BusinessServices/CatalogosInfoPrestamo/consultaTiposRevisionesTasa/xsd/consultaTiposRevisionesTasa_sp.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/CatalogosInfoPrestamo/consultaTiposRevisionesTasa/xsd/consultaTiposRevisionesTasa_sp"/>
    </con:dependency>
</con:xqueryEntry>
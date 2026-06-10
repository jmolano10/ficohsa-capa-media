<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery>xquery version "2004-draft" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$consultaTiposPrestamos" element="ns0:consultaTiposPrestamos" location="../../CatalogosInfoPrestamo/xsd/catalogosInfoPrestamoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/CatalogosInfoPrestamo/consultaTiposPrestamos/xsd/consultaTiposPrestamos_sp.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaTiposPrestamos/xq/consultaTiposPrestamosHNIn/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/catalogosInfoPrestamoTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaTiposPrestamos";

declare function xf:consultaTiposPrestamosHNIn($consultaTiposPrestamos as element(ns0:consultaTiposPrestamos))
    as element(ns1:InputParameters) {
        &lt;ns1:InputParameters>
            &lt;ns1:P_LOAN_TYPE_CODE>{ data($consultaTiposPrestamos/LOAN_TYPE_CODE) }&lt;/ns1:P_LOAN_TYPE_CODE>
        &lt;/ns1:InputParameters>
};

declare variable $consultaTiposPrestamos as element(ns0:consultaTiposPrestamos) external;

xf:consultaTiposPrestamosHNIn($consultaTiposPrestamos)</con:xquery>
    <con:dependency location="../../CatalogosInfoPrestamo/xsd/catalogosInfoPrestamoTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/CatalogosInfoPrestamo/xsd/catalogosInfoPrestamoTypes"/>
    </con:dependency>
    <con:dependency location="../../../BusinessServices/CatalogosInfoPrestamo/consultaTiposPrestamos/xsd/consultaTiposPrestamos_sp.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/CatalogosInfoPrestamo/consultaTiposPrestamos/xsd/consultaTiposPrestamos_sp"/>
    </con:dependency>
</con:xqueryEntry>
<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery>xquery version "2004-draft" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$consultaTargetTipoPrestamo" element="ns0:consultaTargetTipoPrestamo" location="../../ServiciosEmpresariales/xsd/serviciosEmpresarialesTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/ServiciosEmpresariales/consultaTargetTipoPrestamo/xsd/consultaTargetTipoPrestamo_sp.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaTargetTipoPrestamo/xq/consultaTargetTipoPrestamoHNIn/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/serviciosEmpresarialesTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaTargetTipoPrestamo";

declare function xf:consultaTargetTipoPrestamoHNIn($consultaTargetTipoPrestamo as element(ns0:consultaTargetTipoPrestamo))
    as element(ns1:InputParameters) {
        &lt;ns1:InputParameters>
		        &lt;P_TARGET>{ data($consultaTargetTipoPrestamo/TARGET_ID) }&lt;/P_TARGET>
        &lt;/ns1:InputParameters>
};

declare variable $consultaTargetTipoPrestamo as element(ns0:consultaTargetTipoPrestamo) external;

xf:consultaTargetTipoPrestamoHNIn($consultaTargetTipoPrestamo)</con:xquery>
    <con:dependency location="../../ServiciosEmpresariales/xsd/serviciosEmpresarialesTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/ServiciosEmpresariales/xsd/serviciosEmpresarialesTypes"/>
    </con:dependency>
    <con:dependency location="../../../BusinessServices/ServiciosEmpresariales/consultaTargetTipoPrestamo/xsd/consultaTargetTipoPrestamo_sp.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/ServiciosEmpresariales/consultaTargetTipoPrestamo/xsd/consultaTargetTipoPrestamo_sp"/>
    </con:dependency>
</con:xqueryEntry>
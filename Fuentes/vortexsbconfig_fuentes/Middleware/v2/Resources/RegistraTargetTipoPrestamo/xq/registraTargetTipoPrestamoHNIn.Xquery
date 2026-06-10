<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$registraTargetTipoPrestamo" element="ns0:registraTargetTipoPrestamo" location="../../ServiciosEmpresariales/xsd/serviciosEmpresarialesTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/ServiciosEmpresariales/registraTargetTipoPrestamo/xsd/registraTargetTipoPrestamo_sp.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/serviciosEmpresarialesTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/registraTargetTipoPrestamo";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/RegistraTargetTipoPrestamo/xq/registraTargetTipoPrestamoHNIn/";

declare function xf:registraTargetTipoPrestamoHNIn($registraTargetTipoPrestamo as element(ns0:registraTargetTipoPrestamo))
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:P_TARGET_ID>{ data($registraTargetTipoPrestamo/TARGET_ID) }</ns1:P_TARGET_ID>
            <ns1:P_TARGET_DESC>{ data($registraTargetTipoPrestamo/TARGET_DESCRIPTION) }</ns1:P_TARGET_DESC>
            <ns1:P_LOAN_TYPE_ID>{ data($registraTargetTipoPrestamo/LOAN_TYPE_ID) }</ns1:P_LOAN_TYPE_ID>
        </ns1:InputParameters>
};

declare variable $registraTargetTipoPrestamo as element(ns0:registraTargetTipoPrestamo) external;

xf:registraTargetTipoPrestamoHNIn($registraTargetTipoPrestamo)]]></con:xquery>
    <con:dependency location="../../ServiciosEmpresariales/xsd/serviciosEmpresarialesTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/ServiciosEmpresariales/xsd/serviciosEmpresarialesTypes"/>
    </con:dependency>
    <con:dependency location="../../../BusinessServices/ServiciosEmpresariales/registraTargetTipoPrestamo/xsd/registraTargetTipoPrestamo_sp.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/ServiciosEmpresariales/registraTargetTipoPrestamo/xsd/registraTargetTipoPrestamo_sp"/>
    </con:dependency>
</con:xqueryEntry>
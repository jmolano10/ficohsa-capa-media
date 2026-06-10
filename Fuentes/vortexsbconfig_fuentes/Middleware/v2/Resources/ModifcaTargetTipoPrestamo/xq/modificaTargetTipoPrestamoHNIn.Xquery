<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$modificaTargetTipoPrestamo" element="ns0:modificaTargetTipoPrestamo" location="../../ServiciosEmpresariales/xsd/serviciosEmpresarialesTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/ServiciosEmpresariales/modificaTargetTipoPrestamo/xsd/modificaTargetTipoPrestamo_sp.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/serviciosEmpresarialesTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/modificaTargetTipoPrestamo";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ModifcaTargetTipoPrestamo/xq/modificaTargetTipoPrestamoHNIn/";

declare function xf:modificaTargetTipoPrestamoHNIn($modificaTargetTipoPrestamo as element(ns0:modificaTargetTipoPrestamo))
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
        	<ns1:P_TARGET_ID>{ data($modificaTargetTipoPrestamo/TARGET_ID) }</ns1:P_TARGET_ID>
            <ns1:P_TARGET_DESC>{ data($modificaTargetTipoPrestamo/TARGET_DESCRIPTION) }</ns1:P_TARGET_DESC>
            <ns1:P_LOAN_TYPE_ID>{ data($modificaTargetTipoPrestamo/LOAN_TYPE_ID) }</ns1:P_LOAN_TYPE_ID>
            <ns1:P_REQUEST_USER>{ data($modificaTargetTipoPrestamo/REQUEST_USER) }</ns1:P_REQUEST_USER>
            <ns1:P_ACTION>{ data($modificaTargetTipoPrestamo/ACTION) }</ns1:P_ACTION>
        </ns1:InputParameters>
};

declare variable $modificaTargetTipoPrestamo as element(ns0:modificaTargetTipoPrestamo) external;

xf:modificaTargetTipoPrestamoHNIn($modificaTargetTipoPrestamo)]]></con:xquery>
    <con:dependency location="../../ServiciosEmpresariales/xsd/serviciosEmpresarialesTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/ServiciosEmpresariales/xsd/serviciosEmpresarialesTypes"/>
    </con:dependency>
    <con:dependency location="../../../BusinessServices/ServiciosEmpresariales/modificaTargetTipoPrestamo/xsd/modificaTargetTipoPrestamo_sp.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/ServiciosEmpresariales/modificaTargetTipoPrestamo/xsd/modificaTargetTipoPrestamo_sp"/>
    </con:dependency>
</con:xqueryEntry>
<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery>xquery version "2004-draft" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$consultaTiposImpuestosRequestIN" element="ns1:consultaTiposImpuestosRequest" location="../../TributosDEI/xsd/tributosTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/DEI/consultaTiposImpuestos/xsd/consultaTiposImpuestos_sp.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaTiposImpuestos/xq/consultaTipoImpuestoIN/";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/tributosTypes";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaTiposImpuestos";

declare function xf:consultaTipoImpuestoIN($consultaTiposImpuestosRequestIN as element(ns1:consultaTiposImpuestosRequest))
    as element(ns0:InputParameters) {
        &lt;ns0:InputParameters>
         &lt;ns0:PN_CODIGO>{ data($consultaTiposImpuestosRequestIN/TAX_ID) }&lt;/ns0:PN_CODIGO>
        &lt;/ns0:InputParameters>
};

declare variable $consultaTiposImpuestosRequestIN as element(ns1:consultaTiposImpuestosRequest) external;

xf:consultaTipoImpuestoIN($consultaTiposImpuestosRequestIN)</con:xquery>
    <con:dependency location="../../TributosDEI/xsd/tributosTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/TributosDEI/xsd/tributosTypes"/>
    </con:dependency>
    <con:dependency location="../../../BusinessServices/DEI/consultaTiposImpuestos/xsd/consultaTiposImpuestos_sp.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/DEI/consultaTiposImpuestos/xsd/consultaTiposImpuestos_sp"/>
    </con:dependency>
</con:xqueryEntry>
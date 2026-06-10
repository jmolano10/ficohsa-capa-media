<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery>xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaCamposRemesas" element="ns0:consultaCamposRemesas" location="../xsd/consultaCamposRemesasTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/Remesas/consultaCamposRemNoEstandar/xsd/consultaCamposRemNoEstandar_sp.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaCamposRemesasTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaCamposRemNoEstandar";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaCamposRem/xq/consultaCamposRemNoEstandarHNIn/";

declare function xf:consultaCamposRemNoEstandarHNIn($consultaCamposRemesas as element(ns0:consultaCamposRemesas))
    as element(ns1:InputParameters) {
        &lt;ns1:InputParameters>
            &lt;ns1:PV_IDCONVENIOT24>{ data($consultaCamposRemesas/REMITTER_ID) }&lt;/ns1:PV_IDCONVENIOT24>
        &lt;/ns1:InputParameters>
};

declare variable $consultaCamposRemesas as element(ns0:consultaCamposRemesas) external;

xf:consultaCamposRemNoEstandarHNIn($consultaCamposRemesas)</con:xquery>
    <con:dependency location="../xsd/consultaCamposRemesasTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/ConsultaCamposRemesas/xsd/consultaCamposRemesasTypes"/>
    </con:dependency>
    <con:dependency location="../../../BusinessServices/Remesas/consultaCamposRemNoEstandar/xsd/consultaCamposRemNoEstandar_sp.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/Remesas/consultaCamposRemNoEstandar/xsd/consultaCamposRemNoEstandar_sp"/>
    </con:dependency>
</con:xqueryEntry>
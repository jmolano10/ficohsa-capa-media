<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery>xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$validacionCuentaExterna" element="ns0:validacionCuentaExterna" location="../xsd/validacionCuentaExternaTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/ABKGT/consultaSwiftFinanciera/xsd/consultaSwiftFinanciera_sp.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/validacionCuentaExternaTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaSwiftFinanciera";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ValidacionCuentaExterna/xq/consultaCodSwiftIn/";

declare function xf:consultaCodSwiftIn($validacionCuentaExterna as element(ns0:validacionCuentaExterna))
    as element(ns1:InputParameters) {
        &lt;ns1:InputParameters>
            &lt;ns1:PN_CODIGO_FINANCIERA>{ data($validacionCuentaExterna/BANK_DETAILS/BANK/BANK_CODE) }&lt;/ns1:PN_CODIGO_FINANCIERA>
        &lt;/ns1:InputParameters>
};

declare variable $validacionCuentaExterna as element(ns0:validacionCuentaExterna) external;

xf:consultaCodSwiftIn($validacionCuentaExterna)</con:xquery>
    <con:dependency location="../xsd/validacionCuentaExternaTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/ValidacionCuentaExterna/xsd/validacionCuentaExternaTypes"/>
    </con:dependency>
    <con:dependency location="../../../BusinessServices/ABKGT/consultaSwiftFinanciera/xsd/consultaSwiftFinanciera_sp.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/ABKGT/consultaSwiftFinanciera/xsd/consultaSwiftFinanciera_sp"/>
    </con:dependency>
</con:xqueryEntry>
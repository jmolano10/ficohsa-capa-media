<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery>xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/MDW/consultaCredencialesSalesforce/xsd/consultaCredencialesSalesforce_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaCredencialesSalesforce";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/CancelarFinanciamiento/xq/consultaCredencialesSalesforceIn/";

declare function xf:consultaCredencialesSalesforceIn($codigoPais as xs:string)
    as element(ns0:InputParameters) {
        &lt;ns0:InputParameters>
            &lt;ns0:PV_CODIGOPAIS>{ $codigoPais }&lt;/ns0:PV_CODIGOPAIS>
        &lt;/ns0:InputParameters>
};

declare variable $codigoPais as xs:string external;

xf:consultaCredencialesSalesforceIn($codigoPais)</con:xquery>
    <con:dependency location="../../../BusinessServices/MDW/consultaCredencialesSalesforce/xsd/consultaCredencialesSalesforce_sp.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/MDW/consultaCredencialesSalesforce/xsd/consultaCredencialesSalesforce_sp"/>
    </con:dependency>
</con:xqueryEntry>
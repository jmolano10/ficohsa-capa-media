<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery>xquery version "2004-draft";
(:: pragma bea:schema-type-parameter parameter="$group" type="ns1:GROUP" location="../../../../Resources/ConsultaSituacionFinanciera/xsd/sjConsultaSituacionFinancieraInterno.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../VASA/consultaSituacionFinanciera/xsd/consultaSituacionFinanciera_sp.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/BusinessServices/SJS/consultaSituacionFinancieraInternoGT/xq/jConsultaSituacionFinancieraVasaIn/";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaSituacionFinanciera";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/sjConsultaSituacionFinancieraInterno";

declare function xf:jConsultaSituacionFinancieraVasaIn($group as element())
    as element(ns0:InputParameters) {
        &lt;ns0:InputParameters>    
			&lt;ns0:XML_CLIENTES>{ fn-bea:serialize($group/CUSTOMERS) }&lt;/ns0:XML_CLIENTES>
        &lt;/ns0:InputParameters>
};

declare variable $group as element() external;

xf:jConsultaSituacionFinancieraVasaIn($group)</con:xquery>
    <con:dependency location="../../../../Resources/ConsultaSituacionFinanciera/xsd/sjConsultaSituacionFinancieraInterno.xsd">
        <con:schema ref="Middleware/v2/Resources/ConsultaSituacionFinanciera/xsd/sjConsultaSituacionFinancieraInterno"/>
    </con:dependency>
    <con:dependency location="../../../VASA/consultaSituacionFinanciera/xsd/consultaSituacionFinanciera_sp.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/VASA/consultaSituacionFinanciera/xsd/consultaSituacionFinanciera_sp"/>
    </con:dependency>
</con:xqueryEntry>
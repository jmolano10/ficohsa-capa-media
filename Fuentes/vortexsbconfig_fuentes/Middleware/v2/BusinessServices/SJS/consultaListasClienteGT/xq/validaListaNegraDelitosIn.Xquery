<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery>xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../Precredit/validaListaNegraDelitos/xsd/validaListaNegraDelitos_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/validaListaNegraDelitos";
declare namespace xf = "http://tempuri.org/Middleware/v2/BusinessServices/SJS/consultaListasClienteGT/xq/validaListaNegraDelitosIn/";

declare function xf:validaListaNegraDelitosIn($legalId as xs:string)
    as element(ns0:InputParameters) {
        &lt;ns0:InputParameters>
            &lt;ns0:IDENTIDAD>{ $legalId }&lt;/ns0:IDENTIDAD>
        &lt;/ns0:InputParameters>
};

declare variable $legalId as xs:string external;

xf:validaListaNegraDelitosIn($legalId)</con:xquery>
    <con:dependency location="../../../Precredit/validaListaNegraDelitos/xsd/validaListaNegraDelitos_sp.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/Precredit/validaListaNegraDelitos/xsd/validaListaNegraDelitos_sp"/>
    </con:dependency>
</con:xqueryEntry>
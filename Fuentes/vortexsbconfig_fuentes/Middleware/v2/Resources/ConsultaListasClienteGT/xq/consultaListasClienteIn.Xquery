<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery>xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:sjConsultaListasClienteRequest" location="../../../BusinessServices/SJS/consultaListasClienteGT/xsd/sjConsultaListasClienteGT.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/sjConsultaListasCliente";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaListasClienteGT/xq/consultaListasClienteIn/";

declare function xf:consultaListasClienteIn($legalId as xs:string)
    as element(ns0:sjConsultaListasClienteRequest) {
        &lt;ns0:sjConsultaListasClienteRequest>
            &lt;ns0:CUSTOMER_LEGAL_ID>{ $legalId }&lt;/ns0:CUSTOMER_LEGAL_ID>
        &lt;/ns0:sjConsultaListasClienteRequest>
};

declare variable $legalId as xs:string external;

xf:consultaListasClienteIn($legalId)</con:xquery>
    <con:dependency location="../../../BusinessServices/SJS/consultaListasClienteGT/xsd/sjConsultaListasClienteGT.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/SJS/consultaListasClienteGT/xsd/sjConsultaListasClienteGT"/>
    </con:dependency>
</con:xqueryEntry>
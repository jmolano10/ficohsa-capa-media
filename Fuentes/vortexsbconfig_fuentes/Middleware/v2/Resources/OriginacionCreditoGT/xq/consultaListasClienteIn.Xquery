<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery>xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:consultaListasCliente" location="../../ConsultaListasCliente/xsd/consultaListasClienteTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaListasClienteTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/OriginacionCreditoGT/xq/consultaListasClienteIn/";

declare function xf:consultaListasClienteIn($legalId as xs:string)
    as element(ns0:consultaListasCliente) {
        &lt;ns0:consultaListasCliente>
            &lt;CUSTOMER_LEGAL_ID>{ $legalId }&lt;/CUSTOMER_LEGAL_ID>
        &lt;/ns0:consultaListasCliente>
};

declare variable $legalId as xs:string external;

xf:consultaListasClienteIn($legalId)</con:xquery>
    <con:dependency location="../../ConsultaListasCliente/xsd/consultaListasClienteTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/ConsultaListasCliente/xsd/consultaListasClienteTypes"/>
    </con:dependency>
</con:xqueryEntry>
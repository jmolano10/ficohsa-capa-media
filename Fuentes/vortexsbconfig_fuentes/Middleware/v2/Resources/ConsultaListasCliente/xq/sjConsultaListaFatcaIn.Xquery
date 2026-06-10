<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery>xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$sjConsultaListasClienteRequest1" element="ns0:sjConsultaListasClienteRequest" location="../xsd/sjConsultaListasCliente.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/consultarListaFatca/xsd/consultarListaFatca_sp.xsd" ::)

declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultarListaFatca";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/sjConsultaListasCliente";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaListasCliente/xq/sjConsultaListaFatcaIn/";

declare function xf:sjConsultaListaFatcaIn($sjConsultaListasClienteRequest1 as element(ns0:sjConsultaListasClienteRequest))
    as element(ns1:InputParameters) {
        &lt;ns1:InputParameters>
            &lt;ns1:PV_NUMERO_IDENTIFICACION>{ data($sjConsultaListasClienteRequest1/ns0:CUSTOMER_LEGAL_ID) }&lt;/ns1:PV_NUMERO_IDENTIFICACION>
        &lt;/ns1:InputParameters>
};

declare variable $sjConsultaListasClienteRequest1 as element(ns0:sjConsultaListasClienteRequest) external;

xf:sjConsultaListaFatcaIn($sjConsultaListasClienteRequest1)</con:xquery>
    <con:dependency location="../xsd/sjConsultaListasCliente.xsd">
        <con:schema ref="Middleware/v2/Resources/ConsultaListasCliente/xsd/sjConsultaListasCliente"/>
    </con:dependency>
    <con:dependency location="../../../BusinessServices/consultarListaFatca/xsd/consultarListaFatca_sp.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/consultarListaFatca/xsd/consultarListaFatca_sp"/>
    </con:dependency>
</con:xqueryEntry>
<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery>xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$sjConsultaListasClienteRequest1" element="ns1:sjConsultaListasClienteRequest" location="../xsd/sjConsultaListasCliente.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/ConsultaClientesPartesRelacionadas/xsd/consultaClientesPartesRelacionadas_sp.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/sjConsultaListasCliente";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaClientesPartesRelacionadas";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaListasCliente/xq/sjConsultaPartesRelacionadasIn/";

declare function xf:sjConsultaListaPEPIn($sjConsultaListasClienteRequest1 as element(ns1:sjConsultaListasClienteRequest))
    as element(ns0:InputParameters) {
        &lt;ns0:InputParameters>
            &lt;ns0:PV_INDETIDAD>{ data($sjConsultaListasClienteRequest1/ns1:CUSTOMER_LEGAL_ID) }&lt;/ns0:PV_INDETIDAD>
        &lt;/ns0:InputParameters>
};

declare variable $sjConsultaListasClienteRequest1 as element(ns1:sjConsultaListasClienteRequest) external;

xf:sjConsultaListaPEPIn($sjConsultaListasClienteRequest1)</con:xquery>
    <con:dependency location="../xsd/sjConsultaListasCliente.xsd">
        <con:schema ref="Middleware/v2/Resources/ConsultaListasCliente/xsd/sjConsultaListasCliente"/>
    </con:dependency>
    <con:dependency location="../../../BusinessServices/ConsultaClientesPartesRelacionadas/xsd/consultaClientesPartesRelacionadas_sp.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/ConsultaClientesPartesRelacionadas/xsd/consultaClientesPartesRelacionadas_sp"/>
    </con:dependency>
</con:xqueryEntry>
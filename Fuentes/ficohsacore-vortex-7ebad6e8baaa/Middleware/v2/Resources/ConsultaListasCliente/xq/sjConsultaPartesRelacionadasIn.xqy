xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$sjConsultaListasClienteRequest1" element="ns1:sjConsultaListasClienteRequest" location="../xsd/sjConsultaListasCliente.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/ConsultaClientesPartesRelacionadas/xsd/consultaClientesPartesRelacionadas_sp.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/sjConsultaListasCliente";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaClientesPartesRelacionadas";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaListasCliente/xq/sjConsultaPartesRelacionadasIn/";

declare function xf:sjConsultaListaPEPIn($sjConsultaListasClienteRequest1 as element(ns1:sjConsultaListasClienteRequest))
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:PV_INDETIDAD>{ data($sjConsultaListasClienteRequest1/ns1:CUSTOMER_LEGAL_ID) }</ns0:PV_INDETIDAD>
        </ns0:InputParameters>
};

declare variable $sjConsultaListasClienteRequest1 as element(ns1:sjConsultaListasClienteRequest) external;

xf:sjConsultaListaPEPIn($sjConsultaListasClienteRequest1)
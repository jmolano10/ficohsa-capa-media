(:: pragma bea:global-element-parameter parameter="$sjConsultaListasClienteRequest1" element="ns0:sjConsultaListasClienteRequest" location="../xsd/sjConsultaListasCliente.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/consultarListaFatca/xsd/consultarListaFatca_sp.xsd" ::)

declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultarListaFatca";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/sjConsultaListasCliente";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaListasCliente/xq/sjConsultaListaFatcaIn/";

declare function xf:sjConsultaListaFatcaIn($sjConsultaListasClienteRequest1 as element(ns0:sjConsultaListasClienteRequest))
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:PV_NUMERO_IDENTIFICACION>{ data($sjConsultaListasClienteRequest1/ns0:CUSTOMER_LEGAL_ID) }</ns1:PV_NUMERO_IDENTIFICACION>
        </ns1:InputParameters>
};

declare variable $sjConsultaListasClienteRequest1 as element(ns0:sjConsultaListasClienteRequest) external;

xf:sjConsultaListaFatcaIn($sjConsultaListasClienteRequest1)
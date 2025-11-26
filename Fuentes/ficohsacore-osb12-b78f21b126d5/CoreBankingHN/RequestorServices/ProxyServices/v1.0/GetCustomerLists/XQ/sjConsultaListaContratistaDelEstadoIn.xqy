xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://www.ficohsa.com.hn/middleware.services/getCustomerListsHN_SJ";
(:: import schema at "../XSD/GetCustomerListsHN_SJ.xsd" ::)
declare namespace ns2="http://www.ficohsa.com.hn/middleware.services/sjConsultaListasContratistaDelEstado";
(:: import schema at "../../../../../ProviderServices/XSD/ConsultaListaContratistaDelEstado/ConsultaListaContratistaDelEstado_PS.xsd" ::)

declare variable $getCustomerListsHN_SJRequest as element() (:: schema-element(ns1:getCustomerListsHN_SJRequest) ::) external;

declare function local:func($getCustomerListsHN_SJRequest as element() (:: schema-element(ns1:getCustomerListsHN_SJRequest) ::)) as element() (:: schema-element(ns2:sjConsultaListasContratistaDelEstadoRequest) ::) {
    <ns2:sjConsultaListasClienteRequest>
        <ns2:USERNAME>{fn:data($getCustomerListsHN_SJRequest/ns1:USERNAME)}</ns2:USERNAME>
        <ns2:PASSWORD>{fn:data($getCustomerListsHN_SJRequest/ns1:PASSWORD)}</ns2:PASSWORD>
        <ns2:CUSTOMER_LEGAL_ID>{fn:data($getCustomerListsHN_SJRequest/ns1:CUSTOMER_LEGAL_ID)}</ns2:CUSTOMER_LEGAL_ID>
    </ns2:sjConsultaListasClienteRequest>
};

local:func($getCustomerListsHN_SJRequest)
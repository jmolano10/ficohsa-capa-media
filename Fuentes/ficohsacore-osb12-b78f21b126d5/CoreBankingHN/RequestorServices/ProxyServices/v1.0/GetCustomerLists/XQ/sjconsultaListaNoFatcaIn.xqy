xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="http://www.ficohsa.com.hn/middleware.services/getCustomerListsHN_SJ";
(:: import schema at "../XSD/GetCustomerListsHN_SJ.xsd" ::)
declare namespace ns3="http://www.ficohsa.com.hn/middleware.services/sjConsultaListasCliente";
(:: import schema at "../../../../../ProviderServices/XSD/ConsultaListaNoFATCA/ConsultaClienteNoFatca_PS.xsd" ::)

declare namespace ns1="http://www.ficohsa.com/midleware.services/sjConsultaListaNoFatcaIn";

declare variable $getCustomerListsHN_SJRequest as element() (:: schema-element(ns2:getCustomerListsHN_SJRequest) ::) external;

declare function ns1:sjConsultaListaNoFatcaIn($getCustomerListsHN_SJRequest as element() (:: schema-element(ns2:getCustomerListsHN_SJRequest) ::)) as element() (:: schema-element(ns3:sjConsultaListasClienteRequest) ::) {
    <ns3:sjConsultaListasClienteRequest>
        <ns3:USERNAME>{fn:data($getCustomerListsHN_SJRequest/ns2:USERNAME)}</ns3:USERNAME>
        <ns3:PASSWORD>{fn:data($getCustomerListsHN_SJRequest/ns2:PASSWORD)}</ns3:PASSWORD>
        <ns3:CUSTOMER_LEGAL_ID>{fn:data($getCustomerListsHN_SJRequest/ns2:CUSTOMER_LEGAL_ID)}</ns3:CUSTOMER_LEGAL_ID>
    </ns3:sjConsultaListasClienteRequest>
};

ns1:sjConsultaListaNoFatcaIn($getCustomerListsHN_SJRequest)
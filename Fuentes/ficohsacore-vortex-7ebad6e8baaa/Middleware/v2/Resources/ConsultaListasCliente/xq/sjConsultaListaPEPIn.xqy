xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$sjConsultaListasClienteRequest1" element="ns1:sjConsultaListasClienteRequest" location="../xsd/sjConsultaListasCliente.xsd" ::)
(:: pragma bea:global-element-return element="ns0:ConsultadelistaPEP" location="../../../../Business_Resources/consultasCliente/Resources/XMLSchema_1144838292.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/sjConsultaListasCliente";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaListasCliente/xq/sjConsultaListaPEPIn/";

declare function xf:sjConsultaListaPEPIn($sjConsultaListasClienteRequest1 as element(ns1:sjConsultaListasClienteRequest))
    as element(ns0:ConsultadelistaPEP) {
        <ns0:ConsultadelistaPEP>
            <WebRequestCommon>
                <userName>{ data($sjConsultaListasClienteRequest1/ns1:USERNAME) }</userName>
                <password>{ data($sjConsultaListasClienteRequest1/ns1:PASSWORD) }</password>
            </WebRequestCommon>
            <WSFICOPEPDETType>
                <enquiryInputCollection>
                    <columnName>DOCUMENT.NUMBER</columnName>
                    <criteriaValue>{ data($sjConsultaListasClienteRequest1/ns1:CUSTOMER_LEGAL_ID) }</criteriaValue>
                    <operand>EQ</operand>
                </enquiryInputCollection>
            </WSFICOPEPDETType>
        </ns0:ConsultadelistaPEP>
};

declare variable $sjConsultaListasClienteRequest1 as element(ns1:sjConsultaListasClienteRequest) external;

xf:sjConsultaListaPEPIn($sjConsultaListasClienteRequest1)
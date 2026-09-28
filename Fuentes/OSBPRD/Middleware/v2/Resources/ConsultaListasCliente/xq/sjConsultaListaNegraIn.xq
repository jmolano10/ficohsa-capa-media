(:: pragma bea:global-element-parameter parameter="$sjConsultaListasClienteRequest1" element="ns1:sjConsultaListasClienteRequest" location="../xsd/sjConsultaListasCliente.xsd" ::)
(:: pragma bea:global-element-return element="ns0:Consultadelistanegra" location="../../../../Business_Resources/consultasCliente/Resources/XMLSchema_1144838292.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/sjConsultaListasCliente";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaListasCliente/xq/sjConsultaListaNegraIn/";

declare function xf:sjConsultaListaNegraIn($sjConsultaListasClienteRequest1 as element(ns1:sjConsultaListasClienteRequest))
    as element(ns0:Consultadelistanegra) {
        <ns0:Consultadelistanegra>
            <WebRequestCommon>
                <userName>{ data($sjConsultaListasClienteRequest1/ns1:USERNAME) }</userName>
                <password>{ data($sjConsultaListasClienteRequest1/ns1:PASSWORD) }</password>
            </WebRequestCommon>
            <WSFICOBLACKLISTDETType>
                <enquiryInputCollection>
                    <columnName>DOC.NUMBER</columnName>
                    <criteriaValue>{ data($sjConsultaListasClienteRequest1/ns1:CUSTOMER_LEGAL_ID) }</criteriaValue>
                    <operand>EQ</operand>
                </enquiryInputCollection>
            </WSFICOBLACKLISTDETType>
        </ns0:Consultadelistanegra>
};

declare variable $sjConsultaListasClienteRequest1 as element(ns1:sjConsultaListasClienteRequest) external;

xf:sjConsultaListaNegraIn($sjConsultaListasClienteRequest1)
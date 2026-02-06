xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$sjConsultaListasClienteRequest1" element="ns1:sjConsultaListasClienteRequest" location="../xsd/sjConsultaListasCliente.xsd" ::)
(:: pragma bea:global-element-return element="ns0:ConsultaListaGris" location="../../../../Business_Resources/consultasCliente/Resources/XMLSchema_1144838292.xsd" ::)

declare namespace ns0 = "T24WebServicesImpl";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/sjConsultaListasCliente";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaListasCliente/xq/sjConsultaListaGrisIn/";

declare function xf:sjConsultaListaGrisIn($sjConsultaListasClienteRequest1 as element(ns1:sjConsultaListasClienteRequest))
    as element(ns0:ConsultaListaGris) {
        <ns0:ConsultaListaGris>
            <WebRequestCommon>
                <userName>{ data($sjConsultaListasClienteRequest1/ns1:USERNAME) }</userName>
                <password>{ data($sjConsultaListasClienteRequest1/ns1:PASSWORD) }</password>
            </WebRequestCommon>
            <WSFICOBUSCARGRAYLISTType>
                <enquiryInputCollection>
                	<columnName>IDENT.NUMBER</columnName>
                    <criteriaValue>{ data($sjConsultaListasClienteRequest1/ns1:CUSTOMER_LEGAL_ID) }</criteriaValue>
                    <operand>EQ</operand>
                </enquiryInputCollection>
            </WSFICOBUSCARGRAYLISTType>
        </ns0:ConsultaListaGris>
};

declare variable $sjConsultaListasClienteRequest1 as element(ns1:sjConsultaListasClienteRequest) external;

xf:sjConsultaListaGrisIn($sjConsultaListasClienteRequest1)
xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$sjConsultaListasClienteRequest1" element="ns1:sjConsultaListasClienteRequest" location="../../ConsultaListasCliente/xsd/sjConsultaListasCliente.xsd" ::)
(:: pragma bea:global-element-return element="ns0:ConsultadeclientesnoFATCA" location="../../../BusinessServices/T24/consultaClientesNoFATCA/xsd/XMLSchema_-531907416.xsd" ::)

declare namespace ns0 = "T24WebServicesImpl";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/sjConsultaListasCliente";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ListaClientesNoFATCA/xq/listaClientesNoFATCAIn/";

declare function xf:listaClientesNoFATCAIn($sjConsultaListasClienteRequest1 as element(ns1:sjConsultaListasClienteRequest))
    as element(ns0:ConsultadeclientesnoFATCA) {
        <ns0:ConsultadeclientesnoFATCA>
            <WebRequestCommon>
                <userName>{ data($sjConsultaListasClienteRequest1/ns1:USERNAME) }</userName>
                <password>{ data($sjConsultaListasClienteRequest1/ns1:PASSWORD) }</password>
            </WebRequestCommon>
            <WSFICONOFATCAType>
                <enquiryInputCollection>
                	<columnName>ID.NUMBER</columnName>
                    <criteriaValue>{ data($sjConsultaListasClienteRequest1/ns1:CUSTOMER_LEGAL_ID) }</criteriaValue>
                    <operand>EQ</operand>
                </enquiryInputCollection>
            </WSFICONOFATCAType>
        </ns0:ConsultadeclientesnoFATCA>
};

declare variable $sjConsultaListasClienteRequest1 as element(ns1:sjConsultaListasClienteRequest) external;

xf:listaClientesNoFATCAIn($sjConsultaListasClienteRequest1)
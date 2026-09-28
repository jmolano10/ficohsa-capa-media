(:: pragma bea:global-element-parameter parameter="$sjConsultaActivosClienteRequest1" element="ns1:sjConsultaActivosClienteRequest" location="sjConsultaActivosCliente.xsd" ::)
(:: pragma bea:global-element-return element="ns0:Consultactascorrienteporcliente" location="../Resources/XMLSchema_1144838292.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/sjConsultaActivosCliente";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/consultasCliente/consultaActivosCliente/sjConsultaCuentasCorrienteIn/";

declare function xf:sjConsultaCuentasCorrienteIn($sjConsultaActivosClienteRequest1 as element(ns1:sjConsultaActivosClienteRequest))
    as element(ns0:Consultactascorrienteporcliente) {
        <ns0:Consultactascorrienteporcliente>
            <WebRequestCommon>
                <userName>{ data($sjConsultaActivosClienteRequest1/ns1:USERNAME) }</userName>
                <password>{ data($sjConsultaActivosClienteRequest1/ns1:PASSWORD) }</password>
            </WebRequestCommon>
            <WSFICOLINKCURRENTACCTType>
                <enquiryInputCollection>
                    <columnName>CUSTOMER</columnName>
                    <criteriaValue>{ data($sjConsultaActivosClienteRequest1/ns1:CUSTOMER_ID) }</criteriaValue>
                    <operand>EQ</operand>
                </enquiryInputCollection>
            </WSFICOLINKCURRENTACCTType>
        </ns0:Consultactascorrienteporcliente>
};

declare variable $sjConsultaActivosClienteRequest1 as element(ns1:sjConsultaActivosClienteRequest) external;

xf:sjConsultaCuentasCorrienteIn($sjConsultaActivosClienteRequest1)
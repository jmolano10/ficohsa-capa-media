(:: pragma bea:global-element-parameter parameter="$sjConsultaActivosClienteRequest1" element="ns0:sjConsultaActivosClienteRequest" location="sjConsultaActivosCliente.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ConsultaCuentaCorrientexCliente" location="ConsultaCuentasCliente/xsd/services_1.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns1 = "T24WebServicesImpl";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/sjConsultaActivosCliente";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/consultasCliente/consultaActivosCliente/sjConsultaCuentasCorrienteV2In/";

declare function xf:sjConsultaCuentasCorrienteV2In($sjConsultaActivosClienteRequest1 as element(ns0:sjConsultaActivosClienteRequest))
    as element(ns1:ConsultaCuentaCorrientexCliente) {
        <ns1:ConsultaCuentaCorrientexCliente>
             <WebRequestCommon>
                <userName>{ data($sjConsultaActivosClienteRequest1/ns0:USERNAME) }</userName>
                <password>{ data($sjConsultaActivosClienteRequest1/ns0:PASSWORD) }</password>
            </WebRequestCommon>
            <WSFICOLINKCURRENTACCOUNTType>
                <enquiryInputCollection>
                    <columnName>CUSTOMER</columnName>
                    <criteriaValue>{ data($sjConsultaActivosClienteRequest1/ns0:CUSTOMER_ID) }</criteriaValue>
                    <operand>EQ</operand>
                </enquiryInputCollection>
            </WSFICOLINKCURRENTACCOUNTType>
        </ns1:ConsultaCuentaCorrientexCliente>
};

declare variable $sjConsultaActivosClienteRequest1 as element(ns0:sjConsultaActivosClienteRequest) external;

xf:sjConsultaCuentasCorrienteV2In($sjConsultaActivosClienteRequest1)
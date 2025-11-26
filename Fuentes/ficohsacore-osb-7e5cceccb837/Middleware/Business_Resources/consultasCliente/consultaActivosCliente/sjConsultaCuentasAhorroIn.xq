(:: pragma bea:global-element-parameter parameter="$sjConsultaActivosClienteRequest1" element="ns1:sjConsultaActivosClienteRequest" location="sjConsultaActivosCliente.xsd" ::)
(:: pragma bea:global-element-return element="ns0:Consultadectasahorroporcliente" location="../Resources/XMLSchema_1144838292.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/sjConsultaActivosCliente";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/consultasCliente/consultaActivosCliente/sjConsultaCuentasAhorroIn/";

declare function xf:sjConsultaCuentasAhorroIn($sjConsultaActivosClienteRequest1 as element(ns1:sjConsultaActivosClienteRequest))
    as element(ns0:Consultadectasahorroporcliente) {
        <ns0:Consultadectasahorroporcliente>
            <WebRequestCommon>
                <userName>{ data($sjConsultaActivosClienteRequest1/ns1:USERNAME) }</userName>
                <password>{ data($sjConsultaActivosClienteRequest1/ns1:PASSWORD) }</password>
            </WebRequestCommon>
            <WSFICOLINKSAVINGSACCTType>
                <enquiryInputCollection>
                    <columnName>CUSTOMER</columnName>
                    <criteriaValue>{ data($sjConsultaActivosClienteRequest1/ns1:CUSTOMER_ID) }</criteriaValue>
                    <operand>EQ</operand>
                </enquiryInputCollection>
            </WSFICOLINKSAVINGSACCTType>
        </ns0:Consultadectasahorroporcliente>
};

declare variable $sjConsultaActivosClienteRequest1 as element(ns1:sjConsultaActivosClienteRequest) external;

xf:sjConsultaCuentasAhorroIn($sjConsultaActivosClienteRequest1)
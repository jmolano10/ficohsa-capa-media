xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$sjConsultaActivosClienteRequest1" element="ns0:sjConsultaActivosClienteRequest" location="sjConsultaActivosCliente.xsd" ::)
(:: pragma bea:global-element-return element="ns1:Consultadecertifdepporcliente" location="../Resources/XMLSchema_1144838292.xsd" ::)

declare namespace ns1 = "T24WebServicesImpl";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/sjConsultaActivosCliente";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/consultasCliente/consultaActivosCliente/sjConsultaCertifDepositoIn/";

declare function xf:sjConsultaCertifDepositoIn($sjConsultaActivosClienteRequest1 as element(ns0:sjConsultaActivosClienteRequest))
    as element(ns1:Consultadecertifdepporcliente) {
        <ns1:Consultadecertifdepporcliente>
            <WebRequestCommon>
                <userName>{ data($sjConsultaActivosClienteRequest1/ns0:USERNAME) }</userName>
                <password>{ data($sjConsultaActivosClienteRequest1/ns0:PASSWORD) }</password>
            </WebRequestCommon>
            <WSFICOTERMDEPOSITType>
                <enquiryInputCollection>
                    <columnName>CUSTOMER</columnName>
                    <criteriaValue>{ data($sjConsultaActivosClienteRequest1/ns0:CUSTOMER_ID) }</criteriaValue>
                    <operand>EQ</operand>
                </enquiryInputCollection>
            </WSFICOTERMDEPOSITType>
        </ns1:Consultadecertifdepporcliente>
};

declare variable $sjConsultaActivosClienteRequest1 as element(ns0:sjConsultaActivosClienteRequest) external;

xf:sjConsultaCertifDepositoIn($sjConsultaActivosClienteRequest1)
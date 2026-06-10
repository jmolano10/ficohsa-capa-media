<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
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

xf:sjConsultaCuentasAhorroIn($sjConsultaActivosClienteRequest1)]]></con:xquery>
    <con:dependency location="sjConsultaActivosCliente.xsd">
        <con:schema ref="Middleware/Business_Resources/consultasCliente/consultaActivosCliente/sjConsultaActivosCliente"/>
    </con:dependency>
    <con:dependency location="../Resources/XMLSchema_1144838292.xsd">
        <con:schema ref="Middleware/Business_Resources/consultasCliente/Resources/XMLSchema_1144838292"/>
    </con:dependency>
</con:xqueryEntry>
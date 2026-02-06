xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$sjConsultaActivosClienteRequest" element="ns1:sjConsultaActivosClienteRequest" location="sjConsultaActivosCliente.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../v2/BusinessServices/ConsultaFondoPensiones/xsd/consultaFondoPensiones_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaFondoPensiones";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/sjConsultaActivosCliente";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/consultasCliente/consultaActivosCliente/sjConsultaFondoPensiones/";

declare function xf:sjConsultaFondoPensiones($sjConsultaActivosClienteRequest as element(ns1:sjConsultaActivosClienteRequest))
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:PV_IDENTIFICACION>{ data($sjConsultaActivosClienteRequest/ns1:LEGAL_ID) }</ns0:PV_IDENTIFICACION>
        </ns0:InputParameters>
};

declare variable $sjConsultaActivosClienteRequest as element(ns1:sjConsultaActivosClienteRequest) external;

xf:sjConsultaFondoPensiones($sjConsultaActivosClienteRequest)
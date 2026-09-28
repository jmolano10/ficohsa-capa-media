(:: pragma bea:global-element-parameter parameter="$sjConsultaPasivosClienteRequest" element="ns1:sjConsultaPasivosClienteRequest" location="../xsd/sjConsultaPasivosCliente.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../MasterDataHN/conDatosTarjetaCliente/xsd/conDatoTarjetaClienteHN_sp.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/sjConsultaPasivosCliente";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/conDatoTarjetaClienteHN";
declare namespace xf = "http://tempuri.org/Middleware/v2/BusinessServices/SJS/consultaPasivosCliente/xq/sjConsultaTCClienteIn/";

declare function xf:sjConsultaTCClienteIn($sjConsultaPasivosClienteRequest as element(ns1:sjConsultaPasivosClienteRequest))
    as element(ns0:InputParameters) {
    let $customerId := data($sjConsultaPasivosClienteRequest/ns1:CUSTOMER_ID)
    return
        <ns0:InputParameters>
            <ns0:Pais>{ data($sjConsultaPasivosClienteRequest/ns1:COUNTRY) }</ns0:Pais>
            <ns0:NumCliente>{ fn-bea:pad-left($customerId, 19, '0') }</ns0:NumCliente>
        </ns0:InputParameters>
};

declare variable $sjConsultaPasivosClienteRequest as element(ns1:sjConsultaPasivosClienteRequest) external;

xf:sjConsultaTCClienteIn($sjConsultaPasivosClienteRequest)
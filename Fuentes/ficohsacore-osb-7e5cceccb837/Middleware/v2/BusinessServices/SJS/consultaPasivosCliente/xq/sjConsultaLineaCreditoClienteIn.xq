(:: pragma bea:global-element-parameter parameter="$sjConsultaPasivosClienteRequest" element="ns0:sjConsultaPasivosClienteRequest" location="../xsd/sjConsultaPasivosCliente.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../ABK/consultaLineasCreditoCliente/xsd/consultaLineasCreditoCliente_sp.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/sjConsultaPasivosCliente";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaLineasCreditoCliente";
declare namespace xf = "http://tempuri.org/Middleware/v2/BusinessServices/SJS/consultaPasivosCliente/xq/sjConsultaLineaCreditoClienteIn/";

declare function xf:sjConsultaLineaCreditoClienteIn($sjConsultaPasivosClienteRequest as element(ns0:sjConsultaPasivosClienteRequest))
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:P_CUSTOMER_ID>{ data($sjConsultaPasivosClienteRequest/ns0:CUSTOMER_ID) }</ns1:P_CUSTOMER_ID>
        </ns1:InputParameters>
};

declare variable $sjConsultaPasivosClienteRequest as element(ns0:sjConsultaPasivosClienteRequest) external;

xf:sjConsultaLineaCreditoClienteIn($sjConsultaPasivosClienteRequest)
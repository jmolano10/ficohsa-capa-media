(:: pragma bea:global-element-parameter parameter="$consultaPasivosClienteRequest" element="ns1:consultaPasivosClienteRequest" location="../xsd/consultaPasivosClienteTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/ABK/consultaLineasCreditoCliente/xsd/consultaLineasCreditoCliente_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaLineasCreditoCliente";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaClientesTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaPasivosCliente/xq/consultaLineasCreditoClienteIn/";

declare function xf:consultaLineasCreditoClienteIn($consultaPasivosClienteRequest as element(ns1:consultaPasivosClienteRequest))
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:P_CUSTOMER_ID>{ data($consultaPasivosClienteRequest/CUSTOMER_ID) }</ns0:P_CUSTOMER_ID>
        </ns0:InputParameters>
};

declare variable $consultaPasivosClienteRequest as element(ns1:consultaPasivosClienteRequest) external;

xf:consultaLineasCreditoClienteIn($consultaPasivosClienteRequest)
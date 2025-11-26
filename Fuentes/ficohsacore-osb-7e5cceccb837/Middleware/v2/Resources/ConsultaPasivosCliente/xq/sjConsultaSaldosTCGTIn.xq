(:: pragma bea:global-element-parameter parameter="$consultaPasivosClienteRequest1" element="ns0:consultaPasivosClienteRequest" location="../../../../Business_Resources/consultasCliente/Resources/consultaClientesTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultaPasivosClienteRequest" location="../../../../Business_Resources/consultasCliente/Resources/consultaClientesTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaClientesTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/abanksGT/consultaPasivosCliente/xq/sjConsultaSaldosTCIn/";

declare function xf:sjConsultaSaldosTCIn($consultaPasivosClienteRequest1 as element(ns0:consultaPasivosClienteRequest))
    as element(ns0:consultaPasivosClienteRequest) {
        <ns0:consultaPasivosClienteRequest>
            <CUSTOMER_ID>{ data($consultaPasivosClienteRequest1/CUSTOMER_ID) }</CUSTOMER_ID>
            <LIABILITY_TYPE>{ data($consultaPasivosClienteRequest1/LIABILITY_TYPE) }</LIABILITY_TYPE>
        </ns0:consultaPasivosClienteRequest>
};

declare variable $consultaPasivosClienteRequest1 as element(ns0:consultaPasivosClienteRequest) external;

xf:sjConsultaSaldosTCIn($consultaPasivosClienteRequest1)
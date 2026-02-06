xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaPasivosClienteRequest1" element="ns1:consultaPasivosClienteRequest" location="../../../../Business_Resources/consultasCliente/Resources/consultaClientesTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/ABKPA/consultaPasivosCliente/xsd/consultaPasivosCliente_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaListaPrestamos";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaClientesTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/abanksPA/consultaPasivosCliente/xq/consultaPasivosClientePrestamosIn/";

declare function xf:consultaPasivosClientePrestamosIn($consultaPasivosClienteRequest1 as element(ns1:consultaPasivosClienteRequest))
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:CUSTOMER_ID>{ data($consultaPasivosClienteRequest1/CUSTOMER_ID) }</ns0:CUSTOMER_ID>
            <ns0:LIABILITY_TYPE>{ data($consultaPasivosClienteRequest1/LIABILITY_TYPE) }</ns0:LIABILITY_TYPE>
        </ns0:InputParameters>
};

declare variable $consultaPasivosClienteRequest1 as element(ns1:consultaPasivosClienteRequest) external;

xf:consultaPasivosClientePrestamosIn($consultaPasivosClienteRequest1)
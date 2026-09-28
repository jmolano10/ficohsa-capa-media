(:: pragma bea:global-element-parameter parameter="$consultaContratosCliente" element="ns0:consultaContratosCliente" location="../../CobranzasElectronicas/xsd/cobranzasElectronicasTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/ABK/consultaContratosCliente/xsd/consultaContratosCliente_sp.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/cobranzasElectronicasTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaContratosCliente";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaContratosCliente/xq/consultaContratosClienteIn/";

declare function xf:consultaContratosClienteIn($consultaContratosCliente as element(ns0:consultaContratosCliente))
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:PV_CODIGOCLIENTE>{ data($consultaContratosCliente/CUSTOMER_ID) }</ns1:PV_CODIGOCLIENTE>
        </ns1:InputParameters>
};

declare variable $consultaContratosCliente as element(ns0:consultaContratosCliente) external;

xf:consultaContratosClienteIn($consultaContratosCliente)
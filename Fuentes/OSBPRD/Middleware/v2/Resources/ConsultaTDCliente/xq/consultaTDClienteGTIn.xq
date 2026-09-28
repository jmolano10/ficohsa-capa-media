(:: pragma bea:global-element-parameter parameter="$consultaTDCliente1" element="ns0:consultaTDCliente" location="../../../../Business_Resources/tarjetasDebito/consultaTDCliente/consultaTDClienteTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/ABKGT/tarjetaDebitoCliente/xsd/tarjetaDebitoCliente_sp.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaTDClienteTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/tarjetaDebitoCliente";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaTDCliente/xq/consultaTDClienteGTIn/";

declare function xf:consultaTDClienteGTIn($consultaTDCliente1 as element(ns0:consultaTDCliente))
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:CUSTOMER_ID>{ data($consultaTDCliente1/CUSTOMER_ID) }</ns1:CUSTOMER_ID>
        </ns1:InputParameters>
};

declare variable $consultaTDCliente1 as element(ns0:consultaTDCliente) external;

xf:consultaTDClienteGTIn($consultaTDCliente1)
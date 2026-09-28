(:: pragma bea:global-element-parameter parameter="$consultaClienteRequest1" element="ns1:consultaClienteRequest" location="../xsd/consultaClientesTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/ABKGT/consultarTarjetaDebito/xsd/consultarTarjetaDebito_sp.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaClientesTypes";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultarTarjetaDebito";
declare namespace xf = "http://tempuri.org/Middleware/v3/Resources/ConsultaCliente/xq/consultaClienteConsTarjetaDebito/";

declare function xf:consultaClienteConsTarjetaDebito($consultaClienteRequest1 as element(ns1:consultaClienteRequest))
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:PV_NUMERO_TARJETA>{ data($consultaClienteRequest1/ns1:CUSTOMER_ID_VALUE) }</ns0:PV_NUMERO_TARJETA>
        </ns0:InputParameters>
};

declare variable $consultaClienteRequest1 as element(ns1:consultaClienteRequest) external;

xf:consultaClienteConsTarjetaDebito($consultaClienteRequest1)
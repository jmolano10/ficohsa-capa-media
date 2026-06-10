<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery>xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaPasivosClienteRequest" element="ns1:consultaPasivosClienteRequest" location="../xsd/consultaPasivosClienteTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/ABK/consultaLineasCreditoCliente/xsd/consultaLineasCreditoCliente_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaLineasCreditoCliente";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaClientesTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaPasivosCliente/xq/consultaLineasCreditoClienteIn/";

declare function xf:consultaLineasCreditoClienteIn($consultaPasivosClienteRequest as element(ns1:consultaPasivosClienteRequest))
    as element(ns0:InputParameters) {
        &lt;ns0:InputParameters>
            &lt;ns0:P_CUSTOMER_ID>{ data($consultaPasivosClienteRequest/CUSTOMER_ID) }&lt;/ns0:P_CUSTOMER_ID>
        &lt;/ns0:InputParameters>
};

declare variable $consultaPasivosClienteRequest as element(ns1:consultaPasivosClienteRequest) external;

xf:consultaLineasCreditoClienteIn($consultaPasivosClienteRequest)</con:xquery>
    <con:dependency location="../xsd/consultaPasivosClienteTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/ConsultaPasivosCliente/xsd/consultaPasivosClienteTypes"/>
    </con:dependency>
    <con:dependency location="../../../BusinessServices/ABK/consultaLineasCreditoCliente/xsd/consultaLineasCreditoCliente_sp.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/ABK/consultaLineasCreditoCliente/xsd/consultaLineasCreditoCliente_sp"/>
    </con:dependency>
</con:xqueryEntry>
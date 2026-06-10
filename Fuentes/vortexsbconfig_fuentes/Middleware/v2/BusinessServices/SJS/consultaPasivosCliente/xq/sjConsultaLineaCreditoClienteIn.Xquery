<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery>xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$sjConsultaPasivosClienteRequest" element="ns0:sjConsultaPasivosClienteRequest" location="../xsd/sjConsultaPasivosCliente.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../ABK/consultaLineasCreditoCliente/xsd/consultaLineasCreditoCliente_sp.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/sjConsultaPasivosCliente";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaLineasCreditoCliente";
declare namespace xf = "http://tempuri.org/Middleware/v2/BusinessServices/SJS/consultaPasivosCliente/xq/sjConsultaLineaCreditoClienteIn/";

declare function xf:sjConsultaLineaCreditoClienteIn($sjConsultaPasivosClienteRequest as element(ns0:sjConsultaPasivosClienteRequest))
    as element(ns1:InputParameters) {
        &lt;ns1:InputParameters>
            &lt;ns1:P_CUSTOMER_ID>{ data($sjConsultaPasivosClienteRequest/ns0:CUSTOMER_ID) }&lt;/ns1:P_CUSTOMER_ID>
        &lt;/ns1:InputParameters>
};

declare variable $sjConsultaPasivosClienteRequest as element(ns0:sjConsultaPasivosClienteRequest) external;

xf:sjConsultaLineaCreditoClienteIn($sjConsultaPasivosClienteRequest)</con:xquery>
    <con:dependency location="../xsd/sjConsultaPasivosCliente.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/SJS/consultaPasivosCliente/xsd/sjConsultaPasivosCliente"/>
    </con:dependency>
    <con:dependency location="../../../ABK/consultaLineasCreditoCliente/xsd/consultaLineasCreditoCliente_sp.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/ABK/consultaLineasCreditoCliente/xsd/consultaLineasCreditoCliente_sp"/>
    </con:dependency>
</con:xqueryEntry>
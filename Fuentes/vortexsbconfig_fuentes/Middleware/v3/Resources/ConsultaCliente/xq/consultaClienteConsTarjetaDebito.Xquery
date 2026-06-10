<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery>xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaClienteRequest1" element="ns1:consultaClienteRequest" location="../xsd/consultaClientesTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/ABKGT/consultarTarjetaDebito/xsd/consultarTarjetaDebito_sp.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaClientesTypes";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultarTarjetaDebito";
declare namespace xf = "http://tempuri.org/Middleware/v3/Resources/ConsultaCliente/xq/consultaClienteConsTarjetaDebito/";

declare function xf:consultaClienteConsTarjetaDebito($consultaClienteRequest1 as element(ns1:consultaClienteRequest))
    as element(ns0:InputParameters) {
        &lt;ns0:InputParameters>
            &lt;ns0:PV_NUMERO_TARJETA>{ data($consultaClienteRequest1/ns1:CUSTOMER_ID_VALUE) }&lt;/ns0:PV_NUMERO_TARJETA>
        &lt;/ns0:InputParameters>
};

declare variable $consultaClienteRequest1 as element(ns1:consultaClienteRequest) external;

xf:consultaClienteConsTarjetaDebito($consultaClienteRequest1)</con:xquery>
    <con:dependency location="../xsd/consultaClientesTypes.xsd">
        <con:schema ref="Middleware/v3/Resources/ConsultaCliente/xsd/consultaClientesTypes"/>
    </con:dependency>
    <con:dependency location="../../../BusinessServices/ABKGT/consultarTarjetaDebito/xsd/consultarTarjetaDebito_sp.xsd">
        <con:schema ref="Middleware/v3/BusinessServices/ABKGT/consultarTarjetaDebito/xsd/consultarTarjetaDebito_sp"/>
    </con:dependency>
</con:xqueryEntry>
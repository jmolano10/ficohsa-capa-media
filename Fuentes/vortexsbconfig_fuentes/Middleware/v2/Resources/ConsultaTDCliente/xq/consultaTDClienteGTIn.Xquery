<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery>xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaTDCliente1" element="ns0:consultaTDCliente" location="../../../../Business_Resources/tarjetasDebito/consultaTDCliente/consultaTDClienteTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/ABKGT/tarjetaDebitoCliente/xsd/tarjetaDebitoCliente_sp.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaTDClienteTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/tarjetaDebitoCliente";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaTDCliente/xq/consultaTDClienteGTIn/";

declare function xf:consultaTDClienteGTIn($consultaTDCliente1 as element(ns0:consultaTDCliente))
    as element(ns1:InputParameters) {
        &lt;ns1:InputParameters>
            &lt;ns1:CUSTOMER_ID>{ data($consultaTDCliente1/CUSTOMER_ID) }&lt;/ns1:CUSTOMER_ID>
        &lt;/ns1:InputParameters>
};

declare variable $consultaTDCliente1 as element(ns0:consultaTDCliente) external;

xf:consultaTDClienteGTIn($consultaTDCliente1)</con:xquery>
    <con:dependency location="../../../../Business_Resources/tarjetasDebito/consultaTDCliente/consultaTDClienteTypes.xsd">
        <con:schema ref="Middleware/Business_Resources/tarjetasDebito/consultaTDCliente/consultaTDClienteTypes"/>
    </con:dependency>
    <con:dependency location="../../../BusinessServices/ABKGT/tarjetaDebitoCliente/xsd/tarjetaDebitoCliente_sp.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/ABKGT/tarjetaDebitoCliente/xsd/tarjetaDebitoCliente_sp"/>
    </con:dependency>
</con:xqueryEntry>
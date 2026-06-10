<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaTarjetasCreditoPorCliente" element="ns0:consultaTarjetasCreditoPorCliente" location="../xsd/consultaTarjetasCreditoPorClienteTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaClienteRequest" location="../../../../v3/Resources/ConsultaCliente/xsd/consultaClientesTypes.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaClientesTypes";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaTarjetasCreditoPorClienteTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaTarjetasCreditoPorCliente/xq/consultaClienteHNIn/";

declare function xf:consultaClienteHNIn($consultaTarjetasCreditoPorCliente as element(ns0:consultaTarjetasCreditoPorCliente))
    as element(ns1:consultaClienteRequest) {
        <ns1:consultaClienteRequest>
            <ns1:CUSTOMER_ID_TYPE>{ data($consultaTarjetasCreditoPorCliente/CUSTOMER_FILTER/CUSTOMER_ID_TYPE) }</ns1:CUSTOMER_ID_TYPE>
            <ns1:CUSTOMER_ID_VALUE>{ data($consultaTarjetasCreditoPorCliente/CUSTOMER_FILTER/CUSTOMER_ID_VALUE) }</ns1:CUSTOMER_ID_VALUE>
        </ns1:consultaClienteRequest>
};

declare variable $consultaTarjetasCreditoPorCliente as element(ns0:consultaTarjetasCreditoPorCliente) external;

xf:consultaClienteHNIn($consultaTarjetasCreditoPorCliente)]]></con:xquery>
    <con:dependency location="../xsd/consultaTarjetasCreditoPorClienteTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/ConsultaTarjetasCreditoPorCliente/xsd/consultaTarjetasCreditoPorClienteTypes"/>
    </con:dependency>
    <con:dependency location="../../../../v3/Resources/ConsultaCliente/xsd/consultaClientesTypes.xsd">
        <con:schema ref="Middleware/v3/Resources/ConsultaCliente/xsd/consultaClientesTypes"/>
    </con:dependency>
</con:xqueryEntry>
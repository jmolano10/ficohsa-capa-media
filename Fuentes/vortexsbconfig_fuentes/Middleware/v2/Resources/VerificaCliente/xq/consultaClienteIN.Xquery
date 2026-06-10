<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$verificaClienteRequest1" element="ns1:verificaClienteRequest" location="../xsd/verificaClientesTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultaClienteRequest" location="../../../../v3/Resources/ConsultaCliente/xsd/consultaClientesTypes.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/verificaClientesTypes";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaClientesTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/VerificaCliente/xq/consultaClienteIN/";

declare function xf:consultaClienteIN($verificaClienteRequest1 as element(ns1:verificaClienteRequest))
    as element(ns0:consultaClienteRequest) {
        <ns0:consultaClienteRequest>
            <ns0:CUSTOMER_ID_TYPE>{ data($verificaClienteRequest1/ns1:CUSTOMER_ID_TYPE) }</ns0:CUSTOMER_ID_TYPE>
            <ns0:CUSTOMER_ID_VALUE>{ data($verificaClienteRequest1/ns1:CUSTOMER_ID_VALUE) }</ns0:CUSTOMER_ID_VALUE>
        </ns0:consultaClienteRequest>
};

declare variable $verificaClienteRequest1 as element(ns1:verificaClienteRequest) external;

xf:consultaClienteIN($verificaClienteRequest1)]]></con:xquery>
    <con:dependency location="../xsd/verificaClientesTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/VerificaCliente/xsd/verificaClientesTypes"/>
    </con:dependency>
    <con:dependency location="../../../../v3/Resources/ConsultaCliente/xsd/consultaClientesTypes.xsd">
        <con:schema ref="Middleware/v3/Resources/ConsultaCliente/xsd/consultaClientesTypes"/>
    </con:dependency>
</con:xqueryEntry>
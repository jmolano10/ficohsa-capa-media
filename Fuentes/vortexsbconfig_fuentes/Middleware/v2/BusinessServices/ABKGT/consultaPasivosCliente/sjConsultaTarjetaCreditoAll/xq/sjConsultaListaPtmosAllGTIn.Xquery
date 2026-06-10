<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaPasivosClienteRequest1" element="ns0:consultaPasivosClienteRequest" location="../../../../../../Business_Resources/consultasCliente/Resources/consultaClientesTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../xsd/consultaPasivosCliente_sp.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaClientesTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaPasivosCliente";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/abanksGT/consultaPasivosCliente/sjConsultaTarjetaCreditoAll/sjConsultaListaPrestamosAll/";

declare function xf:sjConsultaListaPrestamosAll($consultaPasivosClienteRequest1 as element(ns0:consultaPasivosClienteRequest))
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:CUSTOMER_ID>{ data($consultaPasivosClienteRequest1/CUSTOMER_ID) }</ns1:CUSTOMER_ID>
            <ns1:LIABILITY_TYPE>{ data($consultaPasivosClienteRequest1/LIABILITY_TYPE) }</ns1:LIABILITY_TYPE>
        </ns1:InputParameters>
};

declare variable $consultaPasivosClienteRequest1 as element(ns0:consultaPasivosClienteRequest) external;

xf:sjConsultaListaPrestamosAll($consultaPasivosClienteRequest1)]]></con:xquery>
    <con:dependency location="../../../../../../Business_Resources/consultasCliente/Resources/consultaClientesTypes.xsd">
        <con:schema ref="Middleware/Business_Resources/consultasCliente/Resources/consultaClientesTypes"/>
    </con:dependency>
    <con:dependency location="../../xsd/consultaPasivosCliente_sp.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/ABKGT/consultaPasivosCliente/xsd/consultaPasivosCliente_sp"/>
    </con:dependency>
</con:xqueryEntry>
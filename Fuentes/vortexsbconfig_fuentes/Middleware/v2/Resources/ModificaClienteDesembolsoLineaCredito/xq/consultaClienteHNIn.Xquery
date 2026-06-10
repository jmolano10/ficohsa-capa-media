<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$modificaClienteDesembolsoLineaCredito" element="ns0:modificaClienteDesembolsoLineaCredito" location="../../ServiciosEmpresariales/xsd/serviciosEmpresarialesTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaClienteRequest" location="../../../../v3/Resources/ConsultaCliente/xsd/consultaClientesTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/serviciosEmpresarialesTypes";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaClientesTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ModificaClienteDesembolsoLineaCredito/xq/consultaClienteHNIn/";

declare function xf:consultaClienteHNIn($modificaClienteDesembolsoLineaCredito as element(ns0:modificaClienteDesembolsoLineaCredito))
    as element(ns1:consultaClienteRequest) {
        <ns1:consultaClienteRequest>
            <ns1:CUSTOMER_ID_TYPE>CUSTOMER_ID</ns1:CUSTOMER_ID_TYPE>
            <ns1:CUSTOMER_ID_VALUE>{ data($modificaClienteDesembolsoLineaCredito/CUSTOMERS/CUSTOMER/GENERAL_INFO/BASIC/ID) }</ns1:CUSTOMER_ID_VALUE>
        </ns1:consultaClienteRequest>
};

declare variable $modificaClienteDesembolsoLineaCredito as element(ns0:modificaClienteDesembolsoLineaCredito) external;

xf:consultaClienteHNIn($modificaClienteDesembolsoLineaCredito)]]></con:xquery>
    <con:dependency location="../../ServiciosEmpresariales/xsd/serviciosEmpresarialesTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/ServiciosEmpresariales/xsd/serviciosEmpresarialesTypes"/>
    </con:dependency>
    <con:dependency location="../../../../v3/Resources/ConsultaCliente/xsd/consultaClientesTypes.xsd">
        <con:schema ref="Middleware/v3/Resources/ConsultaCliente/xsd/consultaClientesTypes"/>
    </con:dependency>
</con:xqueryEntry>
<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[(:: pragma bea:global-element-parameter parameter="$consultaProductosAfiliadosBatchRequest1" element="ns0:consultaProductosAfiliadosBatchRequest" location="../xsd/ConsultaProductosAfiliadosBatchTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaPasivosClienteRequest" location="../../../../v2/Resources/ConsultaPasivosCliente/xsd/consultaPasivosClienteTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/ConsultaProductosAfiliadosBatchTypes";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaClientesTypes";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/ProductosAfiliados/consultaProductosAfiliados/xq/consultaPasivosClienteIn/";

declare function xf:agsgf($consultaProductosAfiliadosBatchRequest1 as element(ns0:consultaProductosAfiliadosBatchRequest))
    as element(ns1:consultaPasivosClienteRequest) {
        <ns1:consultaPasivosClienteRequest>
            <CUSTOMER_ID>{ data($consultaProductosAfiliadosBatchRequest1/ns0:CUSTOMER_INFO/ns0:VALUE) }</CUSTOMER_ID>
            <LIABILITY_TYPE>TRC</LIABILITY_TYPE>
        </ns1:consultaPasivosClienteRequest>
};

declare variable $consultaProductosAfiliadosBatchRequest1 as element(ns0:consultaProductosAfiliadosBatchRequest) external;

xf:agsgf($consultaProductosAfiliadosBatchRequest1)]]></con:xquery>
    <con:dependency location="../xsd/ConsultaProductosAfiliadosBatchTypes.xsd">
        <con:schema ref="Middleware/Business_Resources/ProductosAfiliados/consultaProductosAfiliados/xsd/ConsultaProductosAfiliadosBatchTypes"/>
    </con:dependency>
    <con:dependency location="../../../../v2/Resources/ConsultaPasivosCliente/xsd/consultaPasivosClienteTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/ConsultaPasivosCliente/xsd/consultaPasivosClienteTypes"/>
    </con:dependency>
</con:xqueryEntry>
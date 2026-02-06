xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns2:consultaProductosAfiliadosResponse" location="../xsd/ConsultaProductosAfiliadosTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaClienteRequest" location="../../../../v3/Resources/ConsultaCliente/xsd/consultaClientesTypes.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaClientesTypes";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/ConsultaProductosAfiliadosTypes";
declare namespace xf = "http://tempuri.org/Middleware/ProductosAfiliados/consultaProductosAfiliados/xq/consultaCliente/";

declare function xf:consultaCliente($CustomerIdType as xs:string, $CustomerIdValue as xs:string)
    as element(ns1:consultaClienteRequest) {
        <ns1:consultaClienteRequest>
            <ns1:CUSTOMER_ID_TYPE>{ data($CustomerIdType) }</ns1:CUSTOMER_ID_TYPE>
            <ns1:CUSTOMER_ID_VALUE>{ data($CustomerIdValue) }</ns1:CUSTOMER_ID_VALUE>
        </ns1:consultaClienteRequest>
};

declare variable $CustomerIdType as xs:string external;
declare variable $CustomerIdValue as xs:string external;

xf:consultaCliente($CustomerIdType,$CustomerIdValue)
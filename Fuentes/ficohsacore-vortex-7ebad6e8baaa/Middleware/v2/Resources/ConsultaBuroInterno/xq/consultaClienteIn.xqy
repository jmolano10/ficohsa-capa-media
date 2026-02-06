xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaBuroInterno1" element="ns0:consultaBuroInterno" location="../xsd/consultaBuroInternoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaClienteRequest" location="../../../../v3/Resources/ConsultaCliente/xsd/consultaClientesTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaBuroInternoTypes";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaClientesTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaBuroInterno/xq/consultaClienteIn/";

declare function xf:consultaClienteIn($consultaBuroInterno1 as element(ns0:consultaBuroInterno))
    as element(ns1:consultaClienteRequest) {
        <ns1:consultaClienteRequest>
            <ns1:CUSTOMER_ID_TYPE>{ data($consultaBuroInterno1/CUSTOMER_INFO/TYPE) }</ns1:CUSTOMER_ID_TYPE>
            <ns1:CUSTOMER_ID_VALUE>{ data($consultaBuroInterno1/CUSTOMER_INFO/VALUE) }</ns1:CUSTOMER_ID_VALUE>
        </ns1:consultaClienteRequest>
};

declare variable $consultaBuroInterno1 as element(ns0:consultaBuroInterno) external;

xf:consultaClienteIn($consultaBuroInterno1)
xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaClienteTarjetas" element="ns2:consultaClienteTarjetas" location="../xsd/consultaClienteTarjetasTypes.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$requestHeader" element="ns0:RequestHeader" location="../../../../v2/Resources/esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/consultaClienteTC/xsd/consultaClientesTC_sp.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/consultaClienteTarjetasTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaClientesTC";
declare namespace xf = "http://tempuri.org/Middleware/v3/Resources/ConsultaClienteTarjetas/xq/consultaClientesTCIn/";

declare function xf:consultaClientesTCIn($consultaClienteTarjetas as element(ns2:consultaClienteTarjetas),
    $requestHeader as element(ns0:RequestHeader))
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:PV_CODIGO_PAIS>{ data($requestHeader/Region/SourceBank) }</ns1:PV_CODIGO_PAIS>
            <ns1:PV_SEARCH_CRITERIA>{ data($consultaClienteTarjetas/SEARCH_CRITERIA) }</ns1:PV_SEARCH_CRITERIA>
            <ns1:PV_SEARCH_VALUE>{ data($consultaClienteTarjetas/SEARCH_VALUE) }</ns1:PV_SEARCH_VALUE>
        </ns1:InputParameters>
};

declare variable $consultaClienteTarjetas as element(ns2:consultaClienteTarjetas) external;
declare variable $requestHeader as element(ns0:RequestHeader) external;

xf:consultaClientesTCIn($consultaClienteTarjetas,
    $requestHeader)
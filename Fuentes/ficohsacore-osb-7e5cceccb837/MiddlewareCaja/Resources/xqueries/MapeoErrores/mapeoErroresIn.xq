(:: pragma bea:global-element-parameter parameter="$mapeoErrores1" element="ns0:mapeoErrores" location="../../wsdls/mapeoErroresProxy.wsdl" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../xsds/MapeoErrores/mapeodeErrores_sp.xsd" ::)

declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/mapeodeErrores";
declare namespace ns0 = "http://www.example.org/mapeoErroresProxy/";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/MapeoErrores/mapeoErroresIn/";

declare function xf:mapeoErroresIn($mapeoErrores1 as element(ns0:mapeoErrores))
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:TEXTO_ERROR>{ data($mapeoErrores1/TEXTO_ERROR) }</ns1:TEXTO_ERROR>
            <ns1:CODIGO_ERROR_P>{ data($mapeoErrores1/CODIGO_ERROR) }</ns1:CODIGO_ERROR_P>
        </ns1:InputParameters>
};

declare variable $mapeoErrores1 as element(ns0:mapeoErrores) external;

xf:mapeoErroresIn($mapeoErrores1)
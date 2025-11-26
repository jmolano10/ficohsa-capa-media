(:: pragma bea:global-element-parameter parameter="$outputParameters1" element="ns1:OutputParameters" location="../../xsds/MapeoErrores/mapeodeErrores_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns0:mapeoErroresResponse" location="../../wsdls/mapeoErroresProxy.wsdl" ::)

declare namespace ns0 = "http://www.example.org/mapeoErroresProxy/";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/mapeodeErrores";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/MapeoErrores/mapeoErroresOut/";

declare function xf:mapeoErroresOut($outputParameters1 as element(ns1:OutputParameters))
    as element(ns0:mapeoErroresResponse) {
        <ns0:mapeoErroresResponse>
            <MENSAJE_MAPEADO>{ data($outputParameters1/ns1:MENSAJE_MAPEADO) }</MENSAJE_MAPEADO>
            <CODIGO_ERROR>{ data($outputParameters1/ns1:CODIGO_ERROR) }</CODIGO_ERROR>
            <DESCRIPCION_ERROR>{ data($outputParameters1/ns1:DESCRIPCION_ERROR) }</DESCRIPCION_ERROR>
        </ns0:mapeoErroresResponse>
};

declare variable $outputParameters1 as element(ns1:OutputParameters) external;

xf:mapeoErroresOut($outputParameters1)
(:: pragma bea:global-element-parameter parameter="$mapeoErrores1" element="ns0:mapeoErrores" location="../../wsdls/mapeoErroresProxy.wsdl" ::)
(:: pragma bea:global-element-return element="ns0:mapeoErroresResponse" location="../../wsdls/mapeoErroresProxy.wsdl" ::)

declare namespace ns0 = "http://www.example.org/mapeoErroresProxy/";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/MapeoErrores/mapeoErroresExceptionOut/";

declare function xf:mapeoErroresExceptionOut($mapeoErrores1 as element(ns0:mapeoErrores))
    as element(ns0:mapeoErroresResponse) {
        <ns0:mapeoErroresResponse>
            <MENSAJE_MAPEADO>{ data($mapeoErrores1/TEXTO_ERROR) }</MENSAJE_MAPEADO>
        </ns0:mapeoErroresResponse>
};

declare variable $mapeoErrores1 as element(ns0:mapeoErrores) external;

xf:mapeoErroresExceptionOut($mapeoErrores1)
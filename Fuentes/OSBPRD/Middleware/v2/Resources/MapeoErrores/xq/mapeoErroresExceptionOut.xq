(:: pragma bea:global-element-parameter parameter="$mapeoErrores1" element="ns0:mapeoErrores" location="../wsdl/mapeoErroresProxy.wsdl" ::)
(:: pragma bea:global-element-return element="ns0:mapeoErroresResponse" location="../wsdl/mapeoErroresProxy.wsdl" ::)

declare namespace ns0 = "http://www.example.org/mapeoErroresProxy/";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/MapeoErrores/xq/mapeoErroresExceptionOut/";

declare function xf:mapeoErroresExceptionOut($mapeoErrores1 as element(ns0:mapeoErrores))
    as element(ns0:mapeoErroresResponse) {
        <ns0:mapeoErroresResponse>
            <MENSAJE_MAPEADO>{ data($mapeoErrores1/TEXTO_ERROR) }</MENSAJE_MAPEADO>
        </ns0:mapeoErroresResponse>
};

declare variable $mapeoErrores1 as element(ns0:mapeoErrores) external;

xf:mapeoErroresExceptionOut($mapeoErrores1)
(:: pragma bea:global-element-parameter parameter="$mapeoErroresResponse1" element="ns1:mapeoErroresResponse" location="../../wsdls/mapeoErroresProxy.wsdl" ::)
(:: pragma bea:global-element-return element="ns0:ResponseHeader" location="../../xsds/General/Autenticacion.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://www.example.org/mapeoErroresProxy/";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/MapeoErrores/mapeoErroresUsageOut/";

declare function xf:mapeoErroresUsageOut($mapeoErroresResponse1 as element(ns1:mapeoErroresResponse),
    $successIndicator as xs:string)
    as element(ns0:ResponseHeader) {
        <ns0:ResponseHeader>
            <successIndicator>{ data($successIndicator) }</successIndicator>
            <messages>{ data($mapeoErroresResponse1/MENSAJE_MAPEADO) }</messages>
        </ns0:ResponseHeader>
};

declare variable $mapeoErroresResponse1 as element(ns1:mapeoErroresResponse) external;
declare variable $successIndicator as xs:string external;

xf:mapeoErroresUsageOut($mapeoErroresResponse1,
    $successIndicator)
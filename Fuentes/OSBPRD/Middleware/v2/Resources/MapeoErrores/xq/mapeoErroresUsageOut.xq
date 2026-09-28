(:: pragma bea:global-element-parameter parameter="$mapeoErroresResponse1" element="ns0:mapeoErroresResponse" location="../wsdl/mapeoErroresProxy.wsdl" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../../../Business_Resources/esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "http://www.example.org/mapeoErroresProxy/";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/MapeoErrores/xq/mapeoErroresUsageOut/";

declare function xf:mapeoErroresUsageOut($mapeoErroresResponse1 as element(ns0:mapeoErroresResponse),
    $successIndicator as xs:string)
    as element(ns1:ResponseHeader) {
        <ns1:ResponseHeader>
            <messageId>{ fn:string($mapeoErroresResponse1/CODIGO_ERROR/text()) }</messageId>
            <successIndicator>
            { 
            	if (fn:string($mapeoErroresResponse1/CODIGO_RETORNO/text())) then (
            		fn:string($mapeoErroresResponse1/CODIGO_RETORNO/text())
            	) else ($successIndicator)
            }
            </successIndicator>
            <messages>{ data($mapeoErroresResponse1/MENSAJE_MAPEADO) }</messages>
        </ns1:ResponseHeader>
};

declare variable $mapeoErroresResponse1 as element(ns0:mapeoErroresResponse) external;
declare variable $successIndicator as xs:string external;

xf:mapeoErroresUsageOut($mapeoErroresResponse1,
    $successIndicator)
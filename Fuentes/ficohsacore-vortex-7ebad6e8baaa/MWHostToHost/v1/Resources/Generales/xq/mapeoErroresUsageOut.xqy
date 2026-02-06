xquery version "2004-draft" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$mapeoErroresResponse" element="ns1:mapeoErroresResponse" location="../../../BusinessServices/OSB/mapeoErrores/wsdl/MapeoErrores.WSDL" ::)
(:: pragma bea:global-element-return element="ns0:ResponseHeader" location="../../EsquemasGenerales/headerElements.xsd" ::)

declare namespace xf = "http://tempuri.org/MWHostToHost/v1/Resources/Generales/xq/mapeoErroresUsageOut/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://www.example.org/mapeoErroresProxy/";

declare function xf:mapeoErroresUsageOut($mapeoErroresResponse as element(ns1:mapeoErroresResponse),
    $successIndicator as xs:string)
    as element(ns0:ResponseHeader) {
        <ns0:ResponseHeader>
        	<messageId>{ fn:string($mapeoErroresResponse/CODIGO_ERROR/text()) }</messageId>
            <successIndicator>
            { 
            	if (fn:string($mapeoErroresResponse/CODIGO_RETORNO/text())) then (
            		fn:string($mapeoErroresResponse/CODIGO_RETORNO/text())
            	) else ($successIndicator)
            }
            </successIndicator>
            <messages>{ data($mapeoErroresResponse/MENSAJE_MAPEADO) }</messages>
        </ns0:ResponseHeader>
};

declare variable $mapeoErroresResponse as element(ns1:mapeoErroresResponse) external;
declare variable $successIndicator as xs:string external;

xf:mapeoErroresUsageOut($mapeoErroresResponse,
    $successIndicator)
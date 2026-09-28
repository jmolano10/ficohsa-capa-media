xquery version "1.0" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$consultatargetclienteDLCResponse" element="ns1:ConsultatargetclienteDLCResponse" location="../../../BusinessServices/T24/catalogosSegmentacion/xsd/XMLSchema_1140175518.xsd" ::)
(:: pragma bea:global-element-return element="ns0:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/CatalogosSegmentacion/xq/catalogosSegmentacionHNHeaderOut/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "T24WebServicesImpl";

declare function xf:catalogosSegmentacionHNHeaderOut($consultatargetclienteDLCResponse as element(ns1:ConsultatargetclienteDLCResponse))
    as element(ns0:ResponseHeader) {
        <ns0:ResponseHeader>
        {
        	let $validationMessage := string-join($consultatargetclienteDLCResponse/Status/messages, ", ")
        	return        	
	        	if (contains(lower-case($validationMessage), 'no records')) then (
	        		<successIndicator>NO RECORDS</successIndicator>,
	        		<messages>{ $validationMessage }</messages>
	        	) else if($validationMessage = "") then(
	        		<successIndicator>Success</successIndicator>
	        	)else(
	        		<successIndicator>{ data($consultatargetclienteDLCResponse/Status/successIndicator) }</successIndicator>,
	        		<messages>{ $validationMessage }</messages>
	        	)
        }
        </ns0:ResponseHeader>
};

declare variable $consultatargetclienteDLCResponse as element(ns1:ConsultatargetclienteDLCResponse) external;

xf:catalogosSegmentacionHNHeaderOut($consultatargetclienteDLCResponse)
(:: pragma bea:global-element-parameter parameter="$consultaestadoremesaenbackendResponse1" element="ns0:ConsultaestadoremesaenbackendResponse" location="../../../../Business_Resources/remesas/Resoruces/XMLSchema_-1855765488.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaRemesaBackend/xq/consultaRemesaBackendHeaderOut/";

declare function xf:consultaRemesaBackendHeaderOut($consultaestadoremesaenbackendResponse1 as element(ns0:ConsultaestadoremesaenbackendResponse))
    as element(ns1:ResponseHeader) {
        <ns1:ResponseHeader>
            {
            	let $successIndicator := fn:string($consultaestadoremesaenbackendResponse1/Status/successIndicator/text())
            	let $ZERORECORDS := fn:string($consultaestadoremesaenbackendResponse1/WSREMITSTATUST24Type/ZERORECORDS/text())
            	let $messages := fn:string($consultaestadoremesaenbackendResponse1/Status/messages/text())
                return
                	if ($successIndicator = "Success" and $ZERORECORDS != "") then (
                    	<successIndicator>NO RECORDS</successIndicator>,
                    	<messages>{ $ZERORECORDS }</messages>
                    ) else (
                    	<successIndicator>{ $successIndicator }</successIndicator>,
                    	<messages>{ $messages }</messages>
                    ) 
            }
        </ns1:ResponseHeader>
};

declare variable $consultaestadoremesaenbackendResponse1 as element(ns0:ConsultaestadoremesaenbackendResponse) external;

xf:consultaRemesaBackendHeaderOut($consultaestadoremesaenbackendResponse1)
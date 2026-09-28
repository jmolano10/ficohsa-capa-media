(:: pragma bea:global-element-parameter parameter="$consultatargetclienteDLCResponse" element="ns0:ConsultatargetclienteDLCResponse" location="../../../BusinessServices/T24/catalogosSegmentacion/xsd/XMLSchema_1140175518.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaTargetResponse" location="../xsd/catalogosSegmentacionTypes.xsd" ::)

declare namespace ns0 = "T24WebServicesImpl";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/catalogosSegmentacionTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/CatalogosSegmentacion/xq/catalogosSegmentacionHNOut/";

declare function xf:catalogosSegmentacionHNOut($consultatargetclienteDLCResponse as element(ns0:ConsultatargetclienteDLCResponse))
    as element(ns1:consultaTargetResponse) {
    	let $validationMessage := string-join($consultatargetclienteDLCResponse/Status/messages, ", ")
		return
			if(not($validationMessage = "")) then (
        		<ns1:consultaTargetResponse/>
        	
        	) else (
        		let $detailsType := $consultatargetclienteDLCResponse/FICOETARGETWSType[1]/gFICOETARGETWSDetailType/mFICOETARGETWSDetailType
        		return
        			if (count($detailsType) < 1) then (
		        		<ns1:consultaTargetResponse/>
					) else (
		        		<ns1:consultaTargetResponse>		        		
				            <TARGETS>
				            {
				            	for $i in (1 to count($detailsType))
								return
					                <TARGET>
					                    <ID>{ data($detailsType[$i]/ID) }</ID>
					                    <DESCRIPTION>{ data($detailsType[$i]/DESCRIPTION) }</DESCRIPTION>
					                </TARGET>
					        }        
				            </TARGETS>
				        </ns1:consultaTargetResponse>
			        )
        	)
};

declare variable $consultatargetclienteDLCResponse as element(ns0:ConsultatargetclienteDLCResponse) external;

xf:catalogosSegmentacionHNOut($consultatargetclienteDLCResponse)
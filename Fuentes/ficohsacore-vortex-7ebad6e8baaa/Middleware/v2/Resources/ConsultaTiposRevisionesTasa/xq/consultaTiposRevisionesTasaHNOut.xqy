xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaTiposRevisionesTasaResponse" element="ns1:OutputParameters" location="../../../BusinessServices/CatalogosInfoPrestamo/consultaTiposRevisionesTasa/xsd/consultaTiposRevisionesTasa_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultaTiposRevisionesTasaResponse" location="../../CatalogosInfoPrestamo/xsd/catalogosInfoPrestamoTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/catalogosInfoPrestamoTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaTiposRevisionesTasa";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaTiposRevisionesTasa/xq/consultaTiposRevisionesTasaHNOut/";

declare function xf:consultaTiposRevisionesTasaHNOut($consultaTiposRevisionesTasaResponse as element(ns1:OutputParameters))
    as element(ns0:consultaTiposRevisionesTasaResponse) {
        let $revisionCodes := $consultaTiposRevisionesTasaResponse/ns1:P_REVISION_CODE/ns1:P_REVISION_CODE_ITEM
        let $revisionDescriptions := $consultaTiposRevisionesTasaResponse/ns1:P_REVISION_DESC/ns1:P_REVISION_DESC_ITEM
        return
        	if (count($revisionCodes) < 1) then (
        		<ns0:consultaTiposRevisionesTasaResponse/>	
        	) else (
        		<ns0:consultaTiposRevisionesTasaResponse>
		            <REVISIONS>
		            {
		            	for $i in (1 to count($revisionCodes))
						return
							let $code := $revisionCodes[$i]
							let $description := $revisionDescriptions[$i]
							return
								<REVISION>
									<CODE>{ data($code) }</CODE>
									<DESCRIPTION>{ data($description) }</DESCRIPTION>
								</REVISION>
		            }
		            </REVISIONS>
		        </ns0:consultaTiposRevisionesTasaResponse>
        	)        
};

declare variable $consultaTiposRevisionesTasaResponse as element(ns1:OutputParameters) external;

xf:consultaTiposRevisionesTasaHNOut($consultaTiposRevisionesTasaResponse)
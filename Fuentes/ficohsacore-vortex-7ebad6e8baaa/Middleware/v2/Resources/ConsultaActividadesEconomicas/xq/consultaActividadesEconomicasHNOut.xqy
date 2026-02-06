xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaActividadesEconomicasResponse" element="ns0:OutputParameters" location="../../../BusinessServices/CatalogosInfoCliente/consultaActividadesEconomicas/xsd/consultaActividadesEconomicas_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaActividadesEconomicasResponse" location="../../CatalogosInfoCliente/xsd/catalogosInfoClienteTypes.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaActividadesEconomicas";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/catalogosInfoClienteTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaActividadesEconomicas/xq/consultaActividadesEconomicasHNOut/";

declare function xf:consultaActividadesEconomicasHNOut($consultaActividadesEconomicasResponse as element(ns0:OutputParameters))
    as element(ns1:consultaActividadesEconomicasResponse) {
    	let $activityCode := $consultaActividadesEconomicasResponse/ns0:P_ECONOMIC_ACTIVITY_CODE/ns0:ECONOMIC_ACTIVITY_CODE_ITEM
    	let $activityDesc := $consultaActividadesEconomicasResponse/ns0:P_ECONOMIC_ACTIVITY_DESC/ns0:ECONOMIC_ACTIVITY_DESC_ITEM
    	return
    		if (count($activityCode) < 1) then (
    			<ns1:consultaActividadesEconomicasResponse/>
    		) else (
    			<ns1:consultaActividadesEconomicasResponse>
		            <ECONOMIC_ACTIVITIES>
		            {
		            	for $i in (1 to count($activityCode))
			    		return
			    			<ECONOMIC_ACTIVITY>
			                    <CODE>{ data($activityCode[$i]) }</CODE>
			                    <DESCRIPTION>{ data($activityDesc[$i]) }</DESCRIPTION>
			                </ECONOMIC_ACTIVITY>
		            }		                
		            </ECONOMIC_ACTIVITIES>
		        </ns1:consultaActividadesEconomicasResponse>
    		)        
};

declare variable $consultaActividadesEconomicasResponse as element(ns0:OutputParameters) external;

xf:consultaActividadesEconomicasHNOut($consultaActividadesEconomicasResponse)
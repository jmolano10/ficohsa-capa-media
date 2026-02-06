xquery version "2004-draft" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns0:OutputParameters" location="../../../BusinessServices/CatalogosInfoCliente/consultaDestinos/xsd/consultaDestinos_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaDestinosResponse" location="../../CatalogosInfoCliente/xsd/catalogosInfoClienteTypes.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaDestinos/xq/consultaDestinosHNOut/";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaDestinos";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/catalogosInfoClienteTypes";

declare function xf:consultaDestinosHNOut($outputParameters as element(ns0:OutputParameters))
    as element(ns1:consultaDestinosResponse) {
        <ns1:consultaDestinosResponse>
            <INVESTMENTS>
            {
				let $investmentCode := $outputParameters/ns0:P_INVESTMENT/ns0:P_INVESTMENT_ITEM/ns0:INVESTMENT_CODE
				let $investmentDesc := $outputParameters/ns0:P_INVESTMENT/ns0:P_INVESTMENT_ITEM/ns0:INVESTMENT_DESCRIPTION
				let $activityCode := $outputParameters/ns0:P_INVESTMENT/ns0:P_INVESTMENT_ITEM/ns0:ECONOMIC_ACTIVITY_CODE
				let $activityDesc := $outputParameters/ns0:P_INVESTMENT/ns0:P_INVESTMENT_ITEM/ns0:ECONOMIC_ACTIVITY_DESC
				let $investmentSub := $outputParameters/ns0:P_INVESTMENT/ns0:P_INVESTMENT_ITEM/ns0:INVESTMENTS_SUB/ns0:INVESTMENTS_SUB_ITEM
            	for $i in 1 to count($investmentCode)
            	return(                 
                <INVESTMENT>
                    	<CODE>{ data($investmentCode[$i]) }</CODE>
   						<DESCRIPTION>{ data($investmentDesc[$i]) }</DESCRIPTION> 
   						<ECONOMIC_ACTIVITY_CODE>{ data($activityCode[$i]) }</ECONOMIC_ACTIVITY_CODE>
			    		<ECONOMIC_ACTIVITY_DESC>{ data($activityDesc[$i]) }</ECONOMIC_ACTIVITY_DESC>
						{
				    		if (count($investmentSub) > 0) then (
	        					<INVESTMENTS_SUB>
	        					{
	        						for $i in (1 to count($investmentSub))
				    					return
				    						let $investmentSubCode := $investmentSub[$i]/ns0:INVESTMENT_SUB_CODE
				    						let $investmentSubDesc := $investmentSub[$i]/ns0:INVESTMENT_SUB_DESCRIPTION
				    						let $destinations := $investmentSub[$i]/ns0:DESTINATIONS/ns0:DESTINATIONS_ITEM
				    							return
					    							<INVESTMENT_SUB>
					    								<CODE>{ data($investmentSubCode) }</CODE>
					    								<DESCRIPTION>{ data($investmentSubDesc) }</DESCRIPTION>
					    								{
					    									if (count($destinations) > 0) then (
					    										<DESTINATIONS>
					    										{
	        														for $i in (1 to count($destinations))
	        														return
	        															let $investmentSubCode := $destinations[$i]/ns0:DESTINATION_CODE
				    													let $investmentSubDesc := $destinations[$i]/ns0:DESTINATION_DESCRIPTION
				    														return
	        																<DESTINATION>
	        																	<CODE>{ data($investmentSubCode) }</CODE>
	        																	<DESCRIPTION>{ data($investmentSubDesc) }</DESCRIPTION>
	        																</DESTINATION>
	        													}
					    										</DESTINATIONS>
					    									) else ()
					    									}
					    							</INVESTMENT_SUB>
	        								}
	        					</INVESTMENTS_SUB>
	    					) else ()
				    	}			
                </INVESTMENT>
                )
			}
            </INVESTMENTS>           
        </ns1:consultaDestinosResponse>
};

declare variable $outputParameters as element(ns0:OutputParameters) external;

xf:consultaDestinosHNOut($outputParameters)
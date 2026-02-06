xquery version "2004-draft" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$consultaInversionesResponse" element="ns1:OutputParameters" location="../../../BusinessServices/CatalogosInfoCliente/consultaInversiones/xsd/consultaInversiones_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultaInversionesResponse" location="../../CatalogosInfoCliente/xsd/catalogosInfoClienteTypes.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaInversiones/xq/consultaInversionesHNOut/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/catalogosInfoClienteTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaInversiones";

declare function xf:consultaInversionesHNOut($consultaInversionesResponse as element(ns1:OutputParameters))
    as element(ns0:consultaInversionesResponse) {
    	let $investment := $consultaInversionesResponse/ns1:P_INVESTMENT/ns1:P_INVESTMENT_ITEM    	
        return
        	if (count($investment) < 1) then (
        		<ns0:consultaInversionesResponse/>
    		) else (    			
				<ns0:consultaInversionesResponse>
					<INVESTMENTS>
					{
		    			for $i in (1 to count($investment))
			    		return
			    			let $investmentCode := $investment[$i]/ns1:INVESTMENT_CODE
							let $investmentDesc := $investment[$i]/ns1:INVESTMENT_DESCRIPTION
							let $activityCode := $investment[$i]/ns1:ECONOMIC_ACTIVITY_CODE
					    	let $activityDesc := $investment[$i]/ns1:ECONOMIC_ACTIVITY_DESC
					    	let $investmentSub := $investment[$i]/ns1:INVESTMENTS_SUB/ns1:INVESTMENTS_SUB_ITEM
			    			return
			    				<INVESTMENT>
			    					<CODE>{ data($investmentCode) }</CODE>
			    					<DESCRIPTION>{ data($investmentDesc) }</DESCRIPTION>
			    					<ECONOMIC_ACTIVITY_CODE>{ data($activityCode) }</ECONOMIC_ACTIVITY_CODE>
			    					<ECONOMIC_ACTIVITY_DESC>{ data($activityDesc) }</ECONOMIC_ACTIVITY_DESC>
				    				{
				    					if (count($investmentSub) > 0) then (
	        								<INVESTMENTS_SUB>
	        									{
	        										for $i in (1 to count($investmentSub))
				    								return
				    									let $investmentSubCode := $investmentSub[$i]/ns1:INVESTMENT_SUB_CODE
				    									let $investmentSubDesc := $investmentSub[$i]/ns1:INVESTMENT_SUB_DESCRIPTION
				    									return
					    									<INVESTMENT_SUB>
					    										<CODE>{ data($investmentSubCode) }</CODE>
					    										<DESCRIPTION>{ data($investmentSubDesc) }</DESCRIPTION>
					    									</INVESTMENT_SUB>
	        									}
	        								</INVESTMENTS_SUB>
	    								) else ()
				    				}			    				
			    				</INVESTMENT>
	    			}	    			
					</INVESTMENTS>
				</ns0:consultaInversionesResponse>
    		)
};

declare variable $consultaInversionesResponse as element(ns1:OutputParameters) external;

xf:consultaInversionesHNOut($consultaInversionesResponse)
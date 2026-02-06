xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns1:OutputParameters" location="../../../BusinessServices/MasterDataPA/conDatosPlanes/xsd/conDatosPlanes_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultaPlanesCreditoResponse" location="../xsd/consultaPlanesCreditoTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaPlanesCreditoTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/conDatosPlanes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaPlanesCredito/xq/consultaPlanesCreditoPAOut/";

declare function xf:consultaPlanesCreditoPAOut($outputParameters as element(ns1:OutputParameters))
    as element(ns0:consultaPlanesCreditoResponse) {
        let $OutputParameters := $outputParameters
        return
            <ns0:consultaPlanesCreditoResponse>
                {
            	<ns0:CREDIT_PLANS>
            		{
		            	for $row in $outputParameters/ns1:RowSet/ns1:Row  
		        		return(
		        			<ns0:CREDIT_PLAN>
		        				{
		        					for $org in $row/ns1:Column[@name = 'org']
		        					return
		        						<ORG>{data($org)}</ORG>,
		        				
		        				
		        					for $account in $row/ns1:Column[@name = 'cuenta']
									return
										<ACCOUNT>{data($account)}</ACCOUNT>,
		        				
		        				
									for $seqNumber in $row/ns1:Column[@name = 'numseq']
									return
										<SEQ_NUMBER>{ data($seqNumber)}</SEQ_NUMBER>,
								
								
									for $logo in $row/ns1:Column[@name = 'logo']
									return
										<LOGO>{ data($logo)}</LOGO>,
								
								
									for $planNumber in $row/ns1:Column[@name = 'numplan']
									return
										<PLAN_NUMBER>{ data($planNumber) }</PLAN_NUMBER>,
								
								
									for $payMinimum in $row/ns1:Column[@name = 'total_due']
									return
										 <PAY_MINIMUM>{ data($payMinimum) }</PAY_MINIMUM>,
								
								
									for $type in $row/ns1:Column[@name = 'tipo_plan']
									return
										<TYPE_PLAN>{ data($type)}</TYPE_PLAN>,
										
								
								
									for $intRate in $row/ns1:Column[@name = 'int_rate']
									return
										 <INT_RATE>{ data($intRate) }</INT_RATE>,
								
								
									for $intRateBase in $row/ns1:Column[@name = 'int_rat1_base']
									return
										 <INT_RATE_BASE>{data($intRateBase)}</INT_RATE_BASE>,
										
								
								
									for $currentBalance in $row/ns1:Column[@name = 'balanceactual']
									return
										<CURRENT_BALANCE>{data($currentBalance)}</CURRENT_BALANCE>,
								
								
									for $datePlan in $row/ns1:Column[@name = 'fecplan']/text()
									return
										if($datePlan != '')then(
					    					<DATE_PLAN>
					    						{
					    						fn-bea:dateTime-to-string-with-format('yyyyMMdd', $datePlan)
					    						}
					    					</DATE_PLAN>
					    				)else(),
										
								
									for $acrdInt in $row/ns1:Column[@name = 'acrd_int']
									return
										<ACRD_INT>{data($acrdInt)}</ACRD_INT>,
										
								
								
									for $delaysAcrdInt in $row/ns1:Column[@name = 'mora_acrd_int']
									return
										<DELAYS_ACRD_INT>{ data($delaysAcrdInt) }</DELAYS_ACRD_INT>,
								
								
									for $accumulatedDelaysInt in  $row/ns1:Column[@name = 'd2ps_mora_int_per_diem']
									return 
										<ACCUMULATED_DELAYS_INT>{ data($accumulatedDelaysInt) }</ACCUMULATED_DELAYS_INT>
								
		        			}
		        			</ns0:CREDIT_PLAN>
		        		)
		        	}
		        </ns0:CREDIT_PLANS>
        	}
            </ns0:consultaPlanesCreditoResponse>
};

declare variable $outputParameters as element(ns1:OutputParameters) external;

xf:consultaPlanesCreditoPAOut($outputParameters)
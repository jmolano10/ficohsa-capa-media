(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns1:OutputParameters" location="../../../BusinessServices/DesembolsoLineaCredito/procesarSolicitudesCliente/xsd/procesarSolicitudesCliente_sp.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$procesarSolicitudesClienteRequest" element="ns0:procesarSolicitudesCliente" location="../../DesembolsoLineaCredito/xsd/desembolsoLineaCreditoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:procesarSolicitudesClienteResponse" location="../../DesembolsoLineaCredito/xsd/desembolsoLineaCreditoTypes.xsd" ::)

declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/procesarSolicitudesCliente";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/desembolsoLineaCreditoTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ProcesarSolicitudesCliente/xq/procesarSolicitudesClienteHNOut/";
declare function convertirFecha($date as xs:dateTime) 
    as xs:string {
        fn-bea:dateTime-to-string-with-format("yyyyMMdd",$date)
};
declare function xf:procesarSolicitudesClienteHNOut($outputParameters as element(ns1:OutputParameters),
    $procesarSolicitudesClienteRequest as element(ns0:procesarSolicitudesCliente))
    as element(ns0:procesarSolicitudesClienteResponse) {
        <ns0:procesarSolicitudesClienteResponse>
            <CUSTOMER_ID>{ data($procesarSolicitudesClienteRequest/CUSTOMER_ID) }</CUSTOMER_ID>
            {
                for $P_CUSTOMER_NAME in $outputParameters/ns1:P_CUSTOMER_NAME
                return
                    <CUSTOMER_NAME>{ data($P_CUSTOMER_NAME) }</CUSTOMER_NAME>
            }
            {
            	let $request := $procesarSolicitudesClienteRequest/REQUEST_DETAILS/REQUEST
            	let $pIncomeDate := data($outputParameters/ns1:P_INCOME_DATE/ns1:P_INCOME_DATE_ITEM)
            	let $status := data($outputParameters/ns1:P_STATUS/ns1:P_REQUEST_ID_ITEM)
            	let $statusDescription := data($outputParameters/ns1:P_STATUS_DESCRIPTION/ns1:P_STATUS_DESCRIPTION_ITEM)
            	return
            		if(count( $request ) < 1)then(
            		
            		)else(
            			<REQUEST_DETAILS>
            				{
            					for $i in (1 to count ($request))
            					return
            						<REQUEST>
					                    <ID>{ data($request[$i]/ID) }</ID>
					                    {
					                    	if( $pIncomeDate[$i] != "" )then(
					                    		<INCOME_DATE>{ convertirFecha($pIncomeDate[$i]) }</INCOME_DATE>
					                    	)else()
					                    }					                    
					                    <STATUS>{ $status[$i] }</STATUS>
					                    <STATUS_DESCRIPTION>{ $statusDescription[$i] }</STATUS_DESCRIPTION>
					                </REQUEST>
            				}			                
			            </REQUEST_DETAILS>
            		)
            }	
            		
            	
            
        </ns0:procesarSolicitudesClienteResponse>
};

declare variable $outputParameters as element(ns1:OutputParameters) external;
declare variable $procesarSolicitudesClienteRequest as element(ns0:procesarSolicitudesCliente) external;

xf:procesarSolicitudesClienteHNOut($outputParameters,
    $procesarSolicitudesClienteRequest)
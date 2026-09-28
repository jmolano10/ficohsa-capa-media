(:: pragma bea:global-element-parameter parameter="$procesarSolicitudesCliente" element="ns0:procesarSolicitudesCliente" location="../../DesembolsoLineaCredito/xsd/desembolsoLineaCreditoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/DesembolsoLineaCredito/procesarSolicitudesCliente/xsd/procesarSolicitudesCliente_sp.xsd" ::)

declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/procesarSolicitudesCliente";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/desembolsoLineaCreditoTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ProcesarSolicitudesCliente/xq/procesarSolicitudesClienteHNIn/";

declare function xf:procesarSolicitudesClienteHNIn($procesarSolicitudesCliente as element(ns0:procesarSolicitudesCliente))
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:P_CUSTOMER_ID>{ data($procesarSolicitudesCliente/CUSTOMER_ID) }</ns1:P_CUSTOMER_ID>
            <ns1:P_ACTION>{ data($procesarSolicitudesCliente/ACTION) }</ns1:P_ACTION>
            <ns1:P_AUTHORIZATION_USER>{ data($procesarSolicitudesCliente/AUTHORIZATION_USER) }</ns1:P_AUTHORIZATION_USER>
            {
            	let $requestRepetitive := $procesarSolicitudesCliente/REQUEST_DETAILS/REQUEST
            	return(            		            	
	            		<ns1:P_REQUEST_ID>
	            			{
	            				for $request in $requestRepetitive
	            				return
	            					<ns1:P_REQUEST_ID_ITEM>{ data($request/ID) }</ns1:P_REQUEST_ID_ITEM>
	            			}	            			                				            			            			
	            		</ns1:P_REQUEST_ID>,	            		
						<ns1:P_INCOME_DATE>
							{
								for $request in $requestRepetitive,	    		
			    				$incomeDate in $request/INCOME_DATE            	
								return
									if( $incomeDate/text() != "" )then(
			        					<ns1:P_INCOME_DATE_ITEM>{adjust-date-to-timezone(xs:date($incomeDate),()) }</ns1:P_INCOME_DATE_ITEM>
		        					)else()	
							}						
						</ns1:P_INCOME_DATE>
		    				 	          		        			
	             )     
			}
                  
        </ns1:InputParameters>
};

declare variable $procesarSolicitudesCliente as element(ns0:procesarSolicitudesCliente) external;

xf:procesarSolicitudesClienteHNIn($procesarSolicitudesCliente)
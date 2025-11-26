(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns0:OutputParameters" location="../../../BusinessServices/DesembolsoLineaCredito/crearSolicitudCliente/xsd/crearSolicitudCliente_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns1:crearSolicitudClienteResponse" location="../../DesembolsoLineaCredito/xsd/desembolsoLineaCreditoTypes.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/crearSolicitudCliente";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/desembolsoLineaCreditoTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/CrearSolicitudCliente/xq/crearSolicitudClienteHNOut/";

declare function xf:crearSolicitudClienteHNOut($outputParameters as element(ns0:OutputParameters))
    as element(ns1:crearSolicitudClienteResponse) {
        <ns1:crearSolicitudClienteResponse>
            <CUSTOMER_NAME>{ data($outputParameters/ns0:P_CUSTOMER_NAME) }</CUSTOMER_NAME>  
          	{         
				let $requestId := $outputParameters/ns0:P_REQUEST_ID
				let $incomeDate := $outputParameters/ns0:P_INCOME_DATE
				let $status := $outputParameters/ns0:P_STATUS
				let $statusDescription := $outputParameters/ns0:P_STATUS_DESCRIPTION
	        	for $i in 1 to count($requestId)
	        	return(
	        	<REQUEST_DETAILS>
		        	{
	            		if( $requestId != "" )then(
	            			<ID>{ data($requestId[$i]) }</ID>
	            		)else()
	            	}
	        		
					{
			            if( $incomeDate[$i] != "")then(
			             <INCOME_DATE>{ fn-bea:date-from-string-with-format("yyyyMMdd",$incomeDate[$i]) }</INCOME_DATE>
			            )else()
		            }
	        		<STATUS>{ data($status[$i]) }</STATUS>
	        		<STATUS_DESCRIPTION>{ data($statusDescription[$i]) }</STATUS_DESCRIPTION>
	        	</REQUEST_DETAILS>
	        	)
           	}
        </ns1:crearSolicitudClienteResponse>
};

declare variable $outputParameters as element(ns0:OutputParameters) external;

xf:crearSolicitudClienteHNOut($outputParameters)
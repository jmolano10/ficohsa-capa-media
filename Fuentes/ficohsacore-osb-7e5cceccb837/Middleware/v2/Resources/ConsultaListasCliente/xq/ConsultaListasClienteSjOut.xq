(:: pragma bea:global-element-parameter parameter="$sjConsultaListasClienteResponse1" element="ns0:sjConsultaListasClienteResponse" location="../xsd/sjConsultaListasCliente.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaListasClienteResponse" location="../xsd/consultaListasClienteTypes.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaListasClienteTypes";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/sjConsultaListasCliente";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaListasCliente/xq/ConsultaListasClienteSjOut/";

(: Función que determina si cliente está o no en una lista :)
declare function CustomerStatus($customerName as xs:string, $successIndicator as xs:string) as xs:string {
	if (fn:upper-case($successIndicator) = "SUCCESS") then (
		if ($customerName != "") then (
			"YES"
		) else (
			"NO"
		)
	) else if (fn:upper-case($successIndicator) = "NOMATCH") then (
		"NO"
	) else if (fn:upper-case($successIndicator) = "HINT") then (
		"I"
	) else if (fn:upper-case($successIndicator) = "RELUCTANT") then (
		"R"
	) else (
		"ERROR"
	)
};
declare function xf:ConsultaListasClienteSjOut($sjConsultaListasClienteResponse1 as element(ns0:sjConsultaListasClienteResponse), $customerId as xs:string, $customerName as xs:string)
    as element(ns1:consultaListasClienteResponse) {
	        <ns1:consultaListasClienteResponse>
	        {
	        	<CUSTOMER_ID>{ $customerId }</CUSTOMER_ID>,
	        	<CUSTOMER_NAME>{ $customerName }</CUSTOMER_NAME>
	        }
	            <ASSOCIATIONS_LIST>
	            {
	            	let $SUCCESS_INDICATOR := fn:count($sjConsultaListasClienteResponse1/ns0:consultaListaClienteResponse[fn:upper-case(ns0:successIndicator/text()) = "SUCCESS"])
    				return
		            	if ($SUCCESS_INDICATOR > 0) then (
			            	for $ASSOCIATION in $sjConsultaListasClienteResponse1/ns0:consultaListaClienteResponse
			            	return
			                <ASSOCIATION>
			                    <ASSOCIATION_NAME>{ data($ASSOCIATION/ns0:ASSOCIATION_NAME) }</ASSOCIATION_NAME>
			                    <CUSTOMER_STATUS>{ CustomerStatus(fn:string($ASSOCIATION/ns0:CUSTOMER_NAME/text()),fn:string($ASSOCIATION/ns0:successIndicator/text())) }</CUSTOMER_STATUS>
			                </ASSOCIATION>
		                 )else () 
	            }
	            </ASSOCIATIONS_LIST>
	        </ns1:consultaListasClienteResponse>

};

declare variable $sjConsultaListasClienteResponse1 as element(ns0:sjConsultaListasClienteResponse) external;
declare variable $customerId as xs:string external;
declare variable $customerName as xs:string external;

xf:ConsultaListasClienteSjOut($sjConsultaListasClienteResponse1, $customerId, $customerName)
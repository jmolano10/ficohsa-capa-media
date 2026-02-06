xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$sjConsultaListasClienteResponse" element="ns0:sjConsultaListasClienteResponse" location="../../../BusinessServices/SJS/consultaListasClienteGT/xsd/sjConsultaListasClienteGT.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaListasClienteResponse" location="../../ConsultaListasCliente/xsd/consultaListasClienteTypes.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaListasClienteTypes";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/sjConsultaListasCliente";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaListasClienteGT/xq/consultaListasClienteGTOut/";

declare function xf:consultaListasClienteGTOut($sjConsultaListasClienteResponse as element(ns0:sjConsultaListasClienteResponse))
    as element(ns1:consultaListasClienteResponse) {
        <ns1:consultaListasClienteResponse>
            <ASSOCIATIONS_LIST>
            {
            	for $consultaListaClienteResponse in $sjConsultaListasClienteResponse/ns0:consultaListaClienteResponse
            	return(
            		<ASSOCIATION>
                    	<ASSOCIATION_NAME>{ fn:data($consultaListaClienteResponse/ns0:ASSOCIATION_NAME) }</ASSOCIATION_NAME>
                    	{
                    		if (fn:upper-case(fn:data($consultaListaClienteResponse/ns0:successIndicator)) = "SUCCESS") then (
                    			<CUSTOMER_STATUS>YES</CUSTOMER_STATUS>
                    		) else if (fn:upper-case(fn:data($consultaListaClienteResponse/ns0:successIndicator)) = "NO RECORDS") then (
                    			<CUSTOMER_STATUS>NO</CUSTOMER_STATUS>
                    		) else (
                    			<CUSTOMER_STATUS>ERROR</CUSTOMER_STATUS>
                    		)
                    	}
                	</ASSOCIATION>
            	)
            }
            </ASSOCIATIONS_LIST>
        </ns1:consultaListasClienteResponse>
};

declare variable $sjConsultaListasClienteResponse as element(ns0:sjConsultaListasClienteResponse) external;

xf:consultaListasClienteGTOut($sjConsultaListasClienteResponse)
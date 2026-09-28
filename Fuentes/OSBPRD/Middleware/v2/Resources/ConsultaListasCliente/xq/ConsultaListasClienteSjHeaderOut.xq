xquery version "1.0" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$sjConsultaListasClienteResponse1" element="ns0:sjConsultaListasClienteResponse" location="../xsd/sjConsultaListasCliente.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaListasCliente/xq/ConsultaListasClienteSjHeaderOut/";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/sjConsultaListasCliente";

declare function xf:ConsultaListasClienteSjHeaderOut($sjConsultaListasClienteResponse1 as element(ns0:sjConsultaListasClienteResponse))
    as element(ns1:ResponseHeader) {
        <ns1:ResponseHeader>
        {
        	let $SUCCESS_INDICATOR := fn:count($sjConsultaListasClienteResponse1/ns0:consultaListaClienteResponse[fn:upper-case(ns0:successIndicator/text()) = "SUCCESS"])
        	return
        	if ($SUCCESS_INDICATOR > 0) then (
       			<successIndicator>Success</successIndicator>
        	)else(
        		<successIndicator>ERROR</successIndicator>,
        		<messages>CUSTOMER LIST ARE NOT AVAILABLE</messages>
        	) 
        }	
        </ns1:ResponseHeader>
};

declare variable $sjConsultaListasClienteResponse1 as element(ns0:sjConsultaListasClienteResponse) external;

xf:ConsultaListasClienteSjHeaderOut($sjConsultaListasClienteResponse1)
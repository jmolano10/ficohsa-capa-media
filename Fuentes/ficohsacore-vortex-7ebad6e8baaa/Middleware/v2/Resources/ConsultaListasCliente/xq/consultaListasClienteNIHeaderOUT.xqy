xquery version "2004-draft" encoding "Cp1252";
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaListasClienteTypes";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaListasCliente/xq/consultaListasClienteNIHeaderOut/";

declare function xf:consultaListasClienteNIHeaderOut($outputParameters1 as node()) 
	as element(ns1:ResponseHeader) {

        <ns1:ResponseHeader>
        {
        	let $SUCCESS_INDICATOR := data($outputParameters1/IDENTIDAD/text())
        	return
        	if (exists($SUCCESS_INDICATOR)) then (
       			<successIndicator>Success</successIndicator>
        	)else(
        		<successIndicator>ERROR</successIndicator>,
        		<messages>CUSTOMER LIST ARE NOT AVAILABLE</messages>
        	) 
        }	
        </ns1:ResponseHeader>

};

declare variable $outputParameters as node() external;

xf:consultaListasClienteNIHeaderOut($outputParameters)
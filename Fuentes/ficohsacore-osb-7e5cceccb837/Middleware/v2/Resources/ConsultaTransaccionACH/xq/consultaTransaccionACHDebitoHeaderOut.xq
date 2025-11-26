xquery version "1.0" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$consultaACHDebitoResponse" element="ns1:ConsultaACHDebitoResponse" location="../../../BusinessServices/T24/ACHRecibidas/xsd/XMLSchema_478367602.xsd" ::)
(:: pragma bea:global-element-return element="ns0:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaTransaccionACH/xq/consultaTransaccionACHDebitoHeaderOut/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "T24WebServicesImpl";

declare function xf:consultaTransaccionACHDebitoHeaderOut($consultaACHDebitoResponse as element(ns1:ConsultaACHDebitoResponse))
    as element(ns0:ResponseHeader) {
        <ns0:ResponseHeader>
       	{
       		let $successIndicator := fn:string($consultaACHDebitoResponse/Status/successIndicator/text())
       		return
	        	if ($successIndicator = "Success") then (
		            if (fn:string($consultaACHDebitoResponse/WSACHDEBITOSType/ZERORECORDS/text()) = "") then (
		            	<successIndicator>Success</successIndicator>
		            ) else (
		            	<successIndicator>NO RECORDS</successIndicator>,
		            	<messages>0 RECORDS RETURNED</messages>
		            )
		        ) else (
	                <successIndicator>{ $successIndicator }</successIndicator>,
	                <messages>{ fn:string-join($consultaACHDebitoResponse/Status/messages, ". ") }</messages>
	            )
        }
        </ns0:ResponseHeader>
};

declare variable $consultaACHDebitoResponse as element(ns1:ConsultaACHDebitoResponse) external;

xf:consultaTransaccionACHDebitoHeaderOut($consultaACHDebitoResponse)
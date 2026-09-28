xquery version "1.0" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$consultaInversionesResponse" element="ns1:OutputParameters" location="../../../BusinessServices/CatalogosInfoCliente/consultaInversiones/xsd/consultaInversiones_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns0:ResponseHeader" location="../../../../Business_Resources/esquemas_generales/HeaderElements.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaInversiones/xq/consultaInversionesHNHeaderOut/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaInversiones";

declare function xf:consultaInversionesHNHeaderOut($consultaInversionesResponse as element(ns1:OutputParameters))
    as element(ns0:ResponseHeader) {
        <ns0:ResponseHeader>
	        {
	        	let $errorCode := $consultaInversionesResponse/ns1:P_SUCCESSINDICATOR/text()
	        	let $validationMessage := $consultaInversionesResponse/ns1:P_MESSAGES/text()
                return
	            	if ($errorCode != 'SUCCESS') then (
						<successIndicator>{ $errorCode }</successIndicator>,
						<messages>{ $validationMessage }</messages>
					)else(
						<successIndicator>Success</successIndicator>
					) 
	        }
        </ns0:ResponseHeader>
};

declare variable $consultaInversionesResponse as element(ns1:OutputParameters) external;

xf:consultaInversionesHNHeaderOut($consultaInversionesResponse)
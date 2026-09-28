xquery version "1.0" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$consultaOrigenesResponse" element="ns1:OutputParameters" location="../../../BusinessServices/CatalogosInfoCliente/consultaOrigenes/xsd/consultaOrigenes_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns0:ResponseHeader" location="../../../../Business_Resources/esquemas_generales/HeaderElements.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaOrigenes/xq/consultaOrigenesHNHeaderOut/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaOrigenes";

declare function xf:consultaOrigenesHNHeaderOut($consultaOrigenesResponse as element(ns1:OutputParameters))
    as element(ns0:ResponseHeader) {
        <ns0:ResponseHeader>
	        {
	        	let $errorCode := $consultaOrigenesResponse/ns1:P_SUCCESSINDICATOR/text()
	        	let $validationMessage := $consultaOrigenesResponse/ns1:P_MESSAGES/text()
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

declare variable $consultaOrigenesResponse as element(ns1:OutputParameters) external;

xf:consultaOrigenesHNHeaderOut($consultaOrigenesResponse)
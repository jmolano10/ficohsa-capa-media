xquery version "2004-draft" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$consultaTiposRevisionesTasaResponse" element="ns1:OutputParameters" location="../../../BusinessServices/CatalogosInfoPrestamo/consultaTiposRevisionesTasa/xsd/consultaTiposRevisionesTasa_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns0:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaTiposRevisionesTasa/xq/consultaTiposRevisionesTasaHNHeaderOut/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaTiposRevisionesTasa";

declare function xf:consultaTiposRevisionesTasaHNHeaderOut($consultaTiposRevisionesTasaResponse as element(ns1:OutputParameters))
    as element(ns0:ResponseHeader) {
        <ns0:ResponseHeader>
        {
        	let $errorCode := $consultaTiposRevisionesTasaResponse/ns1:P_SUCCESSINDICATOR/text()
        	let $validationMessage := $consultaTiposRevisionesTasaResponse/ns1:P_MESSAGES/text()
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

declare variable $consultaTiposRevisionesTasaResponse as element(ns1:OutputParameters) external;

xf:consultaTiposRevisionesTasaHNHeaderOut($consultaTiposRevisionesTasaResponse)
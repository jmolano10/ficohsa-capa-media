xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaTDNuevaResponse" element="ns1:ConsultaTDNuevaResponse" location="../../../../Business_Resources/tarjetasDebito/Resources/XMLSchema_-155258746.xsd" ::)
(:: pragma bea:global-element-return element="ns0:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaSolicitudTarjetaDebito/xq/consultaSolicitudTarjetaDebitoHeaderOut/";

declare function xf:consultaSolicitudTarjetaDebitoHeaderOut($consultaTDNuevaResponse as element(ns1:ConsultaTDNuevaResponse))
    as element(ns0:ResponseHeader) {
        <ns0:ResponseHeader>
        {
        	if (fn:string($consultaTDNuevaResponse/Status/successIndicator/text()) = "Success") then (
        	   if (fn:string($consultaTDNuevaResponse/FICOBULKAPPTDWSType/ZERORECORDS/text()) = "") then (
        	   		<successIndicator>Success</successIndicator>
        	   ) else (
        	   		<successIndicator>NO RECORDS</successIndicator>,
        	   		<messages>0 RECORDS RETURNED</messages>
        	   )
        	) else (
        		<successIndicator>{ fn:string($consultaTDNuevaResponse/Status/successIndicator/text()) }</successIndicator>,
        		<messages>{ fn:string($consultaTDNuevaResponse/Status/messages/text()) }</messages>
        	)

        }
        </ns0:ResponseHeader>
};

declare variable $consultaTDNuevaResponse as element(ns1:ConsultaTDNuevaResponse) external;

xf:consultaSolicitudTarjetaDebitoHeaderOut($consultaTDNuevaResponse)
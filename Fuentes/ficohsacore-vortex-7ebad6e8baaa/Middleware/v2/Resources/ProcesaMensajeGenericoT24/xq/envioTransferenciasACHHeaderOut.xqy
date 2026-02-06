xquery version "2004-draft" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$envioTransferenciasACHResponse1" element="ns1:envioTransferenciasACHResponse" location="../../EnvioTransferenciasACH/xsd/envioTransferenciasACHTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ProcesaMensajeGenericoT24/xq/envioTransferenciasACHHeaderOut/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";

declare function xf:envioTransferenciasACHHeaderOut($successIndicator as xs:string,
$message as xs:string)
    as element(ns0:ResponseHeader) {
    	<ns0:ResponseHeader>
    		<successIndicator>{ $successIndicator }</successIndicator>
    	{
    		if(fn:upper-case($successIndicator) != ("SUCCESS","PENDING")) then (
    			<messages>{ $message }</messages>
    		)else(
    			
    		)
    	}
        </ns0:ResponseHeader>
};

declare variable $successIndicator as xs:string external;
declare variable $message as xs:string external;

xf:envioTransferenciasACHHeaderOut($successIndicator,$message)
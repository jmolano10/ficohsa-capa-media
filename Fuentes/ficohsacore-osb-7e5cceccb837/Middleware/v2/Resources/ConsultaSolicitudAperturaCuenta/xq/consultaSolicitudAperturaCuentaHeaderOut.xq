(:: pragma bea:global-element-parameter parameter="$consultaCuentaAperturadaResponse" element="ns1:ConsultaCuentaAperturadaResponse" location="../../../../Business_Resources/ConsultasCuenta/Resources/XMLSchema_378991004.xsd" ::)
(:: pragma bea:global-element-return element="ns0:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaSolicitudAperturaCuenta/xq/consultaSolicitudAperturaCuentaHeaderOut/";

declare function xf:consultaSolicitudAperturaCuentaHeaderOut($consultaCuentaAperturadaResponse as element(ns1:ConsultaCuentaAperturadaResponse))
    as element(ns0:ResponseHeader) {
        <ns0:ResponseHeader>
        {
        	if (fn:string($consultaCuentaAperturadaResponse/Status/successIndicator/text()) = "Success") then (
	            if (fn:string($consultaCuentaAperturadaResponse/FICOBULKAPPACCTWSType/ZERORECORDS/text()) = "") then (
	            	<successIndicator>Success</successIndicator>
	            ) else (
	            	<successIndicator>NO RECORDS</successIndicator>,
	            	<messages>0 RECORDS RETURNED</messages>
	            )
	        ) else (
                <successIndicator>{ fn:string($consultaCuentaAperturadaResponse/Status/successIndicator/text()) }</successIndicator>,
                <messages>{         fn:string($consultaCuentaAperturadaResponse/Status/messages/text()) }</messages>
            )
        }
        </ns0:ResponseHeader>
};

declare variable $consultaCuentaAperturadaResponse as element(ns1:ConsultaCuentaAperturadaResponse) external;

xf:consultaSolicitudAperturaCuentaHeaderOut($consultaCuentaAperturadaResponse)

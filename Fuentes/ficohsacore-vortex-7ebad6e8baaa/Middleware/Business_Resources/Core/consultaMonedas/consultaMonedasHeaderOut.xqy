xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultadetasadecambiolcyResponse" element="ns0:ConsultadetasadecambiolcyResponse" location="../Resources/XMLSchema_1632682327.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/Core/consultaMonedas/consultaMonedasHeaderOut/";

declare function xf:consultaMonedasHeaderOut($consultadetasadecambiolcyResponse as element(ns0:ConsultadetasadecambiolcyResponse))
    as element(ns1:ResponseHeader) {
        <ns1:ResponseHeader>
            {
            	if (empty($consultadetasadecambiolcyResponse/WSLCYEXCHRATEType[1]/ZERORECORDS/text())) then (
            		<successIndicator>{ data($consultadetasadecambiolcyResponse/Status/successIndicator) }</successIndicator>,
            		<messages>{ data($consultadetasadecambiolcyResponse/Status/messages) }</messages>
            	) else (
            		<successIndicator>NO RECORDS</successIndicator>,
            		<messages>{ data($consultadetasadecambiolcyResponse/WSLCYEXCHRATEType[1]/ZERORECORDS) }</messages>
            	)
            }            
        </ns1:ResponseHeader>
};

declare variable $consultadetasadecambiolcyResponse as element(ns0:ConsultadetasadecambiolcyResponse) external;

xf:consultaMonedasHeaderOut($consultadetasadecambiolcyResponse)
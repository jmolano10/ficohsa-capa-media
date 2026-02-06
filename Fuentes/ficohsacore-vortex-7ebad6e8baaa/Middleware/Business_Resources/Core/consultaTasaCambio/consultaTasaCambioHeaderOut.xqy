xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultadetasadecambiolcyResponse1" element="ns0:ConsultadetasadecambiolcyResponse" location="../Resources/XMLSchema_1632682327.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/Core/consultaTasaCambio/consultaTasaCambioHeaderOut/";

declare function xf:consultaTasaCambioHeaderOut($consultadetasadecambiolcyResponse1 as element(ns0:ConsultadetasadecambiolcyResponse))
    as element(ns1:ResponseHeader) {
        <ns1:ResponseHeader>
        	{
        		if(empty($consultadetasadecambiolcyResponse1/WSLCYEXCHRATEType[1]/ZERORECORDS/text())) then(
        			<successIndicator>{ data($consultadetasadecambiolcyResponse1/Status/successIndicator) }</successIndicator>,
        			<messages>{ data($consultadetasadecambiolcyResponse1/Status/messages) }</messages>
        			)
        		else(
        			<successIndicator>NO RECORDS</successIndicator>,
        			<messages>{ data($consultadetasadecambiolcyResponse1/WSLCYEXCHRATEType[1]/ZERORECORDS) } </messages>
        		)
        	}
        </ns1:ResponseHeader>
};

declare variable $consultadetasadecambiolcyResponse1 as element(ns0:ConsultadetasadecambiolcyResponse) external;

xf:consultaTasaCambioHeaderOut($consultadetasadecambiolcyResponse1)
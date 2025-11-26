(:: pragma bea:global-element-parameter parameter="$consultadetasadecambiofcyResponse" element="ns0:ConsultadetasadecambiofcyResponse" location="../Resources/XMLSchema_1632682327.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/Core/consultaTasaCambio/consultaTasaCambioExtranjeraHeaderOut/";

declare function xf:consultaTasaCambioExtranjeraHeaderOut($source as xs:string,
    $target as xs:string,
    $consultadetasadecambiofcyResponse as element(ns0:ConsultadetasadecambiofcyResponse))
    as element(ns1:ResponseHeader) {
        <ns1:ResponseHeader>
        	{
        		if(empty($consultadetasadecambiofcyResponse/WSFCYEXCHRATEType[1]/ZERORECORDS/text())) then(
        			let $availables := fn:tokenize($consultadetasadecambiofcyResponse/WSFCYEXCHRATEType[1]/gWSFCYEXCHRATEDetailType/mWSFCYEXCHRATEDetailType[1]/CURRENCY, "\|\|")
        			return
						if( ($source = "USD" and $target = "USD") or 
							($source = "USD" and $target = ($availables)) or
							($target = "USD" and $source = ($availables)) ) then (
							<successIndicator>{ data($consultadetasadecambiofcyResponse/Status/successIndicator) }</successIndicator>,
	        				<messages>{ data($consultadetasadecambiofcyResponse/Status/messages) }</messages>
						)else(
							<successIndicator>NO RECORDS</successIndicator>,
	        				<messages>0 records returned</messages>
						)
        		) else(
        			<successIndicator>NO RECORDS</successIndicator>,
        			<messages>{ data($consultadetasadecambiofcyResponse/WSFCYEXCHRATEType[1]/ZERORECORDS) } </messages>
        		)
        	}
        </ns1:ResponseHeader>
};

declare variable $source as xs:string external;
declare variable $target as xs:string external;
declare variable $consultadetasadecambiofcyResponse as element(ns0:ConsultadetasadecambiofcyResponse) external;

xf:consultaTasaCambioExtranjeraHeaderOut($source,
    $target,
    $consultadetasadecambiofcyResponse)
(:: pragma bea:global-element-parameter parameter="$consultadeventanillaResponse" element="ns0:ConsultadeventanillaResponse" location="../Resources/XMLSchema_1632682327.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/Core/consultaVentanilla/consultaVentanillaHeaderOut/";

declare function xf:consultaVentanillaHeaderOut($consultadeventanillaResponse as element(ns0:ConsultadeventanillaResponse))
    as element(ns1:ResponseHeader) {
        <ns1:ResponseHeader>
        	{
        		if(empty($consultadeventanillaResponse/WSTELLERIDENQType[1]/ZERORECORDS/text())) then(
        			<successIndicator>{ data($consultadeventanillaResponse/Status/successIndicator) }</successIndicator>,
        			<messages>{ data($consultadeventanillaResponse/Status/messages) }</messages>
        			)
        		else(
        			<successIndicator>NO RECORDS</successIndicator>,
        			<messages>{ data($consultadeventanillaResponse/WSTELLERIDENQType[1]/ZERORECORDS) } </messages>
        		)
        	}	
        </ns1:ResponseHeader>
};

declare variable $consultadeventanillaResponse as element(ns0:ConsultadeventanillaResponse) external;

xf:consultaVentanillaHeaderOut($consultadeventanillaResponse)
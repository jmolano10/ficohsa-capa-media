(:: pragma bea:global-element-parameter parameter="$consultademunicipiosResponse" element="ns0:ConsultademunicipiosResponse" location="../../../../Business_Resources/direcciones/Resources/XMLSchema_1123420404.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaMunicipios/xq/consultaMunicipiosHeaderOut/";

declare function xf:consultaMunicipiosHeaderOut($consultademunicipiosResponse as element(ns0:ConsultademunicipiosResponse))
    as element(ns1:ResponseHeader) {
        <ns1:ResponseHeader>
			{
            	if (empty($consultademunicipiosResponse/WSCITYLISTType[1]/ZERORECORDS/text())) then (
            		<successIndicator>{ data($consultademunicipiosResponse/Status/successIndicator) }</successIndicator>,
            		<messages>{ data($consultademunicipiosResponse/Status/messages) }</messages>
            	) else (
            		<successIndicator>NO RECORDS</successIndicator>,
            		<messages>{ data($consultademunicipiosResponse/WSCITYLISTType[1]/ZERORECORDS) }</messages>
            	)
            }
        </ns1:ResponseHeader>
};

declare variable $consultademunicipiosResponse as element(ns0:ConsultademunicipiosResponse) external;

xf:consultaMunicipiosHeaderOut($consultademunicipiosResponse)
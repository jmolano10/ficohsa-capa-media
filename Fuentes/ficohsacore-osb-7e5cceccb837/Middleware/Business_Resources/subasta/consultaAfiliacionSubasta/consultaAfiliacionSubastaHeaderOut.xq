(:: pragma bea:global-element-parameter parameter="$consultaafiliacionsubastaResponse" element="ns0:ConsultaafiliacionsubastaResponse" location="../Resources/XMLSchema_-1390898219.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/consultaSubasta/consultaAfiliacionSubasta/consultaAfiliacionSubastaHeaderOut/";

declare function xf:consultaAfiliacionSubastaHeaderOut($consultaafiliacionsubastaResponse as element(ns0:ConsultaafiliacionsubastaResponse))
    as element(ns1:ResponseHeader) {
        <ns1:ResponseHeader>
			{
            	if (empty($consultaafiliacionsubastaResponse/WSFICOEAUCAFFVIEWType[1]/ZERORECORDS/text())) then (
            		<successIndicator>{ data($consultaafiliacionsubastaResponse/Status/successIndicator) }</successIndicator>,
            		<messages>{ data($consultaafiliacionsubastaResponse/Status/messages) }</messages>
            	) else (
            		<successIndicator>NO RECORDS</successIndicator>,
            		<messages>{ data($consultaafiliacionsubastaResponse/WSFICOEAUCAFFVIEWType[1]/ZERORECORDS) }</messages>
            	)
            }
        </ns1:ResponseHeader>
};

declare variable $consultaafiliacionsubastaResponse as element(ns0:ConsultaafiliacionsubastaResponse) external;

xf:consultaAfiliacionSubastaHeaderOut($consultaafiliacionsubastaResponse)
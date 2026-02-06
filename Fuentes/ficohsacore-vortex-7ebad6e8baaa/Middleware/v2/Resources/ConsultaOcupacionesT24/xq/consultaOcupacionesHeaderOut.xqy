xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$getCustomerOccupationsResponse" element="ns0:getCustomerOccupationsResponse" location="../../../BusinessServices/ConsultaOcupacionesT24/services_1.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaOcupacionesT24/xq/consultaOcupacionesHeaderOut/";

declare function xf:consultaOcupacionesHeaderOut($getCustomerOccupationsResponse as element(ns0:getCustomerOccupationsResponse))
    as element(ns1:ResponseHeader) {
        <ns1:ResponseHeader>
            {
            	if (empty($getCustomerOccupationsResponse/FICOENQOCCUPATIONSType[1]/ZERORECORDS/text())) then (
            		<successIndicator>{ data($getCustomerOccupationsResponse/Status/successIndicator) }</successIndicator>,
            		<messages>{ data($getCustomerOccupationsResponse/Status/messages) }</messages>
            	) else (
            		<successIndicator>NO RECORDS</successIndicator>,
            		<messages>{ data($getCustomerOccupationsResponse/FICOENQOCCUPATIONSType[1]/ZERORECORDS) }</messages>
            	)
            }
        </ns1:ResponseHeader>
};

declare variable $getCustomerOccupationsResponse as element(ns0:getCustomerOccupationsResponse) external;

xf:consultaOcupacionesHeaderOut($getCustomerOccupationsResponse)
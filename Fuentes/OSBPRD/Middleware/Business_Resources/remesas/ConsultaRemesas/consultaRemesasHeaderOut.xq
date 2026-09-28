(:: pragma bea:global-element-parameter parameter="$consultaderemesaResponse" element="ns0:ConsultaderemesaResponse" location="../Resoruces/XMLSchema_-1855765488.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/remesas/ConsultaRemesas/consultaRemesasHeaderOut/";

declare function xf:consultaRemesasHeaderOut($consultaderemesaResponse as element(ns0:ConsultaderemesaResponse))
    as element(ns1:ResponseHeader) {
        <ns1:ResponseHeader>
            {
            	if (empty($consultaderemesaResponse/WSLATAMAGREMITTANCEINFOType[1]/ZERORECORDS/text())) then (
            		<successIndicator>{ data($consultaderemesaResponse/Status/successIndicator) }</successIndicator>,
            		<messages>{ data($consultaderemesaResponse/Status/messages) }</messages>
            	) else (
            		<successIndicator>NO RECORDS</successIndicator>,
            		<messages>{ data($consultaderemesaResponse/WSLATAMAGREMITTANCEINFOType[1]/ZERORECORDS) }</messages>
            	)
            }
        </ns1:ResponseHeader>
};

declare variable $consultaderemesaResponse as element(ns0:ConsultaderemesaResponse) external;

xf:consultaRemesasHeaderOut($consultaderemesaResponse)
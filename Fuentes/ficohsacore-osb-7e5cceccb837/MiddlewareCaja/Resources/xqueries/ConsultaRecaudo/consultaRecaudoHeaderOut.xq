(:: pragma bea:global-element-parameter parameter="$consultadedetallederecaudoResponse" element="ns0:ConsultadedetallederecaudoResponse" location="../../xsds/Recaudos/XMLSchema_-1599652964.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../xsds/General/Autenticacion.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/recaudos/consultaRecaudo/consultaRecaudoHeaderOut/";

declare function xf:consultaRecaudoHeaderOut($consultadedetallederecaudoResponse as element(ns0:ConsultadedetallederecaudoResponse))
    as element(ns1:ResponseHeader) {
        <ns1:ResponseHeader>
            {
            	if (empty($consultadedetallederecaudoResponse/LATAMAGWSPENDINGBILLSType[1]/ZERORECORDS/text())) then (
            		if ($consultadedetallederecaudoResponse/Status/successIndicator/text() != "Success") then (
            			<successIndicator>{ data($consultadedetallederecaudoResponse/Status/successIndicator) }</successIndicator>,
            			<messages>{ data($consultadedetallederecaudoResponse/Status/messages[position()=last()]) }</messages>
            		) else (
            			<successIndicator>{ data($consultadedetallederecaudoResponse/Status/successIndicator) }</successIndicator>,
            			<messages>{ data($consultadedetallederecaudoResponse/Status/messages) }</messages>
            		)
            	) else (
            		<successIndicator>NO RECORDS</successIndicator>,
            		<messages>{ data($consultadedetallederecaudoResponse/LATAMAGWSPENDINGBILLSType[1]/ZERORECORDS) }</messages>
            	)
            }
        </ns1:ResponseHeader>
};

declare variable $consultadedetallederecaudoResponse as element(ns0:ConsultadedetallederecaudoResponse) external;

xf:consultaRecaudoHeaderOut($consultadedetallederecaudoResponse)
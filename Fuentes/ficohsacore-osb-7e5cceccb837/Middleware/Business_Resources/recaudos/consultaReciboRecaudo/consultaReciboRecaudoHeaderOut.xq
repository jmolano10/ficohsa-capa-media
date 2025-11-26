(:: pragma bea:global-element-parameter parameter="$consultadereciboderecaudoResponse" element="ns0:ConsultadereciboderecaudoResponse" location="../Resources/XMLSchema_-1599652964.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/recaudos/consultaReciboRecaudo/consultaReciboRecaudoHeaderOut/";

declare function xf:consultaReciboRecaudoHeaderOut($consultadereciboderecaudoResponse as element(ns0:ConsultadereciboderecaudoResponse))
    as element(ns1:ResponseHeader) {
        <ns1:ResponseHeader>
            {
            	if (empty($consultadereciboderecaudoResponse/LATAMAGEDSLIPREPRINTWEBType[1]/ZERORECORDS/text())) then (
            		<successIndicator>{ data($consultadereciboderecaudoResponse/Status/successIndicator) }</successIndicator>,
            		<messages>{ data($consultadereciboderecaudoResponse/Status/messages) }</messages>
            	) else (
            		<successIndicator>NO RECORDS</successIndicator>,
            		<messages>{ data($consultadereciboderecaudoResponse/LATAMAGEDSLIPREPRINTWEBType[1]/ZERORECORDS) }</messages>
            	)
            }
        </ns1:ResponseHeader>
};

declare variable $consultadereciboderecaudoResponse as element(ns0:ConsultadereciboderecaudoResponse) external;

xf:consultaReciboRecaudoHeaderOut($consultadereciboderecaudoResponse)
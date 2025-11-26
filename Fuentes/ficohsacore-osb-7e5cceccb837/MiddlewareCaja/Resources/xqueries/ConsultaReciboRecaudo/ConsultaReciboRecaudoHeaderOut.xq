xquery version "1.0" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$consultadereciboderecaudoResponse" element="ns0:ConsultadereciboderecaudoResponse" location="../../xsds/Recaudos/XMLSchema_-1599652964.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../xsds/General/Autenticacion.xsd" ::)

declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/ConsultaReciboRecaudo/ConsultaReciboRecaudoHeaderOut/";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "T24WebServicesImpl";

declare function xf:ConsultaReciboRecaudoHeaderOut($consultadereciboderecaudoResponse as element(ns0:ConsultadereciboderecaudoResponse))
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

xf:ConsultaReciboRecaudoHeaderOut($consultadereciboderecaudoResponse)
xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultadeimagenesResponse" element="ns0:ConsultadeimagenesResponse" location="../Resources/XMLSchema_1601969511.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/consultasImagen/ConsultaImagenFirmas/consultaImagenFirmasHeaderOut/";

declare function xf:consultaImagenFirmasHeaderOut($consultadeimagenesResponse as element(ns0:ConsultadeimagenesResponse))
    as element(ns1:ResponseHeader) {
        <ns1:ResponseHeader>
			{
            	if (empty($consultadeimagenesResponse/WSFICOIMAGEVIEWDESCType[1]/ZERORECORDS/text())) then (
            		<successIndicator>{ data($consultadeimagenesResponse/Status/successIndicator) }</successIndicator>,
            		<messages>{ data($consultadeimagenesResponse/Status/messages) }</messages>
            	) else (
            		<successIndicator>NO RECORDS</successIndicator>,
            		<messages>{ data($consultadeimagenesResponse/WSFICOIMAGEVIEWDESCType[1]/ZERORECORDS) }</messages>
            	)
            }
        </ns1:ResponseHeader>
};

declare variable $consultadeimagenesResponse as element(ns0:ConsultadeimagenesResponse) external;

xf:consultaImagenFirmasHeaderOut($consultadeimagenesResponse)
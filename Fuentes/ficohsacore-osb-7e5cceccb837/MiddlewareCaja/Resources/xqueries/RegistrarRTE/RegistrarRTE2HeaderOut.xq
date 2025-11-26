(:: pragma bea:global-element-parameter parameter="$consultadedetalleRTEResponse" element="ns0:ConsultadedetalleRTEResponse" location="../../xsds/RegistroRTE/XMLSchema_-102414330.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../xsds/General/Autenticacion.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/RegistrarRTE/RegistrarRTE2HeaderOut/";

declare function xf:RegistrarRTE2HeaderOut($consultadedetalleRTEResponse as element(ns0:ConsultadedetalleRTEResponse))
    as element(ns1:ResponseHeader) {
        <ns1:ResponseHeader>
            {
                for $transactionId in $consultadedetalleRTEResponse/Status/transactionId
                return
                    <transactionId>{ data($transactionId) }</transactionId>
            }
            {
            	if (empty($consultadedetalleRTEResponse/WSFICORTEENQType[1]/ZERORECORDS/text())) then (
            		<successIndicator>{ data($consultadedetalleRTEResponse/Status/successIndicator) }</successIndicator>,
            		<messages>{ data($consultadedetalleRTEResponse/Status/messages) }</messages>
            	) else (
            		<successIndicator>NO RECORDS</successIndicator>,
            		<messages>{ data($consultadedetalleRTEResponse/WSFICORTEENQType[1]/ZERORECORDS) }</messages>
            	)
            } 
        </ns1:ResponseHeader>
};

declare variable $consultadedetalleRTEResponse as element(ns0:ConsultadedetalleRTEResponse) external;

xf:RegistrarRTE2HeaderOut($consultadedetalleRTEResponse)
xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$outstandingAuthorizationInquiryResponse" element="ns0:OutstandingAuthorizationInquiryResponse" location="../../../BusinessServices/VisionPlusHN/visionPlus/xsd/XMLSchema_769155616.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "http://www.procesa.com/fdcs";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaMovimientosFlotantesTC/xq/consultaMovimientosFlotantesTCHeader/";

declare function xf:consultaMovimientosFlotantesTCHeader($outstandingAuthorizationInquiryResponse as element(ns0:OutstandingAuthorizationInquiryResponse))
    as element(ns1:ResponseHeader) {
        <ns1:ResponseHeader>
        {
        	if (fn:data($outstandingAuthorizationInquiryResponse/ServiceReturnCode) = "P") then (
            	<successIndicator>SUCCESS</successIndicator>,
        		<messageId></messageId>,
    			<messages></messages>
            )
            else
            (
            	<successIndicator>ERROR</successIndicator>,
        		<messageId>{ data($outstandingAuthorizationInquiryResponse/ns0:ReturnCodes/RC/Code)}</messageId>,
        		<messages>{data($outstandingAuthorizationInquiryResponse/ns0:ReturnCodes/RC/Desc)}</messages>
            )
         }
        </ns1:ResponseHeader>
};

declare variable $outstandingAuthorizationInquiryResponse as element(ns0:OutstandingAuthorizationInquiryResponse) external;

xf:consultaMovimientosFlotantesTCHeader($outstandingAuthorizationInquiryResponse)
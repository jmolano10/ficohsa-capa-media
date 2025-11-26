(:: pragma bea:global-element-parameter parameter="$consultaderubrocmpvtadivisasResponse1" element="ns0:ConsultaderubrocmpvtadivisasResponse" location="../Resources/XMLSchema_-1176801753.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/consultaRubro/ConsultaRubro/consultaRubroHeaderOut/";

declare function xf:consultaRubroHeaderOut($consultaderubrocmpvtadivisasResponse1 as element(ns0:ConsultaderubrocmpvtadivisasResponse))
    as element(ns1:ResponseHeader) {
        <ns1:ResponseHeader>
         {
         	if(empty($consultaderubrocmpvtadivisasResponse1/WSBUYSELLCATEGORYType[1]/ZERORECORDS/text())) then (
         		<successIndicator>{ data($consultaderubrocmpvtadivisasResponse1/Status/successIndicator) }</successIndicator>,
         		<messages>{data($consultaderubrocmpvtadivisasResponse1/Status/messages)}</messages>
         	)
         	else(
         		<successIndicator>NO RECORDS</successIndicator>,
         		<messages>{data($consultaderubrocmpvtadivisasResponse1/WSBUYSELLCATEGORYType[1]/ZERORECORDS)}</messages>
         	)
         }
        </ns1:ResponseHeader>
};

declare variable $consultaderubrocmpvtadivisasResponse1 as element(ns0:ConsultaderubrocmpvtadivisasResponse) external;

xf:consultaRubroHeaderOut($consultaderubrocmpvtadivisasResponse1)
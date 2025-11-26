(:: pragma bea:global-element-parameter parameter="$consultaadjudicacionsubastaResponse" element="ns0:ConsultaadjudicacionsubastaResponse" location="../Resources/XMLSchema_-1390898219.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/consultaSubasta/consultaAdjudicacionSubasta/consultaAdjudicacionSubastaHeaderOut/";

declare function xf:consultaAdjudicacionSubastaHeaderOut($consultaadjudicacionsubastaResponse as element(ns0:ConsultaadjudicacionsubastaResponse))
    as element(ns1:ResponseHeader) {
        <ns1:ResponseHeader>
            {
            	if (empty($consultaadjudicacionsubastaResponse/WSFICOPAPENQAAUCType[1]/ZERORECORDS/text())) then (
            		<successIndicator>{ data($consultaadjudicacionsubastaResponse/Status/successIndicator) }</successIndicator>,
            		<messages>{ data($consultaadjudicacionsubastaResponse/Status/messages) }</messages>
            	) else (
            		<successIndicator>NO RECORDS</successIndicator>,
            		<messages>{ data($consultaadjudicacionsubastaResponse/WSFICOPAPENQAAUCType[1]/ZERORECORDS) }</messages>
            	)
            }
        </ns1:ResponseHeader>
};

declare variable $consultaadjudicacionsubastaResponse as element(ns0:ConsultaadjudicacionsubastaResponse) external;

xf:consultaAdjudicacionSubastaHeaderOut($consultaadjudicacionsubastaResponse)
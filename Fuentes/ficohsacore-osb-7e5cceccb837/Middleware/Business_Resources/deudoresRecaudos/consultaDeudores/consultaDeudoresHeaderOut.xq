(:: pragma bea:global-element-parameter parameter="$consultadedeudoresResponse" element="ns0:ConsultadedeudoresResponse" location="../Resources/XMLSchema_-2146193603.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/deudoresRecaudos/consultaDeudores/consultaDeudoresHeaderOut/";

declare function xf:consultaDeudoresHeaderOut($consultadedeudoresResponse as element(ns0:ConsultadedeudoresResponse))
    as element(ns1:ResponseHeader) {
        <ns1:ResponseHeader>
            {
            	if (empty($consultadedeudoresResponse/WSDEBTORLISTType[1]/ZERORECORDS/text())) then (
            		<successIndicator>{ data($consultadedeudoresResponse/Status/successIndicator) }</successIndicator>,
            		<messages>{ data($consultadedeudoresResponse/Status/messages) }</messages>
            	) else (
            		<successIndicator>NO RECORDS</successIndicator>,
            		<messages>{ data($consultadedeudoresResponse/WSDEBTORLISTType[1]/ZERORECORDS) }</messages>
            	)
            }
        </ns1:ResponseHeader>
};

declare variable $consultadedeudoresResponse as element(ns0:ConsultadedeudoresResponse) external;

xf:consultaDeudoresHeaderOut($consultadedeudoresResponse)
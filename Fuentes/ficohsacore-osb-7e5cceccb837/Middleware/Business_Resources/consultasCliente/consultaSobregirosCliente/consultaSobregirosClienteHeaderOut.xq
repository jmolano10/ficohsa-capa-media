(:: pragma bea:global-element-parameter parameter="$consultadesobregirosporclienteResponse" element="ns0:ConsultadesobregirosporclienteResponse" location="../Resources/XMLSchema_1144838292.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/consultasCliente/consultaSobregirosCliente/consultaSobregirosClienteHeaderOut/";

declare function xf:consultaSobregirosClienteHeaderOut($consultadesobregirosporclienteResponse as element(ns0:ConsultadesobregirosporclienteResponse))
    as element(ns1:ResponseHeader) {
        <ns1:ResponseHeader>
			{
            	if (empty($consultadesobregirosporclienteResponse/WSOVERDRAFTLIMITType[1]/ZERORECORDS/text())) then (
            		<successIndicator>{ data($consultadesobregirosporclienteResponse/Status/successIndicator) }</successIndicator>,
            		<messages>{ data($consultadesobregirosporclienteResponse/Status/messages) }</messages>
            	) else (
            		<successIndicator>NO RECORDS</successIndicator>,
            		<messages>{ data($consultadesobregirosporclienteResponse/WSOVERDRAFTLIMITType[1]/ZERORECORDS) }</messages>
            	)
            }
        </ns1:ResponseHeader>
};

declare variable $consultadesobregirosporclienteResponse as element(ns0:ConsultadesobregirosporclienteResponse) external;

xf:consultaSobregirosClienteHeaderOut($consultadesobregirosporclienteResponse)
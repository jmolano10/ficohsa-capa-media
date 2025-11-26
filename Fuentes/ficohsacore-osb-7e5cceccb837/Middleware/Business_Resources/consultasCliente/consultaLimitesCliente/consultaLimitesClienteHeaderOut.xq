(:: pragma bea:global-element-parameter parameter="$consultadelimitesporclienteResponse" element="ns0:ConsultadelimitesporclienteResponse" location="../Resources/XMLSchema_1144838292.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/consultasCliente/consultaLimitesCliente/consultaLimitesClienteHeaderOut/";

declare function xf:consultaLimitesClienteHeaderOut($consultadelimitesporclienteResponse as element(ns0:ConsultadelimitesporclienteResponse))
    as element(ns1:ResponseHeader) {
        <ns1:ResponseHeader>
			{
            	if (empty($consultadelimitesporclienteResponse/WSFICOLIMITSUMMARYType[1]/ZERORECORDS/text())) then (
            		<successIndicator>{ data($consultadelimitesporclienteResponse/Status/successIndicator) }</successIndicator>,
            		<messages>{ data($consultadelimitesporclienteResponse/Status/messages) }</messages>
            	) else (
            		<successIndicator>NO RECORDS</successIndicator>,
            		<messages>{ data($consultadelimitesporclienteResponse/WSFICOLIMITSUMMARYType[1]/ZERORECORDS) }</messages>
            	)
            }
        </ns1:ResponseHeader>
};

declare variable $consultadelimitesporclienteResponse as element(ns0:ConsultadelimitesporclienteResponse) external;

xf:consultaLimitesClienteHeaderOut($consultadelimitesporclienteResponse)
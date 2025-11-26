(:: pragma bea:global-element-parameter parameter="$referenciasporclienteResponse" element="ns0:ReferenciasporclienteResponse" location="../Resources/XMLSchema_1144838292.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/consultasCliente/consultaReferenciasCliente/consultaReferenciasClienteHeaderOut/";

declare function xf:consultaReferenciasClienteHeaderOut($referenciasporclienteResponse as element(ns0:ReferenciasporclienteResponse))
    as element(ns1:ResponseHeader) {
        <ns1:ResponseHeader>
			{
            	if (empty($referenciasporclienteResponse/WSCUSTOMERREFSType[1]/ZERORECORDS/text())) then (
            		<successIndicator>{ data($referenciasporclienteResponse/Status/successIndicator) }</successIndicator>,
            		<messages>{ data($referenciasporclienteResponse/Status/messages) }</messages>
            	) else (
            		<successIndicator>NO RECORDS</successIndicator>,
            		<messages>{ data($referenciasporclienteResponse/WSCUSTOMERREFSType[1]/ZERORECORDS) }</messages>
            	)
            }
        </ns1:ResponseHeader>
};

declare variable $referenciasporclienteResponse as element(ns0:ReferenciasporclienteResponse) external;

xf:consultaReferenciasClienteHeaderOut($referenciasporclienteResponse)
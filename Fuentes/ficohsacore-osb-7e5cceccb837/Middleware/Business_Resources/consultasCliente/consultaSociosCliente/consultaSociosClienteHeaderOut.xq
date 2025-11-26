(:: pragma bea:global-element-parameter parameter="$consultadesociosporclienteResponse" element="ns0:ConsultadesociosporclienteResponse" location="../Resources/XMLSchema_1144838292.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/consultasCliente/consultaSociosCliente/consultaSociosClienteHeaderOut/";

declare function xf:consultaSociosClienteHeaderOut($consultadesociosporclienteResponse as element(ns0:ConsultadesociosporclienteResponse))
    as element(ns1:ResponseHeader) {
        <ns1:ResponseHeader>
			{
            	if (empty($consultadesociosporclienteResponse/WSCUSTOMERBASSOCType[1]/ZERORECORDS/text())) then (
            		<successIndicator>{ data($consultadesociosporclienteResponse/Status/successIndicator) }</successIndicator>,
            		<messages>{ data($consultadesociosporclienteResponse/Status/messages) }</messages>
            	) else (
            		<successIndicator>NO RECORDS</successIndicator>,
            		<messages>{ data($consultadesociosporclienteResponse/WSCUSTOMERBASSOCType[1]/ZERORECORDS) }</messages>
            	)
            }
        </ns1:ResponseHeader>
};

declare variable $consultadesociosporclienteResponse as element(ns0:ConsultadesociosporclienteResponse) external;

xf:consultaSociosClienteHeaderOut($consultadesociosporclienteResponse)
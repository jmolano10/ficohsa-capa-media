xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultadeclienteResponse" element="ns1:ConsultadeclienteResponse" location="../../../../Business_Resources/consultasCliente/Resources/XMLSchema_1144838292.xsd" ::)
(:: pragma bea:global-element-return element="ns0:ResponseHeader" location="../../../../v2/Resources/esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/v3/Resources/ConsultaCliente/xq/consultaClienteHeaderOut/";

declare function xf:consultaClienteHeaderOut($consultadeclienteResponse as element(ns1:ConsultadeclienteResponse))
    as element(ns0:ResponseHeader) {
        <ns0:ResponseHeader>
            {
                for $transactionId in $consultadeclienteResponse/Status/transactionId
                return
                    <transactionId>{ data($transactionId) }</transactionId>
            }
            {
            	if (empty($consultadeclienteResponse/WSCUSTOMERType[1]/ZERORECORDS/text())) then (
            		<successIndicator>{ data($consultadeclienteResponse/Status/successIndicator) }</successIndicator>,
					<messages>{ data($consultadeclienteResponse/Status/messages) }</messages>
            	) else (
            		<successIndicator>NO RECORDS</successIndicator>,
            		<messages>{ data($consultadeclienteResponse/WSCUSTOMERType[1]/ZERORECORDS) }</messages>
            	)
            }
        </ns0:ResponseHeader>
};

declare variable $consultadeclienteResponse as element(ns1:ConsultadeclienteResponse) external;

xf:consultaClienteHeaderOut($consultadeclienteResponse)
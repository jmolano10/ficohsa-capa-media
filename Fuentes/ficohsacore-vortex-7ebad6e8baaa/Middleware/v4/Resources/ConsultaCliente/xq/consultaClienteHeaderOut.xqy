xquery version "2004-draft" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$consultaClientev4Response" element="ns1:ConsultaClientev4Response" location="../../../BusinessServices/T24/svcConsultaCliente_v4/xsd/svcConsultaCliente_v4Types.xsd" ::)
(:: pragma bea:global-element-return element="ns0:ResponseHeader" location="../../../../v2/Resources/esquemas_generales/HeaderElements.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v4/Resources/ConsultaCliente/xq/consultaClienteHeaderHout/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "T24WebServicesImpl";

declare function xf:consultaClienteHeaderHout($consultaClientev4Response as element(ns1:ConsultaClientev4Response))
    as element(ns0:ResponseHeader) {
        <ns0:ResponseHeader>
           	{
                for $transactionId in $consultaClientev4Response/Status/transactionId
                return
                    <transactionId>{ data($transactionId) }</transactionId>
            }
            {
            	if (empty($consultaClientev4Response/WSV4CUSTOMERType[1]/ZERORECORDS/text())) then (
            		<successIndicator>{ data($consultaClientev4Response/Status/successIndicator) }</successIndicator>,
					<messages>{ data($consultaClientev4Response/Status/messages) }</messages>
            	) else (
            		<successIndicator>NO RECORDS</successIndicator>,
            		<messages>{ data($consultaClientev4Response/WSV4CUSTOMERType[1]/ZERORECORDS) }</messages>
            	)
            }         
        </ns0:ResponseHeader>
};

declare variable $consultaClientev4Response as element(ns1:ConsultaClientev4Response) external;

xf:consultaClienteHeaderHout($consultaClientev4Response)
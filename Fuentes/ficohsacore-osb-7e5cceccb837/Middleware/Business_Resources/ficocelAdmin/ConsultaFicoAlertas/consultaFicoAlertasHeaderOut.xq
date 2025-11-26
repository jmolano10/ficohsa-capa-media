(:: pragma bea:global-element-parameter parameter="$consultadeFicoAlertasResponse" element="ns0:ConsultadeFicoAlertasResponse" location="../Resources/XMLSchema_1876963756.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/ficocelAdmin/ConsultaFicoAlertas/consultaFicoAlertasHeaderOut/";

declare function xf:consultaFicoAlertasHeaderOut($consultadeFicoAlertasResponse as element(ns0:ConsultadeFicoAlertasResponse))
    as element(ns1:ResponseHeader) {
        <ns1:ResponseHeader>
			{
            	if (empty($consultadeFicoAlertasResponse/WSALERTLISTType[1]/ZERORECORDS/text())) then (
            		<successIndicator>{ data($consultadeFicoAlertasResponse/Status/successIndicator) }</successIndicator>,
            		<messages>{ data($consultadeFicoAlertasResponse/Status/messages) }</messages>
            	) else (
            		<successIndicator>NO RECORDS</successIndicator>,
            		<messages>{ data($consultadeFicoAlertasResponse/WSALERTLISTType[1]/ZERORECORDS) }</messages>
            	)
            }
        </ns1:ResponseHeader>
};

declare variable $consultadeFicoAlertasResponse as element(ns0:ConsultadeFicoAlertasResponse) external;

xf:consultaFicoAlertasHeaderOut($consultadeFicoAlertasResponse)
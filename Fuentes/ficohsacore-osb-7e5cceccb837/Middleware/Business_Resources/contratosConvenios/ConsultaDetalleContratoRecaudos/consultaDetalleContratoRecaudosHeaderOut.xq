(:: pragma bea:global-element-parameter parameter="$consultadetallecontratorecaudoResponse" element="ns0:ConsultadetallecontratorecaudoResponse" location="../Resources/XMLSchema_266061745.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/contratosConvenios/ConsultaDetalleContratoRecaudos/consultaDetalleContratoRecaudosHeaderOut/";

declare function xf:consultaDetalleContratoRecaudosHeaderOut($consultadetallecontratorecaudoResponse as element(ns0:ConsultadetallecontratorecaudoResponse))
    as element(ns1:ResponseHeader) {
        <ns1:ResponseHeader>
            {
            	if (empty($consultadetallecontratorecaudoResponse/WSCOLLECTIONCONDSType[1]/ZERORECORDS/text())) then (
            		<successIndicator>{ data($consultadetallecontratorecaudoResponse/Status/successIndicator) }</successIndicator>,
            		<messages>{ data($consultadetallecontratorecaudoResponse/Status/messages) }</messages>
            	) else (
            		<successIndicator>NO RECORDS</successIndicator>,
            		<messages>{ data($consultadetallecontratorecaudoResponse/WSCOLLECTIONCONDSType[1]/ZERORECORDS) }</messages>
            	)
            }
        </ns1:ResponseHeader>
};

declare variable $consultadetallecontratorecaudoResponse as element(ns0:ConsultadetallecontratorecaudoResponse) external;

xf:consultaDetalleContratoRecaudosHeaderOut($consultadetallecontratorecaudoResponse)
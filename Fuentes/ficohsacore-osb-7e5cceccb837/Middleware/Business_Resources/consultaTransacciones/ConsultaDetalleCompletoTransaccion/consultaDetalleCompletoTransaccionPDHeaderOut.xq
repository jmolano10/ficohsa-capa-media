(:: pragma bea:global-element-parameter parameter="$consultadetransaccionPDResponse1" element="ns0:ConsultadetransaccionPDResponse" location="../Resources/XMLSchema_-1217682313.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/consultaTransacciones/ConsultaDetalleCompletoTransaccion/consultaDetalleCompletoTransaccionPDHeaderOut/";

declare function xf:consultaDetalleCompletoTransaccionPDHeaderOut($consultadetransaccionPDResponse1 as element(ns0:ConsultadetransaccionPDResponse))
    as element(ns1:ResponseHeader) {
        <ns1:ResponseHeader>
        {
           	if (empty($consultadetransaccionPDResponse1/FICOHNPDBALANCESVIRTUALType[1]/ZERORECORDS/text())) then (
           		<successIndicator>{ data($consultadetransaccionPDResponse1/Status/successIndicator) }</successIndicator>,
           		<messages>{ data($consultadetransaccionPDResponse1/Status/messages) }</messages>
           	) else (
           		<successIndicator>NO RECORDS</successIndicator>,
           		<messages>{ data($consultadetransaccionPDResponse1/FICOHNPDBALANCESVIRTUALType[1]/ZERORECORDS) }</messages>
           	)
        }            
        </ns1:ResponseHeader>
};

declare variable $consultadetransaccionPDResponse1 as element(ns0:ConsultadetransaccionPDResponse) external;

xf:consultaDetalleCompletoTransaccionPDHeaderOut($consultadetransaccionPDResponse1)
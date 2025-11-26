(:: pragma bea:global-element-parameter parameter="$consultaarchdeudoresporcontratoResponse" element="ns0:ConsultaarchdeudoresporcontratoResponse" location="../Resources/XMLSchema_-525487073.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/archivosConvenios/consultaDetalleArchivoDeudores/consultaDetalleArchivoDeudoresHeaderOut/";

declare function xf:consultaDetalleArchivoDeudoresHeaderOut($consultaarchdeudoresporcontratoResponse as element(ns0:ConsultaarchdeudoresporcontratoResponse))
    as element(ns1:ResponseHeader) {
        <ns1:ResponseHeader>
			{
				if (empty($consultaarchdeudoresporcontratoResponse/FICOHNAGFILESTATUSDEBAFFENQType[1]/ZERORECORDS/text())) then (
					<successIndicator>{ data($consultaarchdeudoresporcontratoResponse/Status/successIndicator) }</successIndicator>,
					<messages>{ data($consultaarchdeudoresporcontratoResponse/Status/messages) }</messages>
				) else (
					<successIndicator>NO RECORDS</successIndicator>,
					<messages>{ data($consultaarchdeudoresporcontratoResponse/FICOHNAGFILESTATUSDEBAFFENQType[1]/ZERORECORDS) }</messages>
				)
			}
        </ns1:ResponseHeader>
};

declare variable $consultaarchdeudoresporcontratoResponse as element(ns0:ConsultaarchdeudoresporcontratoResponse) external;

xf:consultaDetalleArchivoDeudoresHeaderOut($consultaarchdeudoresporcontratoResponse)
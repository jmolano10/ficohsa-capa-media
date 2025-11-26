(:: pragma bea:global-element-parameter parameter="$consultadetipodeIdentNaturalResponse1" element="ns0:ConsultadetipodeIdentNaturalResponse" location="../Resources/XMLSchema_-125070348.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/consultasTipoIdentidad/consultaTipoIdentidadNatural/ConsultaTipoIdentidadNaturalHeaderOut/";

declare function xf:ConsultaTipoIdentidadNaturalHeaderOut($consultadetipodeIdentNaturalResponse1 as element(ns0:ConsultadetipodeIdentNaturalResponse))
    as element(ns1:ResponseHeader) {
        <ns1:ResponseHeader>
            {
                for $successIndicator in $consultadetipodeIdentNaturalResponse1/Status/successIndicator
                return
                    if (fn:count($consultadetipodeIdentNaturalResponse1/WSFICOHINDIVIDUALLEGALDOCNAMEType/gWSFICOHINDIVIDUALLEGALDOCNAMEDetailType/mWSFICOHINDIVIDUALLEGALDOCNAMEDetailType) > 0
                    	or data($successIndicator) != "Success") then (
                    	<successIndicator>{ data($successIndicator) }</successIndicator>
                    ) else (
                    	<successIndicator>NO RECORDS</successIndicator>
                    )
            }
            {
                for $messages in $consultadetipodeIdentNaturalResponse1/Status/messages
                return
                    <messages>{ data($messages) }</messages>
            }
        </ns1:ResponseHeader>
};

declare variable $consultadetipodeIdentNaturalResponse1 as element(ns0:ConsultadetipodeIdentNaturalResponse) external;

xf:ConsultaTipoIdentidadNaturalHeaderOut($consultadetipodeIdentNaturalResponse1)
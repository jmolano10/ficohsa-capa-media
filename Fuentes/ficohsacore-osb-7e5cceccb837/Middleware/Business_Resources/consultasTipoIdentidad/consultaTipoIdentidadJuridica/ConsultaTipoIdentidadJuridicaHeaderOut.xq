(:: pragma bea:global-element-parameter parameter="$consultadetipodeIdentJuridicaResponse1" element="ns0:ConsultadetipodeIdentJuridicaResponse" location="../Resources/XMLSchema_-125070348.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/consultasTipoIdentidad/consultaTipoIdentidadJuridica/ConsultaTipoIdentidadJuridicaHeaderOut/";

declare function xf:ConsultaTipoIdentidadJuridicaHeaderOut($consultadetipodeIdentJuridicaResponse1 as element(ns0:ConsultadetipodeIdentJuridicaResponse))
    as element(ns1:ResponseHeader) {
        <ns1:ResponseHeader>
            {
                for $successIndicator in $consultadetipodeIdentJuridicaResponse1/Status/successIndicator
                return
                    if (fn:count($consultadetipodeIdentJuridicaResponse1/WSFICOHCORPORATELEGALDOCNAMEType/gWSFICOHCORPORATELEGALDOCNAMEDetailType/mWSFICOHCORPORATELEGALDOCNAMEDetailType) > 0
                    	or data($successIndicator) != "Success") then (
                    	<successIndicator>{ data($successIndicator) }</successIndicator>
                    ) else (
                    	<successIndicator>NO RECORDS</successIndicator>
                    )
            }
            {
                for $messages in $consultadetipodeIdentJuridicaResponse1/Status/messages
                return
                    <messages>{ data($messages) }</messages>
            }
        </ns1:ResponseHeader>
};

declare variable $consultadetipodeIdentJuridicaResponse1 as element(ns0:ConsultadetipodeIdentJuridicaResponse) external;

xf:ConsultaTipoIdentidadJuridicaHeaderOut($consultadetipodeIdentJuridicaResponse1)
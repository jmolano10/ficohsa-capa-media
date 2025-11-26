(:: pragma bea:global-element-parameter parameter="$consultadetipodeIdentJuridicaResponse" element="ns0:ConsultadetipodeIdentJuridicaResponse" location="../Resources/XMLSchema_-125070348.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultadetipodeIdentNaturalResponse" element="ns0:ConsultadetipodeIdentNaturalResponse" location="../Resources/XMLSchema_-125070348.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/consultasTipoIdentidad/consultaTipoIdentidadMixto/consultaTipoIdentidadMixtoHeaderOut/";

declare function xf:consultaTipoIdentidadMixtoHeaderOut($consultadetipodeIdentJuridicaResponse as element(ns0:ConsultadetipodeIdentJuridicaResponse),
    $consultadetipodeIdentNaturalResponse as element(ns0:ConsultadetipodeIdentNaturalResponse))
    as element(ns1:ResponseHeader) {
        <ns1:ResponseHeader>
            {
                if ( fn:string($consultadetipodeIdentJuridicaResponse/Status/successIndicator/text()) = "Success" or
                   	 fn:string($consultadetipodeIdentNaturalResponse/Status/successIndicator/text()) = "Success") then (
                	
                	<successIndicator>Success</successIndicator>
                ) else (
                	<successIndicator>ERROR</successIndicator>,
                	<messages>{ concat($consultadetipodeIdentJuridicaResponse/Status/messages, " ",
                						$consultadetipodeIdentNaturalResponse/Status/messages) }</messages>
                )
            }
        </ns1:ResponseHeader>
};

declare variable $consultadetipodeIdentJuridicaResponse as element(ns0:ConsultadetipodeIdentJuridicaResponse) external;
declare variable $consultadetipodeIdentNaturalResponse as element(ns0:ConsultadetipodeIdentNaturalResponse) external;

xf:consultaTipoIdentidadMixtoHeaderOut($consultadetipodeIdentJuridicaResponse,
    $consultadetipodeIdentNaturalResponse)
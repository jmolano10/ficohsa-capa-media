xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="http://www.ficohsa.com.hn/middleware.services/ingresaExpedienteTypes";
(:: import schema at "../../../../../../MWBanking/Documents/RequestorServices/XSD/cargarImagenBase64RedisTypes.xsd" ::)
declare namespace ns3="http://www.ficohsa.com/midleware.services/ExpedientesAPITypes";
(:: import schema at "../../../../../ProviderServices/v1.0/XSD/TotalImage/ExpedientesAPITypes.xsd" ::)

declare namespace ns1="http://www.ficohsa.com/midleware.services/saveDocumentIn";

declare variable $cargarImagenBase64RedisRequest as element() (:: schema-element(ns2:cargarImagenBase64RedisRequest) ::) external;

declare function ns1:saveDocumentIn($cargarImagenBase64RedisRequest as element() (:: schema-element(ns2:cargarImagenBase64RedisRequest) ::)) as element() (:: schema-element(ns3:loadImageBase64Request) ::) {
    <ns3:loadImageBase64Request>
        <ns3:imagenBase64>{fn:data($cargarImagenBase64RedisRequest/ns2:Base64Image)}</ns3:imagenBase64>
        <ns3:extension>{fn:data($cargarImagenBase64RedisRequest/ns2:Extension)}</ns3:extension>
        <ns3:imagenEscalaGris>{fn:data($cargarImagenBase64RedisRequest/ns2:GrayScaleImage)}</ns3:imagenEscalaGris>
    </ns3:loadImageBase64Request>
};

ns1:saveDocumentIn($cargarImagenBase64RedisRequest)
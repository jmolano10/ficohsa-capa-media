xquery version "2004-draft" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$cargarLotesResponse" element="ns0:cargarLotesResponse" location="../../../BusinessServices/MTR/cargadorArchivoLote/wsdl/cargadorArchivoLoteEndpoint.wsdl" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/PagosMasivosInterno/xq/pagosMasivosInternoPAHeaderOut/";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "http://servicio.cargararchivolotews.mtrpmsv.cidenet.com.co/";

declare function xf:pagosMasivosInternoPAHeaderOut($cargarLotesResponse as element(ns0:cargarLotesResponse))
    as element(ns1:ResponseHeader) {
        <ns1:ResponseHeader>
            {
                for $codigo in $cargarLotesResponse/respuestaHostToHost/cabeceraRespuesta/codigo
                return
                    <successIndicator>{ data($codigo) }</successIndicator>
            }
            {
                for $mensaje in $cargarLotesResponse/respuestaHostToHost/cabeceraRespuesta/mensaje
                return
                    <messages>{ data($mensaje) }</messages>
            }
        </ns1:ResponseHeader>
};

declare variable $cargarLotesResponse as element(ns0:cargarLotesResponse) external;

xf:pagosMasivosInternoPAHeaderOut($cargarLotesResponse)
(:: pragma bea:global-element-parameter parameter="$cargarLotesResponse" element="ns1:cargarLotesResponse" location="../../../BusinessServices/MTR/cargadorArchivoLote/wsdl/cargadorArchivoLoteEndpoint.wsdl" ::)
(:: pragma bea:global-element-return element="ns0:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://servicio.cargararchivolotews.mtrpmsv.cidenet.com.co/";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/CancelarLote/xq/pagosMasivosInternoNIHeaderOur/";

declare function xf:pagosMasivosInternoNIHeaderOur($cargarLotesResponse as element(ns1:cargarLotesResponse))
    as element(ns0:ResponseHeader) {
        <ns0:ResponseHeader>
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
        </ns0:ResponseHeader>
};

declare variable $cargarLotesResponse as element(ns1:cargarLotesResponse) external;

xf:pagosMasivosInternoNIHeaderOur($cargarLotesResponse)
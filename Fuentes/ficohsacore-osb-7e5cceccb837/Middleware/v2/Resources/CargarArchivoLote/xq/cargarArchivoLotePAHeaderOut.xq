xquery version "1.0" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$cargarArchivoLote" element="ns0:cargarArchivoLote" location="../../../BusinessServices/MTR/cargadorArchivoLote/wsdl/cargadorArchivoLoteEndpoint.wsdl" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/CargarArchivoLote/xq/cargarArchivoLotePAHeaderOut/";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "http://servicio.cargararchivolotews.mtrpmsv.cidenet.com.co/";

declare function xf:cargarArchivoLotePAHeaderOut($cargarArchivoLoteResponse as element(ns0:cargarArchivoLoteResponse))
    as element(ns1:ResponseHeader) {
        <ns1:ResponseHeader>
        {
                let $codigo := $cargarArchivoLoteResponse/respuestaCargaArchivoLote/cabeceraRespuesta/codigo
                let $mensaje := $cargarArchivoLoteResponse/respuestaCargaArchivoLote/cabeceraRespuesta/mensaje
                return
                	if(upper-case(string($codigo)) = 'SUCCESS') then(
                    	<successIndicator>Success</successIndicator>
                    ) else(
                    	<successIndicator>{ data($codigo) }</successIndicator>,
                    	<messages>{ data($mensaje) }</messages>
                    )
            }
        </ns1:ResponseHeader>
};

declare variable $cargarArchivoLoteResponse as element(ns0:cargarArchivoLoteResponse) external;

xf:cargarArchivoLotePAHeaderOut($cargarArchivoLoteResponse)
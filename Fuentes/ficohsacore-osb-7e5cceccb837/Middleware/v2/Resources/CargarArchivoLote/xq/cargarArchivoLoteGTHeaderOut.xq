xquery version "1.0" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$cargarArchivoLoteResponse" element="ns1:cargarArchivoLoteResponse" location="../../../BusinessServices/MTR/cargadorArchivoLote/wsdl/cargadorArchivoLoteEndpoint.wsdl" ::)
(:: pragma bea:global-element-return element="ns0:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/CargarArchivoLote/xq/cargarArchivoLoteGTHeaderOut/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://servicio.cargararchivolotews.mtrpmsv.cidenet.com.co/";

declare function xf:cargarArchivoLoteGTHeaderOut($cargarArchivoLoteResponse as element(ns1:cargarArchivoLoteResponse))
    as element(ns0:ResponseHeader) {
        <ns0:ResponseHeader>
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
        </ns0:ResponseHeader>
};

declare variable $cargarArchivoLoteResponse as element(ns1:cargarArchivoLoteResponse) external;

xf:cargarArchivoLoteGTHeaderOut($cargarArchivoLoteResponse)
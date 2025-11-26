(:: pragma bea:global-element-parameter parameter="$requestHeader" element="ns0:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$cargarArchivoLote" element="ns1:cargarArchivoLote" location="../../PagosMasivos/xsd/pagosMasivosTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns2:cargarArchivoLote" location="../../../BusinessServices/MTR/cargadorArchivoLote/wsdl/cargadorArchivoLoteEndpoint.wsdl" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns2 = "http://servicio.cargararchivolotews.mtrpmsv.cidenet.com.co/";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/pagosMasivosTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/CargarArchivoLote/xq/cargarArchivoLoteNIIn/";

declare function xf:cargarArchivoLoteNIIn($requestHeader as element(ns0:RequestHeader),
    $cargarArchivoLote as element(ns1:cargarArchivoLote))
    as element(ns2:cargarArchivoLote) {
        <ns2:cargarArchivoLote>
            <solicitudCargaArchivoLote>
                <idBancoOrigen>{ data($requestHeader/Region/SourceBank) }</idBancoOrigen>
                <idCliente>{ data($cargarArchivoLote/CUSTOMER_ID) }</idCliente>
                <idUsuario>{ data($cargarArchivoLote/USER_ID) }</idUsuario>
                <idTipoOperacion>{ data($cargarArchivoLote/TYPE) }</idTipoOperacion>
                <cifrado>
                 { 
	            	let $cifrado := data($cargarArchivoLote/ENCRYPTED_FILE)
	            	return 
	            		if ($cifrado = 'YES') then (
	            			'S'
	            		) else (
	            			'N'
	            		)
	            }
				</cifrado>
                <contenidoArchivo>{ data($cargarArchivoLote/FLAT_FILE) }</contenidoArchivo>
                <nombreArchivo>{ data($cargarArchivoLote/FILE_NAME) }</nombreArchivo>
                {
                    for $APPLICATION_DATE in $cargarArchivoLote/APPLICATION_DATE
                    return
                        <fechaAplicacion>{ data($APPLICATION_DATE) }</fechaAplicacion>
                }
            </solicitudCargaArchivoLote>
        </ns2:cargarArchivoLote>
};

declare variable $requestHeader as element(ns0:RequestHeader) external;
declare variable $cargarArchivoLote as element(ns1:cargarArchivoLote) external;

xf:cargarArchivoLoteNIIn($requestHeader,
    $cargarArchivoLote)
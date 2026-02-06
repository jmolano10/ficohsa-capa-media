xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$cargarArchivoLoteResponse" element="ns1:cargarArchivoLoteResponse" location="../../../BusinessServices/MTR/cargadorArchivoLote/wsdl/cargadorArchivoLoteEndpoint.wsdl" ::)
(:: pragma bea:global-element-return element="ns0:cargarArchivoLoteResponse" location="../../PagosMasivos/xsd/pagosMasivosTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/pagosMasivosTypes";
declare namespace ns1 = "http://servicio.cargararchivolotews.mtrpmsv.cidenet.com.co/";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/CargarArchivoLote/xq/cargarArchivoLoteNIOut/";

declare function xf:cargarArchivoLoteNIOut($cargarArchivoLoteResponse as element(ns1:cargarArchivoLoteResponse))
    as element(ns0:cargarArchivoLoteResponse) {
        <ns0:cargarArchivoLoteResponse>
            {
                for $idCliente in $cargarArchivoLoteResponse/respuestaCargaArchivoLote/detalleRespuesta/idCliente
                return
                    <CUSTOMER_ID>{ data($idCliente) }</CUSTOMER_ID>
            }
            {
            	for $idLote in $cargarArchivoLoteResponse/respuestaCargaArchivoLote/detalleRespuesta/idLote
                return
                    <BANK_BATCH_ID>{ data($idLote) }</BANK_BATCH_ID>
            }
            {
            	for $fecha in $cargarArchivoLoteResponse/respuestaCargaArchivoLote/detalleRespuesta/fecha
            	return
            	 	<UPLOAD_DATE>{ fn:adjust-date-to-timezone(fn-bea:date-from-dateTime(data($fecha)),())}</UPLOAD_DATE>
            }
            {
                for $monto in $cargarArchivoLoteResponse/respuestaCargaArchivoLote/detalleRespuesta/monto
                return
                    <TOTAL_AMOUNT>{ data($monto) }</TOTAL_AMOUNT>
            }
            {
                for $cantidadTransacciones in $cargarArchivoLoteResponse/respuestaCargaArchivoLote/detalleRespuesta/cantidadTransacciones
                return
                    <NUMBER_OF_TRANSACTIONS>{ data($cantidadTransacciones) }</NUMBER_OF_TRANSACTIONS>
            }
            {
                for $estado in $cargarArchivoLoteResponse/respuestaCargaArchivoLote/detalleRespuesta/estado
                return
                    <STATUS>{ data($estado) }</STATUS>
            }
            {
                for $transacciones in $cargarArchivoLoteResponse/respuestaCargaArchivoLote/detalleRespuesta/transacciones
                return
                    <TRX_STATUS>
                        {
                            for $transaccion in $transacciones/transaccion
                            return
                                <TRX>
                                    <ID>{ data($transaccion/id) }</ID>
                                    {
                                        for $mensajes in $transaccion/mensajes
                                        return
                                            <ERROR_MESSAGES>
                                                {
                                                    for $mensaje in $mensajes/mensaje
                                                    return
                                                        <MESSAGE>{ data($mensaje) }</MESSAGE>
                                                }
                                            </ERROR_MESSAGES>
                                    }
                                </TRX>
                        }
                    </TRX_STATUS>
            }
        </ns0:cargarArchivoLoteResponse>
};

declare variable $cargarArchivoLoteResponse as element(ns1:cargarArchivoLoteResponse) external;

xf:cargarArchivoLoteNIOut($cargarArchivoLoteResponse)
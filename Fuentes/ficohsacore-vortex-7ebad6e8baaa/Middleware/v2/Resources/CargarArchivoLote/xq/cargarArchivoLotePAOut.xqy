xquery version "2004-draft" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$cargarArchivoLoteResponse" element="ns0:cargarArchivoLoteResponse" location="../../../BusinessServices/MTR/cargadorArchivoLote/wsdl/cargadorArchivoLoteEndpoint.wsdl" ::)
(:: pragma bea:global-element-return element="ns1:cargarArchivoLoteResponse" location="../../PagosMasivos/xsd/pagosMasivosTypes.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/CargarArchivoLote/xq/cargarArchivoLotePAOut/";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/pagosMasivosTypes";
declare namespace ns0 = "http://servicio.cargararchivolotews.mtrpmsv.cidenet.com.co/";

declare function xf:cargarArchivoLotePAOut($cargarArchivoLoteResponse as element(ns0:cargarArchivoLoteResponse))
    as element(ns1:cargarArchivoLoteResponse) {
        <ns1:cargarArchivoLoteResponse>
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
        </ns1:cargarArchivoLoteResponse>
};

declare variable $cargarArchivoLoteResponse as element(ns0:cargarArchivoLoteResponse) external;

xf:cargarArchivoLotePAOut($cargarArchivoLoteResponse)
xquery version "2004-draft" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$cargarLotesResponse" element="ns0:cargarLotesResponse" location="../../../BusinessServices/MTR/cargadorArchivoLote/wsdl/cargadorArchivoLoteEndpoint.wsdl" ::)
(:: pragma bea:global-element-return element="ns1:pagosMasivosResponse" location="../../PagosMasivos/xsd/pagosMasivosTypes.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/PagosMasivosInterno/xq/pagosMasivosInternoPAOut/";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/pagosMasivosTypes";
declare namespace ns0 = "http://servicio.cargararchivolotews.mtrpmsv.cidenet.com.co/";

declare function xf:pagosMasivosInternoPAOut($cargarLotesResponse as element(ns0:cargarLotesResponse))
    as element(ns1:pagosMasivosResponse) {
        <ns1:pagosMasivosResponse>
        	{
                for $idGlobal in $cargarLotesResponse/respuestaHostToHost/detalleRespuesta/idGlobal
                return
                    <GLOBAL_ID>{ data($idGlobal) }</GLOBAL_ID>
            }
            {
                for $idCliente in $cargarLotesResponse/respuestaHostToHost/detalleRespuesta/idCliente
                return
                    <CUSTOMER_ID>{ data($idCliente) }</CUSTOMER_ID>
            }
            {
                for $lotes in $cargarLotesResponse/respuestaHostToHost/detalleRespuesta/lotes
                return
                    <BATCHES>
                        {
                            for $lote in $lotes/lote
                            return
                                <BATCH>
                                    {
                                        for $idLote in $lote/idLote
                                        return
                                            <BANK_BATCH_ID>{ data($idLote) }</BANK_BATCH_ID>
                                    }
                                    <CUSTOMER_BATCH_ID>{ data($lote/idLoteCliente) }</CUSTOMER_BATCH_ID>
                                    {
                                        for $estado in $lote/estado
                                        return
                                            <STATUS>{ data($estado) }</STATUS>
                                    }
                                    {
                                        for $codigoError in $lote/codigoError
                                        return
                                            <ERROR_CODE>{ data($codigoError) }</ERROR_CODE>
                                    }
                                    {
                                        for $mensajeError in $lote/mensajeError
                                        return
                                            <ERROR_MESSAGE>{ data($mensajeError) }</ERROR_MESSAGE>
                                    }
                                </BATCH>
                        }
                    </BATCHES>
            }
        </ns1:pagosMasivosResponse>
};

declare variable $cargarLotesResponse as element(ns0:cargarLotesResponse) external;

xf:pagosMasivosInternoPAOut($cargarLotesResponse)
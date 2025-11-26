xquery version "1.0" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$editarEstadoLoteResponse" element="ns0:editarEstadoLoteResponse" location="../../../BusinessServices/MTR/editorLote/wsdl/editorLoteEndpoint.wsdl" ::)
(:: pragma bea:global-element-return element="ns1:cancelarLoteResponse" location="../../PagosMasivos/xsd/pagosMasivosTypes.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/CancelarLote/xq/cancelarLotePAOut/";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/pagosMasivosTypes";
declare namespace ns0 = "http://servicio.editarlotews.mtrpmsv.cidenet.com.co/";

declare function xf:cancelarLotePAOut($editarEstadoLoteResponse as element(ns0:editarEstadoLoteResponse))
    as element(ns1:cancelarLoteResponse) {
        <ns1:cancelarLoteResponse>
            {
                for $idLote in $editarEstadoLoteResponse/respuestaEdicionLote/detalleRespuesta/idLote
                return
                    <BANK_BATCH_ID>{ data($idLote) }</BANK_BATCH_ID>
            }
            {
                for $estado in $editarEstadoLoteResponse/respuestaEdicionLote/detalleRespuesta/estado
                return
                    <STATUS>{ data($estado) }</STATUS>
            }
            {
                for $descripcionEstado in $editarEstadoLoteResponse/respuestaEdicionLote/detalleRespuesta/descripcionEstado
                return
                    <STATUS_DESC>{ data($descripcionEstado) }</STATUS_DESC>
            }
        </ns1:cancelarLoteResponse>
};

declare variable $editarEstadoLoteResponse as element(ns0:editarEstadoLoteResponse) external;

xf:cancelarLotePAOut($editarEstadoLoteResponse)
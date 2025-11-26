(:: pragma bea:global-element-parameter parameter="$editarEstadoLoteResponse" element="ns1:editarEstadoLoteResponse" location="../../../BusinessServices/MTR/editorLote/wsdl/editorLoteEndpoint.wsdl" ::)
(:: pragma bea:global-element-return element="ns0:cancelarLoteResponse" location="../../PagosMasivos/xsd/pagosMasivosTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/pagosMasivosTypes";
declare namespace ns1 = "http://servicio.editarlotews.mtrpmsv.cidenet.com.co/";
declare namespace xf = "http://tempuri.org/MWHostToHost/cancelarLoteGTOut/";

declare function xf:cancelarLoteGTOut($editarEstadoLoteResponse as element(ns1:editarEstadoLoteResponse))
    as element(ns0:cancelarLoteResponse) {
        <ns0:cancelarLoteResponse>
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
        </ns0:cancelarLoteResponse>
};

declare variable $editarEstadoLoteResponse as element(ns1:editarEstadoLoteResponse) external;

xf:cancelarLoteGTOut($editarEstadoLoteResponse)
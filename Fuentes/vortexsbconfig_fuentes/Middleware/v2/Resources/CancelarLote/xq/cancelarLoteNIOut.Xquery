<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$editarEstadoLoteResponse" element="ns1:editarEstadoLoteResponse" location="../../../BusinessServices/MTR/editorLote/wsdl/editorLoteEndpoint.wsdl" ::)
(:: pragma bea:global-element-return element="ns0:cancelarLoteResponse" location="../../PagosMasivos/xsd/pagosMasivosTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/pagosMasivosTypes";
declare namespace ns1 = "http://servicio.editarlotews.mtrpmsv.cidenet.com.co/";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/CancelarLote/xq/cancelarLoteNIOut/";

declare function xf:cancelarLoteNIOut($editarEstadoLoteResponse as element(ns1:editarEstadoLoteResponse))
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

xf:cancelarLoteNIOut($editarEstadoLoteResponse)]]></con:xquery>
    <con:dependency location="../../../BusinessServices/MTR/editorLote/wsdl/editorLoteEndpoint.wsdl">
        <con:wsdl ref="Middleware/v2/BusinessServices/MTR/editorLote/wsdl/editorLoteEndpoint"/>
    </con:dependency>
    <con:dependency location="../../PagosMasivos/xsd/pagosMasivosTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/PagosMasivos/xsd/pagosMasivosTypes"/>
    </con:dependency>
</con:xqueryEntry>
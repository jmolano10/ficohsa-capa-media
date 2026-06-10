<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$editarEstadoLoteResponse" element="ns1:editarEstadoLoteResponse" location="../../../BusinessServices/MTR/editorLote/wsdl/editorLoteEndpoint.wsdl" ::)
(:: pragma bea:global-element-return element="ns0:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://servicio.editarlotews.mtrpmsv.cidenet.com.co/";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/CancelarLote/xq/cancelarLoteNIHeaderOut/";

declare function xf:cancelarLoteNIHeaderOut($editarEstadoLoteResponse as element(ns1:editarEstadoLoteResponse))
    as element(ns0:ResponseHeader) {
        <ns0:ResponseHeader>
            {
                for $codigo in $editarEstadoLoteResponse/respuestaEdicionLote/cabeceraRespuesta/codigo
                return
                    <successIndicator>{ data($codigo) }</successIndicator>
            }
            {
                for $mensaje in $editarEstadoLoteResponse/respuestaEdicionLote/cabeceraRespuesta/mensaje
                return
                    <messages>{ data($mensaje) }</messages>
            }
        </ns0:ResponseHeader>
};

declare variable $editarEstadoLoteResponse as element(ns1:editarEstadoLoteResponse) external;

xf:cancelarLoteNIHeaderOut($editarEstadoLoteResponse)]]></con:xquery>
    <con:dependency location="../../../BusinessServices/MTR/editorLote/wsdl/editorLoteEndpoint.wsdl">
        <con:wsdl ref="Middleware/v2/BusinessServices/MTR/editorLote/wsdl/editorLoteEndpoint"/>
    </con:dependency>
    <con:dependency location="../../esquemas_generales/HeaderElements.xsd">
        <con:schema ref="Middleware/v2/Resources/esquemas_generales/HeaderElements"/>
    </con:dependency>
</con:xqueryEntry>
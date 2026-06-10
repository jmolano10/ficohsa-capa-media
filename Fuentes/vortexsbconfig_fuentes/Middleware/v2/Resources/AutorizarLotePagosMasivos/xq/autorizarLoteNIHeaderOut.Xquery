<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$autorizarLoteResponse" element="ns1:autorizarLoteResponse" location="../../../BusinessServices/MTR/autorizarLote/wsdl/autorizarLotesEndpoint.wsdl" ::)
(:: pragma bea:global-element-return element="ns0:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://servicio.enviosolicitudcoretask.mtrpmsv.cidenet.com.co/";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/AutorizarLotePagosMasivos/xq/autorizarLoteNIHeaderOut/";

declare function xf:autorizarLoteNIHeaderOut($autorizarLoteResponse as element(ns1:autorizarLoteResponse))
    as element(ns0:ResponseHeader) {
        <ns0:ResponseHeader>
            {
                for $codigo in $autorizarLoteResponse/respuestaAutorizacionLotes/cabeceraRespuesta/codigo
                return
                    <successIndicator>{ data($codigo) }</successIndicator>
            }
            {
                for $mensaje in $autorizarLoteResponse/respuestaAutorizacionLotes/cabeceraRespuesta/mensaje
                return
                    <messages>{ data($mensaje) }</messages>
            }
        </ns0:ResponseHeader>
};

declare variable $autorizarLoteResponse as element(ns1:autorizarLoteResponse) external;

xf:autorizarLoteNIHeaderOut($autorizarLoteResponse)]]></con:xquery>
    <con:dependency location="../../../BusinessServices/MTR/autorizarLote/wsdl/autorizarLotesEndpoint.wsdl">
        <con:wsdl ref="Middleware/v2/BusinessServices/MTR/autorizarLote/wsdl/autorizarLotesEndpoint"/>
    </con:dependency>
    <con:dependency location="../../esquemas_generales/HeaderElements.xsd">
        <con:schema ref="Middleware/v2/Resources/esquemas_generales/HeaderElements"/>
    </con:dependency>
</con:xqueryEntry>
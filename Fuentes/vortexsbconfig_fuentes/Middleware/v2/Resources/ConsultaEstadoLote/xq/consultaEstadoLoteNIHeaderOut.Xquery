<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultarLoteResponse" element="ns1:consultarLoteResponse" location="../../../BusinessServices/MTR/consultorLote/wsdl/consultorLoteEndpoint.wsdl" ::)
(:: pragma bea:global-element-return element="ns0:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://servicio.consultalotews.mtrpmsv.cidenet.com.co/";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaEstadoLote/xq/consultaEstadoLoteNIHeaderOut/";

declare function xf:consultaEstadoLoteNIHeaderOut($consultarLoteResponse as element(ns1:consultarLoteResponse))
    as element(ns0:ResponseHeader) {
        <ns0:ResponseHeader>
            {
                for $codigo in $consultarLoteResponse/respuestaConsultaLote/cabeceraRespuesta/codigo
                return
                    <successIndicator>{ data($codigo) }</successIndicator>
            }
            {
                for $mensaje in $consultarLoteResponse/respuestaConsultaLote/cabeceraRespuesta/mensaje
                return
                    <messages>{ data($mensaje) }</messages>
            }
        </ns0:ResponseHeader>
};

declare variable $consultarLoteResponse as element(ns1:consultarLoteResponse) external;

xf:consultaEstadoLoteNIHeaderOut($consultarLoteResponse)]]></con:xquery>
    <con:dependency location="../../../BusinessServices/MTR/consultorLote/wsdl/consultorLoteEndpoint.wsdl">
        <con:wsdl ref="Middleware/v2/BusinessServices/MTR/consultorLote/wsdl/consultorLoteEndpoint"/>
    </con:dependency>
    <con:dependency location="../../esquemas_generales/HeaderElements.xsd">
        <con:schema ref="Middleware/v2/Resources/esquemas_generales/HeaderElements"/>
    </con:dependency>
</con:xqueryEntry>
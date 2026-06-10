<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$cargarArchivoLote" element="ns0:cargarArchivoLote" location="../../../BusinessServices/MTR/cargadorArchivoLote/wsdl/cargadorArchivoLoteEndpoint.wsdl" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/CargarArchivoLote/xq/cargarArchivoLotePAHeaderOut/";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "http://servicio.cargararchivolotews.mtrpmsv.cidenet.com.co/";

declare function xf:cargarArchivoLotePAHeaderOut($cargarArchivoLoteResponse as element(ns0:cargarArchivoLoteResponse))
    as element(ns1:ResponseHeader) {
        <ns1:ResponseHeader>
        {
                let $codigo := $cargarArchivoLoteResponse/respuestaCargaArchivoLote/cabeceraRespuesta/codigo
                let $mensaje := $cargarArchivoLoteResponse/respuestaCargaArchivoLote/cabeceraRespuesta/mensaje
                return
                	if(upper-case(string($codigo)) = 'SUCCESS') then(
                    	<successIndicator>Success</successIndicator>
                    ) else(
                    	<successIndicator>{ data($codigo) }</successIndicator>,
                    	<messages>{ data($mensaje) }</messages>
                    )
            }
        </ns1:ResponseHeader>
};

declare variable $cargarArchivoLoteResponse as element(ns0:cargarArchivoLoteResponse) external;

xf:cargarArchivoLotePAHeaderOut($cargarArchivoLoteResponse)]]></con:xquery>
    <con:dependency location="../../../BusinessServices/MTR/cargadorArchivoLote/wsdl/cargadorArchivoLoteEndpoint.wsdl">
        <con:wsdl ref="Middleware/v2/BusinessServices/MTR/cargadorArchivoLote/wsdl/cargadorArchivoLoteEndpoint"/>
    </con:dependency>
    <con:dependency location="../../esquemas_generales/HeaderElements.xsd">
        <con:schema ref="Middleware/v2/Resources/esquemas_generales/HeaderElements"/>
    </con:dependency>
</con:xqueryEntry>
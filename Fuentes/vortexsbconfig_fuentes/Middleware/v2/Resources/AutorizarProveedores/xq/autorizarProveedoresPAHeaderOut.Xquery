<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$autorizarTercerosResponse" element="ns0:autorizarTercerosResponse" location="../../../BusinessServices/MTR/autorizadorTerceros/wsdl/autorizadorTercerosEndpoint.wsdl" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/AutorizarProveedores/xq/autorizarProveedoresPAHeaderOut/";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "http://servicio.autorizartercerosws.mtrpmsv.cidenet.com.co/";

declare function xf:autorizarProveedoresPAHeaderOut($autorizarTercerosResponse as element(ns0:autorizarTercerosResponse))
    as element(ns1:ResponseHeader) {
        <ns1:ResponseHeader>
            {
                for $codigo in $autorizarTercerosResponse/return/codigo
                return
                    <successIndicator>{ data($codigo) }</successIndicator>
            }
            {
                for $mensaje in $autorizarTercerosResponse/return/mensaje
                return
                    <messages>{ data($mensaje) }</messages>
            }
        </ns1:ResponseHeader>
};

declare variable $autorizarTercerosResponse as element(ns0:autorizarTercerosResponse) external;

xf:autorizarProveedoresPAHeaderOut($autorizarTercerosResponse)]]></con:xquery>
    <con:dependency location="../../../BusinessServices/MTR/autorizadorTerceros/wsdl/autorizadorTercerosEndpoint.wsdl">
        <con:wsdl ref="Middleware/v2/BusinessServices/MTR/autorizadorTerceros/wsdl/autorizadorTercerosEndpoint"/>
    </con:dependency>
    <con:dependency location="../../esquemas_generales/HeaderElements.xsd">
        <con:schema ref="Middleware/v2/Resources/esquemas_generales/HeaderElements"/>
    </con:dependency>
</con:xqueryEntry>
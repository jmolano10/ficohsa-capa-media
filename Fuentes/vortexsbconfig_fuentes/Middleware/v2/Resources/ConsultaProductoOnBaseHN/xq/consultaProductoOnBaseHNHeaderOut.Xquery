<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaProductoOnBaseHN/xq/consultaProductoOnBaseHNHeaderOut/";

declare function xf:consultaProductoOnBaseHNHeaderOut($codigoMensaje as xs:string,
    $descripcionMensaje as xs:string)
    as element(ns0:ResponseHeader) {
        <ns0:ResponseHeader>
        	{
	            	if ($codigoMensaje  = "SUCCESS" or $codigoMensaje = "0") then (
	            		<successIndicator>Success</successIndicator>
	            	) else (
	            		<successIndicator>{ $codigoMensaje }</successIndicator>,
	            		<messages>{ $descripcionMensaje }</messages>
	            	) 
            }
        </ns0:ResponseHeader>
};

declare variable $codigoMensaje as xs:string external;
declare variable $descripcionMensaje as xs:string external;

xf:consultaProductoOnBaseHNHeaderOut($codigoMensaje,
    $descripcionMensaje)]]></con:xquery>
    <con:dependency location="../../esquemas_generales/HeaderElements.xsd">
        <con:schema ref="Middleware/v2/Resources/esquemas_generales/HeaderElements"/>
    </con:dependency>
</con:xqueryEntry>
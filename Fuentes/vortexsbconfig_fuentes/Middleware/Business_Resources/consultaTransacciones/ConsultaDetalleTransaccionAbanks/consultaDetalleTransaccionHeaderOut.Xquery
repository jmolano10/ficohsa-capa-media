<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace xf = "http://tempuri.org/MiddlewareAbanks/Business_Resources/consultaTransacciones/ConsultaDetalleTransaccion/consultaDetalleTransaccionHeaderOut/";

declare function xf:consultaDetalleTransaccionHeaderOut($succesIndicator as xs:string,
    $message as xs:string)
    as element(ns0:ResponseHeader) {
        <ns0:ResponseHeader>
            <successIndicator>{ $succesIndicator }</successIndicator>
            {
            	if ($succesIndicator != "SUCCESS") then
            		<messages>{ $message }</messages>
            	else ()
            }
        </ns0:ResponseHeader>
};

declare variable $succesIndicator as xs:string external;
declare variable $message as xs:string external;

xf:consultaDetalleTransaccionHeaderOut($succesIndicator,
    $message)]]></con:xquery>
    <con:dependency location="../../esquemas_generales/HeaderElements.xsd">
        <con:schema ref="Middleware/Business_Resources/esquemas_generales/HeaderElements"/>
    </con:dependency>
</con:xqueryEntry>
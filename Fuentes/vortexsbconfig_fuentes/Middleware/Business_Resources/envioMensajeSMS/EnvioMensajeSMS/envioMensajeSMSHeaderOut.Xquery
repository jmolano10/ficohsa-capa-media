<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/envioMensajeSMS/EnvioMensajeSMS/envioMensajeSMSHeaderOut/";

declare function xf:envioMensajeSMSHeaderOut($result as xs:string)
    as element(ns0:ResponseHeader) {
        <ns0:ResponseHeader>
        {
        	if ($result = "Ok") then (
        		<successIndicator>Success</successIndicator>
        	) else (
        		<successIndicator>ERROR</successIndicator>,
        		<messages>{ $result }</messages>
        	)
        }
        </ns0:ResponseHeader>
};

declare variable $result as xs:string external;

xf:envioMensajeSMSHeaderOut($result)]]></con:xquery>
    <con:dependency location="../../esquemas_generales/HeaderElements.xsd">
        <con:schema ref="Middleware/Business_Resources/esquemas_generales/HeaderElements"/>
    </con:dependency>
</con:xqueryEntry>
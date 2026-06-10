<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft" encoding "Cp1252";
(:: pragma bea:global-element-return element="ns0:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/SolicitudAperturaCuenta/xq/AperturaCuentaOnlineHeaderOUT/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";

declare function xf:AperturaCuentaOnlineHeaderOUT($ErrorCode as xs:string
,$validationMessage as xs:string)
    as element(ns0:ResponseHeader) {
       <ns0:ResponseHeader>
            <successIndicator>{ $ErrorCode }</successIndicator>
            {
				if ($ErrorCode != "Success") then (
					<messages>{ $validationMessage }</messages>
				) else (
				)
			}
            
        </ns0:ResponseHeader>
};

declare variable $ErrorCode as xs:string external;
declare variable $validationMessage as xs:string external;

xf:AperturaCuentaOnlineHeaderOUT($ErrorCode,$validationMessage)]]></con:xquery>
    <con:dependency location="../../esquemas_generales/HeaderElements.xsd">
        <con:schema ref="Middleware/v2/Resources/esquemas_generales/HeaderElements"/>
    </con:dependency>
</con:xqueryEntry>
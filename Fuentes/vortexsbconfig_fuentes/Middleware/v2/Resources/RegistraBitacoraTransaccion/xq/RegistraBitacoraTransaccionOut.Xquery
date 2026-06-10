<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma  parameter="$response" type="anyType" ::)
(:: pragma bea:global-element-return element="ns0:registroBitacoraTransaccionResponse" location="../xsd/RegistraBitacoraTransaccionTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/registroBitacoraTransaccionTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/RegistraBitacoraTransaccion/xq/RegistraBitacoraTransaccionOut/";

declare function xf:RegistraBitacoraTransaccionOut($response as element(*))
    as element(ns0:registroBitacoraTransaccionResponse) {
        <ns0:registroBitacoraTransaccionResponse>
            <ERROR_CODE>{ fn:string($response//*:PV_ERROR_CODE/text()) }</ERROR_CODE>
            <ERROR_MESSAGE>{ fn:string($response//*:PV_ERROR_MESSAGE/text()) }</ERROR_MESSAGE>
        </ns0:registroBitacoraTransaccionResponse>
};

declare variable $response as element(*) external;

xf:RegistraBitacoraTransaccionOut($response)]]></con:xquery>
    <con:dependency location="../xsd/RegistraBitacoraTransaccionTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/RegistraBitacoraTransaccion/xsd/RegistraBitacoraTransaccionTypes"/>
    </con:dependency>
</con:xqueryEntry>
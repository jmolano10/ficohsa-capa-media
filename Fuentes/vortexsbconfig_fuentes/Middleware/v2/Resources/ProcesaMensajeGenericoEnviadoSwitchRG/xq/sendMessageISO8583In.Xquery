<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery>xquery version "2004-draft" encoding "Cp1252";
(:: pragma bea:global-element-return element="ns0:sendMessageISO8583Request" location="../../../BusinessServices/Switch/actualizaDatosTarjeta/wsdl/updateCardData.wsdl" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ProcesaMensajeGenericoEnviadoSwitchRG/xq/send/";
declare namespace ns0 = "http://www.ficohsa.com.hn/schema/updateCardDataTypes";

declare function xf:send($message as xs:string)
    as element(ns0:sendMessageISO8583Request) {
        &lt;ns0:sendMessageISO8583Request>
            &lt;message>{ fn:substring-before($message, '|') }&lt;/message>
        &lt;/ns0:sendMessageISO8583Request>
};

declare variable $message as xs:string external;

xf:send($message)</con:xquery>
    <con:dependency location="../../../BusinessServices/Switch/actualizaDatosTarjeta/wsdl/updateCardData.wsdl">
        <con:wsdl ref="Middleware/v2/BusinessServices/Switch/actualizaDatosTarjeta/wsdl/updateCardData"/>
    </con:dependency>
</con:xqueryEntry>
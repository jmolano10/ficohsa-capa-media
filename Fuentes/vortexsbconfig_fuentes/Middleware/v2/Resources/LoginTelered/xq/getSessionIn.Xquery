<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery>xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:GetSessionRequest" location="../../../BusinessServices/Telered/EnrutadorTelered/xsd/XMLSchema_-313640674.xsd" ::)

declare namespace ns0 = "http://dto.eis.pasarela.hubpagos.bytesw.com/";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/LoginTelered/xq/obtenerSesionIn/";

declare function xf:obtenerSesionIn($canal as xs:string)
    as element(ns0:GetSessionRequest) {
        &lt;ns0:GetSessionRequest>
            &lt;canal>{ $canal }&lt;/canal>
        &lt;/ns0:GetSessionRequest>
};

declare variable $canal as xs:string external;

xf:obtenerSesionIn($canal)</con:xquery>
    <con:dependency location="../../../BusinessServices/Telered/EnrutadorTelered/xsd/XMLSchema_-313640674.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/Telered/EnrutadorTelered/xsd/XMLSchema_-313640674"/>
    </con:dependency>
</con:xqueryEntry>
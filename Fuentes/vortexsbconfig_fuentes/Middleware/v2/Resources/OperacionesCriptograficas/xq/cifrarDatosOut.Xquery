<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery>xquery version "1.0" encoding "utf-8";
(:: pragma bea:global-element-return element="ns0:cifrarDatosResponse" location="../xsd/operacionesCriptograficasTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/operacionesCriptograficasTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/OperacionesCriptograficas/xq/cifrarDatosOut/";

declare function xf:cifrarDatosOut($encryptedData as xs:string)
    as element(ns0:cifrarDatosResponse) {
        &lt;ns0:cifrarDatosResponse>
            &lt;ns0:ENCRYPTED_DATA>{ $encryptedData }&lt;/ns0:ENCRYPTED_DATA>
        &lt;/ns0:cifrarDatosResponse>
};

declare variable $encryptedData as xs:string external;

xf:cifrarDatosOut($encryptedData)</con:xquery>
</con:xqueryEntry>
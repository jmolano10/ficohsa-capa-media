<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery>xquery version "1.0" encoding "utf-8";
(:: pragma bea:global-element-return element="ns0:descifrarDatosResponse" location="../xsd/operacionesCriptograficasTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/operacionesCriptograficasTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/OperacionesCriptograficas/xq/descifrarDatosOut/";

declare function xf:descifrarDatosOut($decryptedData as xs:string)
    as element(ns0:descifrarDatosResponse) {
        &lt;ns0:descifrarDatosResponse>
            &lt;ns0:DECRYPTED_DATA>{ $decryptedData }&lt;/ns0:DECRYPTED_DATA>
        &lt;/ns0:descifrarDatosResponse>
};

declare variable $decryptedData as xs:string external;

xf:descifrarDatosOut($decryptedData)</con:xquery>
</con:xqueryEntry>
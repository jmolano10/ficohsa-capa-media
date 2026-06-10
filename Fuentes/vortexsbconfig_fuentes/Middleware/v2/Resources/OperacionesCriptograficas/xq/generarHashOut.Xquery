<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery>xquery version "1.0" encoding "utf-8";
(:: pragma bea:global-element-return element="ns0:generarHashResponse" location="../xsd/operacionesCriptograficasTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/operacionesCriptograficasTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/OperacionesCriptograficas/xq/generarHashOut/";

declare function xf:generarHashOut($hashRepresentation as xs:string)
    as element(ns0:generarHashResponse) {
        &lt;ns0:generarHashResponse>
            &lt;ns0:HASH_REPRESENTATION>{ $hashRepresentation }&lt;/ns0:HASH_REPRESENTATION>
        &lt;/ns0:generarHashResponse>
};

declare variable $hashRepresentation as xs:string external;

xf:generarHashOut($hashRepresentation)</con:xquery>
</con:xqueryEntry>
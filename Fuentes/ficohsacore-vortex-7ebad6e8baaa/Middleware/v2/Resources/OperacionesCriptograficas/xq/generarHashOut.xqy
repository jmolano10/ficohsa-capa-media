xquery version "1.0" encoding "utf-8";
(:: pragma bea:global-element-return element="ns0:generarHashResponse" location="../xsd/operacionesCriptograficasTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/operacionesCriptograficasTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/OperacionesCriptograficas/xq/generarHashOut/";

declare function xf:generarHashOut($hashRepresentation as xs:string)
    as element(ns0:generarHashResponse) {
        <ns0:generarHashResponse>
            <ns0:HASH_REPRESENTATION>{ $hashRepresentation }</ns0:HASH_REPRESENTATION>
        </ns0:generarHashResponse>
};

declare variable $hashRepresentation as xs:string external;

xf:generarHashOut($hashRepresentation)
xquery version "1.0" encoding "utf-8";
(:: pragma bea:global-element-return element="ns0:cifrarDatos" location="../xsd/operacionesCriptograficasTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/operacionesCriptograficasTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/OperacionesCriptograficas/xq/cifrarDatosIn/";

declare function xf:cifrarDatosIn($cipher as xs:string,
    $cryptokeyAlias as xs:string,
    $decryptedData as xs:string)
    as element(ns0:cifrarDatos) {
        <ns0:cifrarDatos>
            <ns0:CIPHER>{ $cipher }</ns0:CIPHER>
            <ns0:CRYPTOKEY_ALIAS>{ $cryptokeyAlias }</ns0:CRYPTOKEY_ALIAS>
            <ns0:DECRYPTED_DATA>{ $decryptedData }</ns0:DECRYPTED_DATA>
        </ns0:cifrarDatos>
};

declare variable $cipher as xs:string external;
declare variable $cryptokeyAlias as xs:string external;
declare variable $decryptedData as xs:string external;

xf:cifrarDatosIn($cipher,
    $cryptokeyAlias,
    $decryptedData)
xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:descifrarDatos" location="../xsd/operacionesCriptograficasTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/operacionesCriptograficasTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/OperacionesCriptograficas/xq/descifrarDatosIn/";

declare function xf:descifrarDatosIn($cipher as xs:string,
    $keyAlias as xs:string,
    $encryptedData as xs:string)
    as element(ns0:descifrarDatos) {
        <ns0:descifrarDatos>
            <ns0:CIPHER>{ $cipher }</ns0:CIPHER>
            <ns0:CRYPTOKEY_ALIAS>{ $keyAlias }</ns0:CRYPTOKEY_ALIAS>
            <ns0:ENCRYPTED_DATA>{ $encryptedData }</ns0:ENCRYPTED_DATA>
        </ns0:descifrarDatos>
};

declare variable $cipher as xs:string external;
declare variable $keyAlias as xs:string external;
declare variable $encryptedData as xs:string external;

xf:descifrarDatosIn($cipher,
    $keyAlias,
    $encryptedData)
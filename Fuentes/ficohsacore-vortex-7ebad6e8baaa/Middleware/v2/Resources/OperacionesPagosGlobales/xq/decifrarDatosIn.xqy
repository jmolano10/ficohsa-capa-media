xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:descifrarDatos" location="../../OperacionesCriptograficas/xsd/operacionesCriptograficasTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/operacionesCriptograficasTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/OperacionesPagosGlobales/xq/decifrarDatosIn/";

declare function xf:decifrarDatosIn($cipher as xs:string,
    $encrypted_data as xs:string,
    $cryptokey_alias as xs:string)
    as element(ns0:descifrarDatos) {
        <ns0:descifrarDatos>
            <ns0:CIPHER>{ $cipher }</ns0:CIPHER>
            <ns0:CRYPTOKEY_ALIAS>{ $cryptokey_alias }</ns0:CRYPTOKEY_ALIAS>
            <ns0:ENCRYPTED_DATA>{ $encrypted_data }</ns0:ENCRYPTED_DATA>
        </ns0:descifrarDatos>
};

declare variable $cipher as xs:string external;
declare variable $encrypted_data as xs:string external;
declare variable $cryptokey_alias as xs:string external;

xf:decifrarDatosIn($cipher,
    $encrypted_data,
    $cryptokey_alias)
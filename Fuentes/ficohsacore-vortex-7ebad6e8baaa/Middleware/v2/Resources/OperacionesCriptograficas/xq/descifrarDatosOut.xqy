xquery version "1.0" encoding "utf-8";
(:: pragma bea:global-element-return element="ns0:descifrarDatosResponse" location="../xsd/operacionesCriptograficasTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/operacionesCriptograficasTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/OperacionesCriptograficas/xq/descifrarDatosOut/";

declare function xf:descifrarDatosOut($decryptedData as xs:string)
    as element(ns0:descifrarDatosResponse) {
        <ns0:descifrarDatosResponse>
            <ns0:DECRYPTED_DATA>{ $decryptedData }</ns0:DECRYPTED_DATA>
        </ns0:descifrarDatosResponse>
};

declare variable $decryptedData as xs:string external;

xf:descifrarDatosOut($decryptedData)
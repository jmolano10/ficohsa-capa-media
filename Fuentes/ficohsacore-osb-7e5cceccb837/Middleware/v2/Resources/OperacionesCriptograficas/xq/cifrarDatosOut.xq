(:: pragma bea:global-element-return element="ns0:cifrarDatosResponse" location="../xsd/operacionesCriptograficasTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/operacionesCriptograficasTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/OperacionesCriptograficas/xq/cifrarDatosOut/";

declare function xf:cifrarDatosOut($encryptedData as xs:string)
    as element(ns0:cifrarDatosResponse) {
        <ns0:cifrarDatosResponse>
            <ns0:ENCRYPTED_DATA>{ $encryptedData }</ns0:ENCRYPTED_DATA>
        </ns0:cifrarDatosResponse>
};

declare variable $encryptedData as xs:string external;

xf:cifrarDatosOut($encryptedData)

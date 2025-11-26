(:: pragma bea:global-element-return element="ns0:GetSessionRequest" location="../../../BusinessServices/Telered/EnrutadorTelered/xsd/XMLSchema_-313640674.xsd" ::)

declare namespace ns0 = "http://dto.eis.pasarela.hubpagos.bytesw.com/";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/LoginTelered/xq/obtenerSesionIn/";

declare function xf:obtenerSesionIn($canal as xs:string)
    as element(ns0:GetSessionRequest) {
        <ns0:GetSessionRequest>
            <canal>{ $canal }</canal>
        </ns0:GetSessionRequest>
};

declare variable $canal as xs:string external;

xf:obtenerSesionIn($canal)
(:: pragma bea:global-element-return element="ns0:validacionToken" location="../../Autenticacion/xsd/autenticacionInternaTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autenticacionInternaTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ProcesaMensajeGenericoT24/xq/autorizacionTokenIn/";

declare function xf:autorizacionTokenIn($username as xs:string,
    $tokenNumber as xs:string)
    as element(ns0:validacionToken) {
        <ns0:validacionToken>
            <USERNAME>{ $username }</USERNAME>
            <TOKEN>{ $tokenNumber }</TOKEN>
        </ns0:validacionToken>
};

declare variable $username as xs:string external;
declare variable $tokenNumber as xs:string external;

xf:autorizacionTokenIn($username,
    $tokenNumber)
xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:creaUsuarioSistemaResponse" location="../../AperturaProductos/xsd/aperturaProductosTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/aperturaProductosTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/CreaUsuarioSistema/xq/creaUsuarioSistemaOUT/";

declare function xf:creaUsuarioSistemaOUT($username as xs:string)
    as element(ns0:creaUsuarioSistemaResponse) {
        <ns0:creaUsuarioSistemaResponse>
            <USER_NAME>{ $username }</USER_NAME>
        </ns0:creaUsuarioSistemaResponse>
};

declare variable $username as xs:string external;

xf:creaUsuarioSistemaOUT($username)
xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:renviarCorreo" location="../../OperacionesCorreoElectronico/xsd/operacionesCorreoElectronicoTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/operacionesCorreoElectronicoTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/RenviarCorreoFacade/xq/renviarCorreoFacadeIn/";

declare function xf:renviarCorreoFacadeIn($IdEmail as xs:string)
    as element(ns0:renviarCorreo) {
        <ns0:renviarCorreo>
            <ID_SENT_EMAIL>{ $IdEmail }</ID_SENT_EMAIL>
        </ns0:renviarCorreo>
};

declare variable $IdEmail as xs:string external;

xf:renviarCorreoFacadeIn($IdEmail)
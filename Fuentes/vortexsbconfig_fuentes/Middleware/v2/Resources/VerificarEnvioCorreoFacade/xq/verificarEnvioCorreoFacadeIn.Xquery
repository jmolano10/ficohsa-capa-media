<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery>xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:verificarEnvioCorreo" location="../../OperacionesCorreoElectronico/xsd/operacionesCorreoElectronicoTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/operacionesCorreoElectronicoTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/VerificarEnvioCorreoFacade/xq/verificarEnvioCorreoFacadeIn/";

declare function xf:verificarEnvioCorreoFacadeIn($IdEmail as xs:string)
    as element(ns0:verificarEnvioCorreo) {
        &lt;ns0:verificarEnvioCorreo>
            &lt;ID_SENT_EMAIL>{ $IdEmail }&lt;/ID_SENT_EMAIL>
        &lt;/ns0:verificarEnvioCorreo>
};

declare variable $IdEmail as xs:string external;

xf:verificarEnvioCorreoFacadeIn($IdEmail)</con:xquery>
    <con:dependency location="../../OperacionesCorreoElectronico/xsd/operacionesCorreoElectronicoTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/OperacionesCorreoElectronico/xsd/operacionesCorreoElectronicoTypes"/>
    </con:dependency>
</con:xqueryEntry>
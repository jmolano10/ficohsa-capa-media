(:: pragma bea:global-element-return element="ns0:verificarEnvioCorreo" location="../../OperacionesCorreoElectronico/xsd/operacionesCorreoElectronicoTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/operacionesCorreoElectronicoTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/VerificarEnvioCorreoFacade/xq/verificarEnvioCorreoFacadeIn/";

declare function xf:verificarEnvioCorreoFacadeIn($IdEmail as xs:string)
    as element(ns0:verificarEnvioCorreo) {
        <ns0:verificarEnvioCorreo>
            <ID_SENT_EMAIL>{ $IdEmail }</ID_SENT_EMAIL>
        </ns0:verificarEnvioCorreo>
};

declare variable $IdEmail as xs:string external;

xf:verificarEnvioCorreoFacadeIn($IdEmail)

xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$verificarEnvioCorreo" element="ns0:verificarEnvioCorreo" location="../../OperacionesCorreoElectronico/xsd/operacionesCorreoElectronicoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/EnvioCorreoLauKey/verificarEnvioCorreo/xsd/verificarEnvioCorreo_sp.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/operacionesCorreoElectronicoTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/verificarEnvioCorreo";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/VerificarEnvioCorreo/xq/verificarEnvioCorreo/";

declare function xf:verificarEnvioCorreo($verificarEnvioCorreo as element(ns0:verificarEnvioCorreo))
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:ID_SENT_EMAIL>{ data($verificarEnvioCorreo/ID_SENT_EMAIL) }</ns1:ID_SENT_EMAIL>
        </ns1:InputParameters>
};

declare variable $verificarEnvioCorreo as element(ns0:verificarEnvioCorreo) external;

xf:verificarEnvioCorreo($verificarEnvioCorreo)
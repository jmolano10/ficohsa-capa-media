xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$envioMensajeUnico" element="ns0:envioMensajeUnico" location="../xsd/envioCorreoElectronicoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/IdentityProtection/xsd/ProtecionIdentidad_EnvioCorreo_sp.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/envioCorreoElectronicoTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/ProtecionIdentidad_EnvioCorreo";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/EnvioCorreoElectronico/xq/EnvioCorreoPrIdIN/";

declare function xf:EnvioCorreoPrIdIN($envioMensajeUnico as element(ns0:envioMensajeUnico))
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:PV_CORREO>{ data($envioMensajeUnico/DESTINATION/ADDRESS[1]) }</ns1:PV_CORREO>
            <ns1:PV_ASUNTO>{ data($envioMensajeUnico/MESSAGE/BODY/VARIABLES/VARIABLE[1]/NAME) }</ns1:PV_ASUNTO>
            <ns1:PV_BODY>{ data($envioMensajeUnico/MESSAGE/BODY/VARIABLES/VARIABLE[1]/VALUE) }</ns1:PV_BODY>
        </ns1:InputParameters>
};

declare variable $envioMensajeUnico as element(ns0:envioMensajeUnico) external;

xf:EnvioCorreoPrIdIN($envioMensajeUnico)
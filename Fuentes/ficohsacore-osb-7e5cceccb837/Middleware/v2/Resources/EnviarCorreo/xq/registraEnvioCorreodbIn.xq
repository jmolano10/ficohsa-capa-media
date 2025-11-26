(:: pragma bea:global-element-parameter parameter="$enviarCorreo" element="ns0:enviarCorreo" location="../../OperacionesCorreoElectronico/xsd/operacionesCorreoElectronicoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/EnvioCorreoLauKey/envioCorreo/xsd/enviarCorreoLauKey_sp.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/operacionesCorreoElectronicoTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/enviarCorreoLauKey";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/EnviarCorreo/xq/registraEnvioCorreodbIn/";

declare function xf:registraEnvioCorreodbIn($enviarCorreo as element(ns0:enviarCorreo))
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:MODULE_CODE>{ data($enviarCorreo/MODULE_CODE) }</ns1:MODULE_CODE>
            <ns1:PROCESS_CODE>{ data($enviarCorreo/PROCESS_CODE) }</ns1:PROCESS_CODE>
            <ns1:TYPE_SEND_EMAIL>{ data($enviarCorreo/TYPE_SEND_EMAIL) }</ns1:TYPE_SEND_EMAIL>
            <ns1:FROMC>{ data($enviarCorreo/FROM) }</ns1:FROMC>
            <ns1:TOC>{ data($enviarCorreo/TO) }</ns1:TOC>
            <ns1:CC>{ data($enviarCorreo/CC) }</ns1:CC>
            <ns1:SUBJECT_PARAMETERS>{ data($enviarCorreo/SUBJECT_PARAMETERS) }</ns1:SUBJECT_PARAMETERS>
            <ns1:MESSAGE_PARAMETERS>{ data($enviarCorreo/MESSAGE_PARAMETERS) }</ns1:MESSAGE_PARAMETERS>
        </ns1:InputParameters>
};

declare variable $enviarCorreo as element(ns0:enviarCorreo) external;

xf:registraEnvioCorreodbIn($enviarCorreo)
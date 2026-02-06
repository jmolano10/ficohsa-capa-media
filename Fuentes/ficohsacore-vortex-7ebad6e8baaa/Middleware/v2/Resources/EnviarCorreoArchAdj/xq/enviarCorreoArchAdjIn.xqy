xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$enviarCorreoArchAdj" element="ns0:enviarCorreoArchAdj" location="../../OperacionesCorreoElectronico/xsd/operacionesCorreoElectronicoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/EnvioCorreoLauKey/enviarCorreoArchivoAdjunto/xsd/enviarCorreoArchAdj_sp.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/operacionesCorreoElectronicoTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/enviarCorreoArchAdj";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/EnviarCorreoArchAdj/xq/enviarCorreoArchAdj/";

declare function xf:enviarCorreoArchAdj($enviarCorreoArchAdj as element(ns0:enviarCorreoArchAdj))
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:MODULE_CODE>{ data($enviarCorreoArchAdj/MODULE_CODE) }</ns1:MODULE_CODE>
            <ns1:PROCESS_CODE>{ data($enviarCorreoArchAdj/PROCESS_CODE) }</ns1:PROCESS_CODE>
            <ns1:TYPE_SEND_EMAIL>{ data($enviarCorreoArchAdj/TYPE_SEND_EMAIL) }</ns1:TYPE_SEND_EMAIL>
            <ns1:FROMC>{ data($enviarCorreoArchAdj/FROM) }</ns1:FROMC>
            <ns1:TOC>{ data($enviarCorreoArchAdj/TO) }</ns1:TOC>
            <ns1:CC>{ data($enviarCorreoArchAdj/CC) }</ns1:CC>
            <ns1:SUBJECT_PARAMETERS>{ data($enviarCorreoArchAdj/SUBJECT_PARAMETERS) }</ns1:SUBJECT_PARAMETERS>
            <ns1:MESSAGE_PARAMETERS>{ data($enviarCorreoArchAdj/MESSAGE_PARAMETERS) }</ns1:MESSAGE_PARAMETERS>
            <ns1:ATTACHMENT_FILE_NAME>{ data($enviarCorreoArchAdj/ATTACHMENT_FILE_NAME) }</ns1:ATTACHMENT_FILE_NAME>
            <ns1:VIRTUAL_ACL>{ data($enviarCorreoArchAdj/VIRTUAL_ACL) }</ns1:VIRTUAL_ACL>
        </ns1:InputParameters>
};

declare variable $enviarCorreoArchAdj as element(ns0:enviarCorreoArchAdj) external;

xf:enviarCorreoArchAdj($enviarCorreoArchAdj)
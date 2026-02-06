xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$enviarCorreoTablaDinamica" element="ns0:enviarCorreoTablaDinamica" location="../../OperacionesCorreoElectronico/xsd/operacionesCorreoElectronicoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/EnvioCorreoLauKey/enviarCorreoTablaDinamica/xsd/enviarCorreoTablaDinamica_sp.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/operacionesCorreoElectronicoTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/enviarCorreoTablaDinamica";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/EnviarCorreoTablaDinamica/xq/enviarCorreoTablaDinamica/";

declare function xf:enviarCorreoTablaDinamica($enviarCorreoTablaDinamica as element(ns0:enviarCorreoTablaDinamica))
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:MODULE_CODE>{ data($enviarCorreoTablaDinamica/MODULE_CODE) }</ns1:MODULE_CODE>
            <ns1:PROCESS_CODE>{ data($enviarCorreoTablaDinamica/PROCESS_CODE) }</ns1:PROCESS_CODE>
            <ns1:TYPE_SEND_EMAIL>{ data($enviarCorreoTablaDinamica/TYPE_SEND_EMAIL) }</ns1:TYPE_SEND_EMAIL>
            <ns1:FROMC>{ data($enviarCorreoTablaDinamica/FROM) }</ns1:FROMC>
            <ns1:TOC>{ data($enviarCorreoTablaDinamica/TO) }</ns1:TOC>
            <ns1:CC>{ data($enviarCorreoTablaDinamica/CC) }</ns1:CC>
            <ns1:SUBJECT_PARAMETERS>{ data($enviarCorreoTablaDinamica/SUBJECT_PARAMETERS) }</ns1:SUBJECT_PARAMETERS>
            <ns1:MESSAGE_PARAMETERS>{ data($enviarCorreoTablaDinamica/MESSAGE_PARAMETERS) }</ns1:MESSAGE_PARAMETERS>
            <ns1:TABLE_PARAMETERS>{ data($enviarCorreoTablaDinamica/TABLE_PARAMETERS) }</ns1:TABLE_PARAMETERS>
        </ns1:InputParameters>
};

declare variable $enviarCorreoTablaDinamica as element(ns0:enviarCorreoTablaDinamica) external;

xf:enviarCorreoTablaDinamica($enviarCorreoTablaDinamica)
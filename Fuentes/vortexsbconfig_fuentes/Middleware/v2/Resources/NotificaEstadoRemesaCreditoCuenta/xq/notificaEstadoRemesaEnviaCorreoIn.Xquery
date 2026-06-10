<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:enviarCorreo" location="../../OperacionesCorreoElectronico/xsd/operacionesCorreoElectronicoTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/operacionesCorreoElectronicoTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/NotificaEstadoRemesaCreditoCuenta/xq/notificaEstadoRemesaEnviaCorreoIn/";

declare function xf:notificaEstadoRemesaEnviaCorreoIn($Email as xs:string)
    as element(ns0:enviarCorreo) {
        <ns0:enviarCorreo>
            <MODULE_CODE>CCTA</MODULE_CODE>
            <PROCESS_CODE>30</PROCESS_CODE>
            <TYPE_SEND_EMAIL>1</TYPE_SEND_EMAIL>
            <FROM>noreply@ficohsa2.hn</FROM>
            <TO>{ $Email }</TO>
            <CC/>
			<SUBJECT_PARAMETERS/>
			<MESSAGE_PARAMETERS/>
            
        </ns0:enviarCorreo>
};

declare variable $Email as xs:string external;

xf:notificaEstadoRemesaEnviaCorreoIn($Email)]]></con:xquery>
    <con:dependency location="../../OperacionesCorreoElectronico/xsd/operacionesCorreoElectronicoTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/OperacionesCorreoElectronico/xsd/operacionesCorreoElectronicoTypes"/>
    </con:dependency>
</con:xqueryEntry>
<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns0:OutputParameters" location="../../../BusinessServices/INTFC/consultaUsuarioPGA/xsd/consultarUsuarioPGA_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaUsuariosPGAResponse" location="../xsd/consultaUsuariosPGATypes.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaUsuariosPGATypes";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultarUsuarioPGA";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaUsuariosPGA/xq/consultarUsuarioPGAOut/";

declare function xf:consultarUsuarioPGAOut($outputParameters as element(ns0:OutputParameters))
    as element(ns1:consultaUsuariosPGAResponse) {
        <ns1:consultaUsuariosPGAResponse>
            <PROFILE>{ data($outputParameters/ns0:PV_PROFILE) }</PROFILE>
            <ROLLCODE>{ data($outputParameters/ns0:PN_ROLL_CODE) }</ROLLCODE> 
        	<ROLLNAME>{ data($outputParameters/ns0:PV_ROLL_NAME) }</ROLLNAME> 
        	<AUTHENTICATOR>{ data($outputParameters/ns0:PV_AUTHENTICATOR) }</AUTHENTICATOR> 
        </ns1:consultaUsuariosPGAResponse>
};

declare variable $outputParameters as element(ns0:OutputParameters) external;

xf:consultarUsuarioPGAOut($outputParameters)]]></con:xquery>
    <con:dependency location="../../../BusinessServices/INTFC/consultaUsuarioPGA/xsd/consultarUsuarioPGA_sp.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/INTFC/consultaUsuarioPGA/xsd/consultarUsuarioPGA_sp"/>
    </con:dependency>
    <con:dependency location="../xsd/consultaUsuariosPGATypes.xsd">
        <con:schema ref="Middleware/v2/Resources/ConsultaUsuarioPGA/xsd/consultaUsuariosPGATypes"/>
    </con:dependency>
</con:xqueryEntry>
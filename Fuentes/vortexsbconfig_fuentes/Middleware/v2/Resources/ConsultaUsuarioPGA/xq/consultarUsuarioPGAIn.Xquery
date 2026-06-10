<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaUsuariosPGA" element="ns1:consultaUsuariosPGA" location="../xsd/consultaUsuariosPGATypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/INTFC/consultaUsuarioPGA/xsd/consultarUsuarioPGA_sp.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaUsuariosPGATypes";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultarUsuarioPGA";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaUsuariosPGA/xq/consultarUsuarioPGAIn/";

declare function xf:consultarUsuarioPGAIn($consultaUsuariosPGA as element(ns1:consultaUsuariosPGA))
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:PV_USER_NAME>{ data($consultaUsuariosPGA/USERNAME) }</ns0:PV_USER_NAME>
            <ns0:PV_APPLICATION>{ data($consultaUsuariosPGA/APPLICATION) }</ns0:PV_APPLICATION>
        </ns0:InputParameters>
};

declare variable $consultaUsuariosPGA as element(ns1:consultaUsuariosPGA) external;

xf:consultarUsuarioPGAIn($consultaUsuariosPGA)]]></con:xquery>
    <con:dependency location="../xsd/consultaUsuariosPGATypes.xsd">
        <con:schema ref="Middleware/v2/Resources/ConsultaUsuarioPGA/xsd/consultaUsuariosPGATypes"/>
    </con:dependency>
    <con:dependency location="../../../BusinessServices/INTFC/consultaUsuarioPGA/xsd/consultarUsuarioPGA_sp.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/INTFC/consultaUsuarioPGA/xsd/consultarUsuarioPGA_sp"/>
    </con:dependency>
</con:xqueryEntry>
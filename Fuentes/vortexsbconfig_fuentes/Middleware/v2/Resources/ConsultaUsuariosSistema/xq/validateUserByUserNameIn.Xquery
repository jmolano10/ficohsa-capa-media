<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery>xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaUsuariosSistema" element="ns5:consultaUsuariosSistema" location="../xsd/consultaUsuariosSistemaTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns6:ValidateUserByUserNameMessageIn" location="../../../BusinessServices/ICB/usersValidationCustomService/wsdl/UsersValidationCustomService.wsdl" ::)

declare namespace ns6 = "urn:tailored.icbanking.services.administration.users";
declare namespace ns5 = "http://www.ficohsa.com.hn/middleware.services/consultaUsuariosSistemaTypes";
declare namespace ns0 = "http://schemas.microsoft.com/2003/10/Serialization/Arrays";
declare namespace ns2 = "urn:infocorp.framework.services.common";
declare namespace ns1 = "urn:infocorp.framework.businessentities.approvalscheme";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaUsuariosSistema/xq/validateUserByUserNameIn/";
declare namespace ns4 = "urn:infocorp.framework.businessentities.common";
declare namespace ns3 = "urn:infocorp.framework.businessentities.security";

declare function xf:validateUserByUserNameIn($consultaUsuariosSistema as element(ns5:consultaUsuariosSistema))
    as element(ns6:ValidateUserByUserNameMessageIn) {
        &lt;ns6:ValidateUserByUserNameMessageIn>
            {
                for $SIGN_ON_NAME in $consultaUsuariosSistema/SIGN_ON_NAME
                return
                    &lt;ns6:UserName>{ data($SIGN_ON_NAME) }&lt;/ns6:UserName>
            }
        &lt;/ns6:ValidateUserByUserNameMessageIn>
};

declare variable $consultaUsuariosSistema as element(ns5:consultaUsuariosSistema) external;

xf:validateUserByUserNameIn($consultaUsuariosSistema)</con:xquery>
    <con:dependency location="../xsd/consultaUsuariosSistemaTypes.xsd"/>
    <con:dependency location="../../../BusinessServices/ICB/usersValidationCustomService/wsdl/UsersValidationCustomService.wsdl"/>
</con:xqueryEntry>
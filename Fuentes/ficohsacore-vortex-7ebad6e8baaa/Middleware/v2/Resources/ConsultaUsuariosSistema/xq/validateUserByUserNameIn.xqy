xquery version "2004-draft";
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
        <ns6:ValidateUserByUserNameMessageIn>
            {
                for $SIGN_ON_NAME in $consultaUsuariosSistema/SIGN_ON_NAME
                return
                    <ns6:UserName>{ data($SIGN_ON_NAME) }</ns6:UserName>
            }
        </ns6:ValidateUserByUserNameMessageIn>
};

declare variable $consultaUsuariosSistema as element(ns5:consultaUsuariosSistema) external;

xf:validateUserByUserNameIn($consultaUsuariosSistema)
xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$cambioFactorSeguridad" element="ns2:cambioFactorSeguridad" location="../xsd/cambioFactorSeguridadTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns6:UpdateSecurityDeviceByUserNameMessageIn" location="../../../BusinessServices/ICB/usersValidationCustomService/wsdl/UsersValidationCustomService.svc.singleWsdl.wsdl" ::)

declare namespace ns6 = "urn:tailored.icbanking.services.administration.users";
declare namespace ns5 = "urn:infocorp.framework.businessentities.common";
declare namespace ns0 = "http://schemas.microsoft.com/2003/10/Serialization/Arrays";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/cambioFactorSeguridadTypes";
declare namespace ns1 = "urn:infocorp.framework.businessentities.approvalscheme";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/CambioFactorSeguridad/xq/cambioFactorSeguridadIn/";
declare namespace ns4 = "urn:infocorp.framework.businessentities.security";
declare namespace ns3 = "urn:infocorp.framework.services.common";

declare function convertirFactorSeguridad($factorSeguridad as xs:string) 
	as xs:string? {
	 	if ($factorSeguridad = "PIN") then "1"
	 	else if ($factorSeguridad = "TOKEN") then "3"
	 	else ""
};	

declare function xf:cambioFactorSeguridadIn($cambioFactorSeguridad as element(ns2:cambioFactorSeguridad))
    as element(ns6:UpdateSecurityDeviceByUserNameMessageIn) {
        <ns6:UpdateSecurityDeviceByUserNameMessageIn>
            <ns6:SecurityDeviceId>{ convertirFactorSeguridad(data($cambioFactorSeguridad/SECURITY_FACTOR)) }</ns6:SecurityDeviceId>
            <ns6:UserName>{ data($cambioFactorSeguridad/USER_NAME) }</ns6:UserName>
        </ns6:UpdateSecurityDeviceByUserNameMessageIn>
};

declare variable $cambioFactorSeguridad as element(ns2:cambioFactorSeguridad) external;

xf:cambioFactorSeguridadIn($cambioFactorSeguridad)
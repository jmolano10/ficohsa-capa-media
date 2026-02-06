xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$getBancaSatClientMessageOut" element="ns7:GetBancaSatClientMessageOut" location="../../../v2/BusinessServices/ICB/usersCustomService/wsdl/UsersCustomService.wsdl" ::)

declare namespace ns6 = "urn:Infocorp.framework.services.common";
declare namespace ns5 = "urn:infocorp.framework.businessentities.common";
declare namespace ns7 = "urn:tailored.icbanking.services.administration.users";
declare namespace ns0 = "http://schemas.microsoft.com/2003/10/Serialization/Arrays";
declare namespace ns2 = "urn:infocorp.framework.businessentities.logging";
declare namespace ns1 = "urn:infocorp.framework.businessentities.approvalscheme";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/consultaCuentasBancaSat/xq/validacionSesionHeaderOut/";
declare namespace ns4 = "urn:infocorp.framework.businessentities.security";
declare namespace ns3 = "urn:infocorp.framework.services.common";

declare function xf:validacionSesionHeaderOut($getBancaSatClientMessageOut as element(ns7:GetBancaSatClientMessageOut))
    as xs:string {
        data($getBancaSatClientMessageOut/ns7:ClientBankIdentifier)
};

declare variable $getBancaSatClientMessageOut as element(ns7:GetBancaSatClientMessageOut) external;

xf:validacionSesionHeaderOut($getBancaSatClientMessageOut)
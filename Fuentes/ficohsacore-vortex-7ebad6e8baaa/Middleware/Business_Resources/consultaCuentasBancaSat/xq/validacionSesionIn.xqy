xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaCuentasBSatRequest1" element="ns3:consultaCuentasBSatRequest" location="../xsd/consultaCuentasBSatTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns6:GetBancaSatClientMessageIn" location="../../../v2/BusinessServices/ICB/usersCustomService/wsdl/UsersCustomService.wsdl" ::)

declare namespace ns6 = "urn:tailored.icbanking.services.administration.users";
declare namespace ns5 = "urn:infocorp.framework.businessentities.common";
declare namespace ns0 = "http://schemas.microsoft.com/2003/10/Serialization/Arrays";
declare namespace ns2 = "urn:infocorp.framework.services.common";
declare namespace ns1 = "urn:infocorp.framework.businessentities.approvalscheme";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/consultaCuentasBancaSat/xq/validacionSesionIn/";
declare namespace ns4 = "urn:infocorp.framework.businessentities.security";
declare namespace ns3 = "http://www.ficohsa.com.hn/middleware.services/consultaCuentasBSatTypes";

declare function xf:validacionSesionIn($consultaCuentasBSatRequest1 as element(ns3:consultaCuentasBSatRequest))
    as element(ns6:GetBancaSatClientMessageIn) {
        <ns6:GetBancaSatClientMessageIn>
            <ns6:Token>{ data($consultaCuentasBSatRequest1/SESSION_TOKEN) }</ns6:Token>
            <ns6:UserId>{ data($consultaCuentasBSatRequest1/USER_ID) }</ns6:UserId>
        </ns6:GetBancaSatClientMessageIn>
};

declare variable $consultaCuentasBSatRequest1 as element(ns3:consultaCuentasBSatRequest) external;

xf:validacionSesionIn($consultaCuentasBSatRequest1)
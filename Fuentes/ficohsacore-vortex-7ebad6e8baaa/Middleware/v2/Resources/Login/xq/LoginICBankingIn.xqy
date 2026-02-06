xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns3:LoginAHMMessageIn" location="../../../BusinessServices/ICB/AutenticaUsuarioICB/wsdl/UsersValidationCustomService.wsdl" ::)

declare namespace ns0 = "http://schemas.microsoft.com/2003/10/Serialization/Arrays";
declare namespace ns2 = "urn:infocorp.framework.businessentities.common";
declare namespace ns1 = "urn:infocorp.framework.services.common";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/Login/xq/LoginICBankingIn/";
declare namespace ns3 = "urn:tailored.icbanking.services.administration.users";

declare function xf:LoginICBankingIn($userName as xs:string,
    $password as xs:string)
    as element(ns3:LoginAHMMessageIn) {
        <ns3:LoginAHMMessageIn>
            <ns3:UserName>{ $userName }</ns3:UserName>
            <ns3:Password>{ $password }</ns3:Password>
        </ns3:LoginAHMMessageIn>
};

declare variable $userName as xs:string external;
declare variable $password as xs:string external;

xf:LoginICBankingIn($userName,
    $password)
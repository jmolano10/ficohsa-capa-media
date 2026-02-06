xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$getBancaSatClientMessageOut1" element="ns3:GetBancaSatClientMessageOut" location="../../../v2/BusinessServices/ICB/BancaSatService/wsdl/BancaSatServiceSingle.wsdl" ::)

declare namespace ns6 = "urn:infocorp.framework.businessentities.common";
declare namespace ns5 = "urn:infocorp.framework.businessentities.security";
declare namespace ns7 = "urn:Infocorp.framework.services.common";
declare namespace ns0 = "http://schemas.microsoft.com/2003/10/Serialization/Arrays";
declare namespace ns2 = "urn:infocorp.framework.businessentities.logging";
declare namespace ns1 = "urn:infocorp.framework.businessentities.approvalscheme";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/consultaCuentasBancaSat/xq/getBancaSatClientOutCliente/";
declare namespace ns4 = "urn:infocorp.framework.services.common";
declare namespace ns3 = "urn:tailored.icbanking.services.bancasat";

declare function xf:getBancaSatClientOutCliente($getBancaSatClientMessageOut1 as element(ns3:GetBancaSatClientMessageOut))
    as xs:string {
        data($getBancaSatClientMessageOut1/ns3:ClientBankIdentifier)
};

declare variable $getBancaSatClientMessageOut1 as element(ns3:GetBancaSatClientMessageOut) external;

xf:getBancaSatClientOutCliente($getBancaSatClientMessageOut1)
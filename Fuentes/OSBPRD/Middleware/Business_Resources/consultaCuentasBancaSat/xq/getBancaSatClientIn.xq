(:: pragma bea:global-element-parameter parameter="$consultaCuentasBSatRequest" element="ns4:consultaCuentasBSatRequest" location="../xsd/consultaCuentasBSatTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns2:GetBancaSatClientMessageIn" location="../../../v2/BusinessServices/ICB/BancaSatService/wsdl/BancaSatServiceSingle.wsdl" ::)

declare namespace ns6 = "urn:infocorp.framework.businessentities.common";
declare namespace ns5 = "urn:infocorp.framework.businessentities.security";
declare namespace ns0 = "http://schemas.microsoft.com/2003/10/Serialization/Arrays";
declare namespace ns2 = "urn:tailored.icbanking.services.bancasat";
declare namespace ns1 = "urn:infocorp.framework.businessentities.approvalscheme";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/consultaCuentasBancaSat/xq/getBancaSatClientIn/";
declare namespace ns4 = "http://www.ficohsa.com.hn/middleware.services/consultaCuentasBSatTypes";
declare namespace ns3 = "urn:infocorp.framework.services.common";

declare function xf:getBancaSatClientIn($consultaCuentasBSatRequest as element(ns4:consultaCuentasBSatRequest))
    as element(ns2:GetBancaSatClientMessageIn) {
        <ns2:GetBancaSatClientMessageIn>
            <ns2:BancaSatUserId>{ data($consultaCuentasBSatRequest/USER_ID) }</ns2:BancaSatUserId>
            <ns2:Token>{ data($consultaCuentasBSatRequest/SESSION_TOKEN) }</ns2:Token>
        </ns2:GetBancaSatClientMessageIn>
};

declare variable $consultaCuentasBSatRequest as element(ns4:consultaCuentasBSatRequest) external;

xf:getBancaSatClientIn($consultaCuentasBSatRequest)
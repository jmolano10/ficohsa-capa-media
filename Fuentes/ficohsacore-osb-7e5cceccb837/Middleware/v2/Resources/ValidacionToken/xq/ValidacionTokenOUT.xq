(:: pragma bea:global-element-parameter parameter="$authenticateGenericChallengeReturn1" element="ns2:authenticateGenericChallengeReturn" location="../../../BusinessServices/Entrust/wsdl/AuthenticationServiceV9.wsdl" ::)
(:: pragma bea:global-element-return element="ns0:ValidacionTokenResponse" location="../xsd/validacionTokenTypes.xsd" ::)

declare namespace ns2 = "urn:entrust.com:ig:authenticationV9:wsdl";
declare namespace ns1 = "urn:entrust.com:ig:commonV9";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/ValidacionTokenTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ValidacionToken/xq/ValidacionTokenOUT/";

declare function xf:ValidacionTokenOUT($authenticateGenericChallengeReturn1 as element(ns2:authenticateGenericChallengeReturn))
    as element(ns0:ValidacionTokenResponse) {
        <ns0:ValidacionTokenResponse>
            <SERIAL_NUMBER>{ data($authenticateGenericChallengeReturn1/tokenInfo/SerialNumber) }</SERIAL_NUMBER>
        </ns0:ValidacionTokenResponse>
};

declare variable $authenticateGenericChallengeReturn1 as element(ns2:authenticateGenericChallengeReturn) external;

xf:ValidacionTokenOUT($authenticateGenericChallengeReturn1)

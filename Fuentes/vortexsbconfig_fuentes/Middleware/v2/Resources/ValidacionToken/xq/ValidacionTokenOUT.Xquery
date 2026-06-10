<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery>xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$authenticateGenericChallengeReturn1" element="ns2:authenticateGenericChallengeReturn" location="../../../BusinessServices/Entrust/wsdl/AuthenticationServiceV9.wsdl" ::)
(:: pragma bea:global-element-return element="ns0:ValidacionTokenResponse" location="../xsd/validacionTokenTypes.xsd" ::)

declare namespace ns2 = "urn:entrust.com:ig:authenticationV9:wsdl";
declare namespace ns1 = "urn:entrust.com:ig:commonV9";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/ValidacionTokenTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ValidacionToken/xq/ValidacionTokenOUT/";

declare function xf:ValidacionTokenOUT($authenticateGenericChallengeReturn1 as element(ns2:authenticateGenericChallengeReturn))
    as element(ns0:ValidacionTokenResponse) {
        &lt;ns0:ValidacionTokenResponse>
            &lt;SERIAL_NUMBER>{ data($authenticateGenericChallengeReturn1/tokenInfo/SerialNumber) }&lt;/SERIAL_NUMBER>
        &lt;/ns0:ValidacionTokenResponse>
};

declare variable $authenticateGenericChallengeReturn1 as element(ns2:authenticateGenericChallengeReturn) external;

xf:ValidacionTokenOUT($authenticateGenericChallengeReturn1)</con:xquery>
    <con:dependency location="../../../BusinessServices/Entrust/wsdl/AuthenticationServiceV9.wsdl">
        <con:wsdl ref="Middleware/v2/BusinessServices/Entrust/wsdl/AuthenticationServiceV9"/>
    </con:dependency>
    <con:dependency location="../xsd/validacionTokenTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/ValidacionToken/xsd/validacionTokenTypes"/>
    </con:dependency>
</con:xqueryEntry>
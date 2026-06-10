<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery>xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$authenticateGenericChallengeReturn1" element="ns2:authenticateGenericChallengeReturn" location="../../../BusinessServices/Entrust/wsdl/AuthenticationServiceV9.wsdl" ::)
(:: pragma bea:global-element-return element="ns0:validacionTokenResponse" location="../xsd/autenticacionInternaTypes.xsd" ::)

declare namespace ns2 = "urn:entrust.com:ig:authenticationV9:wsdl";
declare namespace ns1 = "urn:entrust.com:ig:commonV9";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autenticacionInternaTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/Autenticacion/xq/validacionTokenOUT/";

declare function xf:validacionTokenOUT($authenticateGenericChallengeReturn1 as element(ns2:authenticateGenericChallengeReturn))
    as element(ns0:validacionTokenResponse) {
        &lt;ns0:validacionTokenResponse>
            &lt;SERIAL_NUMBER>{ data($authenticateGenericChallengeReturn1/tokenInfo/SerialNumber) }&lt;/SERIAL_NUMBER>
        &lt;/ns0:validacionTokenResponse>
};

declare variable $authenticateGenericChallengeReturn1 as element(ns2:authenticateGenericChallengeReturn) external;

xf:validacionTokenOUT($authenticateGenericChallengeReturn1)</con:xquery>
    <con:dependency location="../../../BusinessServices/Entrust/wsdl/AuthenticationServiceV9.wsdl">
        <con:wsdl ref="Middleware/v2/BusinessServices/Entrust/wsdl/AuthenticationServiceV9"/>
    </con:dependency>
    <con:dependency location="../xsd/autenticacionInternaTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/Autenticacion/xsd/autenticacionInternaTypes"/>
    </con:dependency>
</con:xqueryEntry>
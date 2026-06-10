<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:login" location="../../../BusinessServices/External/SalesforceRGNEnterprise/wsdl/SalesforceRGNEnterprise.wsdl" ::)

declare namespace ns0 = "urn:enterprise.soap.sforce.com";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/LoginSalesforce/xq/loginSalesforceIn/";

declare function xf:loginSalesforceIn($username as xs:string,
    $password as xs:string)
    as element(ns0:login) {
        <ns0:login>
            <ns0:username>{ $username }</ns0:username>
            <ns0:password>{ $password }</ns0:password>
        </ns0:login>
};

declare variable $username as xs:string external;
declare variable $password as xs:string external;

xf:loginSalesforceIn($username,
    $password)]]></con:xquery>
    <con:dependency location="../../../BusinessServices/External/SalesforceRGNEnterprise/wsdl/SalesforceRGNEnterprise.wsdl">
        <con:wsdl ref="Middleware/v2/BusinessServices/External/SalesforceRGNEnterprise/wsdl/SalesforceRGNEnterprise"/>
    </con:dependency>
</con:xqueryEntry>
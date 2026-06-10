<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:loginSalesforceResponse" location="../xsd/loginSalesforceTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/loginSalesforceTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/LoginSalesforce/xq/loginSalesforceOut/";

declare function xf:loginSalesforceOut($username as xs:string,
    $password as xs:string,
    $session as xs:string)
    as element(ns0:loginSalesforceResponse) {
        <ns0:loginSalesforceResponse>
            <SALESFORCE_INFO>
                <USERNAME>{ $username }</USERNAME>
                <PASSWORD>{ $password }</PASSWORD>
                <SESSION>{ $session }</SESSION>
            </SALESFORCE_INFO>
        </ns0:loginSalesforceResponse>
};

declare variable $username as xs:string external;
declare variable $password as xs:string external;
declare variable $session as xs:string external;

xf:loginSalesforceOut($username,
    $password,
    $session)]]></con:xquery>
    <con:dependency location="../xsd/loginSalesforceTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/LoginSalesforce/xsd/loginSalesforceTypes"/>
    </con:dependency>
</con:xqueryEntry>
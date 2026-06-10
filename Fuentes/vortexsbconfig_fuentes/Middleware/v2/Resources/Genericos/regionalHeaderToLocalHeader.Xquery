<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$requestHeader1" element="ns0:RequestHeader" location="../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-return element="ns0:AutenticacionRequestHeader" location="../../../Business_Resources/esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/Genericos/regionalHeaderToLocalHeader/";

declare function xf:regionalHeaderToLocalHeader($requestHeader1 as element(ns0:RequestHeader))
    as element(ns0:AutenticacionRequestHeader) {
        <ns0:AutenticacionRequestHeader>
            <UserName>{ data($requestHeader1/Authentication/UserName) }</UserName>
            <Password>{ data($requestHeader1/Authentication/Password) }</Password>
        </ns0:AutenticacionRequestHeader>
};

declare variable $requestHeader1 as element(ns0:RequestHeader) external;

xf:regionalHeaderToLocalHeader($requestHeader1)]]></con:xquery>
    <con:dependency location="../esquemas_generales/HeaderElements.xsd">
        <con:schema ref="Middleware/v2/Resources/esquemas_generales/HeaderElements"/>
    </con:dependency>
    <con:dependency location="../../../Business_Resources/esquemas_generales/HeaderElements.xsd">
        <con:schema ref="Middleware/Business_Resources/esquemas_generales/HeaderElements"/>
    </con:dependency>
</con:xqueryEntry>
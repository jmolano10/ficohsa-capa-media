<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$requestHeader" element="ns1:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/consultaSaldosTC/xsd/consultaSaldosTC_sp.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaSaldosTC";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaSaldosTarjetaCredito/xq/consultaSaldosTCIn/";

declare function xf:consultaSaldosTCIn($cardNumber as xs:string,
    $requestHeader as element(ns1:RequestHeader))
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:PV_NUMERO_TARJETA>{ $cardNumber }</ns0:PV_NUMERO_TARJETA>
            <ns0:PV_COUNTRY_CODE>{ data($requestHeader/Region/SourceBank) }</ns0:PV_COUNTRY_CODE>
            <ns0:PV_USER_NAME>{ data($requestHeader/Authentication/UserName) }</ns0:PV_USER_NAME>
        </ns0:InputParameters>
};

declare variable $cardNumber as xs:string external;
declare variable $requestHeader as element(ns1:RequestHeader) external;

xf:consultaSaldosTCIn($cardNumber,
    $requestHeader)]]></con:xquery>
    <con:dependency location="../../esquemas_generales/HeaderElements.xsd">
        <con:schema ref="Middleware/v2/Resources/esquemas_generales/HeaderElements"/>
    </con:dependency>
    <con:dependency location="../../../BusinessServices/consultaSaldosTC/xsd/consultaSaldosTC_sp.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/consultaSaldosTC/xsd/consultaSaldosTC_sp"/>
    </con:dependency>
</con:xqueryEntry>
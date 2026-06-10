<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft" encoding "Cp1252";
(:: pragma bea:global-element-return element="ns0:CreditLimitUpdateRequest" location="../../../BusinessServices/VisionPlusGT/fdcs/wsdl/Fdcs.wsdl" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/VisionPlusGT/xq/creditLimitUpdateIn/";
declare namespace ns0 = "http://www.procesa.com/fdcs";

declare function xf:creditLimitUpdateIn($orgNumber as xs:string,
    $accountNumber as xs:string,
    $foreignUse as xs:string,
    $creditLimit as xs:string,
    $currentCreditLimit as xs:string)
    as element(ns0:CreditLimitUpdateRequest) {
        <ns0:CreditLimitUpdateRequest>
            <OrgNumber>{ data($orgNumber) }</OrgNumber>
            <AccountNumber>{ $accountNumber }</AccountNumber>
            <ForeignUse>{ $foreignUse }</ForeignUse>
            <CreditLimit>{ data($creditLimit) }</CreditLimit>
            <CurrentCreditLimit>{ data($currentCreditLimit) }</CurrentCreditLimit>
        </ns0:CreditLimitUpdateRequest>
};

declare variable $orgNumber as xs:string external;
declare variable $accountNumber as xs:string external;
declare variable $foreignUse as xs:string external;
declare variable $creditLimit as xs:string external;
declare variable $currentCreditLimit as xs:string external;

xf:creditLimitUpdateIn($orgNumber,
    $accountNumber,
    $foreignUse,
    $creditLimit,
    $currentCreditLimit)]]></con:xquery>
    <con:dependency location="../../../BusinessServices/VisionPlusGT/fdcs/wsdl/Fdcs.wsdl">
        <con:wsdl ref="Middleware/v2/BusinessServices/VisionPlusGT/fdcs/wsdl/Fdcs"/>
    </con:dependency>
</con:xqueryEntry>
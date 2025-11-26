xquery version "1.0" encoding "Cp1252";
(:: pragma bea:global-element-return element="ns0:CreditLimitUpdateV2Request" location="../../../BusinessServices/VisionPlusGT/fdcs/wsdl/Fdcs.wsdl" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/VisionPlus/xq/creditLimitUpdateV2In/";
declare namespace ns0 = "http://www.procesa.com/fdcs";

declare function xf:creditLimitUpdateV2In($orgNumber as xs:string,
    $accountNumber as xs:string,
    $foreignUse as xs:string,
    $creditLimit as xs:string,
    $currentCreditLimit as xs:string)
    as element(ns0:CreditLimitUpdateV2Request) {
        <ns0:CreditLimitUpdateV2Request>
            <OrgNumber>{ data($orgNumber) }</OrgNumber>
            <AccountNumber>{ $accountNumber }</AccountNumber>
            <ForeignUse>{ $foreignUse }</ForeignUse>
            <CreditLimit>{ data($creditLimit) }</CreditLimit>
            <CurrentCreditLimit>{data($currentCreditLimit)}</CurrentCreditLimit>
        </ns0:CreditLimitUpdateV2Request>
};

declare variable $orgNumber as xs:string external;
declare variable $accountNumber as xs:string external;
declare variable $foreignUse as xs:string external;
declare variable $creditLimit as xs:string external;
declare variable $currentCreditLimit as xs:string external;

xf:creditLimitUpdateV2In($orgNumber,
    $accountNumber,
    $foreignUse,
    $creditLimit,
    $currentCreditLimit)

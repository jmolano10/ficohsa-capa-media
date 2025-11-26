(:: pragma bea:global-element-return element="ns0:CreditLimitUpdateRequest" location="../../../BusinessServices/VisionPlusPA/vmx/wsdl/VMX.wsdl" ::)

declare namespace ns0 = "http://www.procesa.com/fdcs";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/VisionPlusPA/xq/creditLimitUpdateIn/";

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
    $currentCreditLimit)
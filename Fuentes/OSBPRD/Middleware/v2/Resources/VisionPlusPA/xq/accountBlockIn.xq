xquery version "1.0" encoding "Cp1252";
(:: pragma bea:global-element-return element="ns0:AccountBlockRequest" location="../../../BusinessServices/VisionPlusPA/fdcs/wsdl/Fdcs.wsdl" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/VisionPlusPA/xq/accountBlockIn/";
declare namespace ns0 = "http://www.procesa.com/fdcs";

declare function xf:accountBlockIn($orgNumber as xs:string,
    $accountNumber as xs:string,
    $blockCode as xs:string,
    $blockCodeIndicator as xs:string,
    $foreignUse as xs:string)
    as element(ns0:AccountBlockRequest) {
        <ns0:AccountBlockRequest>
            <OrgNumber>{ data($orgNumber) }</OrgNumber>           
            <AccountNumber>{ data($accountNumber) }</AccountNumber>
            <BlockCode>{ data($blockCode) }</BlockCode>
            <BlockCodeIndicator>{ data($blockCodeIndicator) }</BlockCodeIndicator>
            <ForeignUse>{  data($foreignUse) }</ForeignUse>
        </ns0:AccountBlockRequest>
};

declare variable $orgNumber as xs:string external;
declare variable $accountNumber as xs:string external;
declare variable $blockCode as xs:string external;
declare variable $blockCodeIndicator as xs:string external;
declare variable $foreignUse as xs:string external;

xf:accountBlockIn($orgNumber,
    $accountNumber,
    $blockCode,
    $blockCodeIndicator,
    $foreignUse)
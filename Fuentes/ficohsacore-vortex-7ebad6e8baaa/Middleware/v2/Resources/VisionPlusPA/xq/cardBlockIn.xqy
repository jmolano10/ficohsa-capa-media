xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:CardBlockRequest" location="../../../BusinessServices/VisionPlusPA/fdcs/wsdl/Fdcs.wsdl" ::)

declare namespace ns0 = "http://www.procesa.com/fdcs";
declare namespace xf = "http://tempuri.org/Middleware/cardBlockIn/";

declare function xf:cardBlockIn($orgNumber as xs:string,
    $accountNumber as xs:string,
    $blockCode as xs:string)
    as element(ns0:CardBlockRequest) {
        <ns0:CardBlockRequest>
        	 <OrgNumber>{ data($orgNumber) }</OrgNumber>
            <AccountNumber>{ data($accountNumber) }</AccountNumber>
            <BlockCode>{ data($blockCode) }</BlockCode>
        </ns0:CardBlockRequest>
};

declare variable $orgNumber as xs:string external;
declare variable $accountNumber as xs:string external;
declare variable $blockCode as xs:string external;

xf:cardBlockIn($orgNumber,
    $accountNumber,
    $blockCode)
xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:OutstandingAuthorizationInquiryRequest" location="../../../BusinessServices/VisionPlus/visionPlus/xsd/XMLSchema_769155616.xsd" ::)

declare namespace ns0 = "http://www.procesa.com/fdcs";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/VisionPlus/xq/outstandingAuthorizationInquiryIn/";

declare function xf:outstandingAuthorizationInquiryIn($countryCode as xs:string,
    $org as xs:string,
    $cardNumber as xs:string,
    $beginDate as xs:string,
    $endDate as xs:string,
    $foreingUse as xs:string,
    $registerType as xs:string,
    $effDate as xs:string,
    $functionCode as xs:string,
    $actionFilter as xs:string,
    $reqNBR as xs:string,
    $authCode as xs:string)
    
    as element(ns0:OutstandingAuthorizationInquiryRequest) {
        <ns0:OutstandingAuthorizationInquiryRequest>
            <OFXOAI-ORG>{ data($org) }</OFXOAI-ORG>
            <OFXOAI-ACCT>{ data($cardNumber) }</OFXOAI-ACCT>
            <OFXOAI-EFF-DATE>{data($effDate)}</OFXOAI-EFF-DATE>
            <OFXOAI-TIME>00:00:00</OFXOAI-TIME>
            <OFXOAI-TXN-REC-TYPE>{ data($registerType) }</OFXOAI-TXN-REC-TYPE>
            <OFXOAI-ACCOUNT-LOG-EXT>0</OFXOAI-ACCOUNT-LOG-EXT>
            <OFXOAI-ACCOUNT-RBA>0</OFXOAI-ACCOUNT-RBA>
            <OFXOAI-FOREIGN-USE>{ data($foreingUse) }</OFXOAI-FOREIGN-USE>
            <OFXOAI-SVC-FUNC-CODE>{ data($functionCode) }</OFXOAI-SVC-FUNC-CODE>
            <OFXOAI-ACTION-FILTER>{ data($actionFilter) }</OFXOAI-ACTION-FILTER>
            <OFXOAI-NBR-OF-RECS-REQ>{ data($reqNBR) }</OFXOAI-NBR-OF-RECS-REQ>
            <OFXOAI-AUTH-FROM-DATE>{ fn-bea:date-from-string-with-format("yyyy-MM-dd", $beginDate) }</OFXOAI-AUTH-FROM-DATE>
            <OFXOAI-AUTH-TO-DATE>{ fn-bea:date-from-string-with-format("yyyy-MM-dd", $endDate) }</OFXOAI-AUTH-TO-DATE>
            <OFXOAI-AUTH-NBR>{ data($authCode) }</OFXOAI-AUTH-NBR>
        </ns0:OutstandingAuthorizationInquiryRequest>
};

declare variable $countryCode as xs:string external;
declare variable $org as xs:string external;
declare variable $cardNumber as xs:string external;
declare variable $beginDate as xs:string external;
declare variable $endDate as xs:string external;
declare variable $foreingUse as xs:string external;
declare variable $registerType as xs:string external;
declare variable $effDate as xs:string external;
declare variable $functionCode as xs:string external;
declare variable $actionFilter as xs:string external;
declare variable $reqNBR as xs:string external;
declare variable $authCode as xs:string external;


xf:outstandingAuthorizationInquiryIn($countryCode,
    $org,
    $cardNumber,
    $beginDate,
    $endDate,
    $foreingUse,
    $registerType,
    $effDate,
    $functionCode,
    $actionFilter,
    $reqNBR,
    $authCode)
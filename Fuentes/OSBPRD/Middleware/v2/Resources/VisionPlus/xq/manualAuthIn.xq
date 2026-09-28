(:: pragma bea:global-element-return element="ns0:ManualAuthRequest" location="../../../BusinessServices/VisionPlus/visionPlus/xsd/XMLSchema_769155616.xsd" ::)

declare namespace ns0 = "http://www.procesa.com/fdcs";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/VisionPlus/xq/manualAuthIn/";

declare function xf:manualAuthIn($cardNumber as xs:string,
    $org as xs:string,
    $storeNumber as xs:string,
    $amount as xs:string,
    $planNumber as xs:string,
    $expirationDate as xs:string,
    $accountNumber as xs:string,
    $effectiveDate as xs:string,
    $effectiveTime as xs:string,
    $rbaCode as xs:string,
    $currencyIndicator as xs:string,
    $serviceFlag as xs:string)
    as element(ns0:ManualAuthRequest) {
        <ns0:ManualAuthRequest>
            <OFXRSI-CARD-NBR>{ $cardNumber }</OFXRSI-CARD-NBR>
            <OFXRSI-STORE-ORG>{ data($org) }</OFXRSI-STORE-ORG>
            <OFXRSI-STORE-NBR>{ data($storeNumber) }</OFXRSI-STORE-NBR>
            <OFXRSI-AMT>{ data($amount) }</OFXRSI-AMT>
            <OFXRSI-PLAN>{ data($planNumber) }</OFXRSI-PLAN>
            <OFXRSI-DATE-EXPIRE>{ data($expirationDate) }</OFXRSI-DATE-EXPIRE>
            <OFXRSI-SEC-CODE>0</OFXRSI-SEC-CODE>
            <OFXRSI-SEC-CODE-IND>0</OFXRSI-SEC-CODE-IND>
            <OFXRSI-BILL-PYMT-IND/>
            <OFXRSI-RECUR-PYMT-IND/>
            <OFXRSI-ACCT>{ $accountNumber }</OFXRSI-ACCT>
            <OFXRSI-EFF-DATE>{ data($effectiveDate) }</OFXRSI-EFF-DATE>
            <OFXRSI-TIME>{ data($effectiveTime) }</OFXRSI-TIME>
            <OFXRSI-ACCOUNT-RBA>{ data($rbaCode) }</OFXRSI-ACCOUNT-RBA>
            <OFXRSI-ACCOUNT-LOG-EXT>0</OFXRSI-ACCOUNT-LOG-EXT>
            <OFXRSI-FOREIGN-USE>{ $currencyIndicator }</OFXRSI-FOREIGN-USE>
            <OFXRSI-SERVICE-FLAG>{ $serviceFlag }</OFXRSI-SERVICE-FLAG>
        </ns0:ManualAuthRequest>
};

declare variable $cardNumber as xs:string external;
declare variable $org as xs:string external;
declare variable $storeNumber as xs:string external;
declare variable $amount as xs:string external;
declare variable $planNumber as xs:string external;
declare variable $expirationDate as xs:string external;
declare variable $accountNumber as xs:string external;
declare variable $effectiveDate as xs:string external;
declare variable $effectiveTime as xs:string external;
declare variable $rbaCode as xs:string external;
declare variable $currencyIndicator as xs:string external;
declare variable $serviceFlag as xs:string external;

xf:manualAuthIn($cardNumber,
    $org,
    $storeNumber,
    $amount,
    $planNumber,
    $expirationDate,
    $accountNumber,
    $effectiveDate,
    $effectiveTime,
    $rbaCode,
    $currencyIndicator,
    $serviceFlag)
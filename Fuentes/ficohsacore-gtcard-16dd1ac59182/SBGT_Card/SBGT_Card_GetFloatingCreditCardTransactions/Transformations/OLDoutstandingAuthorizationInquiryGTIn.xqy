xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:OutstandingAuthorizationInquiryRequest" location="../../../BusinessServices/VisionPlus/visionPlus/xsd/XMLSchema_769155616.xsd" ::)

declare namespace ns0 = "http://www.procesa.com/fdcs";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/VisionPlus/xq/outstandingAuthorizationInquiryHNIn/";

declare function xf:fixDate($date as xs:string) as xs:string{

	if (fn:string-length($date) = 1 )
	then
		fn:concat('0', $date)
	else
		$date
		
};

declare function xf:outstandingAuthorizationInquiryHNIn($org as xs:string,
    $accountNumber as xs:string,
    $yesterday as xs:date)
    as element(ns0:OutstandingAuthorizationInquiryRequest) {
        <ns0:OutstandingAuthorizationInquiryRequest>
            <OFXOAI-ORG>{ $org }</OFXOAI-ORG>
            <OFXOAI-ACCT>{ $accountNumber }</OFXOAI-ACCT>
            <OFXOAI-EFF-DATE>{ fn:concat(fn:year-from-date(fn:current-date()),'-',xf:fixDate(fn:string(fn:month-from-date(fn:current-date()))),"-",xf:fixDate(fn:string(fn:day-from-date(fn:current-date())))) }</OFXOAI-EFF-DATE>
            <OFXOAI-TIME>00:00:00</OFXOAI-TIME>
            <OFXOAI-TXN-REC-TYPE>5</OFXOAI-TXN-REC-TYPE>
            <OFXOAI-ACCOUNT-LOG-EXT>0</OFXOAI-ACCOUNT-LOG-EXT>
            <OFXOAI-ACCOUNT-RBA>0</OFXOAI-ACCOUNT-RBA>
            <OFXOAI-FOREIGN-USE>0</OFXOAI-FOREIGN-USE>
            <OFXOAI-SVC-FUNC-CODE/>
            <OFXOAI-ACTION-FILTER/>
            <OFXOAI-NBR-OF-RECS-REQ>100</OFXOAI-NBR-OF-RECS-REQ>
            <OFXOAI-AUTH-FROM-DATE>{ fn:concat(fn:year-from-date(fn:current-date() - xdt:dayTimeDuration("P1D")),'-',xf:fixDate(fn:string(fn:month-from-date(fn:current-date() - xdt:dayTimeDuration("P1D")))),"-",xf:fixDate(fn:string(fn:day-from-date(fn:current-date() - xdt:dayTimeDuration("P1D"))))) }</OFXOAI-AUTH-FROM-DATE>
            <OFXOAI-AUTH-TO-DATE>{ fn:concat(fn:year-from-date(fn:current-date()),'-',xf:fixDate(fn:string(fn:month-from-date(fn:current-date()))),"-",xf:fixDate(fn:string(fn:day-from-date(fn:current-date())))) }</OFXOAI-AUTH-TO-DATE>
            <OFXOAI-AUTH-NBR/>
        </ns0:OutstandingAuthorizationInquiryRequest>
};

declare variable $org as xs:string external;
declare variable $accountNumber as xs:string external;
declare variable $yesterday as xs:date external;

xf:outstandingAuthorizationInquiryHNIn($org,
    $accountNumber,
    $yesterday)
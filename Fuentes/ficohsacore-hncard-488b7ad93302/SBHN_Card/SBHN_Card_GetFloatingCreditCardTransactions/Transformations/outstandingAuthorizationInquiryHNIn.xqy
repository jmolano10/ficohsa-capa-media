xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns0="http://www.procesa.com/fdcs";
(:: import schema at "../Schemas/XMLSchema_769155616.xsd" ::)

declare variable $org as xs:string external;
declare variable $accountNumber as xs:string external;
declare variable $yesterday as xs:date external;

declare function local:fixDate($date as xs:string) as xs:string{
	if (fn:string-length($date) = 1 )
        then 
          fn:concat('0', $date)
	else $date		
};


declare function local:func($org as xs:string, 
                            $accountNumber as xs:string, 
                            $yesterday as xs:date) 
                            as element() (:: schema-element(ns0:OutstandingAuthorizationInquiryRequest) ::) {
    <ns0:OutstandingAuthorizationInquiryRequest>
            <OFXOAI-ORG>{ $org }</OFXOAI-ORG>
            <OFXOAI-ACCT>{ $accountNumber }</OFXOAI-ACCT>
            <OFXOAI-EFF-DATE>{ fn:concat(fn:year-from-date(fn:current-date()),'-',local:fixDate(fn:string(fn:month-from-date(fn:current-date()))),"-",local:fixDate(fn:string(fn:day-from-date(fn:current-date())))) }</OFXOAI-EFF-DATE>
            <OFXOAI-TIME>00:00:00</OFXOAI-TIME>
            <OFXOAI-TXN-REC-TYPE>5</OFXOAI-TXN-REC-TYPE>
            <OFXOAI-ACCOUNT-LOG-EXT>0</OFXOAI-ACCOUNT-LOG-EXT>
            <OFXOAI-ACCOUNT-RBA>0</OFXOAI-ACCOUNT-RBA>
            <OFXOAI-FOREIGN-USE>0</OFXOAI-FOREIGN-USE>
            <OFXOAI-SVC-FUNC-CODE/>
            <OFXOAI-ACTION-FILTER/>
            <OFXOAI-NBR-OF-RECS-REQ>100</OFXOAI-NBR-OF-RECS-REQ>
            <OFXOAI-AUTH-FROM-DATE>{ fn:concat(fn:year-from-date(fn:current-date() - xs:dayTimeDuration("P1D")),'-',local:fixDate(fn:string(fn:month-from-date(fn:current-date() - xs:dayTimeDuration("P1D")))),"-",local:fixDate(fn:string(fn:day-from-date(fn:current-date() - xs:dayTimeDuration("P1D"))))) }</OFXOAI-AUTH-FROM-DATE>
            <OFXOAI-AUTH-TO-DATE>{ fn:concat(fn:year-from-date(fn:current-date()),'-',local:fixDate(fn:string(fn:month-from-date(fn:current-date()))),"-",local:fixDate(fn:string(fn:day-from-date(fn:current-date())))) }</OFXOAI-AUTH-TO-DATE>
            <OFXOAI-AUTH-NBR/>
        </ns0:OutstandingAuthorizationInquiryRequest>
};

local:func($org, $accountNumber, $yesterday)
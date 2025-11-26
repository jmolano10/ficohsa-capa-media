xquery version "1.0" encoding "Cp1252";
(:: pragma bea:global-element-return element="ns0:SettlementQuoteInquiryL8V1Request" location="../../../../../../Middleware/v2/BusinessServices/VisionPlus/visionPlus/xsd/XMLSchema_769155616.xsd" ::)

declare namespace xf = "http://tempuri.org/MWCaja/v2/Resources/CreditCardOperations/CreditCardQuery/xq/SettlementQuoteInquiryL8V1GTIn/";
declare namespace ns0 = "http://www.procesa.com/fdcs";

declare function xf:SettlementQuoteInquiryL8V1GTIn($ORG as xs:string,$ACCOUNT_NUMBER as xs:string
	,$PLAN_NUMBER as xs:string,$SECUENCE_NUMBER as xs:string)
    as element(ns0:SettlementQuoteInquiryL8V1Request) {
        <ns0:SettlementQuoteInquiryL8V1Request>
                    <ARXQII-ORG>{ data($ORG) }</ARXQII-ORG>
                    <ARXQII-ACCT>{ fn-bea:pad-left($ACCOUNT_NUMBER,19,'0') }</ARXQII-ACCT>
            		<ARXQII-PLAN>{ data($PLAN_NUMBER) }</ARXQII-PLAN>
            		<ARXQII-PLAN-SEQ>{ data($SECUENCE_NUMBER) }</ARXQII-PLAN-SEQ>
            		<ARXQII-SVC-FUNC-CODE>N</ARXQII-SVC-FUNC-CODE>
            		<ARXQII-SVC-START-SEQ-NBR>01</ARXQII-SVC-START-SEQ-NBR>            		
            		<ARXQII-PAYOFF-BY-DATE>{fn-bea:date-to-string-with-format("yyyy-MM-dd", fn:current-date())}</ARXQII-PAYOFF-BY-DATE>
            		<ARXQII-STTL-QUOTE-TYPE>P</ARXQII-STTL-QUOTE-TYPE>
            		                    
         </ns0:SettlementQuoteInquiryL8V1Request>
        
};

declare variable $ORG as xs:string external;
declare variable $ACCOUNT_NUMBER as xs:string external;
declare variable $PLAN_NUMBER as xs:string external;
declare variable $SECUENCE_NUMBER as xs:string external;

xf:SettlementQuoteInquiryL8V1GTIn($ORG,$ACCOUNT_NUMBER,$PLAN_NUMBER,$SECUENCE_NUMBER)


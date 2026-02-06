xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$cancelaFinanciamiento1" element="ns1:cancelaFinanciamiento" location="../xsd/cancelaFinanciamientoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:AccountLevelSettlementQuoteRequest" location="../../../BusinessServices/VisionPlus/visionPlus/xsd/XMLSchema_769155616.xsd" ::)

declare namespace ns0 = "http://www.procesa.com/fdcs";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/cancelaFinanciamientoTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/CancelaFinanciamiento/xq/accountLevelSettlementQuoteNIIn/";

declare function xf:accountLevelSettlementQuoteNIIn($cancelaFinanciamiento1 as element(ns1:cancelaFinanciamiento))
    as element(ns0:AccountLevelSettlementQuoteRequest) {
        <ns0:AccountLevelSettlementQuoteRequest>
            <ARXAQI-ORG>{ data($cancelaFinanciamiento1/ORG) }</ARXAQI-ORG>
            <ARXAQI-ACCT>{ data($cancelaFinanciamiento1/ACCOUNT_NUMBER) }</ARXAQI-ACCT>
            <ARXAQI-PAYOFF-BY-DATE>{ data($cancelaFinanciamiento1/CANCELLATION_DATE) }</ARXAQI-PAYOFF-BY-DATE>
            <ARXAQI-STTL-QUOTE-TYPE>P</ARXAQI-STTL-QUOTE-TYPE>
            <ARXAQI-NBR-PLAN-LEVEL-REQ>1</ARXAQI-NBR-PLAN-LEVEL-REQ>
            <ARXAQI-SVC-FUNC-CODE/>
            <ARXAQI-SVC-START-PLAN-SEQ>1</ARXAQI-SVC-START-PLAN-SEQ>
        </ns0:AccountLevelSettlementQuoteRequest>
};

declare variable $cancelaFinanciamiento1 as element(ns1:cancelaFinanciamiento) external;

xf:accountLevelSettlementQuoteNIIn($cancelaFinanciamiento1)
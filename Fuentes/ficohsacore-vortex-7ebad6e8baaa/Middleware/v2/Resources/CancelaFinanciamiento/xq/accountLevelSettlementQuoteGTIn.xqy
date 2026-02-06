xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$cancelaFinanciamiento" element="ns1:cancelaFinanciamiento" location="../xsd/cancelaFinanciamientoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:AccountLevelSettlementQuoteRequest" location="../../../BusinessServices/VisionPlus/visionPlus/xsd/XMLSchema_769155616.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/cancelaFinanciamientoTypes";
declare namespace ns0 = "http://www.procesa.com/fdcs";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/CancelaFinanciamiento/xq/accountLevelSettlementQuoteGTIn/";

declare function xf:accountLevelSettlementQuoteGTIn($cancelaFinanciamiento as element(ns1:cancelaFinanciamiento))
    as element(ns0:AccountLevelSettlementQuoteRequest) {
        <ns0:AccountLevelSettlementQuoteRequest>
            <ARXAQI-ORG>{ data($cancelaFinanciamiento/ORG) }</ARXAQI-ORG>
            <ARXAQI-ACCT>{ data($cancelaFinanciamiento/ACCOUNT_NUMBER) }</ARXAQI-ACCT>
            <ARXAQI-PAYOFF-BY-DATE>{ data($cancelaFinanciamiento/CANCELLATION_DATE) }</ARXAQI-PAYOFF-BY-DATE>
            <ARXAQI-STTL-QUOTE-TYPE>P</ARXAQI-STTL-QUOTE-TYPE>
            <ARXAQI-NBR-PLAN-LEVEL-REQ>1</ARXAQI-NBR-PLAN-LEVEL-REQ>
            <ARXAQI-SVC-FUNC-CODE/>
            <ARXAQI-SVC-START-PLAN-SEQ>1</ARXAQI-SVC-START-PLAN-SEQ>
        </ns0:AccountLevelSettlementQuoteRequest>
};

declare variable $cancelaFinanciamiento as element(ns1:cancelaFinanciamiento) external;

xf:accountLevelSettlementQuoteGTIn($cancelaFinanciamiento)
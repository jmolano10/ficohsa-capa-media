xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$planLevelSettlementQuoteResponse" element="ns0:PlanLevelSettlementQuoteResponse" location="../../../../v2/BusinessServices/VisionPlus/visionPlus/xsd/XMLSchema_769155616.xsd" ::)
(:: pragma bea:global-element-return element="ns1:cancelaFinanciamientoResponse" location="../xsd/cancelaFinanciamientoTypes.xsd" ::)

declare namespace ns0 = "http://www.procesa.com/fdcs";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/cancelaFinanciamientoTypes";
declare namespace xf = "http://tempuri.org/Middleware/v3/Resources/CancelaFinanciamiento/xq/cancelaFinanciamiento/";

declare function xf:cancelaFinanciamiento($planLevelSettlementQuoteResponse as element(ns0:PlanLevelSettlementQuoteResponse))
    as element(ns1:cancelaFinanciamientoResponse) {
        <ns1:cancelaFinanciamientoResponse>
            <ORG>{ data($planLevelSettlementQuoteResponse/ARXPQO-ORG) }</ORG>
            <ALTERN_ORG>{ data($planLevelSettlementQuoteResponse/ARXPQO-FOREIGN-ORG) }</ALTERN_ORG>
            <LOGO>{ data($planLevelSettlementQuoteResponse/ARXPQO-LOGO) }</LOGO>
            <ACCOUNT_NUMBER>{ data($planLevelSettlementQuoteResponse/ARXPQO-ACCT-NBR) }</ACCOUNT_NUMBER>
            <CARD_NUMBER>{ data($planLevelSettlementQuoteResponse/ARXPQO-CARD-NBR) }</CARD_NUMBER>
            <PLAN_SECUENCE>{ data($planLevelSettlementQuoteResponse/ARXPQO-REC-NBR) }</PLAN_SECUENCE>
            <REFERENCE_NUMBER>{ data($planLevelSettlementQuoteResponse/ARXPQO-REF-NBR) }</REFERENCE_NUMBER>
            <CANCELLATION_INDICATOR>{ data($planLevelSettlementQuoteResponse/ARXPQO-SD-PRJ-STTLMT-TYPE) }</CANCELLATION_INDICATOR>
            <ORIGINAL_LOAN_TERM>{ data($planLevelSettlementQuoteResponse/ARXPQO-CEL-ORIG-TERM) }</ORIGINAL_LOAN_TERM>
            <PENDING_LOAN_TERM>{ data($planLevelSettlementQuoteResponse/ARXPQO-CEL-REMAINING-TERM) }</PENDING_LOAN_TERM>
            <PLAN_DATE>{ data($planLevelSettlementQuoteResponse/ARXPQO-PLAN-DATE) }</PLAN_DATE>
            <BILL_FIRST_DATE>{ data($planLevelSettlementQuoteResponse/ARXPQO-CEL-1ST-PMT-DATE) }</BILL_FIRST_DATE>
            <EXPIRATION_LOAN_DATE>{ data($planLevelSettlementQuoteResponse/ARXPQO-CEL-FINAL-PMT-DATE) }</EXPIRATION_LOAN_DATE>
            <EARLY_CANCELLATION_DATE>{ data($planLevelSettlementQuoteResponse/ARXPQO-PAYOFF-BY-DATE-1) }</EARLY_CANCELLATION_DATE>
            <TOTAL_LOAN_AMOUNT>{ data($planLevelSettlementQuoteResponse/ARXPQO-CURR-OUTSTANDINGBAL-1) }</TOTAL_LOAN_AMOUNT>
            <BILLED_INTEREST_AMOUNT>{ data($planLevelSettlementQuoteResponse/ARXPQO-SD-PRJ-INT-PNLTY-1) }</BILLED_INTEREST_AMOUNT>
            <BILLED_INSURANCE_AMOUNT>{ data($planLevelSettlementQuoteResponse/ARXPQO-SD-PRJ-INS-PNLTY-1) }</BILLED_INSURANCE_AMOUNT>
            <PENALTY_AMOUNT>{ data($planLevelSettlementQuoteResponse/ARXPQO-SD-PRJ-USER1-REBTE-1) }</PENALTY_AMOUNT>
            <PRINCIPAL_AMOUNT>{ data($planLevelSettlementQuoteResponse/ARXPQO-SD-PRJ-USER2-REBTE-1) }</PRINCIPAL_AMOUNT>
            <UNBILLED_DISBURSEMENT_COMMISSION>{ data($planLevelSettlementQuoteResponse/ARXPQO-SD-PRJ-USER3-REBTE-1) }</UNBILLED_DISBURSEMENT_COMMISSION>
            <DISBURSEMENT_COMMISSION_TERM>{ data($planLevelSettlementQuoteResponse/ARXPQO-SD-PRJ-TERM-FEE-1) }</DISBURSEMENT_COMMISSION_TERM>
            <ACCRUED_INTEREST_AMOUNT>{ data($planLevelSettlementQuoteResponse/ARXPQO-SD-PRJ-ACCT-INT-1) }</ACCRUED_INTEREST_AMOUNT>
            <UNBILLED_LOAN_AMOUNT>{ data($planLevelSettlementQuoteResponse/ARXPQO-PMT-WITHOUT-PMTDUE-1) }</UNBILLED_LOAN_AMOUNT>
            <CANCELLATION_LOAN_AMOUNT>{ data($planLevelSettlementQuoteResponse/ARXPQO-PMT-WITH-PMT-DUE-1) }</CANCELLATION_LOAN_AMOUNT>
        </ns1:cancelaFinanciamientoResponse>
};

declare variable $planLevelSettlementQuoteResponse as element(ns0:PlanLevelSettlementQuoteResponse) external;

xf:cancelaFinanciamiento($planLevelSettlementQuoteResponse)
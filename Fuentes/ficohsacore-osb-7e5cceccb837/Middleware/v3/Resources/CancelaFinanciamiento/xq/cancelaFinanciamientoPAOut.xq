(:: pragma bea:global-element-parameter parameter="$planLevelSettlementQuoteL8V1Response" element="ns0:PlanLevelSettlementQuoteL8V1Response" location="../../../../v2/BusinessServices/VisionPlus/visionPlus/xsd/XMLSchema_769155616.xsd" ::)
(:: pragma bea:global-element-return element="ns1:cancelaFinanciamientoResponse" location="../xsd/cancelaFinanciamientoTypes.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/cancelaFinanciamientoTypes";
declare namespace ns0 = "http://www.procesa.com/fdcs";
declare namespace xf = "http://tempuri.org/Middleware/v3/Resources/CancelaFinanciamiento/xq/cancelaFinanciamientoPAOut/";

declare function xf:cancelaFinanciamientoPAOut($planLevelSettlementQuoteL8V1Response as element(ns0:PlanLevelSettlementQuoteL8V1Response))
    as element(ns1:cancelaFinanciamientoResponse) {
        <ns1:cancelaFinanciamientoResponse>
            <ORG>{ data($planLevelSettlementQuoteL8V1Response/ARXPQO-ORG) }</ORG>
            <ALTERN_ORG>{ data($planLevelSettlementQuoteL8V1Response/ARXPQO-FOREIGN-ORG) }</ALTERN_ORG>
            <LOGO>{ data($planLevelSettlementQuoteL8V1Response/ARXPQO-LOGO) }</LOGO>
            <ACCOUNT_NUMBER>{ data($planLevelSettlementQuoteL8V1Response/ARXPQO-ACCT-NBR) }</ACCOUNT_NUMBER>
            <CARD_NUMBER>{ data($planLevelSettlementQuoteL8V1Response/ARXPQO-CARD-NBR) }</CARD_NUMBER>
            <PLAN_SECUENCE>{ data($planLevelSettlementQuoteL8V1Response/ARXPQO-REC-NBR) }</PLAN_SECUENCE>
            <REFERENCE_NUMBER>{ data($planLevelSettlementQuoteL8V1Response/ARXPQO-REF-NBR) }</REFERENCE_NUMBER>
            <CANCELLATION_INDICATOR>{ data($planLevelSettlementQuoteL8V1Response/ARXPQO-SD-PRJ-STTLMT-TYPE) }</CANCELLATION_INDICATOR>
            <ORIGINAL_LOAN_TERM>{ data($planLevelSettlementQuoteL8V1Response/ARXPQO-CEL-ORIG-TERM) }</ORIGINAL_LOAN_TERM>
            <PENDING_LOAN_TERM>{ data($planLevelSettlementQuoteL8V1Response/ARXPQO-CEL-REMAINING-TERM) }</PENDING_LOAN_TERM>
            <PLAN_DATE>{ data($planLevelSettlementQuoteL8V1Response/ARXPQO-PLAN-DATE) }</PLAN_DATE>
            <BILL_FIRST_DATE>{ data($planLevelSettlementQuoteL8V1Response/ARXPQO-CEL-1ST-PMT-DATE) }</BILL_FIRST_DATE>
            <EXPIRATION_LOAN_DATE>{ data($planLevelSettlementQuoteL8V1Response/ARXPQO-CEL-FINAL-PMT-DATE) }</EXPIRATION_LOAN_DATE>
            <EARLY_CANCELLATION_DATE>{ data($planLevelSettlementQuoteL8V1Response/ARXPQO-PAYOFF-BY-DATE-1) }</EARLY_CANCELLATION_DATE>
            <TOTAL_LOAN_AMOUNT>{ data($planLevelSettlementQuoteL8V1Response/ARXPQO-CURR-OUTSTANDINGBAL-1) }</TOTAL_LOAN_AMOUNT>
            <BILLED_INTEREST_AMOUNT>{ data($planLevelSettlementQuoteL8V1Response/ARXPQO-SD-PRJ-INT-PNLTY-1) }</BILLED_INTEREST_AMOUNT>
            <BILLED_INSURANCE_AMOUNT>{ data($planLevelSettlementQuoteL8V1Response/ARXPQO-SD-PRJ-INS-PNLTY-1) }</BILLED_INSURANCE_AMOUNT>
            <PENALTY_AMOUNT>{ data($planLevelSettlementQuoteL8V1Response/ARXPQO-SD-PRJ-USER1-REBTE-1) }</PENALTY_AMOUNT>
            <PRINCIPAL_AMOUNT>{ data($planLevelSettlementQuoteL8V1Response/ARXPQO-SD-PRJ-USER2-REBTE-1) }</PRINCIPAL_AMOUNT>
            <UNBILLED_DISBURSEMENT_COMMISSION>{ data($planLevelSettlementQuoteL8V1Response/ARXPQO-SD-PRJ-USER3-REBTE-1) }</UNBILLED_DISBURSEMENT_COMMISSION>
            <DISBURSEMENT_COMMISSION_TERM>{ data($planLevelSettlementQuoteL8V1Response/ARXPQO-SD-PRJ-TERM-FEE-1) }</DISBURSEMENT_COMMISSION_TERM>
            <ACCRUED_INTEREST_AMOUNT>{ data($planLevelSettlementQuoteL8V1Response/ARXPQO-SD-PRJ-ACCT-INT-1) }</ACCRUED_INTEREST_AMOUNT>
            <UNBILLED_LOAN_AMOUNT>{ data($planLevelSettlementQuoteL8V1Response/ARXPQO-PMT-WITHOUT-PMTDUE-1) }</UNBILLED_LOAN_AMOUNT>
            <CANCELLATION_LOAN_AMOUNT>{ data($planLevelSettlementQuoteL8V1Response/ARXPQO-PMT-WITH-PMT-DUE-1) }</CANCELLATION_LOAN_AMOUNT>
            <ITBMS>{ data($planLevelSettlementQuoteL8V1Response/ARXPQO-SD-PRJ-USER6-REBTE-1) }</ITBMS>
            <SETTLEMENT_TYPE>{ data($planLevelSettlementQuoteL8V1Response/ARXPQO-PARTIAL-SETL-TYPE) }</SETTLEMENT_TYPE>
            <METHOD_PAYMENT>{ data($planLevelSettlementQuoteL8V1Response/ARXPQO-PS-QUOTE-TYPE) }</METHOD_PAYMENT>
            <NEW_TERM>{ data($planLevelSettlementQuoteL8V1Response/ARXPQO-PS-NEW-TERM) }</NEW_TERM>
            <NEW_FIXED_PMT_AMD>{ data($planLevelSettlementQuoteL8V1Response/ARXPQO-PS-NEW-FIXED-PMT-AMT) }</NEW_FIXED_PMT_AMD>
        </ns1:cancelaFinanciamientoResponse>
};

declare variable $planLevelSettlementQuoteL8V1Response as element(ns0:PlanLevelSettlementQuoteL8V1Response) external;

xf:cancelaFinanciamientoPAOut($planLevelSettlementQuoteL8V1Response)

package com.ficohsa.model.settlementquotedetails;

import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class SettlementQuoteDetailsModel {

    private SettlementQuoteInquiry settlementQuoteInquiry;

    @Data
    @Builder
    public static class SettlementQuoteInquiry {

        private String organizationReference;
        private String alternateOrganization;
        private String organizationLogo;
        private String accountNumber;
        private String creditCardId;
        private String accountSettlementDate;
        private String accountSettlementAmount;
        private PlanData planData;
    }

    @Data
    @Builder
    public static class PlanData {

        private String productReference;
        private String productType;
        private String productDescription;
        private String quoteType;
        private String settlementDate;
        private String planSettlementAmount;
        private String repaymentType;
        private String repaymentMethod;
        private String newTerm;
        private String newPaymentAmount;
    }
}

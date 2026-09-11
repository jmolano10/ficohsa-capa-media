package com.ficohsa.driven.creditcard.cachecomponent.dto.request;

import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class CacheComponentRequest {

    private String org;
    private String foreignOrg;
    private String logo;
    private String accountNumber;
    private String cardNumber;
    private String accountPayoffDate;
    private String accountPayoffAmount;
    private PlanData planData;

    @Data
    @Builder
    private static class PlanData {

        private PlanEntry planEntry;
    }

    @Data
    @Builder
    public static class PlanEntry {

        private String planRef;
        private String planType;
        private String planDescription;
        private String quoteType;
        private String payoffDate;
        private String planPayoffAmount;
        private String paymentType;
        private String methodPayment;
        private String newTerm;
        private String newPaymentAmount;
    }
}

package com.ficohsa.driven.creditcard.cachecomponent.dto.response;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonProperty;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
public class CacheSettlementQuoteDetailsResponse {

    @JsonProperty("value")
    private ValueData value;

    @Data
    @Builder
   public static class ValueData {

       @JsonProperty("org")
       private String org;

       @JsonProperty("foreignOrg")
       private String foreignOrg;

       @JsonProperty("logo")
       private String logo;

       @JsonProperty("accountNumber")
       private String accountNumber;

       @JsonProperty("cardNumber")
       private String cardNumber;

       @JsonProperty("accountPayoffDate")
       private String accountPayoffDate;

       @JsonProperty("accountPayoffAmount")
       private String accountPayoffAmount;

       @JsonProperty("planData")
       private PlanData planData;
    }

    @Data
    @Builder
    @NoArgsConstructor
    @AllArgsConstructor
    @JsonIgnoreProperties(ignoreUnknown = true)
    @JsonInclude(JsonInclude.Include.NON_NULL)
    public static class PlanData {

        @JsonProperty("planRef")
        private String planRef;

        @JsonProperty("planType")
        private String planType;

        @JsonProperty("planDescription")
        private String planDescription;

        @JsonProperty("quoteType")
        private String quoteType;

        @JsonProperty("payoffDate")
        private String payoffDate;

        @JsonProperty("planPayoffAmount")
        private String planPayoffAmount;

        @JsonProperty("paymentType")
        private String paymentType;

        @JsonProperty("methodPayment")
        private String methodPayment;

        @JsonProperty("newTerm")
        private String newTerm;

        @JsonProperty("newPaymentAmount")
        private String newPaymentAmount;
    }
}

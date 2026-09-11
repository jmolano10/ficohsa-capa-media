package com.ficohsa.driven.visionplus.dto.request;

import com.fasterxml.jackson.annotation.JsonAnyGetter;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Collections;
import java.util.Map;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
@JsonInclude(JsonInclude.Include.NON_NULL)
public class VisionPlusRequest {

    @JsonProperty("data")
    private VisionPlusData data;

    @JsonProperty("cacheKeyFields")
    private CacheKeyFields cacheKeyFields;

    @JsonProperty("ttl")
    private String ttl;

    @JsonProperty("paramName")
    private String paramName;

    @Data
    @Builder
    @AllArgsConstructor
    @NoArgsConstructor
    @JsonInclude(JsonInclude.Include.NON_NULL)
    public static class VisionPlusData {

        @JsonIgnore
        private String operation;

        @JsonIgnore
        private SettlementQuoteInquiryRequest request;

        @JsonAnyGetter
        public Map<String, SettlementQuoteInquiryRequest> getDynamicRequest() {
            if (operation == null || request == null) {
                return Collections.emptyMap();
            }
            return Map.of(operation + "Request", request);
        }
    }

    @Data
    @Builder
    @AllArgsConstructor
    @NoArgsConstructor
    @JsonInclude(JsonInclude.Include.NON_NULL)
    public static class CacheKeyFields {

        @JsonProperty("org")
        private String org;

        @JsonProperty("accountNumber")
        private String accountNumber;

        @JsonProperty("planNumber")
        private String planNumber;

        @JsonProperty("seccuenceNumber")
        private String seccuenceNumber;

        @JsonProperty("cancellationDate")
        private String cancellationDate;
    }

    @Data
    @Builder
    @AllArgsConstructor
    @NoArgsConstructor
    @JsonInclude(JsonInclude.Include.NON_NULL)
    public static class SettlementQuoteInquiryRequest {

        @JsonProperty("ARXQII-ORG")
        private String organization;

        @JsonProperty("ARXQII-ACCT")
        private String account;

        @JsonProperty("ARXQII-PLAN")
        private String plan;

        @JsonProperty("ARXQII-PLAN-SEQ")
        private String planSequence;

        @JsonProperty("ARXQII-SVC-FUNC-CODE")
        private String serviceFunctionCode;

        @JsonProperty("ARXQII-SVC-START-SEQ-NBR")
        private String serviceStartSequenceNumber;

        @JsonProperty("ARXQII-PAYOFF-BY-DATE")
        private String payoffByDate;

        @JsonProperty("ARXQII-STTL-QUOTE-TYPE")
        private String settlementQuoteType;

        @JsonProperty("ARXQII-PARTIAL-SETL-AMT")
        private String partialSettlementAmount;

        @JsonProperty("ARXQII-PS-TYPE")
        private String psType;
    }
}

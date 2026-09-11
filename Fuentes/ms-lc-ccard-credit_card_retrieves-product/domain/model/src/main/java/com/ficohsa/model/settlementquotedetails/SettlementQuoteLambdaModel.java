package com.ficohsa.model.settlementquotedetails;

import lombok.Builder;
import lombok.Data;

import java.util.List;

@Data
@Builder
public class SettlementQuoteLambdaModel {

        private String name;
        private ValueConfig value;
        private String type;
        private String description;
        private String country;
        private String domain;
        private List<String> tags;
        private Integer precedence;
        private String effectiveFrom;
        private String effectiveTo;
        private String status;
        private String updatedAt;
        private String updatedBy;


    @Data
    @Builder
    public static class ValueConfig {

        private MethodsConfig methods;
    }

    @Data
    @Builder
    public static class MethodsConfig {

        private MethodConfig debitCardDetails;
        private MethodConfig settlementQuoteDetails;
        private MethodConfig debitBasicInformation;
    }

    @Data
    @Builder
    public static class MethodConfig {

        private List<RegionConfig> regions;
        private CacheConfig cache;
    }

    @Data
    @Builder
    public static class RegionConfig {

        private String region;
        private Boolean enabled;
    }

    @Data
    @Builder
    public static class CacheConfig {

        private Boolean enabled;
        private Integer ttlSeconds;
        private List<String> cacheKeyFields;
    }
}

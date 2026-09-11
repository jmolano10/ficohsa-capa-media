package com.ficohsa.driven.cobis.dto.response;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Data;

import java.util.List;

@Data
public class CobisSpResponse {
    private CobisSpMeta meta;
    private CobisSpData data;

    @Data
    public static class CobisSpMeta {
        private String wrapper;
    }

    @Data
    public static class CobisSpData {
        @JsonProperty("#result-set-1")
        private List<CobisSpCardData> resultSet1;
        
        @JsonProperty("RETURN_VALUE")
        private Integer returnValue;
    }

    @Data
    public static class CobisSpCardData {
        @JsonProperty("CARD_NUMBER")
        private String cardNumber;
        
        @JsonProperty("CARD_HOLDER_NAME")
        private String cardHolderName;
        
        @JsonProperty("CARD_CATEGORY")
        private String cardCategory;
        
        @JsonProperty("CARD_TYPE")
        private String cardType;
        
        @JsonProperty("ISSUE_DATE")
        private String issueDate;
        
        @JsonProperty("CARD_BRAND")
        private String cardBrand;
        
        @JsonProperty("CARD_CURRENCY")
        private String cardCurrency;
        
        @JsonProperty("CARD_ACCOUNT_NUMBER")
        private String cardAccountNumber;
        
        @JsonProperty("CARD_STATUS")
        private String cardStatus;
    }
}

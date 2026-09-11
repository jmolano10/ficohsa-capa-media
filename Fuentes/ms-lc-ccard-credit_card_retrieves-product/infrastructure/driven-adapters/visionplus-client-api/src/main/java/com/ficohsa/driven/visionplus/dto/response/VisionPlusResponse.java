package com.ficohsa.driven.visionplus.dto.response;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.databind.annotation.JsonDeserialize;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
@JsonIgnoreProperties(ignoreUnknown = true)
public class VisionPlusResponse {

    private Meta meta;
    private DataContainer data;
    private Links links;

    @Data
    @AllArgsConstructor
    @NoArgsConstructor
    @JsonIgnoreProperties(ignoreUnknown = true)
    public static class Meta {
        private Object bian;
    }

    @Data
    @AllArgsConstructor
    @NoArgsConstructor
    @JsonIgnoreProperties(ignoreUnknown = true)
    public static class Links {
        private String self;
    }

    @Data
    @AllArgsConstructor
    @NoArgsConstructor
    @JsonIgnoreProperties(ignoreUnknown = true)
    public static class DataContainer {
        private BodyData body;
    }

    @Data
    @AllArgsConstructor
    @NoArgsConstructor
    @JsonIgnoreProperties(ignoreUnknown = true)
    public static class BodyData {
        @JsonProperty("settlementQuoteInquiryL8V1Response")
        private SettlementQuoteInquiryResponse settlementQuoteInquiryL8V1Response;

        @JsonProperty("settlementQuoteInquiryL8V2Response")
        private SettlementQuoteInquiryResponse settlementQuoteInquiryL8V2Response;

        public SettlementQuoteInquiryResponse getSettlementQuoteInquiryResponse() {
            return settlementQuoteInquiryL8V1Response != null ? 
                   settlementQuoteInquiryL8V1Response : settlementQuoteInquiryL8V2Response;
        }
    }

    @Data
    @AllArgsConstructor
    @NoArgsConstructor
    @JsonIgnoreProperties(ignoreUnknown = true)
    public static class SettlementQuoteInquiryResponse {

        @JsonProperty("serviceReturnCode")
        private String serviceReturnCode;

        @JsonProperty("returnCodeCount")
        private String returnCodeCount;

        @JsonProperty("returnCodes")
        @JsonDeserialize(using = ReturnCodesWrapperDeserializer.class)
        private ReturnCodesWrapper returnCodes;

        @JsonProperty("arxqioCurrencyNod")
        private String currencyNod;

        @JsonProperty("arxqioCurrencyCode")
        private String currencyCode;

        @JsonProperty("arxqioForeignUse")
        private String foreignUse;

        @JsonProperty("arxqioOrg")
        private String org;

        @JsonProperty("arxqioForeignOrg")
        private String foreignOrg;

        @JsonProperty("arxqioLogo")
        private String logo;

        @JsonProperty("arxqioAcctNbr")
        private String accountNumber;

        @JsonProperty("arxqioCardNbr")
        private String cardNumber;

        @JsonProperty("arxqioAcctQuote")
        private String acctQuote;

        @JsonProperty("arxqioAcctPayoffDate")
        private String accountPayoffDate;

        @JsonProperty("arxqioAcctPayoffAmt")
        private String accountPayoffAmount;

        @JsonProperty("arxqioRrMoreInd")
        private String rrMoreInd;

        @JsonProperty("arxqioSvcStartSeqNbr")
        private String svcStartSeqNbr;

        @JsonProperty("arxqioPlanNbrOccurs")
        private String planNbrOccurs;

        @JsonProperty("arxqioPlanData")
        private PlanDataWrapper planData;

        @JsonProperty("arxqioFiller")
        private String filler;

        @JsonProperty("arxqioUserFiller")
        private String userFiller;
    }

    @Data
    @AllArgsConstructor
    @NoArgsConstructor
    @JsonIgnoreProperties(ignoreUnknown = true)
    public static class ReturnCodesWrapper {
        @JsonProperty("rc")
        @JsonDeserialize(using = RcListDeserializer.class)
        private List<ReturnCode> rc;
    }

    @Data
    @AllArgsConstructor
    @NoArgsConstructor
    @JsonIgnoreProperties(ignoreUnknown = true)
    public static class ReturnCode {
        @JsonProperty("code")
        private String code;
        @JsonProperty("desc")
        private String desc;
    }

    @Data
    @AllArgsConstructor
    @NoArgsConstructor
    @JsonIgnoreProperties(ignoreUnknown = true)
    public static class PlanDataWrapper {
        @JsonProperty("arxqioPlanEntry")
        @JsonDeserialize(using = PlanEntryListDeserializer.class)
        private List<PlanEntry> arxqioPlanEntry;
    }

    @Data
    @AllArgsConstructor
    @NoArgsConstructor
    @JsonIgnoreProperties(ignoreUnknown = true)
    public static class PlanEntry {

        @JsonProperty("arxqioSubPlan")
        private String subPlan;

        @JsonProperty("arxqioPlanSeq")
        private String planSeq;

        @JsonProperty("arxqioPlanRef")
        private String planRef;

        @JsonProperty("arxqioPlanType")
        private String planType;

        @JsonProperty("arxqioPlanDesc")
        private String planDescription;

        @JsonProperty("arxqioPlanOpenDate")
        private String planOpenDate;

        @JsonProperty("arxqioQuoteType")
        private String quoteType;

        @JsonProperty("arxqioPayoffDate1")
        private String payoffDate1;

        @JsonProperty("arxqioPlanPayoffAmt1")
        private String planPayoffAmount1;

        @JsonProperty("arxqioPayoffDate2")
        private String payoffDate2;

        @JsonProperty("arxqioPlanPayoffAmt2")
        private String planPayoffAmount2;

        @JsonProperty("arxqioCurrBal")
        private String currBal;

        @JsonProperty("arxqioPartialSetlType")
        private String partialSetlType;

        @JsonProperty("arxqioPsQuoteType")
        private String psQuoteType;

        @JsonProperty("arxqioPsNewTerm")
        private String psNewTerm;

        @JsonProperty("arxqioPsNewFixedPmtAmt")
        private String psNewFixedPmtAmt;
    }
}

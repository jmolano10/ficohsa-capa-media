package com.ficohsa.driven.t24.dto.response;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class T24DataDto {
    private BodyDto body;

    @Data
    @Builder
    @NoArgsConstructor
    @AllArgsConstructor
    public static class BodyDto {
        private ConsultaMaestraTarjetaDebitoResponseDto consultaMaestraTarjetaDebitoResponse;
    }

    @Data
    @Builder
    @NoArgsConstructor
    @AllArgsConstructor
    public static class ConsultaMaestraTarjetaDebitoResponseDto {
        private StatusDto status;
        private WsficodebitcardcustomerTypeDto wsficodebitcardcustomerType;
    }

    @Data
    @Builder
    @NoArgsConstructor
    @AllArgsConstructor
    public static class StatusDto {
        private String successIndicator;
        private String messages;
    }

    @Data
    @Builder
    @NoArgsConstructor
    @AllArgsConstructor
    public static class WsficodebitcardcustomerTypeDto {
        @JsonProperty("gWsficodebitcardcustomerDetailType")
        private GWsficodebitcardcustomerDetailTypeDto gWsficodebitcardcustomerDetailType;
        private String zerorecords;
    }

    @Data
    @Builder
    @NoArgsConstructor
    @AllArgsConstructor
    public static class GWsficodebitcardcustomerDetailTypeDto {
        @JsonProperty("mWsficodebitcardcustomerDetailType")
        private MWsficodebitcardcustomerDetailTypeDto mWsficodebitcardcustomerDetailType;
    }

    @Data
    @Builder
    @NoArgsConstructor
    @AllArgsConstructor
    public static class MWsficodebitcardcustomerDetailTypeDto {
        private String customer;
        private String cardnumber;
        private String nameoncard;
        private String currency1;
        private String primaryacct;
        private String scndryacct;
        private String cardstatus;
        private String typeofcard;
        private String producttype;
        private String customerlegalId;
        private String issuedate;
    }
}

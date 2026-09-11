package com.ficohsa.driven.creditcard.errormanager.dto;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Builder;

@Builder(toBuilder = true)
public record ErrorResponse(Data data) {

    @Builder(toBuilder = true)
    public record Data(
            @JsonProperty("success_indicator")
            String indicator,

            @JsonProperty("message_id")
            String id,
            String messages) {
    }
}

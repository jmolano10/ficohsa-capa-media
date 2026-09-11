package com.ficohsa.driven.creditcard.errormanager.dto;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Builder;

@Builder(toBuilder = true)
public record ErrorRequest(
        @JsonProperty("codigo_error")
        String code,
        @JsonProperty("texto_error")
        String text) {
}

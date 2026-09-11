package com.ficohsa.driven.creditcard.datawarehouse.dto.response;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Data;

@Data
public class CreditCardDto {
    @JsonProperty("CUENTA")
    private CardAccountDto cardAccountDto;
}

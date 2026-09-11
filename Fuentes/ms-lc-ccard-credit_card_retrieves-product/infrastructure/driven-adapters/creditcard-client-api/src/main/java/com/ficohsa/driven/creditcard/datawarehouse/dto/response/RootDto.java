package com.ficohsa.driven.creditcard.datawarehouse.dto.response;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Data;

@Data
public class RootDto {
    @JsonProperty("CLIENTE")
    private ClientsDto client;
}


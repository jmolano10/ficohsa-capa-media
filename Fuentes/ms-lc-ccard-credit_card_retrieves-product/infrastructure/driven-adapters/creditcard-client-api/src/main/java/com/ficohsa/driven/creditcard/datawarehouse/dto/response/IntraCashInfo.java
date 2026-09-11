package com.ficohsa.driven.creditcard.datawarehouse.dto.response;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Data;

@Data
public class IntraCashInfo {

    @JsonProperty("SALDOINTRA")
    private String balance;

    @JsonProperty("CUOTAINTRA")
    private String installment;

    @JsonProperty("INTERESESINTRA")
    private String interest;

    @JsonProperty("CARGOSINTRA")
    private String fee;

}

package com.ficohsa.driven.creditcard.datawarehouse.dto.response;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Data;

@Data
public class ExtraCashInfo {

    @JsonProperty("SALDOEXTRA")
    private String balance;

    @JsonProperty("CUOTAEXTRA")
    private String installment;

    @JsonProperty("INTERESESEXTRA")
    private String interest;

    @JsonProperty("CARGOSINTRA")
    private String fee;
}

package com.ficohsa.driven.creditcard.datawarehouse.dto.response;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Data;

import java.util.List;

@Data
public class ProductTransactions {

    @JsonProperty("TRANSACCIONESTARJETA")
    private List<Transaction> transaction;

}

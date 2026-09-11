package com.ficohsa.driven.creditcard.r2dbc.dto;

import lombok.Data;

import java.math.BigDecimal;
import java.time.LocalDateTime;

@Data
public class CreditCardRowDto {
    private String creditCardId;
    private String accountNumber;
    private String cardHolderName;
    private BigDecimal cardType;
    private String cardProductName;
    private Integer cardOperationalStatus;
    private Integer cardProductType;
    private String cardAffinityGroup;
    private LocalDateTime cardEffectiveDate;
    private String nameField;
    private String valueField;
}

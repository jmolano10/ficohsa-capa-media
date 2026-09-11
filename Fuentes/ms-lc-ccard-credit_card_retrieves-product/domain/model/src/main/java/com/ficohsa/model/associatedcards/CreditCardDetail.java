package com.ficohsa.model.associatedcards;

import lombok.Data;

@Data
public class CreditCardDetail {
    private String creditCardId;
    private String accountNumber;
    private String cardHolderName;
    private String cardType;
    private String cardProductName;
    private String cardOperationalStatus;
    private String cardProductType;
    private String cardAffinityGroup;
    private String cardEffectiveDate;
    private AdditionalInformation additionalInformation;
}

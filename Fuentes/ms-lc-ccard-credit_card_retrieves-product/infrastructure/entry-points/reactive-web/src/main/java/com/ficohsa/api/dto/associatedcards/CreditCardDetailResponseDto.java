package com.ficohsa.api.dto.associatedcards;

import lombok.Builder;

@Builder
public record CreditCardDetailResponseDto(
    String creditCardId,
    String accountNumber,
    String cardHolderName,
    String cardType,
    String cardProductName,
    String cardOperationalStatus,
    String cardProductType,
    String cardAffinityGroup,
    String cardEffectiveDate,
    AdditionalInformationResponseDto additionalInformation
) {}

package com.ficohsa.api.dto.associatedcards;

import lombok.Builder;
import java.util.List;

@Builder
public record CreditCardPortfolioResponseDto(
    List<CreditCardDetailResponseDto> creditCardDetails
) {}

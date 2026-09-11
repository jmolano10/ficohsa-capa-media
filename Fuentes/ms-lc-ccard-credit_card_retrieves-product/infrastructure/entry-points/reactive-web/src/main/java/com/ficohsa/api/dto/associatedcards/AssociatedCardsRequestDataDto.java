package com.ficohsa.api.dto.associatedcards;

import com.ficohsa.api.dto.CreditCardRetrieveRequestDto;
import jakarta.validation.Valid;
import lombok.Builder;

@Builder
public record AssociatedCardsRequestDataDto(
    @Valid CreditCardRetrieveRequestDto creditCardRetrieveRequest
) {}

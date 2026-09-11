package com.ficohsa.api.dto.associatedcards;

import jakarta.validation.Valid;
import jakarta.validation.constraints.NotNull;
import lombok.Builder;

@Builder
public record AssociatedCardsRequestDto(
    @NotNull @Valid AssociatedCardsRequestDataDto data
) {}

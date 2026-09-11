package com.ficohsa.api.dto;

import jakarta.validation.Valid;
import jakarta.validation.constraints.NotBlank;
import lombok.Builder;
import java.util.List;

@Builder
public record CreditCardRetrieveRequestDto(
    @Valid CustomerFilterDto customerFilter,
    @NotBlank String creditCardStatus,
    List<FilterCriteriaDto> filterCriterias
) {}

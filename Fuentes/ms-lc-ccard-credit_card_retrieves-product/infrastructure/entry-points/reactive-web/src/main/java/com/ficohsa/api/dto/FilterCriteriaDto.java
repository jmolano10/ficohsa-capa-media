package com.ficohsa.api.dto;

import lombok.Builder;

@Builder
public record FilterCriteriaDto(
    String filterId,
    String filterType,
    String filterValue
) {}

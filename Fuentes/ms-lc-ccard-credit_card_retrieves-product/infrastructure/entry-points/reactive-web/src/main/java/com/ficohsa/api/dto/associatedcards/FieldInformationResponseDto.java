package com.ficohsa.api.dto.associatedcards;

import lombok.Builder;

@Builder
public record FieldInformationResponseDto(
    String nameField,
    String valueField
) {}

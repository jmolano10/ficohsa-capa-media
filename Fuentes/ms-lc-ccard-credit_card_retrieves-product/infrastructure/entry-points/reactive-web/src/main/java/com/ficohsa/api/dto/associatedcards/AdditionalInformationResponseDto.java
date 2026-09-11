package com.ficohsa.api.dto.associatedcards;

import lombok.Builder;

@Builder
public record AdditionalInformationResponseDto(
    FieldInformationResponseDto fieldInformation
) {}

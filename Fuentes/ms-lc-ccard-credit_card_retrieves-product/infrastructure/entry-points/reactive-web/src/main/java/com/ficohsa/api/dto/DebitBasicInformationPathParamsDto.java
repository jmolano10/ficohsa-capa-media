package com.ficohsa.api.dto;

import lombok.Builder;

@Builder
public record DebitBasicInformationPathParamsDto(
    String creditCardId
) {}

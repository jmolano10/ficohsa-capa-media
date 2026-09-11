package com.ficohsa.api.dto;

import lombok.Builder;

@Builder
public record DebitCardDetailsRequestDto(
    String customerIdentification,
    String accountstatustypevalues,
    String accountNumber
) {}

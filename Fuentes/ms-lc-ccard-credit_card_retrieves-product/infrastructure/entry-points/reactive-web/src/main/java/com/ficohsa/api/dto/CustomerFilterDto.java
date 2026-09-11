package com.ficohsa.api.dto;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Pattern;
import lombok.Builder;

@Builder
public record CustomerFilterDto(
    @NotBlank
    @Pattern(regexp = "^(LEGAL_ID|CUSTOMER_ID)$", message = "customerIdentificationType must be LEGAL_ID or CUSTOMER_ID")
    String customerIdentificationType,
    @NotBlank String customerIdentification
) {}

package com.ficohsa.api.dto.settlementquotedetails.request;

import jakarta.validation.Valid;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Pattern;
import lombok.Builder;

@Builder
public record SettlementQuoteDetailsRequestDto(
    @NotNull(message = "data is required")
    @Valid
    RequestData data
) {
    @Builder
    public record RequestData(
        @NotBlank(message = "accountNumber is required")
        String accountNumber,
        @NotBlank(message = "organizationReference is required")
        String organizationReference,
        @NotBlank(message = "financingPlanReference is required")
        String financingPlanReference,
        @NotBlank(message = "paymentSequenceNumber is required")
        String paymentSequenceNumber,
        @NotBlank(message = "cancellationDate is required")
        @Pattern(regexp = "^\\d{4}-\\d{2}-\\d{2}$", message = "cancellationDate must be in format yyyy-MM-dd")
        String cancellationDate,
        Double repaymentAmount,
        Integer paymentType
    ) {}
}

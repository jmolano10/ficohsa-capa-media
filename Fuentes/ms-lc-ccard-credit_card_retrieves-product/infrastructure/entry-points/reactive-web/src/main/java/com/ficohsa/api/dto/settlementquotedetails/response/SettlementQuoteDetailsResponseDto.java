package com.ficohsa.api.dto.settlementquotedetails.response;

import lombok.Builder;

@Builder
public record SettlementQuoteDetailsResponseDto(
    String organizationReference,
    String alternateOrganization,
    String organizationLogo,
    String accountNumber,
    String creditCardId,
    String accountSettlementDate,
    String accountSettlementAmount,
    PlanData planData
) {
    @Builder
    public record PlanData(
        String productReference,
        String productType,
        String productDescription,
        String quoteType,
        String settlementDate,
        String planSettlementAmount,
        String repaymentType,
        String repaymentMethod,
        String newTerm,
        String newPaymentAmount
    ) {}
}

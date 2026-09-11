package com.ficohsa.api.dto.cardposition;

import lombok.Builder;
import java.util.List;

@Builder
public record CreditCardStatementDto(
    String partyReference,
    String productInstanceReference,
    String associationReference,
    String statementDate,
    String paymentDueDate,
    String positionLimitValue,
    String positionLimitCCY,
    String rewardPointsBalance,
    String previousStatementBalanceLCY,
    String periodStatementBalanceLCY,
    String paymentAmountLCY,
    String minimumPaymentAmountLCY,
    String previousStatementBalanceFCY,
    String periodStatementBalanceFCY,
    String paymentAmountFCY,
    String minimumPaymentAmountFCY,
    List<AssociatedCardReference> associatedCardReference
) {
    @Builder
    public record AssociatedCardReference(
        String cardIdentifier,
        String cardHolderReference,
        List<CardTransactionRecord> cardTransactionRecord
    ) {}

    @Builder
    public record CardTransactionRecord(
        String transactionDate,
        String transactionNarrative,
        String transactionAmount,
        String transactionCurrency,
        String transactionType,
        String originalTransactionAmount,
        String originalTransactionCurrency,
        String transactionCode,
        String transactionGroupCode,
        String transactionReference
    ) {}
}

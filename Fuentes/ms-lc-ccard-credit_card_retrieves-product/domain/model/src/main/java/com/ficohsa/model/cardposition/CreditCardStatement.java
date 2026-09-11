package com.ficohsa.model.cardposition;

import lombok.*;

import java.util.List;

@Getter
@Setter
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class CreditCardStatement {
    private String partyReference;
    private String productInstanceReference;
    private String associationReference;
    private String statementDate;
    private String paymentDueDate;
    private String positionLimitValue;
    private String positionLimitCCY;
    private String rewardPointsBalance;
    private String previousStatementBalanceLCY;
    private String periodStatementBalanceLCY;
    private String paymentAmountLCY;
    private String minimumPaymentAmountLCY;
    private String previousStatementBalanceFCY;
    private String periodStatementBalanceFCY;
    private String paymentAmountFCY;
    private String minimumPaymentAmountFCY;
    private List<AssociatedCardReference> associatedCardReference;

    @Getter
    @Setter
    @Builder
    @AllArgsConstructor
    @NoArgsConstructor
    public static class AssociatedCardReference {
        private String cardIdentifier;
        private String cardHolderReference;
        private List<CardTransactionRecord> cardTransactionRecord;
    }

    @Getter
    @Setter
    @Builder
    @AllArgsConstructor
    @NoArgsConstructor
    public static class CardTransactionRecord {
        private String transactionDate;
        private String transactionNarrative;
        private String transactionAmount;
        private String transactionCurrency;
        private String transactionType;
        private String originalTransactionAmount;
        private String originalTransactionCurrency;
        private String transactionCode;
        private String transactionGroupCode;
        private String transactionReference;
    }
}

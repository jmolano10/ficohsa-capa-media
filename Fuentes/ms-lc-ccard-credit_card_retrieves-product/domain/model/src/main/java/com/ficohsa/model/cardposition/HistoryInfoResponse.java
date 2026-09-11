package com.ficohsa.model.cardposition;

import lombok.*;

import java.util.List;

@Getter
@Setter
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class HistoryInfoResponse {
    private List<InfoRow> rows;

    @Getter
    @Setter
    @Builder
    @AllArgsConstructor
    @NoArgsConstructor
    public static class InfoRow {
        private String partyReference;
        private String productInstanceReference;
        private String associationReference;
        private String statementDate;
        private String paymentDueDate;
        private String currencyCode;
        private String positionLimitValue;
        private String rewardPointsBalance;
        private String previousStatementBalance;
        private String minimumPaymentAmount;
        private String paymentAmount;
        private String periodStatementBalance;
    }
}

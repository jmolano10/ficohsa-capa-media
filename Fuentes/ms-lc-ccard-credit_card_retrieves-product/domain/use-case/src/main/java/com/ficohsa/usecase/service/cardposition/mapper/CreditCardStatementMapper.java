package com.ficohsa.usecase.service.cardposition.mapper;

import com.ficohsa.model.cardposition.CreditCardStatement;
import com.ficohsa.model.cardposition.HistoryInfoResponse;

import java.util.List;
import java.util.Optional;

public class CreditCardStatementMapper {

    private CreditCardStatementMapper() {
    }

    public static CreditCardStatement merge(HistoryInfoResponse historyInfo, CreditCardStatement transactionData, String localCurrency) {
        if (historyInfo == null || historyInfo.getRows() == null || historyInfo.getRows().isEmpty()) {
            return transactionData;
        }

        var firstRow = historyInfo.getRows().getFirst();
        var usdRow = findRowByCurrency(historyInfo.getRows(), "USD");
        var localRow = findRowByCurrency(historyInfo.getRows(), localCurrency);

        String positionLimitCcy = resolvePositionLimitCcy(usdRow, localRow, localCurrency);

        return CreditCardStatement.builder()
                .partyReference(firstRow.getPartyReference())
                .productInstanceReference(firstRow.getProductInstanceReference())
                .associationReference(firstRow.getAssociationReference())
                .statementDate(firstRow.getStatementDate())
                .paymentDueDate(firstRow.getPaymentDueDate())
                .positionLimitValue(usdRow.map(HistoryInfoResponse.InfoRow::getPositionLimitValue)
                        .orElseGet(() -> localRow.map(HistoryInfoResponse.InfoRow::getPositionLimitValue).orElse(null)))
                .positionLimitCCY(positionLimitCcy)
                .rewardPointsBalance(usdRow.map(HistoryInfoResponse.InfoRow::getRewardPointsBalance)
                        .orElse(null))
                .previousStatementBalanceLCY(localRow.map(HistoryInfoResponse.InfoRow::getPreviousStatementBalance).orElse(null))
                .periodStatementBalanceLCY(localRow.map(HistoryInfoResponse.InfoRow::getPeriodStatementBalance).orElse(null))
                .paymentAmountLCY(localRow.map(HistoryInfoResponse.InfoRow::getPaymentAmount).orElse(null))
                .minimumPaymentAmountLCY(localRow.map(HistoryInfoResponse.InfoRow::getMinimumPaymentAmount).orElse(null))
                .previousStatementBalanceFCY(usdRow.map(HistoryInfoResponse.InfoRow::getPreviousStatementBalance).orElse(null))
                .periodStatementBalanceFCY(usdRow.map(HistoryInfoResponse.InfoRow::getPeriodStatementBalance).orElse(null))
                .paymentAmountFCY(usdRow.map(HistoryInfoResponse.InfoRow::getPaymentAmount).orElse(null))
                .minimumPaymentAmountFCY(usdRow.map(HistoryInfoResponse.InfoRow::getMinimumPaymentAmount).orElse(null))
                .associatedCardReference(transactionData != null ? transactionData.getAssociatedCardReference() : null)
                .build();
    }

    private static String resolvePositionLimitCcy(Optional<HistoryInfoResponse.InfoRow> usdRow, Optional<HistoryInfoResponse.InfoRow> localRow, String localCurrency) {
        if (usdRow.isPresent()) {
            return "USD";
        }
        if (localRow.isPresent()) {
            return localCurrency;
        }
        return null;
    }

    private static Optional<HistoryInfoResponse.InfoRow> findRowByCurrency(List<HistoryInfoResponse.InfoRow> rows, String currency) {
        return rows.stream()
                .filter(row -> currency.equals(row.getCurrencyCode()))
                .findFirst();
    }
}

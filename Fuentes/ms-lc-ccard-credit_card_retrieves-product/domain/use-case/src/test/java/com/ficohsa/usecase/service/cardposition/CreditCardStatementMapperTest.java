package com.ficohsa.usecase.service.cardposition;

import com.ficohsa.model.cardposition.CreditCardStatement;
import com.ficohsa.model.cardposition.HistoryInfoResponse;
import com.ficohsa.usecase.service.cardposition.mapper.CreditCardStatementMapper;
import org.junit.jupiter.api.Test;

import java.util.List;

import static org.junit.jupiter.api.Assertions.*;

class CreditCardStatementMapperTest {

    @Test
    void merge_NullHistoryInfo_ReturnsTransactionData() {
        CreditCardStatement transactionData = CreditCardStatement.builder()
                .partyReference("test")
                .build();

        CreditCardStatement result = CreditCardStatementMapper.merge(null, transactionData, "HNL");

        assertEquals(transactionData, result);
    }

    @Test
    void merge_EmptyRows_ReturnsTransactionData() {
        HistoryInfoResponse historyInfo = HistoryInfoResponse.builder()
                .rows(List.of())
                .build();

        CreditCardStatement transactionData = CreditCardStatement.builder()
                .partyReference("test")
                .build();

        CreditCardStatement result = CreditCardStatementMapper.merge(historyInfo, transactionData, "HNL");

        assertEquals(transactionData, result);
    }

    @Test
    void merge_WithUSDAndLocalCurrency_Success() {
        HistoryInfoResponse.InfoRow usdRow = HistoryInfoResponse.InfoRow.builder()
                .partyReference("John Doe")
                .productInstanceReference("1234567890")
                .associationReference("ACC123")
                .statementDate("2024-01-01")
                .paymentDueDate("2024-01-15")
                .currencyCode("USD")
                .positionLimitValue("5000")
                .rewardPointsBalance("100.5")
                .previousStatementBalance("1000")
                .minimumPaymentAmount("50")
                .paymentAmount("100")
                .periodStatementBalance("900")
                .build();

        HistoryInfoResponse.InfoRow localRow = HistoryInfoResponse.InfoRow.builder()
                .currencyCode("HNL")
                .positionLimitValue("125000")
                .previousStatementBalance("25000")
                .minimumPaymentAmount("1250")
                .paymentAmount("2500")
                .periodStatementBalance("22500")
                .build();

        HistoryInfoResponse historyInfo = HistoryInfoResponse.builder()
                .rows(List.of(usdRow, localRow))
                .build();

        CreditCardStatement transactionData = CreditCardStatement.builder()
                .associatedCardReference(List.of())
                .build();

        CreditCardStatement result = CreditCardStatementMapper.merge(historyInfo, transactionData, "HNL");

        assertNotNull(result);
        assertEquals("John Doe", result.getPartyReference());
        assertEquals("1234567890", result.getProductInstanceReference());
        assertEquals("5000", result.getPositionLimitValue());
        assertEquals("USD", result.getPositionLimitCCY());
        assertEquals("100.5", result.getRewardPointsBalance());
        assertEquals("25000", result.getPreviousStatementBalanceLCY());
        assertEquals("1000", result.getPreviousStatementBalanceFCY());
    }

    @Test
    void merge_OnlyLocalCurrency_Success() {
        HistoryInfoResponse.InfoRow localRow = HistoryInfoResponse.InfoRow.builder()
                .partyReference("Jane Doe")
                .productInstanceReference("9876543210")
                .associationReference("ACC456")
                .statementDate("2024-02-01")
                .paymentDueDate("2024-02-15")
                .currencyCode("GTQ")
                .positionLimitValue("10000")
                .rewardPointsBalance("")
                .previousStatementBalance("2000")
                .minimumPaymentAmount("100")
                .paymentAmount("200")
                .periodStatementBalance("1800")
                .build();

        HistoryInfoResponse historyInfo = HistoryInfoResponse.builder()
                .rows(List.of(localRow))
                .build();

        CreditCardStatement result = CreditCardStatementMapper.merge(historyInfo, null, "GTQ");

        assertNotNull(result);
        assertEquals("Jane Doe", result.getPartyReference());
        assertEquals("10000", result.getPositionLimitValue());
        assertEquals("GTQ", result.getPositionLimitCCY());
        assertNull(result.getRewardPointsBalance());
        assertNull(result.getAssociatedCardReference());
    }

    @Test
    void merge_NoCurrencyMatch_NullValues() {
        HistoryInfoResponse.InfoRow row = HistoryInfoResponse.InfoRow.builder()
                .partyReference("Test User")
                .productInstanceReference("1111222233334444")
                .associationReference("ACC789")
                .statementDate("2024-03-01")
                .paymentDueDate("2024-03-15")
                .currencyCode("EUR")
                .build();

        HistoryInfoResponse historyInfo = HistoryInfoResponse.builder()
                .rows(List.of(row))
                .build();

        CreditCardStatement result = CreditCardStatementMapper.merge(historyInfo, null, "HNL");

        assertNotNull(result);
        assertEquals("Test User", result.getPartyReference());
        assertNull(result.getPositionLimitValue());
        assertNull(result.getPositionLimitCCY());
    }
}


package com.ficohsa.usecase;

import com.ficohsa.lib.core.exception.UnprocessableEntityException;
import com.ficohsa.model.cardposition.CreditCardStatement;
import com.ficohsa.model.cardposition.HistoryInfoResponse;
import com.ficohsa.ports.IHistoryInfoTransactionsGateway;
import com.ficohsa.ports.IHistoryTransactionsGateway;
import com.ficohsa.ports.IRegionalizationGateway;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import reactor.core.publisher.Mono;
import reactor.test.StepVerifier;

import static org.mockito.ArgumentMatchers.anyString;
import static org.mockito.Mockito.when;

@ExtendWith(MockitoExtension.class)
class CardPositionUseCaseTest {

    @Mock
    private IHistoryInfoTransactionsGateway historyInfoTransactionsGateway;

    @Mock
    private IHistoryTransactionsGateway historyTransactionsGateway;

    @Mock
    private IRegionalizationGateway regionalizationGateway;

    @InjectMocks
    private CardPositionUseCase useCase;

    @Test
    void rtvCardPosition_success() {
        when(regionalizationGateway.validateRegion(anyString(), anyString(), anyString())).thenReturn(Mono.empty());
        when(historyInfoTransactionsGateway.rtvHistoryInfoTc(anyString(), anyString()))
                .thenReturn(Mono.just(new HistoryInfoResponse()));
        when(historyTransactionsGateway.rtvHistoryTc(anyString(), anyString(), anyString()))
                .thenReturn(Mono.just(new CreditCardStatement()));

        StepVerifier.create(useCase.rtvCardPosition("4111111111111111", "HN01", "HN01"))
                .expectNextCount(1)
                .verifyComplete();
    }

    @Test
    void rtvCardPosition_nullCreditCardId_throwsUnprocessableEntity() {
        StepVerifier.create(useCase.rtvCardPosition(null, "HN01", "HN01"))
                .expectError(UnprocessableEntityException.class)
                .verify();
    }
}

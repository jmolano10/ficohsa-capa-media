package com.ficohsa.usecase;

import com.ficohsa.lib.core.exception.UnprocessableEntityException;
import com.ficohsa.model.debitbasicinformation.DebitBasicInformation;
import com.ficohsa.ports.IDebitBasicInformationGateway;
import com.ficohsa.ports.IRegionalizationGateway;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import reactor.core.publisher.Mono;
import reactor.test.StepVerifier;

import java.util.Map;

import static org.mockito.ArgumentMatchers.anyString;
import static org.mockito.Mockito.when;

@ExtendWith(MockitoExtension.class)
class DebitBasicInformationUseCaseTest {

    @Mock
    private IRegionalizationGateway regionalizationGateway;

    @Mock
    private IDebitBasicInformationGateway mockStrategy;

    private DebitBasicInformationUseCase useCase;

    @BeforeEach
    void setUp() {
        Map<String, IDebitBasicInformationGateway> strategies = Map.of("HN01", mockStrategy);
        useCase = new DebitBasicInformationUseCase(strategies, regionalizationGateway);
    }

    @Test
    void debitBasicInformationRetrieve_success() {
        DebitBasicInformation expected = new DebitBasicInformation(null, null, null, null, null);
        when(regionalizationGateway.validateRegion(anyString(), anyString(), anyString())).thenReturn(Mono.empty());
        when(mockStrategy.retrieveDebitBasicInformation("123")).thenReturn(Mono.just(expected));

        StepVerifier.create(useCase.debitBasicInformationRetrieve("123", "HN01"))
                .expectNext(expected)
                .verifyComplete();
    }

    @Test
    void debitBasicInformationRetrieve_strategyNotFound() {
        when(regionalizationGateway.validateRegion(anyString(), anyString(), anyString())).thenReturn(Mono.empty());

        StepVerifier.create(useCase.debitBasicInformationRetrieve("123", "XX01"))
                .expectError(UnprocessableEntityException.class)
                .verify();
    }
}

package com.ficohsa.usecase;

import com.ficohsa.lib.core.exception.UnprocessableEntityException;
import com.ficohsa.model.settlementquotedetails.SettlementQuoteDetails;
import com.ficohsa.model.settlementquotedetails.SettlementQuoteDetailsModel;
import com.ficohsa.ports.IRegionalizationGateway;
import com.ficohsa.ports.ISettlementQuoteDetailsGateway;
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
class SettlementQuoteDetailsUseCaseTest {

    @Mock
    private IRegionalizationGateway regionalizationGateway;

    @Mock
    private ISettlementQuoteDetailsGateway wrapperStrategy;

    private SettlementQuoteDetailsUseCase useCase;

    @BeforeEach
    void setUp() {
        Map<String, ISettlementQuoteDetailsGateway> strategies = Map.of("HN01VP", wrapperStrategy);
        useCase = new SettlementQuoteDetailsUseCase(regionalizationGateway, strategies);
    }

    @Test
    void retrieveSettlementQuoteDetails_success() {
        SettlementQuoteDetails request = SettlementQuoteDetails.builder()
                .accountNumber("123456")
                .region("HN01")
                .build();

        SettlementQuoteDetailsModel expected = SettlementQuoteDetailsModel.builder()
                .settlementQuoteInquiry(SettlementQuoteDetailsModel.SettlementQuoteInquiry.builder()
                        .accountNumber("123456")
                        .build())
                .build();

        when(regionalizationGateway.validateRegion(anyString(), anyString(), anyString())).thenReturn(Mono.empty());
        when(wrapperStrategy.retrieveSettlementQuoteDetails(request)).thenReturn(Mono.just(expected));

        StepVerifier.create(useCase.retrieveSettlementQuoteDetails(request))
                .expectNext(expected)
                .verifyComplete();
    }

    @Test
    void retrieveSettlementQuoteDetails_strategyNotFound() {
        SettlementQuoteDetails request = SettlementQuoteDetails.builder()
                .accountNumber("123456")
                .region("XX01")
                .build();

        when(regionalizationGateway.validateRegion(anyString(), anyString(), anyString())).thenReturn(Mono.empty());

        StepVerifier.create(useCase.retrieveSettlementQuoteDetails(request))
                .expectError(UnprocessableEntityException.class)
                .verify();
    }
}

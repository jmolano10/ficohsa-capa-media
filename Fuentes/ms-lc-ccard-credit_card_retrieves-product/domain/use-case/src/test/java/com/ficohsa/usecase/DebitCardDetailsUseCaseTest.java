package com.ficohsa.usecase;

import com.ficohsa.lib.core.exception.UnprocessableEntityException;
import com.ficohsa.model.debitcarddetails.CustomerInquiry;
import com.ficohsa.model.debitcarddetails.DebitCardDetails;
import com.ficohsa.model.debitcarddetails.DebitCardInquiry;
import com.ficohsa.ports.IDebitCardDetailsGateway;
import com.ficohsa.ports.IRegionalizationGateway;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import reactor.core.publisher.Mono;
import reactor.test.StepVerifier;

import java.util.List;
import java.util.Map;

import static org.mockito.ArgumentMatchers.anyString;
import static org.mockito.Mockito.when;

@ExtendWith(MockitoExtension.class)
class DebitCardDetailsUseCaseTest {

    @Mock
    private IRegionalizationGateway regionalizationGateway;

    @Mock
    private IDebitCardDetailsGateway mockStrategy;

    private DebitCardDetailsUseCase useCase;

    @BeforeEach
    void setUp() {
        Map<String, IDebitCardDetailsGateway> strategies = Map.of("HN01", mockStrategy);
        useCase = new DebitCardDetailsUseCase(strategies, regionalizationGateway);
    }

    @Test
    void getDebitCardDetails_success() {
        DebitCardInquiry inquiry = new DebitCardInquiry();
        inquiry.setCardStatus("ACTIVE");
        inquiry.setAssociationReference("123456");
        inquiry.setIssueDate("20230115");

        DebitCardDetails details = new DebitCardDetails();
        details.setCustomerInquiry(new CustomerInquiry());
        details.setDebitCardInquiry(List.of(inquiry));

        when(regionalizationGateway.validateRegion(anyString(), anyString(), anyString())).thenReturn(Mono.empty());
        when(mockStrategy.retrieveDebitCardDetails(anyString(), anyString(), anyString())).thenReturn(Mono.just(details));

        StepVerifier.create(useCase.getDebitCardDetails("123", "ACTIVE", "123456", "HN01"))
                .expectNextMatches(result -> result.getDebitCardInquiry() != null
                        && result.getDebitCardInquiry().size() == 1
                        && result.getDebitCardInquiry().get(0).getIssueDate().equals("2023-01-15"))
                .verifyComplete();
    }

    @Test
    void getDebitCardDetails_strategyNotFound() {
        when(regionalizationGateway.validateRegion(anyString(), anyString(), anyString())).thenReturn(Mono.empty());

        StepVerifier.create(useCase.getDebitCardDetails("123", "ACTIVE", null, "XX01"))
                .expectError(UnprocessableEntityException.class)
                .verify();
    }
}

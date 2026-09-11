package com.ficohsa.usecase;

import com.ficohsa.model.associatedcards.*;
import com.ficohsa.ports.IAssociatedCardsGateway;
import com.ficohsa.ports.IRegionalizationGateway;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import reactor.core.publisher.Mono;

import java.util.Collections;
import java.util.List;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.anyString;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
class AssociatedCardsUseCaseTest {

    @Mock
    private IAssociatedCardsGateway associatedCardsOutPort;

    @Mock
    private IRegionalizationGateway regionalizationGateway;

    private AssociatedCardsUseCase associatedCardsUseCase;

    @BeforeEach
    void setUp() {
        associatedCardsUseCase = new AssociatedCardsUseCase(associatedCardsOutPort, regionalizationGateway);
        lenient().when(regionalizationGateway.validateRegion(anyString(), anyString(), anyString())).thenReturn(Mono.empty());
    }

    @Test
    void shouldReturnCreditCardPortfolioWhenValidRequest() {
        // Given
        CreditCardRetrieve request = createMockCreditCardRetrieve();
        CreditCardPortfolio expectedResponse = createMockCreditCardPortfolio();
        
        when(associatedCardsOutPort.getAssociatedActiveCards(request)).thenReturn(Mono.just(expectedResponse));

        // When
        CreditCardPortfolio result = associatedCardsUseCase.execute(request).block();

        // Then
        assertNotNull(result);
        assertEquals(expectedResponse, result);
        verify(associatedCardsOutPort, times(1)).getAssociatedActiveCards(request);
    }

    @Test
    void shouldReturnEmptyPortfolioWhenNoCardsFound() {
        // Given
        CreditCardRetrieve request = createMockCreditCardRetrieve();
        CreditCardPortfolio emptyResponse = new CreditCardPortfolio();
        emptyResponse.setCreditCardDetails(Collections.emptyList());
        
        when(associatedCardsOutPort.getAssociatedActiveCards(request)).thenReturn(Mono.just(emptyResponse));

        // When
        CreditCardPortfolio result = associatedCardsUseCase.execute(request).block();

        // Then
        assertNotNull(result);
        assertTrue(result.getCreditCardDetails().isEmpty());
        verify(associatedCardsOutPort, times(1)).getAssociatedActiveCards(request);
    }

    @Test
    void shouldPropagateExceptionWhenPortThrowsException() {
        // Given
        CreditCardRetrieve request = createMockCreditCardRetrieve();
        RuntimeException expectedException = new RuntimeException("Associated cards not found");
        
        when(associatedCardsOutPort.getAssociatedActiveCards(request)).thenReturn(Mono.error(expectedException));

        // When
        Mono<CreditCardPortfolio> result = associatedCardsUseCase.execute(request);

        // Then
        RuntimeException exception = assertThrows(RuntimeException.class, result::block);
        assertEquals("Associated cards not found", exception.getMessage());
        verify(associatedCardsOutPort, times(1)).getAssociatedActiveCards(request);
    }

    private CreditCardRetrieve createMockCreditCardRetrieve() {
        CreditCardRetrieve request = new CreditCardRetrieve();
        
        CustomerFilter customerFilter = new CustomerFilter();
        customerFilter.setCustomerIdentification("0801199012345");
        
        request.setCustomerFilter(customerFilter);
        request.setCreditCardStatus("ACTIVE");
        request.setRegion("HN01");
        
        return request;
    }

    private CreditCardPortfolio createMockCreditCardPortfolio() {
        CreditCardDetail detail = new CreditCardDetail();
        detail.setCreditCardId("CC001");
        detail.setAccountNumber("4000123456789012");
        detail.setCardHolderName("John Doe");
        detail.setCardType("CREDIT");
        detail.setCardProductName("Visa Classic");
        detail.setCardOperationalStatus("ACTIVE");
        detail.setCardProductType("CLASSIC");
        detail.setCardAffinityGroup("VISA");
        detail.setCardEffectiveDate("2019-01-15");

        FieldInformation fieldInfo = new FieldInformation();
        fieldInfo.setNameField("limit");
        fieldInfo.setValueField("50000");

        AdditionalInformation additionalInfo = new AdditionalInformation();
        additionalInfo.setFieldInformation(fieldInfo);
        detail.setAdditionalInformation(additionalInfo);

        CreditCardPortfolio portfolio = new CreditCardPortfolio();
        portfolio.setCreditCardDetails(List.of(detail));
        
        return portfolio;
    }
}


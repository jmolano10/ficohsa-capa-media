package com.ficohsa.usecase;

import com.ficohsa.model.CreditCardsDetails;
import com.ficohsa.ports.ICreditCardsDetailsGateway;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import reactor.core.publisher.Mono;
import reactor.test.StepVerifier;

import static org.mockito.Mockito.when;

@ExtendWith(MockitoExtension.class)
class CreditCardUseCaseTest {

    @Mock
    private ICreditCardsDetailsGateway creditCardsDetailsGateway;

    @InjectMocks
    private CreditCardUseCase useCase;

    @Test
    void creditCardRetrieve_success() {
        CreditCardsDetails expected = new CreditCardsDetails(null, null, null, null, null, null, null);
        when(creditCardsDetailsGateway.getCreditCard("123")).thenReturn(Mono.just(expected));

        StepVerifier.create(useCase.creditCardRetrieve("123"))
                .expectNext(expected)
                .verifyComplete();
    }

    @Test
    void creditCardRetrieve_error() {
        when(creditCardsDetailsGateway.getCreditCard("123")).thenReturn(Mono.error(new RuntimeException("Not found")));

        StepVerifier.create(useCase.creditCardRetrieve("123"))
                .expectError(RuntimeException.class)
                .verify();
    }
}

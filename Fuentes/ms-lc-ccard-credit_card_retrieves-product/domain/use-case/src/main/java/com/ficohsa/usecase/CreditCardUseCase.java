package com.ficohsa.usecase;

import com.ficohsa.model.CreditCardsDetails;
import com.ficohsa.ports.ICreditCardRetrieve;
import com.ficohsa.ports.ICreditCardsDetailsGateway;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;
import reactor.core.publisher.Mono;

@Slf4j
@Component
@RequiredArgsConstructor
public class CreditCardUseCase implements ICreditCardRetrieve {

    private final ICreditCardsDetailsGateway creditCardsDetailsGateway;

    @Override
    public Mono<CreditCardsDetails> creditCardRetrieve(String customerIdentification) {
        return creditCardsDetailsGateway.getCreditCard(customerIdentification);
    }
}

package com.ficohsa.ports;

import com.ficohsa.model.CreditCardsDetails;
import reactor.core.publisher.Mono;

public interface ICreditCardRetrieve {
    Mono<CreditCardsDetails> creditCardRetrieve(String customerIdentification);
}

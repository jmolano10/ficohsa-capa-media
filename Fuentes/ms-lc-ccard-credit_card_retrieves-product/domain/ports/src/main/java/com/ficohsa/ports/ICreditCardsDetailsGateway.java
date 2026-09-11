package com.ficohsa.ports;

import com.ficohsa.model.CreditCardsDetails;
import reactor.core.publisher.Mono;

public interface ICreditCardsDetailsGateway {
    Mono<CreditCardsDetails> getCreditCard(String customerIdentification);
}


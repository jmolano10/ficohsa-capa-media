package com.ficohsa.ports;

import com.ficohsa.model.associatedcards.CreditCardPortfolio;
import com.ficohsa.model.associatedcards.CreditCardRetrieve;
import reactor.core.publisher.Mono;

public interface IAssociatedCardsGateway {
    Mono<CreditCardPortfolio> getAssociatedActiveCards(CreditCardRetrieve creditCardRetrieve);
}


package com.ficohsa.ports;

import com.ficohsa.model.associatedcards.CreditCardPortfolio;
import com.ficohsa.model.associatedcards.CreditCardRetrieve;
import reactor.core.publisher.Mono;

public interface IAssociatedCards {
    Mono<CreditCardPortfolio> execute(CreditCardRetrieve creditCardRetrieve);
}

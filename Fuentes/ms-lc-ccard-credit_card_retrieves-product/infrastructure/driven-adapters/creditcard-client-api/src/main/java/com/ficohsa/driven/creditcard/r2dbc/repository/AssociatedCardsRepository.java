package com.ficohsa.driven.creditcard.r2dbc.repository;

import com.ficohsa.driven.creditcard.r2dbc.dto.CreditCardRowDto;
import reactor.core.publisher.Flux;

public interface AssociatedCardsRepository {
    Flux<CreditCardRowDto> getAssociatedActiveCards(String region, String numCliente, Integer tipo);
}

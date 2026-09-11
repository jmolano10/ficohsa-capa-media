package com.ficohsa.ports;

import com.ficohsa.model.cardposition.CreditCardStatement;
import reactor.core.publisher.Mono;

public interface IHistoryTransactionsGateway {
    Mono<CreditCardStatement> rtvHistoryTc(String cardNumber, String rgIso03, String type);
}


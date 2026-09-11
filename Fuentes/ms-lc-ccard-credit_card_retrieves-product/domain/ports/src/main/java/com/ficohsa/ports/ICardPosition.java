package com.ficohsa.ports;

import com.ficohsa.model.cardposition.CreditCardStatement;
import reactor.core.publisher.Mono;

public interface ICardPosition {
    Mono<CreditCardStatement> rtvCardPosition(String creditCardId, String srcRg, String dstRg);
}

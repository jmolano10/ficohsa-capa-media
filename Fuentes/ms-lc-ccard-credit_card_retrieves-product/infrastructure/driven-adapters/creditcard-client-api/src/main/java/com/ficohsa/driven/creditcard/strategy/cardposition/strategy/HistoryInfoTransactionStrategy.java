package com.ficohsa.driven.creditcard.strategy.cardposition.strategy;

import com.ficohsa.driven.creditcard.r2dbc.dto.cardposition.HtryInfoTcDto;
import reactor.core.publisher.Mono;

public interface HistoryInfoTransactionStrategy {
    String getRegion();
    Mono<HtryInfoTcDto> execute(String cardNumber, String rgIso03);
}

package com.ficohsa.driven.creditcard.strategy.cardposition.strategy;

import com.ficohsa.driven.creditcard.r2dbc.dto.cardposition.HtryTxDto;
import reactor.core.publisher.Mono;

public interface HistoryTransactionsStrategy {
    String getRegion();
    Mono<HtryTxDto> execute(String cardNumber, String rgIso03);
}

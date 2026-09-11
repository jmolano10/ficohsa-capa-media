package com.ficohsa.ports;

import com.ficohsa.model.settlementquotedetails.SettlementQuoteDetailsModel;
import reactor.core.publisher.Mono;

public interface ICacheComponentGateway {

    Mono<SettlementQuoteDetailsModel> getCache(String key);
    Mono<Void> setCache(String key, SettlementQuoteDetailsModel value);
}


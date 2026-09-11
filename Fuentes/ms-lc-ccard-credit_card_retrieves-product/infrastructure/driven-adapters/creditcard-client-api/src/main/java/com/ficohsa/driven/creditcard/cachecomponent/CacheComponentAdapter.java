package com.ficohsa.driven.creditcard.cachecomponent;

import com.ficohsa.driven.creditcard.cachecomponent.config.CacheComponentClientConfig;
import com.ficohsa.driven.creditcard.cachecomponent.mapper.CacheComponentMapper;
import com.ficohsa.lib.core.utility.AppTool;
import com.ficohsa.model.settlementquotedetails.SettlementQuoteDetailsModel;
import com.ficohsa.ports.ICacheComponentGateway;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;
import reactor.core.publisher.Mono;

import static com.ficohsa.driven.creditcard.cachecomponent.mapper.CacheComponentMapper.toEntity;

@Slf4j
@Component
@RequiredArgsConstructor
public class CacheComponentAdapter implements ICacheComponentGateway {

    private final CacheComponentClientConfig cacheComponentWebClient;

    @Override
    public Mono<SettlementQuoteDetailsModel> getCache(String key) {
                return AppTool.context()
                .flatMap(context -> cacheComponentWebClient.getCache(key, context) )
                .map(CacheComponentMapper::toModel)
                .doOnSuccess(response -> log.info("[ADAPTER] Successfully retrieved loan advances from T24"))
                .doOnError(error -> log.error("[ADAPTER] Vision plus service error: {}", error.getMessage()));
    }

    @Override
    public Mono<Void> setCache(String key, SettlementQuoteDetailsModel value) {
        return AppTool.context()
                .flatMap(context -> cacheComponentWebClient.setCache(toEntity(value), context) )
                .map(CacheComponentMapper::toModel)
                .doOnSuccess(response -> log.info("[ADAPTER] Successfully retrieved loan advances from T24"))
                .doOnError(error -> log.error("[ADAPTER] Vision plus service error: {}", error.getMessage()))
                .then();
    }
}


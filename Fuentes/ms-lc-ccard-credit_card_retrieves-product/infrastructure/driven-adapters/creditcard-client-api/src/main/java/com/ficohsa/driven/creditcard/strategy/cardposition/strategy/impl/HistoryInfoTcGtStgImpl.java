package com.ficohsa.driven.creditcard.strategy.cardposition.strategy.impl;

import com.ficohsa.driven.creditcard.r2dbc.dto.cardposition.HtryInfoTcDto;
import com.ficohsa.driven.creditcard.r2dbc.repository.cardposition.infotx.impl.HtryInfoTcGtRepositoryImpl;
import com.ficohsa.driven.creditcard.strategy.cardposition.strategy.HistoryInfoTransactionStrategy;
import com.ficohsa.helper.RegionUtils;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;
import reactor.core.publisher.Mono;

@Component
@RequiredArgsConstructor
@Slf4j
public class HistoryInfoTcGtStgImpl implements HistoryInfoTransactionStrategy {
    private final HtryInfoTcGtRepositoryImpl htryInfoTcRepository;

    @Override
    public String getRegion() {
        return RegionUtils.GT01_GT01;
    }

    @Override
    public Mono<HtryInfoTcDto> execute(String cardNumber, String rgIso03) {
        return htryInfoTcRepository.rtvHtryInfoTc(cardNumber, rgIso03);
    }
}


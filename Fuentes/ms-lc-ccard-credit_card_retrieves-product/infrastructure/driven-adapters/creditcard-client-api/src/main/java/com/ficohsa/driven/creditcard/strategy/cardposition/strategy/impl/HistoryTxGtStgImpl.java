package com.ficohsa.driven.creditcard.strategy.cardposition.strategy.impl;

import com.ficohsa.driven.creditcard.r2dbc.dto.cardposition.HtryTxDto;
import com.ficohsa.driven.creditcard.r2dbc.repository.cardposition.historytx.impl.HtryTxGtRepositoryImpl;
import com.ficohsa.driven.creditcard.strategy.cardposition.strategy.HistoryTransactionsStrategy;
import com.ficohsa.helper.RegionUtils;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;
import reactor.core.publisher.Mono;

@Component
@RequiredArgsConstructor
@Slf4j
public class HistoryTxGtStgImpl implements HistoryTransactionsStrategy {
    private final HtryTxGtRepositoryImpl htryTxRepository;

    @Override
    public String getRegion() {
        return RegionUtils.GT01_GT01;
    }

    @Override
    public Mono<HtryTxDto> execute(String cardNumber, String rgIso03) {
        return htryTxRepository.rtvHtryTx(cardNumber, rgIso03, "1");
    }
}


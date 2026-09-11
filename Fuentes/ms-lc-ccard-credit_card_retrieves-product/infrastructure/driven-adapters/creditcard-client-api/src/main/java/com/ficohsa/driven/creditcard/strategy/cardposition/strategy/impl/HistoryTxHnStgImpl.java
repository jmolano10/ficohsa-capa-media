package com.ficohsa.driven.creditcard.strategy.cardposition.strategy.impl;

import com.ficohsa.driven.creditcard.r2dbc.dto.cardposition.HtryTxDto;
import com.ficohsa.driven.creditcard.r2dbc.repository.cardposition.historytx.impl.HtryTxHnRepositoryImpl;
import com.ficohsa.driven.creditcard.strategy.cardposition.strategy.HistoryTransactionsStrategy;
import com.ficohsa.helper.RegionUtils;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;
import reactor.core.publisher.Mono;

@Component
@RequiredArgsConstructor
@Slf4j
public class HistoryTxHnStgImpl implements HistoryTransactionsStrategy {
    private final HtryTxHnRepositoryImpl htryTxRepository;

    @Override
    public String getRegion() {
        return RegionUtils.HN01_HN01;
    }

    @Override
    public Mono<HtryTxDto> execute(String cardNumber, String rgIso03) {
        return htryTxRepository.rtvHtryTx(cardNumber, rgIso03, "1");
    }
}


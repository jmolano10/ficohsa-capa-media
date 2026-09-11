package com.ficohsa.driven.creditcard.strategy.cardposition.strategy.impl;

import com.ficohsa.driven.creditcard.r2dbc.dto.cardposition.HtryInfoTcDto;
import com.ficohsa.driven.creditcard.r2dbc.repository.cardposition.infotx.impl.HtryInfoTcNiRepositoryImpl;
import com.ficohsa.driven.creditcard.strategy.cardposition.strategy.HistoryInfoTransactionStrategy;
import com.ficohsa.helper.RegionUtils;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;
import reactor.core.publisher.Mono;

@Component
@RequiredArgsConstructor
@Slf4j
public class HistoryInfoTcNiStgImpl implements HistoryInfoTransactionStrategy {
    private final HtryInfoTcNiRepositoryImpl htryInfoTcRepository;

    @Override
    public String getRegion() {
        return RegionUtils.NI01_NI01;
    }

    @Override
    public Mono<HtryInfoTcDto> execute(String cardNumber, String rgIso03) {
        return htryInfoTcRepository.rtvHtryInfoTc(cardNumber, rgIso03);
    }
}


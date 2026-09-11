package com.ficohsa.driven.creditcard.strategy.cardposition.strategy.impl;

import com.ficohsa.driven.creditcard.r2dbc.dto.cardposition.HtryInfoTcDto;
import com.ficohsa.driven.creditcard.r2dbc.repository.cardposition.infotx.impl.HtryInfoTcPaRepositoryImpl;
import com.ficohsa.driven.creditcard.strategy.cardposition.strategy.HistoryInfoTransactionStrategy;
import com.ficohsa.helper.RegionUtils;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;
import reactor.core.publisher.Mono;

@Component
@RequiredArgsConstructor
@Slf4j
public class HistoryInfoTcPaStgImpl implements HistoryInfoTransactionStrategy {
    private final HtryInfoTcPaRepositoryImpl htryInfoTcRepository;

    @Override
    public String getRegion() {
        return RegionUtils.PA01_PA01;
    }

    @Override
    public Mono<HtryInfoTcDto> execute(String cardNumber, String rgIso03) {
        return htryInfoTcRepository.rtvHtryInfoTc(cardNumber, rgIso03);
    }
}


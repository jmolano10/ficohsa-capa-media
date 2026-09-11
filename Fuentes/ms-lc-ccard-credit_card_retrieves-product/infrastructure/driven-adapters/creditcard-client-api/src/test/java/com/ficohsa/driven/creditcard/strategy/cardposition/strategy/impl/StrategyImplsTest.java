package com.ficohsa.driven.creditcard.strategy.cardposition.strategy.impl;

import com.ficohsa.driven.creditcard.r2dbc.dto.cardposition.HtryInfoTcDto;
import com.ficohsa.driven.creditcard.r2dbc.dto.cardposition.HtryTxDto;
import com.ficohsa.driven.creditcard.r2dbc.repository.cardposition.historytx.impl.HtryTxGtRepositoryImpl;
import com.ficohsa.driven.creditcard.r2dbc.repository.cardposition.historytx.impl.HtryTxHnRepositoryImpl;
import com.ficohsa.driven.creditcard.r2dbc.repository.cardposition.historytx.impl.HtryTxNiRepositoryImpl;
import com.ficohsa.driven.creditcard.r2dbc.repository.cardposition.historytx.impl.HtryTxPaRepositoryImpl;
import com.ficohsa.driven.creditcard.r2dbc.repository.cardposition.infotx.impl.HtryInfoTcGtRepositoryImpl;
import com.ficohsa.driven.creditcard.r2dbc.repository.cardposition.infotx.impl.HtryInfoTcHnRepositoryImpl;
import com.ficohsa.driven.creditcard.r2dbc.repository.cardposition.infotx.impl.HtryInfoTcNiRepositoryImpl;
import com.ficohsa.driven.creditcard.r2dbc.repository.cardposition.infotx.impl.HtryInfoTcPaRepositoryImpl;
import com.ficohsa.helper.RegionUtils;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import reactor.core.publisher.Mono;
import reactor.test.StepVerifier;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.mockito.ArgumentMatchers.anyString;
import static org.mockito.Mockito.when;

@ExtendWith(MockitoExtension.class)
class StrategyImplsTest {

    @Mock private HtryTxHnRepositoryImpl htryTxHn;
    @Mock private HtryTxGtRepositoryImpl htryTxGt;
    @Mock private HtryTxNiRepositoryImpl htryTxNi;
    @Mock private HtryTxPaRepositoryImpl htryTxPa;
    @Mock private HtryInfoTcHnRepositoryImpl htryInfoHn;
    @Mock private HtryInfoTcGtRepositoryImpl htryInfoGt;
    @Mock private HtryInfoTcNiRepositoryImpl htryInfoNi;
    @Mock private HtryInfoTcPaRepositoryImpl htryInfoPa;

    @Test
    void historyTxHn_regionAndExecute() {
        HistoryTxHnStgImpl stg = new HistoryTxHnStgImpl(htryTxHn);
        assertEquals(RegionUtils.HN01_HN01, stg.getRegion());
        when(htryTxHn.rtvHtryTx(anyString(), anyString(), anyString())).thenReturn(Mono.just(new HtryTxDto()));
        StepVerifier.create(stg.execute("card", "HN")).expectNextCount(1).verifyComplete();
    }

    @Test
    void historyTxGt_regionAndExecute() {
        HistoryTxGtStgImpl stg = new HistoryTxGtStgImpl(htryTxGt);
        assertEquals(RegionUtils.GT01_GT01, stg.getRegion());
        when(htryTxGt.rtvHtryTx(anyString(), anyString(), anyString())).thenReturn(Mono.just(new HtryTxDto()));
        StepVerifier.create(stg.execute("card", "GT")).expectNextCount(1).verifyComplete();
    }

    @Test
    void historyTxNi_regionAndExecute() {
        HistoryTxNiStgImpl stg = new HistoryTxNiStgImpl(htryTxNi);
        assertEquals(RegionUtils.NI01_NI01, stg.getRegion());
        when(htryTxNi.rtvHtryTx(anyString(), anyString(), anyString())).thenReturn(Mono.just(new HtryTxDto()));
        StepVerifier.create(stg.execute("card", "NI")).expectNextCount(1).verifyComplete();
    }

    @Test
    void historyTxPa_regionAndExecute() {
        HistoryTxPaStgImpl stg = new HistoryTxPaStgImpl(htryTxPa);
        assertEquals(RegionUtils.PA01_PA01, stg.getRegion());
        when(htryTxPa.rtvHtryTx(anyString(), anyString(), anyString())).thenReturn(Mono.just(new HtryTxDto()));
        StepVerifier.create(stg.execute("card", "PA")).expectNextCount(1).verifyComplete();
    }

    @Test
    void historyInfoHn_regionAndExecute() {
        HistoryInfoTcHnStgImpl stg = new HistoryInfoTcHnStgImpl(htryInfoHn);
        assertEquals(RegionUtils.HN01_HN01, stg.getRegion());
        when(htryInfoHn.rtvHtryInfoTc(anyString(), anyString())).thenReturn(Mono.just(new HtryInfoTcDto()));
        StepVerifier.create(stg.execute("card", "HN")).expectNextCount(1).verifyComplete();
    }

    @Test
    void historyInfoGt_regionAndExecute() {
        HistoryInfoTcGtStgImpl stg = new HistoryInfoTcGtStgImpl(htryInfoGt);
        assertEquals(RegionUtils.GT01_GT01, stg.getRegion());
        when(htryInfoGt.rtvHtryInfoTc(anyString(), anyString())).thenReturn(Mono.just(new HtryInfoTcDto()));
        StepVerifier.create(stg.execute("card", "GT")).expectNextCount(1).verifyComplete();
    }

    @Test
    void historyInfoNi_regionAndExecute() {
        HistoryInfoTcNiStgImpl stg = new HistoryInfoTcNiStgImpl(htryInfoNi);
        assertEquals(RegionUtils.NI01_NI01, stg.getRegion());
        when(htryInfoNi.rtvHtryInfoTc(anyString(), anyString())).thenReturn(Mono.just(new HtryInfoTcDto()));
        StepVerifier.create(stg.execute("card", "NI")).expectNextCount(1).verifyComplete();
    }

    @Test
    void historyInfoPa_regionAndExecute() {
        HistoryInfoTcPaStgImpl stg = new HistoryInfoTcPaStgImpl(htryInfoPa);
        assertEquals(RegionUtils.PA01_PA01, stg.getRegion());
        when(htryInfoPa.rtvHtryInfoTc(anyString(), anyString())).thenReturn(Mono.just(new HtryInfoTcDto()));
        StepVerifier.create(stg.execute("card", "PA")).expectNextCount(1).verifyComplete();
    }
}

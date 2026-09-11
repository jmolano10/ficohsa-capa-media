package com.ficohsa.driven.creditcard.strategy.cardposition;

import com.ficohsa.driven.creditcard.r2dbc.dto.cardposition.HtryTxDto;
import com.ficohsa.driven.creditcard.strategy.cardposition.strategy.HistoryTransactionsStrategy;
import com.ficohsa.lib.core.exception.BusinessCoreException;
import com.ficohsa.lib.core.exception.NotFoundException;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.web.server.ResponseStatusException;
import reactor.core.publisher.Mono;
import reactor.test.StepVerifier;

import java.util.List;

import static org.mockito.ArgumentMatchers.*;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
class HistoryTransactionAdapterTest {

    @Mock
    private HistoryTransactionsStrategy strategy;

    private HistoryTransactionAdapter adapter;

    @BeforeEach
    void setUp() {
        lenient().when(strategy.getRegion()).thenReturn("HN01-HN01");
        adapter = new HistoryTransactionAdapter(List.of(strategy));
    }

    @Test
    void rtvHistoryTc_success_returnsStatement() {
        HtryTxDto.TransaccionRow row = new HtryTxDto.TransaccionRow();
        row.setNumtarjeta("123");
        row.setNombreTarjetahabiente("John");
        row.setFecefectiva("2024-01-01");
        row.setDescripcion("Purchase");
        row.setMonto("100");
        row.setCodMoneda("HNL");
        row.setTipoMovimiento("C");
        row.setMontoOriginal("100");
        row.setMonedaOriginal("USD");

        HtryTxDto dto = new HtryTxDto();
        dto.setCodigoError(-1);
        dto.setRowSet(List.of(row));

        when(strategy.execute("123", "HND")).thenReturn(Mono.just(dto));

        StepVerifier.create(adapter.rtvHistoryTc("123", "HN01-HN01", "1"))
                .expectNextMatches(s -> s.getAssociatedCardReference().size() == 1)
                .verifyComplete();
    }

    @Test
    void rtvHistoryTc_multipleCards_groupedCorrectly() {
        HtryTxDto.TransaccionRow row1 = new HtryTxDto.TransaccionRow();
        row1.setNumtarjeta("A");
        row1.setNombreTarjetahabiente("Alice");

        HtryTxDto.TransaccionRow row2 = new HtryTxDto.TransaccionRow();
        row2.setNumtarjeta("B");
        row2.setNombreTarjetahabiente("Bob");

        HtryTxDto dto = new HtryTxDto();
        dto.setCodigoError(-1);
        dto.setRowSet(List.of(row1, row2));

        when(strategy.execute(anyString(), eq("HND"))).thenReturn(Mono.just(dto));

        StepVerifier.create(adapter.rtvHistoryTc("X", "HN01-HN01", "1"))
                .expectNextMatches(s -> s.getAssociatedCardReference().size() == 2)
                .verifyComplete();
    }

    @Test
    void rtvHistoryTc_emptyRowSet_throwsNotFoundException() {
        HtryTxDto dto = new HtryTxDto();
        dto.setCodigoError(-1);
        dto.setRowSet(List.of());

        when(strategy.execute(anyString(), anyString())).thenReturn(Mono.just(dto));

        StepVerifier.create(adapter.rtvHistoryTc("123", "HN01-HN01", "1"))
                .expectError(NotFoundException.class)
                .verify();
    }

    @Test
    void rtvHistoryTc_nullRowSet_throwsNotFoundException() {
        HtryTxDto dto = new HtryTxDto();
        dto.setCodigoError(-1);
        dto.setRowSet(null);

        when(strategy.execute(anyString(), anyString())).thenReturn(Mono.just(dto));

        StepVerifier.create(adapter.rtvHistoryTc("123", "HN01-HN01", "1"))
                .expectError(NotFoundException.class)
                .verify();
    }

    @Test
    void rtvHistoryTc_regionNotFound_throwsResponseStatusException() {
        StepVerifier.create(adapter.rtvHistoryTc("123", "XX01-XX01", "1"))
                .expectError(ResponseStatusException.class)
                .verify();
    }

    @Test
    void rtvHistoryTc_invalidRegionIso_throwsResponseStatusException() {
        HistoryTransactionsStrategy invalidStrategy = mock(HistoryTransactionsStrategy.class);
        when(invalidStrategy.getRegion()).thenReturn("INVALID");

        HistoryTransactionAdapter adapterWithInvalid = new HistoryTransactionAdapter(List.of(invalidStrategy));

        StepVerifier.create(adapterWithInvalid.rtvHistoryTc("123", "INVALID", "1"))
                .expectError(ResponseStatusException.class)
                .verify();
    }

    @Test
    void rtvHistoryTc_errorCode_throwsBusinessCoreException() {
        HtryTxDto dto = new HtryTxDto();
        dto.setCodigoError(500);
        dto.setMensajeError("DB error");

        when(strategy.execute(anyString(), anyString())).thenReturn(Mono.just(dto));

        StepVerifier.create(adapter.rtvHistoryTc("123", "HN01-HN01", "1"))
                .expectError(BusinessCoreException.class)
                .verify();
    }

    @Test
    void rtvHistoryTc_errorCodeNull_passesThrough() {
        HtryTxDto.TransaccionRow row = new HtryTxDto.TransaccionRow();
        row.setNumtarjeta("123");
        row.setNombreTarjetahabiente("John");

        HtryTxDto dto = new HtryTxDto();
        dto.setCodigoError(null);
        dto.setRowSet(List.of(row));

        when(strategy.execute(anyString(), anyString())).thenReturn(Mono.just(dto));

        StepVerifier.create(adapter.rtvHistoryTc("123", "HN01-HN01", "1"))
                .expectNextMatches(s -> s.getAssociatedCardReference().size() == 1)
                .verifyComplete();
    }

    @Test
    void rtvHistoryTc_errorCodeMinusOne_passesThrough() {
        HtryTxDto.TransaccionRow row = new HtryTxDto.TransaccionRow();
        row.setNumtarjeta("123");
        row.setNombreTarjetahabiente("John");

        HtryTxDto dto = new HtryTxDto();
        dto.setCodigoError(-1);
        dto.setRowSet(List.of(row));

        when(strategy.execute(anyString(), anyString())).thenReturn(Mono.just(dto));

        StepVerifier.create(adapter.rtvHistoryTc("123", "HN01-HN01", "1"))
                .expectNextMatches(s -> !s.getAssociatedCardReference().isEmpty())
                .verifyComplete();
    }

    @Test
    void rtvHistoryTc_strategyError_propagates() {
        when(strategy.execute(anyString(), anyString())).thenReturn(Mono.error(new RuntimeException("fail")));

        StepVerifier.create(adapter.rtvHistoryTc("123", "HN01-HN01", "1"))
                .expectError(RuntimeException.class)
                .verify();
    }
}

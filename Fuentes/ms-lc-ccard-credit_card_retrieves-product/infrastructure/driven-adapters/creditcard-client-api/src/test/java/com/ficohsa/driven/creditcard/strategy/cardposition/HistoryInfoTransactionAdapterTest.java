package com.ficohsa.driven.creditcard.strategy.cardposition;

import com.ficohsa.driven.creditcard.r2dbc.dto.cardposition.HtryInfoTcDto;
import com.ficohsa.driven.creditcard.strategy.cardposition.strategy.HistoryInfoTransactionStrategy;
import com.ficohsa.lib.core.exception.BusinessCoreException;
import com.ficohsa.lib.core.exception.NotFoundException;
import com.ficohsa.lib.core.exception.UnprocessableEntityException;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import reactor.core.publisher.Mono;
import reactor.test.StepVerifier;

import java.util.List;

import static org.mockito.ArgumentMatchers.*;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
class HistoryInfoTransactionAdapterTest {

    @Mock
    private HistoryInfoTransactionStrategy strategy;

    private HistoryInfoTransactionAdapter adapter;

    @BeforeEach
    void setUp() {
        lenient().when(strategy.getRegion()).thenReturn("HN01-HN01");
        adapter = new HistoryInfoTransactionAdapter(List.of(strategy));
    }

    @Test
    void rtvHistoryInfoTc_success() {
        HtryInfoTcDto.InfoHistoricaRow row = new HtryInfoTcDto.InfoHistoricaRow();
        row.setAccountName("John");
        row.setNumtarjeta("123");
        row.setAccountNbr("ACC1");

        HtryInfoTcDto dto = new HtryInfoTcDto();
        dto.setCodigoError(-1);
        dto.setRowSet(List.of(row));

        when(strategy.execute("123", "HND")).thenReturn(Mono.just(dto));

        StepVerifier.create(adapter.rtvHistoryInfoTc("123", "HN01-HN01"))
                .expectNextMatches(r -> r.getRows().size() == 1 && "John".equals(r.getRows().get(0).getPartyReference()))
                .verifyComplete();
    }

    @Test
    void rtvHistoryInfoTc_emptyRowSet_throwsNotFoundException() {
        HtryInfoTcDto dto = new HtryInfoTcDto();
        dto.setCodigoError(-1);
        dto.setRowSet(List.of());

        when(strategy.execute(anyString(), anyString())).thenReturn(Mono.just(dto));

        StepVerifier.create(adapter.rtvHistoryInfoTc("123", "HN01-HN01"))
                .expectError(NotFoundException.class)
                .verify();
    }

    @Test
    void rtvHistoryInfoTc_nullRowSet_throwsNotFoundException() {
        HtryInfoTcDto dto = new HtryInfoTcDto();
        dto.setCodigoError(-1);
        dto.setRowSet(null);

        when(strategy.execute(anyString(), anyString())).thenReturn(Mono.just(dto));

        StepVerifier.create(adapter.rtvHistoryInfoTc("123", "HN01-HN01"))
                .expectError(NotFoundException.class)
                .verify();
    }

    @Test
    void rtvHistoryInfoTc_regionNotFound_throwsUnprocessableEntity() {
        StepVerifier.create(adapter.rtvHistoryInfoTc("123", "XX01-XX01"))
                .expectError(UnprocessableEntityException.class)
                .verify();
    }

    @Test
    void rtvHistoryInfoTc_invalidRegionIso_throwsUnprocessableEntity() {
        HistoryInfoTransactionStrategy invalid = mock(HistoryInfoTransactionStrategy.class);
        when(invalid.getRegion()).thenReturn("INVALID");
        var a = new HistoryInfoTransactionAdapter(List.of(invalid));

        StepVerifier.create(a.rtvHistoryInfoTc("123", "INVALID"))
                .expectError(UnprocessableEntityException.class)
                .verify();
    }

    @Test
    void rtvHistoryInfoTc_errorCode_throwsBusinessCoreException() {
        HtryInfoTcDto dto = new HtryInfoTcDto();
        dto.setCodigoError(500);
        dto.setMensajeError("DB error");

        when(strategy.execute(anyString(), anyString())).thenReturn(Mono.just(dto));

        StepVerifier.create(adapter.rtvHistoryInfoTc("123", "HN01-HN01"))
                .expectError(BusinessCoreException.class)
                .verify();
    }

    @Test
    void rtvHistoryInfoTc_cardNotFound_throwsNotFoundWrappedInBusinessCore() {
        HtryInfoTcDto dto = new HtryInfoTcDto();
        dto.setCodigoError(2);
        dto.setMensajeError("Se debe especificar un numero de Tarjeta.");

        when(strategy.execute(anyString(), anyString())).thenReturn(Mono.just(dto));

        StepVerifier.create(adapter.rtvHistoryInfoTc("123", "HN01-HN01"))
                .expectErrorMatches(e -> e instanceof BusinessCoreException bce
                        && bce.getStatus() == 404)
                .verify();
    }

    @Test
    void rtvHistoryInfoTc_errorCodeNull_passesThrough() {
        HtryInfoTcDto.InfoHistoricaRow row = new HtryInfoTcDto.InfoHistoricaRow();
        row.setNumtarjeta("123");
        row.setAccountName("A");

        HtryInfoTcDto dto = new HtryInfoTcDto();
        dto.setCodigoError(null);
        dto.setRowSet(List.of(row));

        when(strategy.execute(anyString(), anyString())).thenReturn(Mono.just(dto));

        StepVerifier.create(adapter.rtvHistoryInfoTc("123", "HN01-HN01"))
                .expectNextCount(1)
                .verifyComplete();
    }
}

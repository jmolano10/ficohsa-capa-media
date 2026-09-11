package com.ficohsa.driven.creditcard.r2dbc.repository.cardposition.historytx.impl;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.ficohsa.driven.creditcard.r2dbc.config.DatabaseConnectionProvider;
import com.ficohsa.driven.creditcard.r2dbc.config.DatabasePropsConfig;
import com.ficohsa.lib.core.exception.InternalServerException;
import io.r2dbc.spi.Row;
import io.r2dbc.spi.RowMetadata;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.r2dbc.core.DatabaseClient;
import org.springframework.r2dbc.core.DatabaseClient.GenericExecuteSpec;
import org.springframework.r2dbc.core.RowsFetchSpec;
import reactor.core.publisher.Flux;
import reactor.core.publisher.Mono;
import reactor.test.StepVerifier;

import java.time.LocalDateTime;
import java.time.Month;
import java.util.function.BiFunction;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.anyString;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
class HtryTxGtRepositoryImplTest {

    private static final LocalDateTime FIXED_DATE = LocalDateTime.of(2025, Month.JANUARY, 1, 0, 0);

    @Mock
    private DatabaseConnectionProvider connectionProvider;
    @Mock
    private DatabasePropsConfig databaseProperties;
    @Mock
    private ObjectMapper mapper;
    @Mock
    private DatabaseClient databaseClient;
    @Mock
    private GenericExecuteSpec executeSpec;
    @Mock
    private RowsFetchSpec<Row> rowsFetchSpec;

    private HtryTxGtRepositoryImpl repository;

    @BeforeEach
    void setUp() {
        repository = new HtryTxGtRepositoryImpl(connectionProvider, databaseProperties, mapper);
        lenient().when(databaseProperties.getQueryTimeoutSeconds()).thenReturn(30);
    }

    @SuppressWarnings("unchecked")
    @Test
    void rtvHtryTx_success_returnsDtoWithTransactions() {
        when(connectionProvider.getConnectionForCardPosition("process-gt", "mssql"))
                .thenReturn(Mono.just(databaseClient));
        when(databaseClient.sql(anyString())).thenReturn(executeSpec);
        when(executeSpec.bind(anyString(), any())).thenReturn(executeSpec);

        // Mock the map to invoke the BiFunction with a data row then an error-result row
        when(executeSpec.map(any(BiFunction.class))).thenAnswer(invocation -> {
            BiFunction<Row, RowMetadata, Row> mapFn = invocation.getArgument(0);

            // Simulate a data row (no CodigoError column)
            Row dataRow = mock(Row.class);
            RowMetadata dataMetadata = mock(RowMetadata.class);
            when(dataMetadata.contains("CodigoError")).thenReturn(false);
            when(dataMetadata.contains("numtarjeta")).thenReturn(true);
            when(dataMetadata.contains("nombreTarjetahabiente")).thenReturn(true);
            when(dataMetadata.contains("fecefectiva")).thenReturn(true);
            when(dataMetadata.contains("descripcion")).thenReturn(true);
            when(dataMetadata.contains("monto")).thenReturn(true);
            when(dataMetadata.contains("CodMoneda")).thenReturn(true);
            when(dataMetadata.contains("TipoMovimiento")).thenReturn(true);
            when(dataMetadata.contains("MontoOriginal")).thenReturn(true);
            when(dataMetadata.contains("MonedaOriginal")).thenReturn(true);
            when(dataRow.get("numtarjeta")).thenReturn("4111111111111111");
            when(dataRow.get("nombreTarjetahabiente")).thenReturn("John Doe");
            when(dataRow.get("fecefectiva", LocalDateTime.class)).thenReturn(FIXED_DATE);
            when(dataRow.get("descripcion")).thenReturn("Purchase");
            when(dataRow.get("monto")).thenReturn("100.00");
            when(dataRow.get("CodMoneda")).thenReturn("HNL");
            when(dataRow.get("TipoMovimiento")).thenReturn("D");
            when(dataRow.get("MontoOriginal")).thenReturn("100.00");
            when(dataRow.get("MonedaOriginal")).thenReturn("HNL");

            // Simulate error-result row (has CodigoError)
            Row errorRow = mock(Row.class);
            RowMetadata errorMetadata = mock(RowMetadata.class);
            when(errorMetadata.contains("CodigoError")).thenReturn(true);
            when(errorRow.get("CodigoError", Integer.class)).thenReturn(0);
            when(errorMetadata.contains("MensajeError")).thenReturn(true);
            when(errorRow.get("MensajeError")).thenReturn(null);

            mapFn.apply(dataRow, dataMetadata);
            mapFn.apply(errorRow, errorMetadata);

            RowsFetchSpec<Row> fetchSpec = mock(RowsFetchSpec.class);
            when(fetchSpec.all()).thenReturn(Flux.just(dataRow, errorRow));
            return fetchSpec;
        });

        StepVerifier.create(repository.rtvHtryTx("4111111111111111", "HN", "GRP"))
                .assertNext(dto -> {
                    assertEquals(0, dto.getCodigoError());
                    assertNull(dto.getMensajeError());
                    assertFalse(dto.getRowSet().isEmpty());
                    assertEquals("4111111111111111", dto.getRowSet().get(0).getNumtarjeta());
                })
                .verifyComplete();

        verify(connectionProvider).getConnectionForCardPosition("process-gt", "mssql");
    }

    @Test
    void rtvHtryTx_connectionError_throwsInternalServerException() {
        when(connectionProvider.getConnectionForCardPosition("process-gt", "mssql"))
                .thenReturn(Mono.error(new RuntimeException("Connection failed")));

        StepVerifier.create(repository.rtvHtryTx("4111111111111111", "HN", "GRP"))
                .expectError(InternalServerException.class)
                .verify();
    }

    @SuppressWarnings("unchecked")
    @Test
    void rtvHtryTx_queryError_throwsInternalServerException() {
        when(connectionProvider.getConnectionForCardPosition("process-gt", "mssql"))
                .thenReturn(Mono.just(databaseClient));
        when(databaseClient.sql(anyString())).thenReturn(executeSpec);
        when(executeSpec.bind(anyString(), any())).thenReturn(executeSpec);
        when(executeSpec.map(any(BiFunction.class))).thenReturn((RowsFetchSpec) rowsFetchSpec);
        when(rowsFetchSpec.all()).thenReturn(Flux.error(new RuntimeException("SQL error")));

        StepVerifier.create(repository.rtvHtryTx("4111111111111111", "HN", "GRP"))
                .expectError(InternalServerException.class)
                .verify();
    }
}

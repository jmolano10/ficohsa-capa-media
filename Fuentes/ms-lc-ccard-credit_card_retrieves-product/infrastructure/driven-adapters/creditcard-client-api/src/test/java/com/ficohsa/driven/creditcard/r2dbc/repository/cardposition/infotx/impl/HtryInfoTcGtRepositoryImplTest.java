package com.ficohsa.driven.creditcard.r2dbc.repository.cardposition.infotx.impl;

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

import java.util.function.BiFunction;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.anyString;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
class HtryInfoTcGtRepositoryImplTest {

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

    private HtryInfoTcGtRepositoryImpl repository;

    @BeforeEach
    void setUp() {
        repository = new HtryInfoTcGtRepositoryImpl(connectionProvider, databaseProperties, mapper);
        lenient().when(databaseProperties.getQueryTimeoutSeconds()).thenReturn(30);
    }

    @SuppressWarnings("unchecked")
    @Test
    void rtvHtryInfoTc_success_returnsDtoWithRows() {
        when(connectionProvider.getConnectionForCardPosition("process-gt", "mssql"))
                .thenReturn(Mono.just(databaseClient));
        when(databaseClient.sql(anyString())).thenReturn(executeSpec);
        when(executeSpec.bind(anyString(), any())).thenReturn(executeSpec);

        when(executeSpec.map(any(BiFunction.class))).thenAnswer(invocation -> {
            BiFunction<Row, RowMetadata, Row> mapFn = invocation.getArgument(0);

            // Simulate data row
            Row dataRow = mock(Row.class);
            RowMetadata dataMetadata = mock(RowMetadata.class);
            when(dataMetadata.contains("CodigoError")).thenReturn(false);
            when(dataMetadata.contains("cardholder_name")).thenReturn(true);
            when(dataMetadata.contains("numtarjeta")).thenReturn(true);
            when(dataMetadata.contains("Account_nbr")).thenReturn(true);
            when(dataMetadata.contains("fecproxecta")).thenReturn(true);
            when(dataMetadata.contains("fechamaximapago")).thenReturn(true);
            when(dataMetadata.contains("CodMoneda")).thenReturn(true);
            when(dataMetadata.contains("CRLIM")).thenReturn(true);
            when(dataMetadata.contains("PuntosAcumulados")).thenReturn(true);
            when(dataMetadata.contains("totbalini")).thenReturn(true);
            when(dataMetadata.contains("pagominimo")).thenReturn(true);
            when(dataMetadata.contains("actualdue")).thenReturn(true);
            when(dataMetadata.contains("SaldoAlCorte")).thenReturn(true);
            when(dataRow.get("cardholder_name")).thenReturn("John Doe");
            when(dataRow.get("numtarjeta")).thenReturn("4111111111111111");
            when(dataRow.get("Account_nbr")).thenReturn("ACC001");
            when(dataRow.get("fecproxecta")).thenReturn("2024-02-01");
            when(dataRow.get("fechamaximapago")).thenReturn("2024-02-15");
            when(dataRow.get("CodMoneda")).thenReturn("HNL");
            when(dataRow.get("CRLIM")).thenReturn("50000");
            when(dataRow.get("PuntosAcumulados")).thenReturn("1200");
            when(dataRow.get("totbalini")).thenReturn("15000");
            when(dataRow.get("pagominimo")).thenReturn("750");
            when(dataRow.get("actualdue")).thenReturn("3000");
            when(dataRow.get("SaldoAlCorte")).thenReturn("12000");

            // Simulate error-result row
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

        StepVerifier.create(repository.rtvHtryInfoTc("4111111111111111", "HN"))
                .assertNext(dto -> {
                    assertEquals(0, dto.getCodigoError());
                    assertNull(dto.getMensajeError());
                    assertFalse(dto.getRowSet().isEmpty());
                    assertEquals("4111111111111111", dto.getRowSet().get(0).getNumtarjeta());
                    assertEquals("John Doe", dto.getRowSet().get(0).getAccountName());
                    assertEquals("ACC001", dto.getRowSet().get(0).getAccountNbr());
                })
                .verifyComplete();

        verify(connectionProvider).getConnectionForCardPosition("process-gt", "mssql");
    }

    @Test
    void rtvHtryInfoTc_connectionError_throwsInternalServerException() {
        when(connectionProvider.getConnectionForCardPosition("process-gt", "mssql"))
                .thenReturn(Mono.error(new RuntimeException("Connection failed")));

        StepVerifier.create(repository.rtvHtryInfoTc("4111111111111111", "HN"))
                .expectError(InternalServerException.class)
                .verify();
    }

    @SuppressWarnings("unchecked")
    @Test
    void rtvHtryInfoTc_queryError_throwsInternalServerException() {
        when(connectionProvider.getConnectionForCardPosition("process-gt", "mssql"))
                .thenReturn(Mono.just(databaseClient));
        when(databaseClient.sql(anyString())).thenReturn(executeSpec);
        when(executeSpec.bind(anyString(), any())).thenReturn(executeSpec);
        when(executeSpec.map(any(BiFunction.class))).thenReturn((RowsFetchSpec) rowsFetchSpec);
        when(rowsFetchSpec.all()).thenReturn(Flux.error(new RuntimeException("SQL error")));

        StepVerifier.create(repository.rtvHtryInfoTc("4111111111111111", "HN"))
                .expectError(InternalServerException.class)
                .verify();
    }
}

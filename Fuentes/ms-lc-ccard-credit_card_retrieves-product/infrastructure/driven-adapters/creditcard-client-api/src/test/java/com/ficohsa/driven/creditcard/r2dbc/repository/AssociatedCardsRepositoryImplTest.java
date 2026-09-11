package com.ficohsa.driven.creditcard.r2dbc.repository;

import com.ficohsa.driven.creditcard.r2dbc.config.DatabaseConnectionProvider;
import com.ficohsa.driven.creditcard.r2dbc.config.DatabasePropsConfig;
import com.ficohsa.driven.creditcard.r2dbc.dto.CreditCardRowDto;
import com.ficohsa.helper.RegionMappingService;
import com.ficohsa.lib.core.exception.InternalServerException;
import com.ficohsa.lib.core.exception.NotFoundException;
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

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.time.Month;
import java.util.function.BiFunction;

import static org.junit.jupiter.api.Assertions.assertNull;
import static org.junit.jupiter.api.Assertions.assertThrows;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.anyString;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
class AssociatedCardsRepositoryImplTest {

    private static final LocalDateTime FIXED_DATE = LocalDateTime.of(2025, Month.JANUARY, 1, 0, 0);

    @Mock private DatabaseConnectionProvider connectionProvider;
    @Mock private RegionMappingService regionMappingService;
    @Mock private DatabasePropsConfig databaseProperties;
    @Mock private DatabaseClient databaseClient;
    @Mock private GenericExecuteSpec executeSpec;
    @Mock private RowsFetchSpec<CreditCardRowDto> rowsFetchSpec;

    private AssociatedCardsRepositoryImpl repository;

    @BeforeEach
    void setUp() {
        repository = new AssociatedCardsRepositoryImpl(connectionProvider, regionMappingService, databaseProperties);
        lenient().when(databaseProperties.getQueryTimeoutSeconds()).thenReturn(30);
    }

    @SuppressWarnings("unchecked")
    @Test
    void getAssociatedActiveCards_success_mapsDataRow() {
        when(connectionProvider.getConnectionByRegion("HN01")).thenReturn(Mono.just(databaseClient));
        when(regionMappingService.getCountryCodeByRegion("HN01")).thenReturn("HN");
        when(databaseClient.sql(anyString())).thenReturn(executeSpec);
        when(executeSpec.bind(anyString(), any())).thenReturn(executeSpec);

        when(executeSpec.map(any(BiFunction.class))).thenAnswer(invocation -> {
            BiFunction<Row, RowMetadata, CreditCardRowDto> mapper = invocation.getArgument(0);

            // Simulate a data row (no MensajeError column)
            Row dataRow = mock(Row.class);
            RowMetadata metadata = mock(RowMetadata.class);
            when(metadata.contains("MensajeError")).thenReturn(false);
            when(dataRow.get("NumeroTarjeta", String.class)).thenReturn("4111111111111111");
            when(dataRow.get("NumeroCuenta", String.class)).thenReturn("001");
            when(dataRow.get("NombreCompleto", String.class)).thenReturn("John Doe");
            when(dataRow.get("CategoriaTarjeta", BigDecimal.class)).thenReturn(BigDecimal.ONE);
            when(dataRow.get("EstadoTarjeta", Integer.class)).thenReturn(1);
            when(dataRow.get("Producto", Integer.class)).thenReturn(2);
            when(dataRow.get("GrupoAfinidad", String.class)).thenReturn("GRP");
            when(dataRow.get("fecapertura", LocalDateTime.class)).thenReturn(FIXED_DATE);

            CreditCardRowDto result = mapper.apply(dataRow, metadata);

            RowsFetchSpec<CreditCardRowDto> fetchSpec = mock(RowsFetchSpec.class);
            when(fetchSpec.all()).thenReturn(Flux.just(result));
            return fetchSpec;
        });

        StepVerifier.create(repository.getAssociatedActiveCards("HN01", "12345", 1))
                .expectNextMatches(card -> "4111111111111111".equals(card.getCreditCardId())
                        && "John Doe".equals(card.getCardHolderName()))
                .verifyComplete();
    }

    @SuppressWarnings("unchecked")
    @Test
    void getAssociatedActiveCards_errorRow_noError_returnsEmptyDto() {
        when(connectionProvider.getConnectionByRegion("HN01")).thenReturn(Mono.just(databaseClient));
        when(regionMappingService.getCountryCodeByRegion("HN01")).thenReturn("HN");
        when(databaseClient.sql(anyString())).thenReturn(executeSpec);
        when(executeSpec.bind(anyString(), any())).thenReturn(executeSpec);

        when(executeSpec.map(any(BiFunction.class))).thenAnswer(invocation -> {
            BiFunction<Row, RowMetadata, CreditCardRowDto> mapper = invocation.getArgument(0);

            Row row = mock(Row.class);
            RowMetadata metadata = mock(RowMetadata.class);
            when(metadata.contains("MensajeError")).thenReturn(true);
            when(row.get("MensajeError", String.class)).thenReturn(null);

            CreditCardRowDto result = mapper.apply(row, metadata);
            assertNull(result.getCreditCardId()); // empty dto

            RowsFetchSpec<CreditCardRowDto> fetchSpec = mock(RowsFetchSpec.class);
            when(fetchSpec.all()).thenReturn(Flux.just(result));
            return fetchSpec;
        });

        StepVerifier.create(repository.getAssociatedActiveCards("HN01", "12345", 1))
                .verifyComplete(); // filtered out by null creditCardId
    }

    @SuppressWarnings("unchecked")
    @Test
    void getAssociatedActiveCards_notFoundError_throwsNotFoundException() {
        when(connectionProvider.getConnectionByRegion("HN01")).thenReturn(Mono.just(databaseClient));
        when(regionMappingService.getCountryCodeByRegion("HN01")).thenReturn("HN");
        when(databaseClient.sql(anyString())).thenReturn(executeSpec);
        when(executeSpec.bind(anyString(), any())).thenReturn(executeSpec);

        when(executeSpec.map(any(BiFunction.class))).thenAnswer(invocation -> {
            BiFunction<Row, RowMetadata, CreditCardRowDto> mapper = invocation.getArgument(0);

            Row row = mock(Row.class);
            RowMetadata metadata = mock(RowMetadata.class);
            when(metadata.contains("MensajeError")).thenReturn(true);
            when(row.get("MensajeError", String.class)).thenReturn("Código cliente no existe");

            assertThrows(NotFoundException.class, () -> mapper.apply(row, metadata));

            RowsFetchSpec<CreditCardRowDto> fetchSpec = mock(RowsFetchSpec.class);
            when(fetchSpec.all()).thenReturn(Flux.empty());
            return fetchSpec;
        });

        StepVerifier.create(repository.getAssociatedActiveCards("HN01", "99999", 1))
                .verifyComplete();
    }

    @SuppressWarnings("unchecked")
    @Test
    void getAssociatedActiveCards_otherError_throwsInternalServerException() {
        when(connectionProvider.getConnectionByRegion("HN01")).thenReturn(Mono.just(databaseClient));
        when(regionMappingService.getCountryCodeByRegion("HN01")).thenReturn("HN");
        when(databaseClient.sql(anyString())).thenReturn(executeSpec);
        when(executeSpec.bind(anyString(), any())).thenReturn(executeSpec);

        when(executeSpec.map(any(BiFunction.class))).thenAnswer(invocation -> {
            BiFunction<Row, RowMetadata, CreditCardRowDto> mapper = invocation.getArgument(0);

            Row row = mock(Row.class);
            RowMetadata metadata = mock(RowMetadata.class);
            when(metadata.contains("MensajeError")).thenReturn(true);
            when(row.get("MensajeError", String.class)).thenReturn("Some DB error");

            assertThrows(InternalServerException.class, () -> mapper.apply(row, metadata));

            RowsFetchSpec<CreditCardRowDto> fetchSpec = mock(RowsFetchSpec.class);
            when(fetchSpec.all()).thenReturn(Flux.empty());
            return fetchSpec;
        });

        StepVerifier.create(repository.getAssociatedActiveCards("HN01", "99999", 1))
                .verifyComplete();
    }

    @Test
    void getAssociatedActiveCards_connectionError_propagates() {
        when(connectionProvider.getConnectionByRegion("HN01"))
                .thenReturn(Mono.error(new RuntimeException("Connection failed")));

        StepVerifier.create(repository.getAssociatedActiveCards("HN01", "12345", 1))
                .expectError(RuntimeException.class)
                .verify();
    }
}

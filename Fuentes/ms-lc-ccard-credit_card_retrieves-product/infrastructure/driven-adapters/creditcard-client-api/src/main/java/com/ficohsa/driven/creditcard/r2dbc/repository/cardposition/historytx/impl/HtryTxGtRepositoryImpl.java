package com.ficohsa.driven.creditcard.r2dbc.repository.cardposition.historytx.impl;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.ficohsa.driven.creditcard.r2dbc.config.DatabaseConnectionProvider;
import com.ficohsa.driven.creditcard.r2dbc.config.DatabasePropsConfig;
import com.ficohsa.driven.creditcard.r2dbc.dto.cardposition.HtryTxDto;
import com.ficohsa.driven.creditcard.r2dbc.repository.cardposition.historytx.HtryTxRepository;
import com.ficohsa.lib.core.exception.InternalServerException;
import io.r2dbc.spi.Row;
import io.r2dbc.spi.RowMetadata;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Repository;
import reactor.core.publisher.Mono;

import java.time.Duration;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.atomic.AtomicInteger;
import java.util.concurrent.atomic.AtomicReference;

@Repository
@RequiredArgsConstructor
@Slf4j
public class HtryTxGtRepositoryImpl implements HtryTxRepository {
    private final DatabaseConnectionProvider connectionProvider;
    private final DatabasePropsConfig databaseProperties;
    private final ObjectMapper mapper;
    private final DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
    private static final String NO_VALID_COLUMN = "No valid column found";
    private static final String CONNECTION_NAME = "process-gt";
    private static final String RDBMS_NAME = "mssql";

    @Override
    public Mono<HtryTxDto> rtvHtryTx(String cardNumber, String rgIso03, String group) {
        return connectionProvider.getConnectionForCardPosition(CONNECTION_NAME, RDBMS_NAME)
                .flatMap(client -> {
                    List<HtryTxDto.TransaccionRow> rows = new ArrayList<>();
                    AtomicInteger codigoError = new AtomicInteger(0);
                    AtomicReference<String> mensajeError = new AtomicReference<>();
                    return client.sql(
                                    "DECLARE @CodigoError INT, @MensajeError VARCHAR(4000); " +
                                            "EXEC [dbo].[OSBConTransaccionesHistoricas] " +
                                            "@Pais = :pais, @Org = NULL, @NumCuenta = :numCuenta, @Tipo = 1, " +
                                            "@Mes = NULL, @Anio = NULL, @Agrupar = :agrupar, " +
                                            "@CodigoError = @CodigoError OUTPUT, @MensajeError = @MensajeError OUTPUT; " +
                                            "SELECT @CodigoError as CodigoError, @MensajeError as MensajeError")
                            .bind("pais", rgIso03)
                            .bind("numCuenta", cardNumber)
                            .bind("agrupar", group)
                            .map((row, metadata) -> {
                                if (metadata.contains("CodigoError")) {
                                    codigoError.set(getIntValue(row, metadata, "CodigoError"));
                                    mensajeError.set(getStringValue(row, metadata, "MensajeError"));
                                    return row;
                                }
                                HtryTxDto.TransaccionRow txRow = new HtryTxDto.TransaccionRow();
                                txRow.setNumtarjeta(getStringValue(row, metadata, "numtarjeta"));
                                txRow.setNombreTarjetahabiente(getStringValue(row, metadata, "nombreTarjetahabiente"));
                                txRow.setFecefectiva(getLocalDateTimeValue(row, metadata, "fecefectiva").format(formatter));
                                txRow.setDescripcion(getStringValue(row, metadata, "descripcion"));
                                txRow.setMonto(getStringValue(row, metadata, "monto"));
                                txRow.setCodMoneda(getStringValue(row, metadata, "CodMoneda"));
                                txRow.setTipoMovimiento(getStringValue(row, metadata, "TipoMovimiento"));
                                txRow.setMontoOriginal(getStringValue(row, metadata, "MontoOriginal"));
                                txRow.setMonedaOriginal(getStringValue(row, metadata, "MonedaOriginal"));
                                rows.add(txRow);
                                return row;
                            })
                            .all()
                            .collectList()
                            .map(rowSet -> new HtryTxDto(codigoError.get(), mensajeError.get(), rows));
                })
                .timeout(Duration.ofSeconds(databaseProperties.getQueryTimeoutSeconds()))
                .doOnError(error -> log.error("[ADAPTER] Error executing OSBConTransaccionesHistoricas GT: {}", error.getMessage(), error))
                .onErrorMap(e -> new InternalServerException("Error querying historical transactions GT"));
    }

    private String getStringValue(Row row, RowMetadata metadata, String... columnNames) {
        for (String columnName : columnNames) {
            if (metadata.contains(columnName)) {
                try {
                    Object value = row.get(columnName); // Sin especificar clase
                    return value != null ? value.toString() : null;
                } catch (Exception e) {
                    log.error("[ADAPTER] Could not convert column {} to String", columnName);
                    throw new InternalServerException(NO_VALID_COLUMN);
                }
            }
        }
        throw new InternalServerException(NO_VALID_COLUMN);
    }

    private Integer getIntValue(Row row, RowMetadata metadata, String... columnNames) {
        for (String columnName : columnNames) {
            if (metadata.contains(columnName)) {
                return row.get(columnName, Integer.class);
            }
        }
        throw new InternalServerException(NO_VALID_COLUMN);
    }

    private LocalDateTime getLocalDateTimeValue(Row row, RowMetadata metadata, String... columnNames) {
        for (String columnName : columnNames) {
            if (metadata.contains(columnName)) {
                return row.get(columnName, LocalDateTime.class);
            }
        }
        throw new InternalServerException(NO_VALID_COLUMN);
    }
}


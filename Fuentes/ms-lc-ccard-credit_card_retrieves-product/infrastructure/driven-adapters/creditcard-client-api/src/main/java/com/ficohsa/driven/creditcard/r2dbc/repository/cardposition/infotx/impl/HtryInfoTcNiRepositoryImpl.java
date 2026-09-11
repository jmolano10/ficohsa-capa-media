package com.ficohsa.driven.creditcard.r2dbc.repository.cardposition.infotx.impl;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.ficohsa.driven.creditcard.r2dbc.config.DatabaseConnectionProvider;
import com.ficohsa.driven.creditcard.r2dbc.config.DatabasePropsConfig;
import com.ficohsa.driven.creditcard.r2dbc.dto.cardposition.HtryInfoTcDto;
import com.ficohsa.driven.creditcard.r2dbc.repository.cardposition.infotx.HtryInfoTcRepository;
import com.ficohsa.lib.core.exception.InternalServerException;
import io.r2dbc.spi.Row;
import io.r2dbc.spi.RowMetadata;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Repository;
import reactor.core.publisher.Mono;

import java.time.Duration;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.concurrent.atomic.AtomicInteger;
import java.util.concurrent.atomic.AtomicReference;

@Repository
@RequiredArgsConstructor
@Slf4j
public class HtryInfoTcNiRepositoryImpl implements HtryInfoTcRepository {
    private final DatabaseConnectionProvider connectionProvider;
    private final DatabasePropsConfig databaseProperties;
    private final ObjectMapper mapper;
    private static final String NO_VALID_COLUMN = "No valid column found";
    private static final String CONNECTION_NAME = "cards-process-ni";
    private static final String RDBMS_NAME = "mssql";

    @Override
    public Mono<HtryInfoTcDto> rtvHtryInfoTc(String cardNumber, String rgIso03) {
        return connectionProvider.getConnectionForCardPosition(CONNECTION_NAME, RDBMS_NAME)
                .flatMap(client -> {
                    List<HtryInfoTcDto.InfoHistoricaRow> rows = new ArrayList<>();
                    AtomicInteger codigoError = new AtomicInteger(0);
                    AtomicReference<String> mensajeError = new AtomicReference<>();
                    return client.sql(
                                    "DECLARE @CodigoError INT, @MensajeError VARCHAR(4000); " +
                                            "EXEC [dbo].[OSBConInfoHistoricaTC] " +
                                            "@Pais = :pais, @Org = NULL, @NumCard = :numCard, @Mes = NULL, @Anio = NULL, " +
                                            "@CodigoError = @CodigoError OUTPUT, @MensajeError = @MensajeError OUTPUT; " +
                                            "SELECT @CodigoError as CodigoError, @MensajeError as MensajeError")
                            .bind("pais", rgIso03)
                            .bind("numCard", cardNumber)
                            .map((row, metadata) -> {
                                if (metadata.contains("CodigoError")) {
                                    codigoError.set(getIntValue(row, metadata, "CodigoError"));
                                    mensajeError.set(getStringValue(row, metadata, "MensajeError"));
                                    return row;
                                }
                                HtryInfoTcDto.InfoHistoricaRow infoRow = new HtryInfoTcDto.InfoHistoricaRow();
                                infoRow.setAccountName(getStringValue(row, metadata, "cardholder_name", "account_name"));
                                infoRow.setNumtarjeta(getStringValue(row, metadata, "numtarjeta"));
                                infoRow.setAccountNbr(getStringValue(row, metadata, "Account_nbr"));
                                infoRow.setFecproxecta(getStringValue(row, metadata, "fecproxecta"));
                                infoRow.setFechamaximapago(getStringValue(row, metadata, "fechamaximapago"));
                                infoRow.setCodMoneda(getStringValue(row, metadata, "CodMoneda"));
                                infoRow.setCrlim(getStringValue(row, metadata, "CRLIM"));
                                infoRow.setPuntosAcumulados(getStringValue(row, metadata, "PuntosAcumulados"));
                                infoRow.setTotbalini(getStringValue(row, metadata, "totbalini"));
                                infoRow.setPagominimo(getStringValue(row, metadata, "pagominimo"));
                                infoRow.setActualdue(getStringValue(row, metadata, "actualdue"));
                                infoRow.setSaldoAlCorte(getStringValue(row, metadata, "SaldoAlCorte"));
                                rows.add(infoRow);
                                return row;
                            })
                            .all()
                            .collectList()
                            .map(rowSet -> new HtryInfoTcDto(codigoError.get(), mensajeError.get(), rows));
                })
                .timeout(Duration.ofSeconds(databaseProperties.getQueryTimeoutSeconds()))
                .doOnError(error -> log.error("[ADAPTER] Error executing OSBConInfoHistoricaTC NI: {}", error.getMessage(), error))
                .onErrorMap(e -> new InternalServerException("Error querying historical TC information NI"));
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

    private int getIntValue(Row row, RowMetadata metadata, String... columnNames) {
        for (String columnName : columnNames) {
            if (metadata.contains(columnName)) {
                return Optional.ofNullable(row.get(columnName, Integer.class)).orElse(0);
            }
        }
        throw new InternalServerException(NO_VALID_COLUMN);
    }
}

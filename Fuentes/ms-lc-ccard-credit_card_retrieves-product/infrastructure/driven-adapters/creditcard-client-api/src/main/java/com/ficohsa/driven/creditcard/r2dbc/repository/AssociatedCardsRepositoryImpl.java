package com.ficohsa.driven.creditcard.r2dbc.repository;

import com.ficohsa.driven.creditcard.r2dbc.config.DatabaseConnectionProvider;
import com.ficohsa.driven.creditcard.r2dbc.config.DatabasePropsConfig;
import com.ficohsa.driven.creditcard.r2dbc.dto.CreditCardRowDto;
import com.ficohsa.helper.RegionMappingService;
import com.ficohsa.lib.core.exception.InternalServerException;
import com.ficohsa.lib.core.exception.NotFoundException;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Repository;
import reactor.core.publisher.Flux;

import java.math.BigDecimal;
import java.time.Duration;
import java.time.LocalDateTime;
import java.util.concurrent.TimeoutException;


@Repository
@RequiredArgsConstructor
@Slf4j
public class AssociatedCardsRepositoryImpl implements AssociatedCardsRepository {

    private final DatabaseConnectionProvider connectionProvider;
    private final RegionMappingService regionMappingService;
    private final DatabasePropsConfig databaseProperties;

    @Override
    public Flux<CreditCardRowDto> getAssociatedActiveCards(String region, String numCliente, Integer tipo) {
        return connectionProvider.getConnectionByRegion(region)
                .flatMapMany(client -> 
                    client.sql("DECLARE @CodigoError INT, @MensajeError VARCHAR(4000); " +
                              "EXEC [dbo].[OSBConDatoTarjetasActivasCliente] " +
                              "@Pais = :pais, @Org = NULL, @NumCliente = :numCliente, @Tipo = :tipo, " +
                              "@CodigoError = @CodigoError OUTPUT, @MensajeError = @MensajeError OUTPUT; " +
                              "SELECT @CodigoError as CodigoError, @MensajeError as MensajeError")
                            .bind("pais", regionMappingService.getCountryCodeByRegion(region))
                            .bind("numCliente", numCliente)
                            .bind("tipo", tipo)
                            .map((row, metadata) -> {
                                if (metadata.contains("MensajeError")) {
                                    String errorMessage = row.get("MensajeError", String.class);
                                    if (errorMessage != null) {
                                        if ("Código cliente no existe".equals(errorMessage)) {
                                            throw new NotFoundException(errorMessage);
                                        }
                                        throw new InternalServerException(errorMessage);
                                    }
                                    return new CreditCardRowDto();
                                }
                                CreditCardRowDto creditCard = new CreditCardRowDto();
                                creditCard.setCreditCardId(row.get("NumeroTarjeta", String.class));
                                creditCard.setAccountNumber(row.get("NumeroCuenta", String.class));
                                creditCard.setCardHolderName(row.get("NombreCompleto", String.class));
                                creditCard.setCardType(row.get("CategoriaTarjeta", BigDecimal.class));
                                creditCard.setCardOperationalStatus(row.get("EstadoTarjeta", Integer.class));
                                creditCard.setCardProductType(row.get("Producto", Integer.class));
                                creditCard.setCardAffinityGroup(row.get("GrupoAfinidad", String.class));
                                creditCard.setCardEffectiveDate(row.get("fecapertura", LocalDateTime.class));
                                return creditCard;
                            }).all()
                )
                .filter(creditCardRowDto -> creditCardRowDto.getCreditCardId() != null)
                .timeout(Duration.ofSeconds(databaseProperties.getQueryTimeoutSeconds()))
                .doOnError(TimeoutException.class, error -> 
                    log.error("[ADAPTER] Query timeout after {} seconds for region: {}", 
                        databaseProperties.getQueryTimeoutSeconds(), region))
                .doOnError(error -> log.error("[ADAPTER] Error executing SP for region: {}, error: {}", region, error.getMessage()))
                .doOnSubscribe(subscription -> log.info("[ADAPTER] Executing SP for region: {}", region))
                .doOnComplete(() -> log.info("[ADAPTER] SP execution completed for region: {}", region));
    }
}



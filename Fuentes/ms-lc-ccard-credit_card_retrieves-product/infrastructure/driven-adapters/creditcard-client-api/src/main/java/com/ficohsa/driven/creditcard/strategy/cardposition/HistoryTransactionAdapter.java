package com.ficohsa.driven.creditcard.strategy.cardposition;

import com.ficohsa.driven.creditcard.r2dbc.dto.cardposition.HtryTxDto;
import com.ficohsa.driven.creditcard.strategy.cardposition.strategy.HistoryTransactionsStrategy;
import com.ficohsa.helper.RegionUtils;
import com.ficohsa.lib.core.exception.BadGatewayException;
import com.ficohsa.lib.core.exception.BusinessCoreException;
import com.ficohsa.lib.core.exception.NotFoundException;
import com.ficohsa.model.cardposition.CreditCardStatement;
import com.ficohsa.ports.IHistoryTransactionsGateway;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Component;
import org.springframework.web.server.ResponseStatusException;
import reactor.core.publisher.Mono;

import java.util.Collections;
import java.util.List;
import java.util.Map;
import java.util.function.Function;
import java.util.stream.Collectors;

@Slf4j
@Component
@RequiredArgsConstructor
public class HistoryTransactionAdapter implements IHistoryTransactionsGateway {
    private final List<HistoryTransactionsStrategy> strategies;
    private Map<String, HistoryTransactionsStrategy> strategyMap;

    private Map<String, HistoryTransactionsStrategy> getStrategyMap() {
        if (strategyMap == null) {
            strategyMap = strategies.stream()
                    .collect(Collectors.toMap(HistoryTransactionsStrategy::getRegion, Function.identity()));
        }
        return strategyMap;
    }

    @Override
    public Mono<CreditCardStatement> rtvHistoryTc(String cardNumber, String rg, String type) {
        return Mono.justOrEmpty(getStrategyMap().get(rg))
                .switchIfEmpty(Mono.error(new ResponseStatusException(HttpStatus.UNPROCESSABLE_ENTITY, "NOT_IMPLEMENTED")))
                .flatMap(strategy -> {
                    String region = extractRegion(rg);
                    return strategy.execute(cardNumber, region);
                })
                .flatMap(this::handleErrorResponse)
                .map(this::mapToCreditCardStatement)
                .doOnSuccess(result -> log.info("[ADAPTER] HistoryInfoResponse: {}", result.getAssociatedCardReference().size()))
                .filter(creditCardStatement -> !creditCardStatement.getAssociatedCardReference().isEmpty())
                .switchIfEmpty(Mono.error(new NotFoundException("No records for this request")));
    }

    private static final String ERROR_PREFIX = "FICBCO0008$#$";

    private Mono<HtryTxDto> handleErrorResponse(HtryTxDto response) {
        if (response.getCodigoError() != null && response.getCodigoError() != -1) {
            log.error("[ADAPTER] Error in OSBConTransaccionesHistoricas: {} - {}",
                    response.getCodigoError(), response.getMensajeError());

            var codErr = response.getCodigoError().toString();
            var textErr = ERROR_PREFIX + response.getMensajeError();

            log.info("[ADAPTER] Invoking error manager with code: {} and message: {}", codErr, textErr);

            return Mono.error(new BusinessCoreException(new BadGatewayException("Failed to retrieve data from external source"), codErr, textErr));
        }
        return Mono.just(response);
    }

    private CreditCardStatement mapToCreditCardStatement(HtryTxDto response) {
        List<CreditCardStatement.AssociatedCardReference> associatedCards = response.getRowSet() != null ?
            response.getRowSet().stream()
                .collect(Collectors.groupingBy(
                        HtryTxDto.TransaccionRow::getNumtarjeta,
                    Collectors.collectingAndThen(
                        Collectors.toList(),
                        rows -> CreditCardStatement.AssociatedCardReference.builder()
                            .cardIdentifier(rows.getFirst().getNumtarjeta())
                            .cardHolderReference(rows.getFirst().getNombreTarjetahabiente())
                            .cardTransactionRecord(
                                rows.stream()
                                    .map(row -> CreditCardStatement.CardTransactionRecord.builder()
                                        .transactionDate(row.getFecefectiva())
                                        .transactionNarrative(row.getDescripcion())
                                        .transactionAmount(row.getMonto())
                                        .transactionCurrency(row.getCodMoneda())
                                        .transactionType(row.getTipoMovimiento())
                                        .originalTransactionAmount(row.getMontoOriginal())
                                        .originalTransactionCurrency(row.getMonedaOriginal())
                                        .build()
                                    )
                                    .toList()
                            )
                            .build()
                    )
                ))
                .values()
                .stream()
                .toList()
            : Collections.emptyList();
        
        return CreditCardStatement.builder()
                .associatedCardReference(associatedCards)
                .build();
    }

    private String extractRegion(String rg) {
        String iso03 = RegionUtils.toISO03(rg);
        if (iso03 == null) throw new ResponseStatusException(HttpStatus.UNPROCESSABLE_ENTITY, "NOT_IMPLEMENTED");
        return iso03;
    }
}



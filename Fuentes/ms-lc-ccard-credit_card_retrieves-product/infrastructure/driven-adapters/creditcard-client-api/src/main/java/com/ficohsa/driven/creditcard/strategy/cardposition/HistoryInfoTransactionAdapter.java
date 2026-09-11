package com.ficohsa.driven.creditcard.strategy.cardposition;

import com.ficohsa.driven.creditcard.r2dbc.dto.cardposition.HtryInfoTcDto;
import com.ficohsa.driven.creditcard.strategy.cardposition.strategy.HistoryInfoTransactionStrategy;
import com.ficohsa.helper.RegionUtils;
import com.ficohsa.lib.core.exception.BadGatewayException;
import com.ficohsa.lib.core.exception.BusinessCoreException;
import com.ficohsa.lib.core.exception.NotFoundException;
import com.ficohsa.lib.core.exception.UnprocessableEntityException;
import com.ficohsa.model.cardposition.HistoryInfoResponse;
import com.ficohsa.ports.IHistoryInfoTransactionsGateway;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;
import reactor.core.publisher.Mono;

import java.util.Collections;
import java.util.List;
import java.util.Map;
import java.util.function.Function;
import java.util.stream.Collectors;

@Slf4j
@Component
@RequiredArgsConstructor
public class HistoryInfoTransactionAdapter implements IHistoryInfoTransactionsGateway {
    private final List<HistoryInfoTransactionStrategy> strategies;
    private Map<String, HistoryInfoTransactionStrategy> strategyMap;

    private Map<String, HistoryInfoTransactionStrategy> getStrategyMap() {
        if (strategyMap == null) {
            strategyMap = strategies.stream()
                    .collect(Collectors.toMap(HistoryInfoTransactionStrategy::getRegion, Function.identity()));
        }
        return strategyMap;
    }

    @Override
    public Mono<HistoryInfoResponse> rtvHistoryInfoTc(String cardNumber, String rg) {
        return Mono.justOrEmpty(getStrategyMap().get(rg))
                .switchIfEmpty(Mono.error(new UnprocessableEntityException("NOT_IMPLEMENTED")))
                .flatMap(strategy -> {
                    String region = extractRegion(rg);
                    return strategy.execute(cardNumber, region);
                })
                .flatMap(this::handleErrorResponse)
                .map(this::mapToHistoryInfoResponse)
                .doOnSuccess(result -> log.info("[ADAPTER] HistoryInfoResponse: {}", result.getRows().size()))
                .filter(historyInfo -> !historyInfo.getRows().isEmpty())
                .switchIfEmpty(Mono.error(new NotFoundException("No records for this request")));
    }

    private static final String ERROR_PREFIX = "FICBCO0008$#$";

    private static final int ERROR_CARD_NOT_FOUND = 2;
    private static final String ERROR_MSG_CARD_NOT_FOUND = "Se debe especificar un numero de Tarjeta";

    private Mono<HtryInfoTcDto> handleErrorResponse(HtryInfoTcDto response) {
        if (response.getCodigoError() != null && response.getCodigoError() != -1) {
            log.error("[ADAPTER] Error in OSBConInfoHistoricaTC: {} - {}",
                    response.getCodigoError(), response.getMensajeError());

            var codErr = response.getCodigoError().toString();
            var textErr = ERROR_PREFIX + response.getMensajeError();

            log.info("[ADAPTER] Invoking error manager with code: {} and message: {}", codErr, textErr);

            if (response.getCodigoError() == ERROR_CARD_NOT_FOUND
                    && response.getMensajeError() != null
                    && response.getMensajeError().contains(ERROR_MSG_CARD_NOT_FOUND)) {
                return Mono.error(new BusinessCoreException(new NotFoundException("Credit card not found"), codErr, textErr));
            }

            return Mono.error(new BusinessCoreException(new BadGatewayException("Failed to retrieve data from external source"), codErr, textErr));
        }
        return Mono.just(response);
    }

    private HistoryInfoResponse mapToHistoryInfoResponse(HtryInfoTcDto response) {
        log.info("[ADAPTER] Historical information retrieved: {} records", 
                response.getRowSet() != null ? response.getRowSet().size() : 0);

        List<HistoryInfoResponse.InfoRow> rows = response.getRowSet() != null ?
                response.getRowSet().stream()
                        .map(row -> HistoryInfoResponse.InfoRow.builder()
                                .partyReference(row.getAccountName())
                                .productInstanceReference(row.getNumtarjeta())
                                .associationReference(row.getAccountNbr())
                                .statementDate(row.getFecproxecta())
                                .paymentDueDate(row.getFechamaximapago())
                                .currencyCode(row.getCodMoneda())
                                .positionLimitValue(row.getCrlim())
                                .rewardPointsBalance(row.getPuntosAcumulados())
                                .previousStatementBalance(row.getTotbalini())
                                .minimumPaymentAmount(row.getPagominimo())
                                .paymentAmount(row.getActualdue())
                                .periodStatementBalance(row.getSaldoAlCorte())
                                .build())
                        .toList()
                : Collections.emptyList();
        
        return HistoryInfoResponse.builder()
                .rows(rows)
                .build();
    }

    private String extractRegion(String rg) {
        String iso03 = RegionUtils.toISO03(rg);
        if (iso03 == null) throw new UnprocessableEntityException("NOT_IMPLEMENTED");
        return iso03;
    }
}



package com.ficohsa.helper;

import com.ficohsa.lib.core.exception.UnprocessableEntityException;
import com.ficohsa.model.RegionStatusModel;
import com.ficohsa.model.settlementquotedetails.RegionModel;
import com.ficohsa.ports.IDebitBasicInformationGateway;
import com.ficohsa.ports.IDebitCardDetailsGateway;
import com.ficohsa.ports.ISettlementQuoteDetailsGateway;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;
import reactor.core.publisher.Mono;

import java.util.Map;

@Slf4j
@Component
@RequiredArgsConstructor
public class CertificateDepositInfoResolver {

    private static final String NOT_IMPLEMENTED = "NOT_IMPLEMENTED";

    private static final String ORIGINAL_SOURCE_BANK_LOG = "Original sourceBank: {}";
    private static final String NORMALIZED_SOURCE_REGION_LOG = "Normalized sourceRegion: {}";
    private static final String REGION_LOG_PREFIX = "Region: ";

    // Spring inyecta todas las estrategias: keys = nombres de @Component ("HN","GT","PA","NI")
    private final Map<String, IDebitBasicInformationGateway> strategies;
    private final Map<String, IDebitCardDetailsGateway> debitCardDetailsStrategies;
    private final Map<String, ISettlementQuoteDetailsGateway> settlementQuoteDetailsStrategies;

    public Mono<IDebitBasicInformationGateway> resolveWrapper(String sourceBank, RegionStatusModel params){
        return Mono.fromCallable(() -> {
            log.info(ORIGINAL_SOURCE_BANK_LOG, sourceBank);
            String sourceRegion = normalize(sourceBank);
            log.info(NORMALIZED_SOURCE_REGION_LOG, sourceRegion);
            log.info("[HELPER] Available strategies: {}", strategies.keySet());

            var match = params.getRegionStatusRetrieve().getRegionStates().stream().filter(
                            region -> sourceRegion.equalsIgnoreCase(region.getRegion().substring(0, 4)))
                    .findFirst();

            if (match.isEmpty()) {
                throw new UnprocessableEntityException(NOT_IMPLEMENTED);
            }

            log.info(REGION_LOG_PREFIX + match.get().getRegion());
            if (Boolean.FALSE.equals(match.get().getEnabled())) {
                throw new UnprocessableEntityException(NOT_IMPLEMENTED);
            }

            IDebitBasicInformationGateway strategy = strategies.get(sourceRegion);
            log.info("[HELPER] Found strategy for {}: {}", sourceRegion, strategy != null ? strategy.getClass().getSimpleName() : "null");

            if (strategy == null) {
                throw new UnprocessableEntityException(NOT_IMPLEMENTED);
            }

            return strategy;
        });
    }

    public Mono<IDebitCardDetailsGateway> resolveDebitCardDetailsWrapper(String sourceBank, RegionStatusModel params){
        return Mono.fromCallable(() -> {
            log.info(ORIGINAL_SOURCE_BANK_LOG, sourceBank);
            String sourceRegion = normalize(sourceBank);
            log.info(NORMALIZED_SOURCE_REGION_LOG, sourceRegion);
            log.info("[HELPER] Available debit card details strategies: {}", debitCardDetailsStrategies.keySet());

            var match = params.getRegionStatusRetrieve().getRegionStates().stream().filter(
                            region -> sourceRegion.equalsIgnoreCase(region.getRegion().substring(0, 4)))
                    .findFirst();

            if (match.isEmpty()) {
                throw new UnprocessableEntityException(NOT_IMPLEMENTED);
            }

            log.info(REGION_LOG_PREFIX + match.get().getRegion());
            if (Boolean.FALSE.equals(match.get().getEnabled())) {
                throw new UnprocessableEntityException(NOT_IMPLEMENTED);
            }

            IDebitCardDetailsGateway strategy = debitCardDetailsStrategies.get(sourceRegion);
            log.info("[HELPER] Found debit card details strategy for {}: {}", sourceRegion, strategy != null ? strategy.getClass().getSimpleName() : "null");

            if (strategy == null) {
                throw new UnprocessableEntityException(NOT_IMPLEMENTED);
            }

            return strategy;
        });
    }

    public Mono<ISettlementQuoteDetailsGateway> resolveSettlementQuoteDetailsWrapper(String sourceBank, RegionModel params){
        return Mono.fromCallable(() -> {
            log.info(ORIGINAL_SOURCE_BANK_LOG, sourceBank);
            String sourceRegion = normalize(sourceBank);
            log.info(NORMALIZED_SOURCE_REGION_LOG, sourceRegion);
            log.info("[HELPER] Available debit card details strategies: {}", settlementQuoteDetailsStrategies.keySet());

            var match = params.getRegions().stream().filter(
                            region -> sourceRegion.equalsIgnoreCase(region.getRegion().substring(0, 4)))
                    .findFirst();

            if (match.isEmpty()) {
                throw new UnprocessableEntityException(NOT_IMPLEMENTED);
            }

            log.info(REGION_LOG_PREFIX + match.get().getRegion());
            if (Boolean.FALSE.equals(match.get().getEnabled())) {
                throw new UnprocessableEntityException(NOT_IMPLEMENTED);
            }

            ISettlementQuoteDetailsGateway strategy = settlementQuoteDetailsStrategies.get(sourceRegion+"VP");
            log.info(sourceRegion, sourceRegion+"VP");
            log.info("[HELPER] Found debit card details strategy for {}: {}", sourceRegion, strategy != null ? strategy.getClass().getSimpleName() : "null");

            if (strategy == null) {
                throw new UnprocessableEntityException(NOT_IMPLEMENTED);
            }

            return strategy;
        });
    }

    private String normalize(String sourceBank) {
        return sourceBank.trim();
    }
}




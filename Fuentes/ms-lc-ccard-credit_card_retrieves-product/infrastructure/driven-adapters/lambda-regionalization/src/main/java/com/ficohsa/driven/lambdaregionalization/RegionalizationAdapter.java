package com.ficohsa.driven.lambdaregionalization;

import com.ficohsa.helper.config.*;
import com.ficohsa.lib.regionalization.utils.RegionalizationConstants;
import com.ficohsa.ports.IRegionalizationGateway;
import jakarta.annotation.PostConstruct;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;
import reactor.core.publisher.Mono;

import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

@Slf4j
@Component
@RequiredArgsConstructor
public class RegionalizationAdapter implements IRegionalizationGateway {

    private final RegionalizationComponentPort regionalizationComponent;
    private final CardPositionRetrieveProperties cardPositionProps;
    private final DebitBasicInformationProperties debitBasicInfoProps;
    private final DebitCardDetailsProperties debitCardDetailsProps;
    private final SettlementQuoteDetailsProperties settlementQuoteProps;
    private final AssociatedActiveCardsProperties associatedActiveCardsProps;

    private final Map<String, OperationConfig> operationConfigs = new ConcurrentHashMap<>();

    record OperationConfig(String country, String domain, String method) {}

    @PostConstruct
    void init() {
        register(cardPositionProps.getMethod(), cardPositionProps.getCountry(), cardPositionProps.getDomain());
        register(debitBasicInfoProps.getMethod(), debitBasicInfoProps.getCountry(), debitBasicInfoProps.getDomain());
        register(debitCardDetailsProps.getMethod(), debitCardDetailsProps.getCountry(), debitCardDetailsProps.getDomain());
        register(settlementQuoteProps.getMethod(), settlementQuoteProps.getCountry(), settlementQuoteProps.getDomain());
        register(associatedActiveCardsProps.getMethod(), associatedActiveCardsProps.getCountry(), associatedActiveCardsProps.getDomain());
        log.info("[ADAPTER] Registered regionalization operations: {}", operationConfigs.keySet());
    }

    private void register(String method, String country, String domain) {
        operationConfigs.put(method, new OperationConfig(country, domain, method));
    }

    @Override
    public Mono<Void> validateRegion(String methodName, String sourceBank, String destinationBank) {
        var config = resolveConfig(methodName);
        return Mono.defer(() -> {
            log.info("[ADAPTER] Validating region: country={}, domain={}, method={}, sourceBank={}, destinationBank={}",
                    config.country(), config.domain(), config.method(), sourceBank, destinationBank);
            return regionalizationComponent
                    .validateRegionEnabled(config.country(), config.domain(), config.method(),
                            RegionalizationConstants.DEFAULT_VERSION, sourceBank, destinationBank)
                    .doOnSuccess(v -> log.info("[ADAPTER] Region validation successful for {}", methodName))
                    .doOnError(e -> log.warn("[ADAPTER] Region validation failed for {}: {}", methodName, e.getMessage()));
        });
    }

    private OperationConfig resolveConfig(String methodName) {
        var config = operationConfigs.get(methodName);
        if (config == null) {
            throw new IllegalArgumentException("Unknown operation: " + methodName + ". Registered: " + operationConfigs.keySet());
        }
        return config;
    }
}

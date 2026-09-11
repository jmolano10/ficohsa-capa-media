package com.ficohsa.usecase;

import com.ficohsa.lib.core.exception.UnprocessableEntityException;
import com.ficohsa.model.settlementquotedetails.SettlementQuoteDetails;
import com.ficohsa.model.settlementquotedetails.SettlementQuoteDetailsModel;
import com.ficohsa.ports.IRegionalizationGateway;
import com.ficohsa.ports.ISettlementQuoteDetails;
import com.ficohsa.ports.ISettlementQuoteDetailsGateway;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;
import reactor.core.publisher.Mono;

import java.util.Map;

@Slf4j
@Component
@RequiredArgsConstructor
public class SettlementQuoteDetailsUseCase implements ISettlementQuoteDetails {

    private final IRegionalizationGateway regionalizationGateway;
    private final Map<String, ISettlementQuoteDetailsGateway> settlementQuoteDetailsStrategies;

    @Override
    public Mono<SettlementQuoteDetailsModel> retrieveSettlementQuoteDetails(SettlementQuoteDetails request) {
        log.info("[USE-CASE] Orchestrating settlement quote details retrieval for account: {}", request.getAccountNumber());
        String sourceBank = request.getRegion();
        return regionalizationGateway.validateRegion("settlement-quote-details", sourceBank, sourceBank)
                .then(Mono.defer(() -> {
                    String normalizedBank = sourceBank.trim();
                    ISettlementQuoteDetailsGateway strategy = settlementQuoteDetailsStrategies.get(normalizedBank + "VP");
                    if (strategy == null) {
                        return Mono.error(new UnprocessableEntityException("NOT_IMPLEMENTED"));
                    }
                    return strategy.retrieveSettlementQuoteDetails(request);
                }));
    }
}

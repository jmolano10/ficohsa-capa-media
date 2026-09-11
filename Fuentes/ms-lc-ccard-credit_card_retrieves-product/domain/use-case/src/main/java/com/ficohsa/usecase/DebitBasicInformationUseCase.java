package com.ficohsa.usecase;

import com.ficohsa.lib.core.exception.UnprocessableEntityException;
import com.ficohsa.model.debitbasicinformation.DebitBasicInformation;
import com.ficohsa.ports.IDebitBasicInformation;
import com.ficohsa.ports.IDebitBasicInformationGateway;
import com.ficohsa.ports.IRegionalizationGateway;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;
import reactor.core.publisher.Mono;

import java.util.Map;

@Slf4j
@Component
@RequiredArgsConstructor
public class DebitBasicInformationUseCase implements IDebitBasicInformation {

    private final Map<String, IDebitBasicInformationGateway> strategies;
    private final IRegionalizationGateway regionalizationGateway;

    @Override
    public Mono<DebitBasicInformation> debitBasicInformationRetrieve(String debitCardId, String sourceBank) {
        return regionalizationGateway.validateRegion("debit-basic-information", sourceBank, sourceBank)
                .then(Mono.defer(() -> {
                    IDebitBasicInformationGateway strategy = strategies.get(sourceBank.trim());
                    if (strategy == null) {
                        return Mono.error(new UnprocessableEntityException("NOT_IMPLEMENTED"));
                    }
                    return strategy.retrieveDebitBasicInformation(debitCardId)
                            .contextWrite(context -> context.put("Source-Bank", sourceBank));
                }));
    }
}

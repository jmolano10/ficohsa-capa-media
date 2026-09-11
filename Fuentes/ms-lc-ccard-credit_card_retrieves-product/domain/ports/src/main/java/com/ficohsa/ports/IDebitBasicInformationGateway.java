package com.ficohsa.ports;

import com.ficohsa.model.debitbasicinformation.DebitBasicInformation;
import reactor.core.publisher.Mono;

public interface IDebitBasicInformationGateway {
    String key();

    Mono<DebitBasicInformation> retrieveDebitBasicInformation(String debitCardId);

}


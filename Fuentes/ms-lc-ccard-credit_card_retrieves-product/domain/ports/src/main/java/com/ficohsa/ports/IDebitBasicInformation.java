package com.ficohsa.ports;

import com.ficohsa.model.debitbasicinformation.DebitBasicInformation;
import reactor.core.publisher.Mono;

public interface IDebitBasicInformation {
    Mono<DebitBasicInformation> debitBasicInformationRetrieve(String debitCardId, String sourceBank);
}

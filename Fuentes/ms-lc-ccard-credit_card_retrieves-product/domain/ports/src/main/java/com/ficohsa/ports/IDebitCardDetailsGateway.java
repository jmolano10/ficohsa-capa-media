package com.ficohsa.ports;

import com.ficohsa.model.debitcarddetails.DebitCardDetails;
import reactor.core.publisher.Mono;

public interface IDebitCardDetailsGateway {
    String key();
    Mono<DebitCardDetails> retrieveDebitCardDetails(String customerIdentification, String accountStatusTypeValues, String accountNumber);
}


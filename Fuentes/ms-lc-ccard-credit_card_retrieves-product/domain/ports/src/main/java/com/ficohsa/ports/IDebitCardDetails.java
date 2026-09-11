package com.ficohsa.ports;

import com.ficohsa.model.debitcarddetails.DebitCardDetails;
import reactor.core.publisher.Mono;

public interface IDebitCardDetails {
    Mono<DebitCardDetails> getDebitCardDetails(String customerIdentification, String accountStatusTypeValues, String accountNumber, String sourceBank);
}

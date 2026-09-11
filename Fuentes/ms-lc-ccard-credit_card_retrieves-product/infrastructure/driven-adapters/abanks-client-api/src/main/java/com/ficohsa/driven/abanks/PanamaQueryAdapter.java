package com.ficohsa.driven.abanks;

import com.ficohsa.model.debitbasicinformation.DebitBasicInformation;
import com.ficohsa.model.debitcarddetails.DebitCardDetails;
import com.ficohsa.ports.IDebitBasicInformationGateway;
import com.ficohsa.ports.IDebitCardDetailsGateway;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Component;
import reactor.core.publisher.Mono;

@Slf4j
@Component
public class PanamaQueryAdapter implements IDebitBasicInformationGateway, IDebitCardDetailsGateway {
    
    private final AbanksQueryAdapter abanksQueryAdapter;

    public PanamaQueryAdapter(@Qualifier("abanksQueryAdapter") AbanksQueryAdapter abanksQueryAdapter) {
        this.abanksQueryAdapter = abanksQueryAdapter;
    }

    @Override
    public String key() {
        return "PA01";
    }

    @Override
    public Mono<DebitBasicInformation> retrieveDebitBasicInformation(String debitCardId) {
        return abanksQueryAdapter.retrieveDebitBasicInformation(debitCardId);
    }
    @Override
    public Mono<DebitCardDetails> retrieveDebitCardDetails(String customerIdentification, String accountStatusTypeValues, String accountNumber) {
        return abanksQueryAdapter.retrieveDebitCardDetails(customerIdentification, accountStatusTypeValues, accountNumber);
    }

}



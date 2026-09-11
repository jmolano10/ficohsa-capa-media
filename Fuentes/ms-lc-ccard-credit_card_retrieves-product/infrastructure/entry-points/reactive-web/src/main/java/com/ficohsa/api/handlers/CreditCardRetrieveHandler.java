package com.ficohsa.api.handlers;

import com.ficohsa.lib.core.utility.AppTool;
import com.ficohsa.model.CreditCardsDetails;
import com.ficohsa.ports.ICreditCardRetrieve;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;
import reactor.core.publisher.Mono;

@Slf4j
@Component
@RequiredArgsConstructor
public class CreditCardRetrieveHandler {

    private final ICreditCardRetrieve creditCardRetrieve;

    public Mono<CreditCardsDetails> handle(String customerIdentification) {
        return AppTool.context()
                .flatMap(ctx -> creditCardRetrieve.creditCardRetrieve(customerIdentification));
    }
}

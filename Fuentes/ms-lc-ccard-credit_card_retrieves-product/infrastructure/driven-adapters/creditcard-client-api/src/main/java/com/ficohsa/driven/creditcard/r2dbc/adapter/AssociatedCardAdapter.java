package com.ficohsa.driven.creditcard.r2dbc.adapter;

import com.ficohsa.driven.creditcard.r2dbc.mapper.CreditCardPortfolioMapper;
import com.ficohsa.driven.creditcard.r2dbc.repository.AssociatedCardsRepository;
import com.ficohsa.model.associatedcards.CreditCardPortfolio;
import com.ficohsa.model.associatedcards.CreditCardRetrieve;
import com.ficohsa.ports.IAssociatedCardsGateway;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;
import reactor.core.publisher.Mono;

@Component
@AllArgsConstructor
@Slf4j
public class AssociatedCardAdapter implements IAssociatedCardsGateway {

    private final AssociatedCardsRepository repository;
    private final CreditCardPortfolioMapper mapper;

    @Override
    public Mono<CreditCardPortfolio> getAssociatedActiveCards(CreditCardRetrieve creditCardRetrieve) {
        String region = creditCardRetrieve.getRegion();
        String customerId = creditCardRetrieve.getCustomerFilter().getCustomerIdentification();
        Integer customerType = creditCardRetrieve.getCustomerFilter().getCustomerIdentificationTypeCode();
        return repository.getAssociatedActiveCards(region, customerId, customerType)
                .collectList()
                .map(rows -> mapper.toDomainPortfolioWithRegion(rows, region))
                .doOnSuccess(result -> log.info("[ADAPTER] Retrieved {} credit cards",
                    result.getCreditCardDetails().size()));
    }
}


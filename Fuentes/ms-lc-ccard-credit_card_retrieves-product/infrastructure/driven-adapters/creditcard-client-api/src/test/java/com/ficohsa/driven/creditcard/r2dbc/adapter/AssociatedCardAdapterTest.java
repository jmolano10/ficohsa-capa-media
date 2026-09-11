package com.ficohsa.driven.creditcard.r2dbc.adapter;

import com.ficohsa.driven.creditcard.r2dbc.dto.CreditCardRowDto;
import com.ficohsa.driven.creditcard.r2dbc.mapper.CreditCardPortfolioMapper;
import com.ficohsa.driven.creditcard.r2dbc.repository.AssociatedCardsRepository;
import com.ficohsa.model.associatedcards.CreditCardPortfolio;
import com.ficohsa.model.associatedcards.CreditCardRetrieve;
import com.ficohsa.model.associatedcards.CustomerFilter;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import reactor.core.publisher.Flux;
import reactor.test.StepVerifier;

import java.util.Collections;

import static org.mockito.ArgumentMatchers.*;
import static org.mockito.Mockito.when;

@ExtendWith(MockitoExtension.class)
class AssociatedCardAdapterTest {

    @Mock private AssociatedCardsRepository repository;
    @Mock private CreditCardPortfolioMapper mapper;
    @InjectMocks private AssociatedCardAdapter adapter;

    @Test
    void getAssociatedActiveCards_success() {
        CreditCardRetrieve request = new CreditCardRetrieve();
        CustomerFilter filter = new CustomerFilter();
        filter.setCustomerIdentification("123");
        filter.setCustomerIdentificationTypeCode(1);
        request.setCustomerFilter(filter);
        request.setRegion("HN01");

        CreditCardPortfolio portfolio = new CreditCardPortfolio();
        portfolio.setCreditCardDetails(Collections.emptyList());

        when(repository.getAssociatedActiveCards(anyString(), anyString(), anyInt()))
                .thenReturn(Flux.just(new CreditCardRowDto()));
        when(mapper.toDomainPortfolioWithRegion(anyList(), anyString()))
                .thenReturn(portfolio);

        StepVerifier.create(adapter.getAssociatedActiveCards(request))
                .expectNext(portfolio)
                .verifyComplete();
    }
}

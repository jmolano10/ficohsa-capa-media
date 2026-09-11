package com.ficohsa.usecase;

import com.ficohsa.model.associatedcards.CreditCardPortfolio;
import com.ficohsa.model.associatedcards.CreditCardRetrieve;
import com.ficohsa.ports.IAssociatedCards;
import com.ficohsa.ports.IAssociatedCardsGateway;
import com.ficohsa.ports.IRegionalizationGateway;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;
import reactor.core.publisher.Mono;

@Slf4j
@Component
@RequiredArgsConstructor
public class AssociatedCardsUseCase implements IAssociatedCards {
    private final IAssociatedCardsGateway associatedCardsOutPort;
    private final IRegionalizationGateway regionalizationGateway;

    @Override
    public Mono<CreditCardPortfolio> execute(CreditCardRetrieve creditCardRetrieve) {
        String region = creditCardRetrieve.getRegion();
        return regionalizationGateway.validateRegion("associated-active-cards", region, region)
                .then(associatedCardsOutPort.getAssociatedActiveCards(creditCardRetrieve));
    }
}

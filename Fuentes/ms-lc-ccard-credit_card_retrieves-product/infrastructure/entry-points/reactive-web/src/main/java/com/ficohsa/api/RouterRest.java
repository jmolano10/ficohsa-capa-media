package com.ficohsa.api;

import com.ficohsa.api.dto.settlementquotedetails.request.SettlementQuoteDetailsRequestDto;
import com.ficohsa.api.handlers.*;
import com.ficohsa.lib.router.component.RestComponent;
import lombok.RequiredArgsConstructor;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.ParameterizedTypeReference;
import org.springframework.web.reactive.function.server.RouterFunction;
import org.springframework.web.reactive.function.server.ServerResponse;

@Configuration(proxyBeanMethods = false)
@RequiredArgsConstructor
public class RouterRest {

    private final RestComponent restComponent;

    @Bean
    public RouterFunction<ServerResponse> routes(
            CreditCardRetrieveHandler creditCardRetrieveHandler,
            SettlementQuoteDetailsHandler settlementQuoteDetailsHandler,
            AssociatedActiveCardsHandler associatedActiveCardsHandler,
            DebitBasicInformationHandler debitBasicInformationHandler,
            DebitCardDetailsHandler debitCardDetailsHandler,
            CardPositionHandler cardPositionHandler) {
        return restComponent.get("/cards/credit-card-retrieves/v1/{customerIdentification}/retrieve",
                        request -> creditCardRetrieveHandler.handle(request.pathVariable("customerIdentification")))
                .post("/cards/credit-card-retrieves/v1/settlement-quote-details", SettlementQuoteDetailsRequestDto.class,
                        settlementQuoteDetailsHandler::retrieveSettlementQuoteDetails)
                .post("/cards/credit-card-retrieves/v1/associated-active-cards", new ParameterizedTypeReference<>() {},
                        associatedActiveCardsHandler::handle)
                .get("/cards/credit-card-retrieves/v1/product/{creditCardId}/debit-basic-information", debitBasicInformationHandler::handle)
                .get("/cards/credit-card-retrieves/v1/{customerIdentification}/debit-card-details", debitCardDetailsHandler::handle)
                .get("/cards/credit-card-retrieves/v1/product/{creditCardId}/card-position/retrieve", cardPositionHandler::handle)
                .build();
    }
}

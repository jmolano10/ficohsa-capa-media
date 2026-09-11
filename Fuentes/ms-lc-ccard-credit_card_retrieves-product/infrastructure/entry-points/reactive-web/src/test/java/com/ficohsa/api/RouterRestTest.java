package com.ficohsa.api;

import com.ficohsa.api.handlers.*;
import com.ficohsa.lib.router.component.RestComponent;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.core.ParameterizedTypeReference;
import org.springframework.web.reactive.function.server.RouterFunction;
import org.springframework.web.reactive.function.server.ServerResponse;

import java.util.function.Function;

import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.anyString;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.when;

@ExtendWith(MockitoExtension.class)
class RouterRestTest {

    @Mock
    private RestComponent restComponent;
    @Mock
    private CreditCardRetrieveHandler creditCardRetrieveHandler;
    @Mock
    private SettlementQuoteDetailsHandler settlementQuoteDetailsHandler;
    @Mock
    private AssociatedActiveCardsHandler associatedActiveCardsHandler;
    @Mock
    private DebitBasicInformationHandler debitBasicInformationHandler;
    @Mock
    private DebitCardDetailsHandler debitCardDetailsHandler;
    @Mock
    private CardPositionHandler cardPositionHandler;

    private RouterRest routerRest;

    @SuppressWarnings("unchecked")
    @BeforeEach
    void setUp() {
        routerRest = new RouterRest(restComponent);

        RestComponent mockBuilder = mock(RestComponent.class);
        when(restComponent.get(anyString(), any())).thenReturn(mockBuilder);
        when(mockBuilder.post(anyString(), any(Class.class), any(Function.class))).thenReturn(mockBuilder);
        when(mockBuilder.post(anyString(), any(ParameterizedTypeReference.class), any(Function.class))).thenReturn(mockBuilder);
        when(mockBuilder.get(anyString(), any())).thenReturn(mockBuilder);
        when(mockBuilder.build()).thenReturn(mock(RouterFunction.class));
    }

    @Test
    void routes_ShouldReturnRouterFunction() {
        RouterFunction<ServerResponse> result = routerRest.routes(
                creditCardRetrieveHandler,
                settlementQuoteDetailsHandler,
                associatedActiveCardsHandler,
                debitBasicInformationHandler,
                debitCardDetailsHandler,
                cardPositionHandler);

        assertNotNull(result);
    }
}

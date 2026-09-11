package com.ficohsa.api.handlers;

import com.ficohsa.api.dto.associatedcards.AssociatedCardsRequestDataDto;
import com.ficohsa.api.dto.associatedcards.AssociatedCardsResponseDto;
import com.ficohsa.api.mappers.AssociatedCardsMapper;
import com.ficohsa.api.mappers.CreditCardPortfolioResponseMapper;
import com.ficohsa.lib.core.dto.AppContext;
import com.ficohsa.lib.core.exception.BadRequestException;
import com.ficohsa.lib.core.utility.AppTool;
import com.ficohsa.model.associatedcards.CreditCardPortfolio;
import com.ficohsa.model.associatedcards.CreditCardRetrieve;
import com.ficohsa.ports.IAssociatedCards;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockedStatic;
import org.mockito.junit.jupiter.MockitoExtension;
import reactor.core.publisher.Mono;
import reactor.test.StepVerifier;

import java.time.LocalDateTime;
import java.time.Month;
import java.util.UUID;

import static org.mockito.Mockito.mockStatic;
import static org.mockito.Mockito.when;

@ExtendWith(MockitoExtension.class)
class AssociatedActiveCardsHandlerTest {

    private static final LocalDateTime FIXED_DATE = LocalDateTime.of(2025, Month.JANUARY, 1, 0, 0);

    @Mock private IAssociatedCards associatedCards;
    @Mock private AssociatedCardsMapper associatedCardsMapper;
    @Mock private CreditCardPortfolioResponseMapper responseMapper;

    @InjectMocks
    private AssociatedActiveCardsHandler handler;

    @Test
    void handle_success() {
        AppContext ctx = new AppContext("es", "app", "user", "token", "caller",
                "web", UUID.fromString("550e8400-e29b-41d4-a716-446655440000"), "HN01", null, FIXED_DATE, null);
        CreditCardRetrieve domain = new CreditCardRetrieve();
        CreditCardPortfolio portfolio = new CreditCardPortfolio();
        AssociatedCardsResponseDto response = AssociatedCardsResponseDto.builder().build();
        AssociatedCardsRequestDataDto request = AssociatedCardsRequestDataDto.builder().build();

        when(associatedCardsMapper.toDomain(request)).thenReturn(domain);
        when(associatedCards.execute(domain)).thenReturn(Mono.just(portfolio));
        when(responseMapper.toResponse(portfolio)).thenReturn(response);

        try (MockedStatic<AppTool> mocked = mockStatic(AppTool.class)) {
            mocked.when(AppTool::context).thenReturn(Mono.just(ctx));

            StepVerifier.create(handler.handle(request))
                    .expectNext(response)
                    .verifyComplete();
        }
    }

    @Test
    void handle_invalidRegion() {
        AppContext ctx = new AppContext("es", "app", "user", "token", "caller",
                "web", UUID.fromString("550e8400-e29b-41d4-a716-446655440000"), "", null, FIXED_DATE, null);
        AssociatedCardsRequestDataDto request = AssociatedCardsRequestDataDto.builder().build();
        CreditCardRetrieve domain = new CreditCardRetrieve();

        when(associatedCardsMapper.toDomain(request)).thenReturn(domain);

        try (MockedStatic<AppTool> mocked = mockStatic(AppTool.class)) {
            mocked.when(AppTool::context).thenReturn(Mono.just(ctx));

            StepVerifier.create(handler.handle(request))
                    .expectError(BadRequestException.class)
                    .verify();
        }
    }

    @Test
    void handle_regionNotAvailable() {
        AppContext ctx = new AppContext("es", "app", "user", "token", "caller",
                "web", UUID.fromString("550e8400-e29b-41d4-a716-446655440000"), "XX99", null, FIXED_DATE, null);
        AssociatedCardsRequestDataDto request = AssociatedCardsRequestDataDto.builder().build();
        CreditCardRetrieve domain = new CreditCardRetrieve();

        when(associatedCardsMapper.toDomain(request)).thenReturn(domain);

        try (MockedStatic<AppTool> mocked = mockStatic(AppTool.class)) {
            mocked.when(AppTool::context).thenReturn(Mono.just(ctx));

            StepVerifier.create(handler.handle(request))
                    .expectError(com.ficohsa.lib.core.exception.UnprocessableEntityException.class)
                    .verify();
        }
    }
}

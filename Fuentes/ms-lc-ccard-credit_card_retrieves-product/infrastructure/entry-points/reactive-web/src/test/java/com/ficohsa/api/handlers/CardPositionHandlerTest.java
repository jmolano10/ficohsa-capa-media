package com.ficohsa.api.handlers;

import com.ficohsa.lib.core.dto.AppContext;
import com.ficohsa.lib.core.exception.BadRequestException;
import com.ficohsa.lib.core.utility.AppTool;
import com.ficohsa.model.cardposition.CreditCardStatement;
import com.ficohsa.ports.ICardPosition;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockedStatic;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.reactive.function.server.ServerRequest;
import reactor.core.publisher.Mono;
import reactor.test.StepVerifier;

import java.time.LocalDateTime;
import java.time.Month;
import java.util.UUID;

import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
class CardPositionHandlerTest {

    private static final LocalDateTime FIXED_DATE = LocalDateTime.of(2025, Month.JANUARY, 1, 0, 0);

    @Mock private ICardPosition cardPosition;
    @Mock private ServerRequest serverRequest;

    @InjectMocks
    private CardPositionHandler handler;

    @Test
    void handle_success() {
        AppContext ctx = new AppContext("es", "app", "user", "token", "caller",
                "web", UUID.fromString("550e8400-e29b-41d4-a716-446655440000"), "HN01", "GT01", FIXED_DATE, null);
        CreditCardStatement expected = new CreditCardStatement();

        MultiValueMap<String, String> params = new LinkedMultiValueMap<>();
        when(serverRequest.pathVariable("creditCardId")).thenReturn("4000123456789012");
        when(serverRequest.queryParams()).thenReturn(params);
        when(cardPosition.rtvCardPosition("4000123456789012", "HN01", "GT01"))
                .thenReturn(Mono.just(expected));

        try (MockedStatic<AppTool> mocked = mockStatic(AppTool.class)) {
            mocked.when(AppTool::context).thenReturn(Mono.just(ctx));

            StepVerifier.create(handler.handle(serverRequest))
                    .expectNext(expected)
                    .verifyComplete();
        }
    }

    @Test
    void handle_invalidMonth_throwsBadRequest() {
        MultiValueMap<String, String> params = new LinkedMultiValueMap<>();
        params.add("month", "abc");

        when(serverRequest.pathVariable("creditCardId")).thenReturn("4000123456789012");
        when(serverRequest.queryParams()).thenReturn(params);

        StepVerifier.create(handler.handle(serverRequest))
                .expectError(BadRequestException.class)
                .verify();
    }

    @Test
    void handle_invalidYear_throwsBadRequest() {
        MultiValueMap<String, String> params = new LinkedMultiValueMap<>();
        params.add("year", "xyz");

        when(serverRequest.pathVariable("creditCardId")).thenReturn("4000123456789012");
        when(serverRequest.queryParams()).thenReturn(params);

        StepVerifier.create(handler.handle(serverRequest))
                .expectError(BadRequestException.class)
                .verify();
    }

    @Test
    void handle_nullRegion_throwsBadRequest() {
        AppContext ctx = new AppContext("es", "app", "user", "token", "caller",
                "web", UUID.fromString("550e8400-e29b-41d4-a716-446655440000"), null, null, FIXED_DATE, null);

        MultiValueMap<String, String> params = new LinkedMultiValueMap<>();
        when(serverRequest.pathVariable("creditCardId")).thenReturn("4000123456789012");
        lenient().when(serverRequest.queryParams()).thenReturn(params);

        try (MockedStatic<AppTool> mocked = mockStatic(AppTool.class)) {
            mocked.when(AppTool::context).thenReturn(Mono.just(ctx));

            StepVerifier.create(handler.handle(serverRequest))
                    .verifyError();
        }
    }

    void handle_emptyRegion_throwsBadRequest() {
        AppContext ctx = new AppContext("es", "app", "user", "token", "caller",
                "web", UUID.fromString("550e8400-e29b-41d4-a716-446655440000"), "", null, FIXED_DATE, null);

        MultiValueMap<String, String> params = new LinkedMultiValueMap<>();
        when(serverRequest.pathVariable("creditCardId")).thenReturn("4000123456789012");
        lenient().when(serverRequest.queryParams()).thenReturn(params);

        try (MockedStatic<AppTool> mocked = mockStatic(AppTool.class)) {
            mocked.when(AppTool::context).thenReturn(Mono.just(ctx));

            StepVerifier.create(handler.handle(serverRequest))
                    .verifyError();
        }
    }

    @Test
    void handle_invalidRegion_throwsUnprocessableEntity() {
        AppContext ctx = new AppContext("es", "app", "user", "token", "caller",
                "web", UUID.fromString("550e8400-e29b-41d4-a716-446655440000"), "XX99", null, FIXED_DATE, null);

        MultiValueMap<String, String> params = new LinkedMultiValueMap<>();
        when(serverRequest.pathVariable("creditCardId")).thenReturn("4000123456789012");
        lenient().when(serverRequest.queryParams()).thenReturn(params);

        try (MockedStatic<AppTool> mocked = mockStatic(AppTool.class)) {
            mocked.when(AppTool::context).thenReturn(Mono.just(ctx));

            StepVerifier.create(handler.handle(serverRequest))
                    .verifyError();
        }
    }
}

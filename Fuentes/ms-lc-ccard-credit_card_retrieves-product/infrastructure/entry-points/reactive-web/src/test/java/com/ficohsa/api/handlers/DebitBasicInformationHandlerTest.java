package com.ficohsa.api.handlers;

import com.ficohsa.lib.core.dto.AppContext;
import com.ficohsa.lib.core.exception.BadRequestException;
import com.ficohsa.lib.core.utility.AppTool;
import com.ficohsa.model.debitbasicinformation.DebitBasicInformation;
import com.ficohsa.ports.IDebitBasicInformation;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockedStatic;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.web.reactive.function.server.ServerRequest;
import reactor.core.publisher.Mono;
import reactor.test.StepVerifier;

import java.time.LocalDateTime;
import java.time.Month;
import java.util.Map;
import java.util.UUID;

import static org.mockito.Mockito.mockStatic;
import static org.mockito.Mockito.when;

@ExtendWith(MockitoExtension.class)
class DebitBasicInformationHandlerTest {

    private static final LocalDateTime FIXED_DATE = LocalDateTime.of(2025, Month.JANUARY, 1, 0, 0);

    @Mock private IDebitBasicInformation debitBasicInformation;
    @Mock private ServerRequest serverRequest;

    @InjectMocks
    private DebitBasicInformationHandler handler;

    @Test
    void handle_success() {
        AppContext ctx = new AppContext("es", "app", "user", "token", "caller",
                "web", UUID.fromString("550e8400-e29b-41d4-a716-446655440000"), "HN01", null, FIXED_DATE, null);
        DebitBasicInformation expected = new DebitBasicInformation(null, null, null, null, null);

        when(serverRequest.pathVariables()).thenReturn(Map.of("creditCardId", "123456789012"));
        when(debitBasicInformation.debitBasicInformationRetrieve("123456789012", "HN01"))
                .thenReturn(Mono.just(expected));

        try (MockedStatic<AppTool> mocked = mockStatic(AppTool.class)) {
            mocked.when(AppTool::context).thenReturn(Mono.just(ctx));

            StepVerifier.create(handler.handle(serverRequest))
                    .expectNext(expected)
                    .verifyComplete();
        }
    }

    @Test
    void handle_shortCreditCardId_throwsBadRequest() {
        when(serverRequest.pathVariables()).thenReturn(Map.of("creditCardId", "123"));

        StepVerifier.create(handler.handle(serverRequest))
                .expectError(BadRequestException.class)
                .verify();
    }

    @Test
    void handle_invalidRegion_throwsUnprocessableEntity() {
        AppContext ctx = new AppContext("es", "app", "user", "token", "caller",
                "web", UUID.fromString("550e8400-e29b-41d4-a716-446655440000"), "XX99", null, FIXED_DATE, null);

        when(serverRequest.pathVariables()).thenReturn(Map.of("creditCardId", "123456789012"));

        try (MockedStatic<AppTool> mocked = mockStatic(AppTool.class)) {
            mocked.when(AppTool::context).thenReturn(Mono.just(ctx));

            StepVerifier.create(handler.handle(serverRequest))
                    .verifyError();
        }
    }
}

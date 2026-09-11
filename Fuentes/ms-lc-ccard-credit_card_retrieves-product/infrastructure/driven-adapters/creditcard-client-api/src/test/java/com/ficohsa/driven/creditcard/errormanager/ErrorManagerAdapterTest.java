package com.ficohsa.driven.creditcard.errormanager;

import com.ficohsa.driven.creditcard.errormanager.config.ErrorManagerClientConfig;
import com.ficohsa.driven.creditcard.errormanager.dto.ErrorRequest;
import com.ficohsa.driven.creditcard.errormanager.dto.ErrorResponse;
import com.ficohsa.lib.core.dto.AppContext;
import com.ficohsa.lib.core.exception.InternalServerException;
import com.ficohsa.lib.core.utility.AppTool;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.Mock;
import org.mockito.MockedStatic;
import org.mockito.junit.jupiter.MockitoExtension;
import reactor.core.publisher.Mono;
import reactor.test.StepVerifier;

import java.time.LocalDateTime;
import java.time.Month;
import java.util.Map;
import java.util.UUID;

import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.anyMap;
import static org.mockito.Mockito.mockStatic;
import static org.mockito.Mockito.when;

@ExtendWith(MockitoExtension.class)
class ErrorManagerAdapterTest {

    private static final LocalDateTime FIXED_DATE = LocalDateTime.of(2025, Month.JANUARY, 1, 0, 0);

    @Mock
    private ErrorManagerClientConfig errorManagerWebClient;

    private ErrorManagerAdapter adapter;
    private AppContext ctx;

    @BeforeEach
    void setUp() {
        adapter = new ErrorManagerAdapter(errorManagerWebClient);
        ctx = new AppContext("es", "app", "user", "Bearer token", "caller", "web",
                UUID.fromString("550e8400-e29b-41d4-a716-446655440000"), "HN01", null, FIXED_DATE, null);
    }

    @Test
    void consume_success() {
        ErrorRequest request = ErrorRequest.builder().code("500").text("err").build();
        Map<String, String> headers = Map.of("X-Correlation-Id", "abc");

        ErrorResponse.Data data = ErrorResponse.Data.builder().indicator("S").id("1").messages("ok").build();
        ErrorResponse response = new ErrorResponse(data);

        when(errorManagerWebClient.consume(anyMap(), any(ErrorRequest.class))).thenReturn(Mono.just(response));

        try (MockedStatic<AppTool> m = mockStatic(AppTool.class)) {
            m.when(AppTool::context).thenReturn(Mono.just(ctx));

            StepVerifier.create(adapter.consume(request, headers))
                    .expectNextMatches(r -> "S".equals(r.data().indicator()))
                    .verifyComplete();
        }
    }

    @Test
    void consume_emptyResponse_throwsInternalServerException() {
        ErrorRequest request = ErrorRequest.builder().code("500").text("err").build();
        Map<String, String> headers = Map.of("X-Correlation-Id", "abc");

        when(errorManagerWebClient.consume(anyMap(), any(ErrorRequest.class))).thenReturn(Mono.empty());

        try (MockedStatic<AppTool> m = mockStatic(AppTool.class)) {
            m.when(AppTool::context).thenReturn(Mono.just(ctx));

            StepVerifier.create(adapter.consume(request, headers))
                    .expectError(InternalServerException.class)
                    .verify();
        }
    }

    @Test
    void consume_webClientError_propagates() {
        ErrorRequest request = ErrorRequest.builder().code("500").text("err").build();
        Map<String, String> headers = Map.of("X-Correlation-Id", "abc");

        when(errorManagerWebClient.consume(anyMap(), any(ErrorRequest.class)))
                .thenReturn(Mono.error(new RuntimeException("timeout")));

        try (MockedStatic<AppTool> m = mockStatic(AppTool.class)) {
            m.when(AppTool::context).thenReturn(Mono.just(ctx));

            StepVerifier.create(adapter.consume(request, headers))
                    .expectError(RuntimeException.class)
                    .verify();
        }
    }
}

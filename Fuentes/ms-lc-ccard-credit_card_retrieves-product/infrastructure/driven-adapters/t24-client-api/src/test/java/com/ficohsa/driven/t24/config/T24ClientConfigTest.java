package com.ficohsa.driven.t24.config;

import com.ficohsa.driven.t24.dto.request.T24Request;
import com.ficohsa.lib.core.dto.AppContext;
import com.ficohsa.lib.web.component.WebClientComponent;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.ArgumentCaptor;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.core.ParameterizedTypeReference;
import reactor.core.publisher.Mono;
import reactor.test.StepVerifier;

import java.time.LocalDateTime;
import java.time.Month;
import java.util.Map;
import java.util.UUID;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.mockito.ArgumentMatchers.*;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

@ExtendWith(MockitoExtension.class)
class T24ClientConfigTest {

    private static final LocalDateTime FIXED_DATE = LocalDateTime.of(2025, Month.JANUARY, 1, 0, 0);

    @Mock
    private WebClientComponent webClient;

    @Mock
    private T24PropsConfig t24Properties;

    @InjectMocks
    private T24ClientConfig t24WebClient;

    @Test
    void executeOperation_buildsUrlAndPropagatesHeaders() {
        when(t24Properties.getBaseUrl()).thenReturn("http://t24-wrapper");
        when(t24Properties.getPath()).thenReturn("/api/v1");

        T24Request request = new T24Request();
        AppContext context = new AppContext("es", "app-id", "user", "Bearer token", "caller-svc",
                "web", UUID.fromString("550e8400-e29b-41d4-a716-446655440000"), "HN01", null, FIXED_DATE, null);
        Object expected = Map.of("result", "ok");

        when(webClient.post(anyString(), anyMap(), any(), any(ParameterizedTypeReference.class)))
                .thenReturn(Mono.just(expected));

        StepVerifier.create(t24WebClient.executeOperation(request, context, "inquire"))
                .expectNext(expected)
                .verifyComplete();

        @SuppressWarnings("unchecked")
        ArgumentCaptor<Map<String, String>> headersCaptor = ArgumentCaptor.forClass(Map.class);
        verify(webClient).post(eq("http://t24-wrapper/api/v1/inquire"), headersCaptor.capture(), eq(request), any(ParameterizedTypeReference.class));

        Map<String, String> headers = headersCaptor.getValue();
        assertEquals("caller-svc", headers.get("Caller-Service"));
        assertEquals("es", headers.get("Accept-Language"));
    }
}

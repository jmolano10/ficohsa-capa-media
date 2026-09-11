package com.ficohsa.driven.cobis.config;

import com.ficohsa.driven.cobis.dto.request.CobisRequest;
import com.ficohsa.driven.cobis.dto.request.CobisSpRequest;
import com.ficohsa.driven.cobis.dto.response.CobisResponse;
import com.ficohsa.driven.cobis.dto.response.CobisSpResponse;
import com.ficohsa.lib.core.dto.AppContext;
import com.ficohsa.lib.web.component.WebClientComponent;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.core.ParameterizedTypeReference;
import reactor.core.publisher.Mono;
import reactor.test.StepVerifier;

import java.time.LocalDateTime;
import java.time.Month;
import java.util.UUID;

import static org.mockito.ArgumentMatchers.*;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

@ExtendWith(MockitoExtension.class)
class CobisClientConfigTest {

    private static final LocalDateTime FIXED_DATE = LocalDateTime.of(2025, Month.JANUARY, 1, 0, 0);

    @Mock
    private WebClientComponent webClient;

    @Mock
    private CobisPropsConfig cobisProperties;

    @InjectMocks
    private CobisClientConfig cobisWebClient;

    private AppContext buildContext() {
        return new AppContext("es", "app-id", "user", "Bearer token", "caller-svc",
                "web", UUID.fromString("550e8400-e29b-41d4-a716-446655440000"), "HN01", null, FIXED_DATE, null);
    }

    @Test
    void executeOperation_callsPostWithCorrectUrl() {
        when(cobisProperties.getBaseUrl()).thenReturn("http://cobis");
        when(cobisProperties.getPath()).thenReturn("/wrapper");

        CobisRequest request = CobisRequest.builder().build();
        CobisResponse expected = CobisResponse.builder().build();

        when(webClient.post(anyString(), anyMap(), any(), any(ParameterizedTypeReference.class)))
                .thenReturn(Mono.just(expected));

        StepVerifier.create(cobisWebClient.executeOperation(request, buildContext(), "query"))
                .expectNext(expected)
                .verifyComplete();

        verify(webClient).post(eq("http://cobis/wrapper/query"), anyMap(), eq(request), any(ParameterizedTypeReference.class));
    }

    @Test
    void executeSpOperation_callsPostWithSpUrl() {
        when(cobisProperties.getSpBaseUrl()).thenReturn("http://cobis-sp");
        when(cobisProperties.getSpPath()).thenReturn("/sp");

        CobisSpRequest request = CobisSpRequest.builder().build();
        CobisSpResponse expected = new CobisSpResponse();

        when(webClient.post(anyString(), anyMap(), any(), any(ParameterizedTypeReference.class)))
                .thenReturn(Mono.just(expected));

        StepVerifier.create(cobisWebClient.executeSpOperation(request, buildContext()))
                .expectNext(expected)
                .verifyComplete();

        verify(webClient).post(eq("http://cobis-sp/sp"), anyMap(), eq(request), any(ParameterizedTypeReference.class));
    }
}

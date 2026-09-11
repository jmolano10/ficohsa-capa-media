package com.ficohsa.driven.creditcard.cachecomponent.config;

import com.ficohsa.driven.creditcard.cachecomponent.dto.request.CacheComponentRequest;
import com.ficohsa.driven.creditcard.cachecomponent.dto.response.CacheSettlementQuoteDetailsResponse;
import com.ficohsa.lib.core.dto.AppContext;
import com.ficohsa.lib.web.component.WebClientComponent;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.core.ParameterizedTypeReference;
import org.springframework.test.util.ReflectionTestUtils;
import reactor.core.publisher.Mono;
import reactor.test.StepVerifier;

import java.time.LocalDateTime;
import java.time.Month;
import java.util.UUID;

import static org.mockito.ArgumentMatchers.*;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

@ExtendWith(MockitoExtension.class)
class CacheComponentClientConfigTest {

    private static final LocalDateTime FIXED_DATE = LocalDateTime.of(2025, Month.JANUARY, 1, 0, 0);

    @Mock
    private WebClientComponent webClient;

    @InjectMocks
    private CacheComponentClientConfig cacheComponentWebClient;

    private AppContext buildContext() {
        return new AppContext("es", "app-id", "user", "Bearer token", "caller-svc",
                "web", UUID.fromString("550e8400-e29b-41d4-a716-446655440000"), "HN01", null, FIXED_DATE, null);
    }

    @Test
    void setCache_callsPostWithCorrectUrl() {
        ReflectionTestUtils.setField(cacheComponentWebClient, "baseUrl", "http://ccp");
        ReflectionTestUtils.setField(cacheComponentWebClient, "setCcpPath", "/set");
        ReflectionTestUtils.setField(cacheComponentWebClient, "getCcpPath", "/get");

        CacheComponentRequest request = CacheComponentRequest.builder().org("ORG").build();
        CacheSettlementQuoteDetailsResponse expected = CacheSettlementQuoteDetailsResponse.builder().build();

        when(webClient.post(anyString(), anyMap(), any(), any(ParameterizedTypeReference.class)))
                .thenReturn(Mono.just(expected));

        StepVerifier.create(cacheComponentWebClient.setCache(request, buildContext()))
                .expectNext(expected)
                .verifyComplete();

        verify(webClient).post(eq("http://ccp/set"), anyMap(), eq(request), any(ParameterizedTypeReference.class));
    }

    @Test
    void getCache_callsGetWithCorrectUrl() {
        ReflectionTestUtils.setField(cacheComponentWebClient, "baseUrl", "http://ccp");
        ReflectionTestUtils.setField(cacheComponentWebClient, "setCcpPath", "/set");
        ReflectionTestUtils.setField(cacheComponentWebClient, "getCcpPath", "/get");

        CacheSettlementQuoteDetailsResponse expected = CacheSettlementQuoteDetailsResponse.builder().build();

        when(webClient.get(anyString(), anyMap(), any(ParameterizedTypeReference.class)))
                .thenReturn(Mono.just(expected));

        StepVerifier.create(cacheComponentWebClient.getCache("key", buildContext()))
                .expectNext(expected)
                .verifyComplete();

        verify(webClient).get(eq("http://ccp/get/key"), anyMap(), any(ParameterizedTypeReference.class));
    }
}

package com.ficohsa.driven.abanks.config;

import com.ficohsa.driven.abanks.dto.request.AbanksRequest;
import com.ficohsa.driven.abanks.dto.response.AbanksResponse;
import com.ficohsa.lib.core.dto.AppContext;
import com.ficohsa.lib.web.component.WebClientComponent;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.ArgumentCaptor;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.core.ParameterizedTypeReference;
import org.springframework.test.util.ReflectionTestUtils;
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
class AbankClientConfigTest {

    private static final LocalDateTime FIXED_DATE = LocalDateTime.of(2025, Month.JANUARY, 1, 0, 0);

    @Mock
    private WebClientComponent webClient;

    @InjectMocks
    private AbankClientConfig abankWebClient;

    private AppContext buildContext(String sourceBank) {
        return new AppContext("es", "app-id", "user", "Bearer token", "caller-svc",
                "web", UUID.fromString("550e8400-e29b-41d4-a716-446655440000"), sourceBank, null, FIXED_DATE, null);
    }

    @Test
    void getBankProducts_usesGT01Path_whenSourceBankIsGT01() {
        ReflectionTestUtils.setField(abankWebClient, "baseUrl", "http://abanks");
        ReflectionTestUtils.setField(abankWebClient, "pathGT01", "/gt");
        ReflectionTestUtils.setField(abankWebClient, "pathPA01", "/pa");

        AbanksRequest request = AbanksRequest.builder().catalogueName("cat").build();
        AppContext context = buildContext("GT01");
        AbanksResponse expected = new AbanksResponse();

        when(webClient.post(anyString(), anyMap(), any(), any(ParameterizedTypeReference.class)))
                .thenReturn(Mono.just(expected));

        StepVerifier.create(abankWebClient.getBankProducts(request, context))
                .expectNext(expected)
                .verifyComplete();

        @SuppressWarnings("unchecked")
        ArgumentCaptor<Map<String, String>> headersCaptor = ArgumentCaptor.forClass(Map.class);
        verify(webClient).post(eq("http://abanks/gt"), headersCaptor.capture(), eq(request), any(ParameterizedTypeReference.class));

        Map<String, String> headers = headersCaptor.getValue();
        assertEquals("caller-svc", headers.get("Caller-Service"));
        assertEquals("es", headers.get("Accept-Language"));
    }

    @Test
    void getBankProducts_usesPA01Path_whenSourceBankIsPA01() {
        ReflectionTestUtils.setField(abankWebClient, "baseUrl", "http://abanks");
        ReflectionTestUtils.setField(abankWebClient, "pathGT01", "/gt");
        ReflectionTestUtils.setField(abankWebClient, "pathPA01", "/pa");

        AbanksRequest request = AbanksRequest.builder().catalogueName("cat").build();
        AppContext context = buildContext("PA01");
        AbanksResponse expected = new AbanksResponse();

        when(webClient.post(anyString(), anyMap(), any(), any(ParameterizedTypeReference.class)))
                .thenReturn(Mono.just(expected));

        StepVerifier.create(abankWebClient.getBankProducts(request, context))
                .expectNext(expected)
                .verifyComplete();

        verify(webClient).post(eq("http://abanks/pa"), anyMap(), eq(request), any(ParameterizedTypeReference.class));
    }
}

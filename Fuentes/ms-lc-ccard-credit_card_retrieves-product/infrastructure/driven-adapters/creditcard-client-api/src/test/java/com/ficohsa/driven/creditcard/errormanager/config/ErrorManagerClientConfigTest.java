package com.ficohsa.driven.creditcard.errormanager.config;

import com.ficohsa.driven.creditcard.errormanager.dto.ErrorRequest;
import com.ficohsa.driven.creditcard.errormanager.dto.ErrorResponse;
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

import java.util.Map;

import static org.mockito.ArgumentMatchers.*;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

@ExtendWith(MockitoExtension.class)
class ErrorManagerClientConfigTest {

    @Mock
    private WebClientComponent webClient;

    @InjectMocks
    private ErrorManagerClientConfig errorManagerWebClient;

    @Test
    void consume_callsPostWithHeadersAndRequest() {
        ReflectionTestUtils.setField(errorManagerWebClient, "baseUrl", "http://error-svc");
        ReflectionTestUtils.setField(errorManagerWebClient, "path", "/errors");

        Map<String, String> headers = Map.of("Correlation-Id", "abc-123", "Source-Bank", "HN01");
        ErrorRequest request = ErrorRequest.builder().code("ERR01").build();
        ErrorResponse expected = ErrorResponse.builder().build();

        when(webClient.post(anyString(), anyMap(), any(), any(ParameterizedTypeReference.class)))
                .thenReturn(Mono.just(expected));

        StepVerifier.create(errorManagerWebClient.consume(headers, request))
                .expectNext(expected)
                .verifyComplete();

        verify(webClient).post(eq("http://error-svc/errors"), eq(headers), eq(request), any(ParameterizedTypeReference.class));
    }
}

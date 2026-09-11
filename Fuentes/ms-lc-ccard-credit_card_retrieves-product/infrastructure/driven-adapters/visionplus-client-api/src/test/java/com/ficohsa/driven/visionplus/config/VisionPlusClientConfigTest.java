package com.ficohsa.driven.visionplus.config;

import com.ficohsa.driven.visionplus.dto.request.VisionPlusRequest;
import com.ficohsa.driven.visionplus.dto.response.VisionPlusResponse;
import com.ficohsa.lib.core.dto.AppContext;
import com.ficohsa.lib.core.exception.BadRequestException;
import com.ficohsa.lib.core.exception.UnprocessableEntityException;
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
class VisionPlusClientConfigTest {

    private static final LocalDateTime FIXED_DATE = LocalDateTime.of(2025, Month.JANUARY, 1, 0, 0);

    @Mock
    private WebClientComponent webClient;

    @Mock
    private VisionPlusCacheManagerPropsConfig config;

    @InjectMocks
    private VisionPlusClientConfig visionPlusWebClient;

    @Test
    void retrievesSettlementQuoteDetails_failsOnMissingHeaders() {
        AppContext context = new AppContext(null, null, null, null, null,
                null, null, null, null, null, null);
        VisionPlusRequest request = new VisionPlusRequest();

        StepVerifier.create(visionPlusWebClient.retrievesSettlementQuoteDetails(request, context))
                .expectError(BadRequestException.class)
                .verify();
    }

    @Test
    void retrievesSettlementQuoteDetails_failsOnMismatchedDestinationBank() {
        AppContext context = new AppContext("es", "app-id", "user", "Bearer token", "caller",
                "web", UUID.fromString("550e8400-e29b-41d4-a716-446655440000"), "HN01", "GT01", FIXED_DATE, null);
        VisionPlusRequest request = new VisionPlusRequest();

        StepVerifier.create(visionPlusWebClient.retrievesSettlementQuoteDetails(request, context))
                .expectError(UnprocessableEntityException.class)
                .verify();
    }

    @Test
    void retrievesSettlementQuoteDetails_hn_usesL8v2() {
        AppContext context = new AppContext("es", "app-id", "user", "Bearer token", "caller",
                "web", UUID.fromString("550e8400-e29b-41d4-a716-446655440000"), "HN01", null, FIXED_DATE, null);
        VisionPlusRequest request = new VisionPlusRequest();

        when(config.getSettlementQuoteInquiryL8v2Operation()).thenReturn("L8V2");
        when(config.getSettlementQuoteInquiryL8v2ParamName()).thenReturn("param2");
        when(config.getSettlementQuoteInquiryL8v2Endpoint()).thenReturn("http://vps/cache");
        when(config.getSettlementQuoteInquiryCallerService()).thenReturn("vps-caller");
        when(config.getCacheTtl()).thenReturn("300");

        VisionPlusResponse expected = new VisionPlusResponse();
        when(webClient.post(anyString(), anyMap(), any(), any(ParameterizedTypeReference.class)))
                .thenReturn(Mono.just(expected));

        StepVerifier.create(visionPlusWebClient.retrievesSettlementQuoteDetails(request, context))
                .expectNext(expected)
                .verifyComplete();

        @SuppressWarnings("unchecked")
        ArgumentCaptor<Map<String, String>> headersCaptor = ArgumentCaptor.forClass(Map.class);
        verify(webClient).post(eq("http://vps/cache"), headersCaptor.capture(), eq(request), any(ParameterizedTypeReference.class));

        Map<String, String> headers = headersCaptor.getValue();
        assertEquals("vps-caller", headers.get("Caller-Service"));
        assertEquals("L8V2", headers.get("operation"));
        assertEquals("HN01", headers.get("Destination-Bank"));
    }

    @Test
    void retrievesSettlementQuoteDetails_gt_usesL8v1() {
        AppContext context = new AppContext("es", "app-id", "user", "Bearer token", "caller",
                "web", UUID.fromString("550e8400-e29b-41d4-a716-446655440000"), "GT01", "GT01", FIXED_DATE, null);
        VisionPlusRequest request = new VisionPlusRequest();

        when(config.getSettlementQuoteInquiryL8v1Operation()).thenReturn("L8V1");
        when(config.getSettlementQuoteInquiryL8v1ParamName()).thenReturn("param1");
        when(config.getSettlementQuoteInquiryL8v1Endpoint()).thenReturn("http://vps/cache");
        when(config.getSettlementQuoteInquiryCallerService()).thenReturn("vps-caller");
        when(config.getCacheTtl()).thenReturn("300");

        VisionPlusResponse expected = new VisionPlusResponse();
        when(webClient.post(anyString(), anyMap(), any(), any(ParameterizedTypeReference.class)))
                .thenReturn(Mono.just(expected));

        StepVerifier.create(visionPlusWebClient.retrievesSettlementQuoteDetails(request, context))
                .expectNext(expected)
                .verifyComplete();

        verify(webClient).post(eq("http://vps/cache"), anyMap(), eq(request), any(ParameterizedTypeReference.class));
    }
}

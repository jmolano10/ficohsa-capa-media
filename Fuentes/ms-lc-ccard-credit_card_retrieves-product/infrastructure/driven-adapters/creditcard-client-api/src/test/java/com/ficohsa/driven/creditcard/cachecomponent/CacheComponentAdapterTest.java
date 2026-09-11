package com.ficohsa.driven.creditcard.cachecomponent;

import com.ficohsa.driven.creditcard.cachecomponent.config.CacheComponentClientConfig;
import com.ficohsa.driven.creditcard.cachecomponent.dto.response.CacheSettlementQuoteDetailsResponse;
import com.ficohsa.lib.core.dto.AppContext;
import com.ficohsa.lib.core.utility.AppTool;
import com.ficohsa.model.settlementquotedetails.SettlementQuoteDetailsModel;
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
import java.util.UUID;

import static org.mockito.ArgumentMatchers.*;
import static org.mockito.Mockito.mockStatic;
import static org.mockito.Mockito.when;

@ExtendWith(MockitoExtension.class)
class CacheComponentAdapterTest {

    private static final LocalDateTime FIXED_DATE = LocalDateTime.of(2025, Month.JANUARY, 1, 0, 0);

    @Mock
    private CacheComponentClientConfig cacheComponentWebClient;

    private CacheComponentAdapter adapter;

    private AppContext ctx;

    @BeforeEach
    void setUp() {
        adapter = new CacheComponentAdapter(cacheComponentWebClient);
        ctx = new AppContext("es", "app", "user", "Bearer token", "caller", "web",
                UUID.fromString("550e8400-e29b-41d4-a716-446655440000"), "HN01", null, FIXED_DATE, null);
    }

    private CacheSettlementQuoteDetailsResponse buildResponse() {
        var planData = CacheSettlementQuoteDetailsResponse.PlanData.builder()
                .planRef("P1").planType("T").planDescription("D").quoteType("Q")
                .payoffDate("2024-01-01").planPayoffAmount("1000").paymentType("M")
                .methodPayment("CASH").newTerm("12").newPaymentAmount("100").build();
        var value = CacheSettlementQuoteDetailsResponse.ValueData.builder()
                .org("ORG").foreignOrg("FO").logo("L").accountNumber("AN")
                .cardNumber("CN").accountPayoffDate("2024-01-01")
                .accountPayoffAmount("5000").planData(planData).build();
        return CacheSettlementQuoteDetailsResponse.builder().value(value).build();
    }

    @Test
    void getCache_success() {
        when(cacheComponentWebClient.getCache(eq("key1"), any(AppContext.class)))
                .thenReturn(Mono.just(buildResponse()));

        try (MockedStatic<AppTool> m = mockStatic(AppTool.class)) {
            m.when(AppTool::context).thenReturn(Mono.just(ctx));

            StepVerifier.create(adapter.getCache("key1"))
                    .expectNextMatches(r -> r.getSettlementQuoteInquiry() != null)
                    .verifyComplete();
        }
    }

    @Test
    void getCache_error_propagates() {
        when(cacheComponentWebClient.getCache(anyString(), any(AppContext.class)))
                .thenReturn(Mono.error(new RuntimeException("fail")));

        try (MockedStatic<AppTool> m = mockStatic(AppTool.class)) {
            m.when(AppTool::context).thenReturn(Mono.just(ctx));

            StepVerifier.create(adapter.getCache("key1"))
                    .expectError(RuntimeException.class)
                    .verify();
        }
    }

    @Test
    void setCache_success() {
        when(cacheComponentWebClient.setCache(any(), any(AppContext.class)))
                .thenReturn(Mono.just(buildResponse()));

        try (MockedStatic<AppTool> m = mockStatic(AppTool.class)) {
            m.when(AppTool::context).thenReturn(Mono.just(ctx));

            SettlementQuoteDetailsModel model = SettlementQuoteDetailsModel.builder().build();
            StepVerifier.create(adapter.setCache("key1", model))
                    .verifyComplete();
        }
    }

    @Test
    void setCache_error_propagates() {
        when(cacheComponentWebClient.setCache(any(), any(AppContext.class)))
                .thenReturn(Mono.error(new RuntimeException("fail")));

        try (MockedStatic<AppTool> m = mockStatic(AppTool.class)) {
            m.when(AppTool::context).thenReturn(Mono.just(ctx));

            SettlementQuoteDetailsModel model = SettlementQuoteDetailsModel.builder().build();
            StepVerifier.create(adapter.setCache("key1", model))
                    .expectError(RuntimeException.class)
                    .verify();
        }
    }
}

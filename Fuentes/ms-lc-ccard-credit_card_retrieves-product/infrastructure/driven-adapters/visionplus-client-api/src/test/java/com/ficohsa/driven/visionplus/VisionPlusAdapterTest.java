package com.ficohsa.driven.visionplus;

import com.ficohsa.driven.visionplus.config.VisionPlusClientConfig;
import com.ficohsa.driven.visionplus.dto.response.VisionPlusResponse;
import com.ficohsa.lib.core.dto.AppContext;
import com.ficohsa.lib.core.exception.BadGatewayException;
import com.ficohsa.lib.core.exception.BusinessCoreException;
import com.ficohsa.lib.core.exception.ServiceUnavailableException;
import com.ficohsa.lib.core.utility.AppTool;
import com.ficohsa.model.settlementquotedetails.SettlementQuoteDetails;
import com.ficohsa.model.settlementquotedetails.SettlementQuoteDetailsModel;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockedStatic;
import org.mockito.junit.jupiter.MockitoExtension;
import reactor.core.publisher.Mono;
import reactor.test.StepVerifier;

import java.time.LocalDateTime;
import java.time.Month;
import java.util.List;
import java.util.UUID;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.mockStatic;
import static org.mockito.Mockito.when;

@ExtendWith(MockitoExtension.class)
class VisionPlusAdapterTest {

    private static final LocalDateTime FIXED_DATE = LocalDateTime.of(2025, Month.JANUARY, 1, 0, 0);

    @Mock private VisionPlusClientConfig visionPlusWebClient;
    @InjectMocks private VisionPlusAdapter adapter;

    private AppContext ctx;
    private SettlementQuoteDetails request;

    @BeforeEach
    void setUp() {
        ctx = new AppContext("es", "app", "user", "Bearer token", "caller", "web",
                UUID.fromString("550e8400-e29b-41d4-a716-446655440000"), "HN01", null, FIXED_DATE, null);
        request = SettlementQuoteDetails.builder()
                .accountNumber("123456")
                .organizationReference("ORG1")
                .financingPlanReference("PLAN1")
                .paymentSequenceNumber("01")
                .cancellationDate("2025-12-31")
                .build();
    }

    @Test
    void key_returnsExpectedValue() {
        assertEquals("PA01VP/GT01VP/HN01VP/NI01VP", adapter.key());
    }

    // ===== retrieveSettlementQuoteDetails =====

    @Test
    void retrieveSettlementQuoteDetails_success() {
        var vpResponse = buildSuccessResponse();

        try (MockedStatic<AppTool> m = mockStatic(AppTool.class)) {
            m.when(AppTool::context).thenReturn(Mono.just(ctx));
            when(visionPlusWebClient.retrievesSettlementQuoteDetails(any(), any()))
                    .thenReturn(Mono.just(vpResponse));

            StepVerifier.create(adapter.retrieveSettlementQuoteDetails(request))
                    .expectNextCount(1)
                    .verifyComplete();
        }
    }

    @Test
    void retrieveSettlementQuoteDetails_emptyResponse_throwsBadGateway() {
        try (MockedStatic<AppTool> m = mockStatic(AppTool.class)) {
            m.when(AppTool::context).thenReturn(Mono.just(ctx));
            when(visionPlusWebClient.retrievesSettlementQuoteDetails(any(), any()))
                    .thenReturn(Mono.empty());

            StepVerifier.create(adapter.retrieveSettlementQuoteDetails(request))
                    .expectError(BadGatewayException.class)
                    .verify();
        }
    }

    @Test
    void retrieveSettlementQuoteDetails_nullResponseData_throwsBadGateway() {
        var vpResponse = new VisionPlusResponse();
        vpResponse.setData(null);

        try (MockedStatic<AppTool> m = mockStatic(AppTool.class)) {
            m.when(AppTool::context).thenReturn(Mono.just(ctx));
            when(visionPlusWebClient.retrievesSettlementQuoteDetails(any(), any()))
                    .thenReturn(Mono.just(vpResponse));

            StepVerifier.create(adapter.retrieveSettlementQuoteDetails(request))
                    .expectError(BadGatewayException.class)
                    .verify();
        }
    }

    @Test
    void retrieveSettlementQuoteDetails_nullBody_throwsBadGateway() {
        var vpResponse = new VisionPlusResponse();
        vpResponse.setData(new VisionPlusResponse.DataContainer());

        try (MockedStatic<AppTool> m = mockStatic(AppTool.class)) {
            m.when(AppTool::context).thenReturn(Mono.just(ctx));
            when(visionPlusWebClient.retrievesSettlementQuoteDetails(any(), any()))
                    .thenReturn(Mono.just(vpResponse));

            StepVerifier.create(adapter.retrieveSettlementQuoteDetails(request))
                    .expectError(BadGatewayException.class)
                    .verify();
        }
    }

    @Test
    void retrieveSettlementQuoteDetails_nullInnerResponse_throwsBadGateway() {
        var body = new VisionPlusResponse.BodyData();
        var dataContainer = new VisionPlusResponse.DataContainer();
        dataContainer.setBody(body);
        var vpResponse = new VisionPlusResponse();
        vpResponse.setData(dataContainer);

        try (MockedStatic<AppTool> m = mockStatic(AppTool.class)) {
            m.when(AppTool::context).thenReturn(Mono.just(ctx));
            when(visionPlusWebClient.retrievesSettlementQuoteDetails(any(), any()))
                    .thenReturn(Mono.just(vpResponse));

            StepVerifier.create(adapter.retrieveSettlementQuoteDetails(request))
                    .expectError(BadGatewayException.class)
                    .verify();
        }
    }

    @Test
    void retrieveSettlementQuoteDetails_businessError_withReturnCodes_throwsBusinessCoreException() {
        var vpResponse = buildErrorResponse("F", "VPL5SQI99S", "Some business error");

        try (MockedStatic<AppTool> m = mockStatic(AppTool.class)) {
            m.when(AppTool::context).thenReturn(Mono.just(ctx));
            when(visionPlusWebClient.retrievesSettlementQuoteDetails(any(), any()))
                    .thenReturn(Mono.just(vpResponse));

            StepVerifier.create(adapter.retrieveSettlementQuoteDetails(request))
                    .expectError(BusinessCoreException.class)
                    .verify();
        }
    }

    @Test
    void retrieveSettlementQuoteDetails_notFoundAcctCard_throwsBusinessCoreException() {
        var vpResponse = buildErrorResponse("F", "VPL5SQI11S", "Account/Card not found");

        try (MockedStatic<AppTool> m = mockStatic(AppTool.class)) {
            m.when(AppTool::context).thenReturn(Mono.just(ctx));
            when(visionPlusWebClient.retrievesSettlementQuoteDetails(any(), any()))
                    .thenReturn(Mono.just(vpResponse));

            StepVerifier.create(adapter.retrieveSettlementQuoteDetails(request))
                    .expectError(BusinessCoreException.class)
                    .verify();
        }
    }

    @Test
    void retrieveSettlementQuoteDetails_notFoundPlan_throwsBusinessCoreException() {
        var vpResponse = buildErrorResponse("F", "VPL5SQI15S", "Plan not found");

        try (MockedStatic<AppTool> m = mockStatic(AppTool.class)) {
            m.when(AppTool::context).thenReturn(Mono.just(ctx));
            when(visionPlusWebClient.retrievesSettlementQuoteDetails(any(), any()))
                    .thenReturn(Mono.just(vpResponse));

            StepVerifier.create(adapter.retrieveSettlementQuoteDetails(request))
                    .expectError(BusinessCoreException.class)
                    .verify();
        }
    }

    @Test
    void retrieveSettlementQuoteDetails_notFoundPlanRecord_throwsBusinessCoreException() {
        var vpResponse = buildErrorResponse("F", "VPL5SQI14S", "Plan record not found");

        try (MockedStatic<AppTool> m = mockStatic(AppTool.class)) {
            m.when(AppTool::context).thenReturn(Mono.just(ctx));
            when(visionPlusWebClient.retrievesSettlementQuoteDetails(any(), any()))
                    .thenReturn(Mono.just(vpResponse));

            StepVerifier.create(adapter.retrieveSettlementQuoteDetails(request))
                    .expectError(BusinessCoreException.class)
                    .verify();
        }
    }

    @Test
    void retrieveSettlementQuoteDetails_errorWithNullReturnCodes_throwsBusinessCoreException() {
        var innerResponse = new VisionPlusResponse.SettlementQuoteInquiryResponse();
        innerResponse.setServiceReturnCode("F");
        innerResponse.setReturnCodes(null);

        var body = new VisionPlusResponse.BodyData();
        body.setSettlementQuoteInquiryL8V1Response(innerResponse);
        var dataContainer = new VisionPlusResponse.DataContainer();
        dataContainer.setBody(body);
        var vpResponse = new VisionPlusResponse();
        vpResponse.setData(dataContainer);

        try (MockedStatic<AppTool> m = mockStatic(AppTool.class)) {
            m.when(AppTool::context).thenReturn(Mono.just(ctx));
            when(visionPlusWebClient.retrievesSettlementQuoteDetails(any(), any()))
                    .thenReturn(Mono.just(vpResponse));

            StepVerifier.create(adapter.retrieveSettlementQuoteDetails(request))
                    .expectError(BusinessCoreException.class)
                    .verify();
        }
    }

    @Test
    void retrieveSettlementQuoteDetails_errorWithEmptyRcList_throwsBusinessCoreException() {
        var returnCodes = new VisionPlusResponse.ReturnCodesWrapper();
        returnCodes.setRc(List.of());

        var innerResponse = new VisionPlusResponse.SettlementQuoteInquiryResponse();
        innerResponse.setServiceReturnCode("F");
        innerResponse.setReturnCodes(returnCodes);

        var body = new VisionPlusResponse.BodyData();
        body.setSettlementQuoteInquiryL8V1Response(innerResponse);
        var dataContainer = new VisionPlusResponse.DataContainer();
        dataContainer.setBody(body);
        var vpResponse = new VisionPlusResponse();
        vpResponse.setData(dataContainer);

        try (MockedStatic<AppTool> m = mockStatic(AppTool.class)) {
            m.when(AppTool::context).thenReturn(Mono.just(ctx));
            when(visionPlusWebClient.retrievesSettlementQuoteDetails(any(), any()))
                    .thenReturn(Mono.just(vpResponse));

            StepVerifier.create(adapter.retrieveSettlementQuoteDetails(request))
                    .expectError(BusinessCoreException.class)
                    .verify();
        }
    }

    // ===== fallback =====

    @Test
    void fallbackRetrieveSettlementQuoteDetails_returnsServiceUnavailable() {
        try {
            var method = VisionPlusAdapter.class.getDeclaredMethod(
                    "fallbackRetrieveSettlementQuoteDetails", SettlementQuoteDetails.class, Throwable.class);
            method.setAccessible(true);

            @SuppressWarnings("unchecked")
            Mono<SettlementQuoteDetailsModel> result = (Mono<SettlementQuoteDetailsModel>)
                    method.invoke(adapter, request, new RuntimeException("circuit open"));

            StepVerifier.create(result)
                    .expectError(ServiceUnavailableException.class)
                    .verify();
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    // ===== Helpers =====

    private VisionPlusResponse buildSuccessResponse() {
        var planEntry = new VisionPlusResponse.PlanEntry();
        planEntry.setPlanRef("REF1");
        planEntry.setPlanType("TYPE1");
        planEntry.setPlanDescription("DESC");
        planEntry.setPayoffDate1("2025-12-31");
        planEntry.setPlanPayoffAmount1("1000.00");

        var planData = new VisionPlusResponse.PlanDataWrapper();
        planData.setArxqioPlanEntry(List.of(planEntry));

        var innerResponse = new VisionPlusResponse.SettlementQuoteInquiryResponse();
        innerResponse.setServiceReturnCode("P");
        innerResponse.setOrg("ORG1");
        innerResponse.setAccountNumber("123456");
        innerResponse.setCardNumber("4111111111111111");
        innerResponse.setAccountPayoffDate("2025-12-31");
        innerResponse.setAccountPayoffAmount("5000.00");
        innerResponse.setPlanData(planData);

        var body = new VisionPlusResponse.BodyData();
        body.setSettlementQuoteInquiryL8V1Response(innerResponse);
        var dataContainer = new VisionPlusResponse.DataContainer();
        dataContainer.setBody(body);
        var vpResponse = new VisionPlusResponse();
        vpResponse.setData(dataContainer);
        return vpResponse;
    }

    private VisionPlusResponse buildErrorResponse(String serviceReturnCode, String errorCode, String errorDesc) {
        var returnCode = new VisionPlusResponse.ReturnCode();
        returnCode.setCode(errorCode);
        returnCode.setDesc(errorDesc);

        var returnCodes = new VisionPlusResponse.ReturnCodesWrapper();
        returnCodes.setRc(List.of(returnCode));

        var innerResponse = new VisionPlusResponse.SettlementQuoteInquiryResponse();
        innerResponse.setServiceReturnCode(serviceReturnCode);
        innerResponse.setReturnCodes(returnCodes);

        var body = new VisionPlusResponse.BodyData();
        body.setSettlementQuoteInquiryL8V1Response(innerResponse);
        var dataContainer = new VisionPlusResponse.DataContainer();
        dataContainer.setBody(body);
        var vpResponse = new VisionPlusResponse();
        vpResponse.setData(dataContainer);
        return vpResponse;
    }
}

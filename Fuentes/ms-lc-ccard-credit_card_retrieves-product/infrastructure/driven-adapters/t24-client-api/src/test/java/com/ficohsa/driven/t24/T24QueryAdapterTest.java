package com.ficohsa.driven.t24;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.ficohsa.driven.t24.config.T24ClientConfig;
import com.ficohsa.driven.t24.dto.DebitCardResponse;
import com.ficohsa.driven.t24.dto.response.T24DataDto;
import com.ficohsa.driven.t24.dto.response.T24Response;
import com.ficohsa.driven.t24.mapper.T24Mapper;
import com.ficohsa.lib.core.dto.AppContext;
import com.ficohsa.lib.core.exception.BusinessException;
import com.ficohsa.lib.core.exception.InternalServerException;
import com.ficohsa.lib.core.exception.NotFoundException;
import com.ficohsa.lib.core.utility.AppTool;
import com.ficohsa.model.debitbasicinformation.DebitBasicInformation;
import com.ficohsa.model.debitbasicinformation.LinkedAccounts;
import com.ficohsa.model.debitcarddetails.CustomerInquiry;
import com.ficohsa.model.debitcarddetails.DebitCardDetails;
import com.ficohsa.model.debitcarddetails.DebitCardInquiry;
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
import java.util.Collections;
import java.util.List;
import java.util.UUID;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.eq;
import static org.mockito.Mockito.mockStatic;
import static org.mockito.Mockito.when;

@ExtendWith(MockitoExtension.class)
class T24QueryAdapterTest {

    private static final LocalDateTime FIXED_DATE = LocalDateTime.of(2025, Month.JANUARY, 1, 0, 0);

    @Mock private T24ClientConfig t24WebClient;
    @Mock private T24Mapper t24Mapper;
    @Mock private ObjectMapper objectMapper;
    @InjectMocks private T24QueryAdapter adapter;

    private AppContext ctx;

    @BeforeEach
    void setUp() {
        ctx = new AppContext("es", "app", "user", "Bearer token", "caller", "web",
                UUID.fromString("550e8400-e29b-41d4-a716-446655440000"), "HN01", null, FIXED_DATE, null);
    }

    @Test
    void key_returnsHN01() {
        assertEquals("HN01", adapter.key());
    }

    // ===== retrieveDebitBasicInformation =====

    @Test
    void retrieveDebitBasicInformation_success() {
        var t24Response = buildSuccessT24Response();
        var expected = new DebitBasicInformation("cust1", "name", "type", "ACTIVE", new LinkedAccounts(Collections.emptyList(), Collections.emptyList()));

        try (MockedStatic<AppTool> m = mockStatic(AppTool.class)) {
            m.when(AppTool::context).thenReturn(Mono.just(ctx));
            when(t24WebClient.executeOperation(any(), any(), any())).thenReturn(Mono.just(t24Response));
            when(objectMapper.convertValue(any(), eq(T24Response.class))).thenReturn(t24Response);
            when(t24Mapper.mapToDebitBasicInformation(any(T24Response.class))).thenReturn(expected);

            StepVerifier.create(adapter.retrieveDebitBasicInformation("12345"))
                    .expectNext(expected)
                    .verifyComplete();
        }
    }

    @Test
    void retrieveDebitBasicInformation_nullBody_throwsInternalServerException() {
        var t24Response = T24Response.builder().data(null).build();

        try (MockedStatic<AppTool> m = mockStatic(AppTool.class)) {
            m.when(AppTool::context).thenReturn(Mono.just(ctx));
            when(t24WebClient.executeOperation(any(), any(), any())).thenReturn(Mono.just(t24Response));
            when(objectMapper.convertValue(any(), eq(T24Response.class))).thenReturn(t24Response);

            StepVerifier.create(adapter.retrieveDebitBasicInformation("12345"))
                    .expectError(InternalServerException.class)
                    .verify();
        }
    }

    @Test
    void retrieveDebitBasicInformation_nullBodyDto_throwsInternalServerException() {
        var t24Response = T24Response.builder()
                .data(T24DataDto.builder().body(null).build())
                .build();

        try (MockedStatic<AppTool> m = mockStatic(AppTool.class)) {
            m.when(AppTool::context).thenReturn(Mono.just(ctx));
            when(t24WebClient.executeOperation(any(), any(), any())).thenReturn(Mono.just(t24Response));
            when(objectMapper.convertValue(any(), eq(T24Response.class))).thenReturn(t24Response);

            StepVerifier.create(adapter.retrieveDebitBasicInformation("12345"))
                    .expectError(InternalServerException.class)
                    .verify();
        }
    }

    @Test
    void retrieveDebitBasicInformation_zeroRecords_throwsNotFoundException() {
        var customerType = T24DataDto.WsficodebitcardcustomerTypeDto.builder()
                .zerorecords("NO DATA")
                .build();
        var consultaResponse = T24DataDto.ConsultaMaestraTarjetaDebitoResponseDto.builder()
                .wsficodebitcardcustomerType(customerType)
                .status(T24DataDto.StatusDto.builder().successIndicator("Success").build())
                .build();
        var t24Response = T24Response.builder()
                .data(T24DataDto.builder()
                        .body(T24DataDto.BodyDto.builder()
                                .consultaMaestraTarjetaDebitoResponse(consultaResponse)
                                .build())
                        .build())
                .build();

        try (MockedStatic<AppTool> m = mockStatic(AppTool.class)) {
            m.when(AppTool::context).thenReturn(Mono.just(ctx));
            when(t24WebClient.executeOperation(any(), any(), any())).thenReturn(Mono.just(t24Response));
            when(objectMapper.convertValue(any(), eq(T24Response.class))).thenReturn(t24Response);

            StepVerifier.create(adapter.retrieveDebitBasicInformation("12345"))
                    .expectError(NotFoundException.class)
                    .verify();
        }
    }

    @Test
    void retrieveDebitBasicInformation_businessError_throwsBusinessException() {
        var consultaResponse = T24DataDto.ConsultaMaestraTarjetaDebitoResponseDto.builder()
                .wsficodebitcardcustomerType(T24DataDto.WsficodebitcardcustomerTypeDto.builder().build())
                .status(T24DataDto.StatusDto.builder().successIndicator("FAILURE").messages("Some error").build())
                .build();
        var t24Response = T24Response.builder()
                .data(T24DataDto.builder()
                        .body(T24DataDto.BodyDto.builder()
                                .consultaMaestraTarjetaDebitoResponse(consultaResponse)
                                .build())
                        .build())
                .build();

        try (MockedStatic<AppTool> m = mockStatic(AppTool.class)) {
            m.when(AppTool::context).thenReturn(Mono.just(ctx));
            when(t24WebClient.executeOperation(any(), any(), any())).thenReturn(Mono.just(t24Response));
            when(objectMapper.convertValue(any(), eq(T24Response.class))).thenReturn(t24Response);

            StepVerifier.create(adapter.retrieveDebitBasicInformation("12345"))
                    .expectError(BusinessException.class)
                    .verify();
        }
    }

    // ===== retrieveDebitCardDetails =====

    @Test
    void retrieveDebitCardDetails_success() {
        var debitCardResponse = new DebitCardResponse(
                new DebitCardResponse.Meta("svc", "dom", "ts"),
                new DebitCardResponse.Data(
                        new DebitCardResponse.Body(
                                new DebitCardResponse.ConsultaMaestraTarjetaDebitoResponse(
                                        new DebitCardResponse.Status("Success"),
                                        new DebitCardResponse.WsficodebitcardcustomerType(
                                                null,
                                                new DebitCardResponse.GWsficodebitcardcustomerDetailType(
                                                        List.of(new DebitCardResponse.MWsficodebitcardcustomerDetailType(
                                                                "cust1", "4111", "name", "USD", "primary", "secondary", "90", "VISA", "CC", "legal1", "2024-01-01"
                                                        ))
                                                )
                                        )
                                )
                        )
                )
        );

        var expected = new DebitCardDetails();
        expected.setCustomerInquiry(new CustomerInquiry());
        expected.setDebitCardInquiry(List.of(new DebitCardInquiry()));

        try (MockedStatic<AppTool> m = mockStatic(AppTool.class)) {
            m.when(AppTool::context).thenReturn(Mono.just(ctx));
            when(t24WebClient.executeOperation(any(), any(), any())).thenReturn(Mono.just(debitCardResponse));
            when(objectMapper.convertValue(any(), eq(DebitCardResponse.class))).thenReturn(debitCardResponse);
            when(t24Mapper.mapToDebitCardDetails(any(DebitCardResponse.class))).thenReturn(expected);

            StepVerifier.create(adapter.retrieveDebitCardDetails("cust1", "ACTIVE", "acc1"))
                    .expectNext(expected)
                    .verifyComplete();
        }
    }

    @Test
    void retrieveDebitCardDetails_nullData_throwsNotFoundException() {
        var debitCardResponse = new DebitCardResponse(null, null);

        try (MockedStatic<AppTool> m = mockStatic(AppTool.class)) {
            m.when(AppTool::context).thenReturn(Mono.just(ctx));
            when(t24WebClient.executeOperation(any(), any(), any())).thenReturn(Mono.just(debitCardResponse));
            when(objectMapper.convertValue(any(), eq(DebitCardResponse.class))).thenReturn(debitCardResponse);

            StepVerifier.create(adapter.retrieveDebitCardDetails("cust1", "ACTIVE", "acc1"))
                    .expectError(NotFoundException.class)
                    .verify();
        }
    }

    @Test
    void retrieveDebitCardDetails_nullBody_throwsNotFoundException() {
        var debitCardResponse = new DebitCardResponse(null, new DebitCardResponse.Data(null));

        try (MockedStatic<AppTool> m = mockStatic(AppTool.class)) {
            m.when(AppTool::context).thenReturn(Mono.just(ctx));
            when(t24WebClient.executeOperation(any(), any(), any())).thenReturn(Mono.just(debitCardResponse));
            when(objectMapper.convertValue(any(), eq(DebitCardResponse.class))).thenReturn(debitCardResponse);

            StepVerifier.create(adapter.retrieveDebitCardDetails("cust1", "ACTIVE", "acc1"))
                    .expectError(NotFoundException.class)
                    .verify();
        }
    }

    // ===== Helper =====

    private T24Response buildSuccessT24Response() {
        var detail = T24DataDto.MWsficodebitcardcustomerDetailTypeDto.builder()
                .customer("cust1").cardnumber("4111").nameoncard("name")
                .currency1("USD").primaryacct("primary").scndryacct("secondary")
                .cardstatus("90").typeofcard("VISA").producttype("CC")
                .customerlegalId("legal1").issuedate("2024-01-01")
                .build();
        var customerType = T24DataDto.WsficodebitcardcustomerTypeDto.builder()
                .gWsficodebitcardcustomerDetailType(
                        T24DataDto.GWsficodebitcardcustomerDetailTypeDto.builder()
                                .mWsficodebitcardcustomerDetailType(detail)
                                .build())
                .build();
        var consultaResponse = T24DataDto.ConsultaMaestraTarjetaDebitoResponseDto.builder()
                .status(T24DataDto.StatusDto.builder().successIndicator("Success").build())
                .wsficodebitcardcustomerType(customerType)
                .build();
        return T24Response.builder()
                .data(T24DataDto.builder()
                        .body(T24DataDto.BodyDto.builder()
                                .consultaMaestraTarjetaDebitoResponse(consultaResponse)
                                .build())
                        .build())
                .build();
    }
}

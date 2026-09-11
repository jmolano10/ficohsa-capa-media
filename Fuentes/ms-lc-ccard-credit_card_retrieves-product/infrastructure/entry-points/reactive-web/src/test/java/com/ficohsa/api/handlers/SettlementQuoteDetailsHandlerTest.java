package com.ficohsa.api.handlers;

import com.ficohsa.api.dto.settlementquotedetails.request.SettlementQuoteDetailsRequestDto;
import com.ficohsa.api.mappers.SettlementQuoteDetailMapper;
import com.ficohsa.lib.core.dto.AppContext;
import com.ficohsa.lib.core.exception.BadRequestException;
import com.ficohsa.lib.core.utility.AppTool;
import com.ficohsa.model.settlementquotedetails.SettlementQuoteDetails;
import com.ficohsa.model.settlementquotedetails.SettlementQuoteDetailsModel;
import com.ficohsa.ports.ISettlementQuoteDetails;
import jakarta.validation.Validation;
import jakarta.validation.ValidatorFactory;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.junit.jupiter.params.ParameterizedTest;
import org.junit.jupiter.params.provider.Arguments;
import org.junit.jupiter.params.provider.MethodSource;
import org.mockito.Mock;
import org.mockito.MockedStatic;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.validation.beanvalidation.SpringValidatorAdapter;
import reactor.core.publisher.Mono;
import reactor.test.StepVerifier;

import java.time.LocalDateTime;
import java.time.Month;
import java.util.UUID;
import java.util.stream.Stream;

import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
class SettlementQuoteDetailsHandlerTest {

    private static final LocalDateTime FIXED_DATE = LocalDateTime.of(2025, Month.JANUARY, 1, 0, 0);

    @Mock
    private ISettlementQuoteDetails useCase;

    @Mock
    private SettlementQuoteDetailMapper settlementQuoteDetailMapper;

    private SettlementQuoteDetailsHandler handler;

    private org.springframework.validation.Validator validator;

    private SettlementQuoteDetailsRequestDto validRequest;

    @BeforeEach
    void setUp() {
        ValidatorFactory factory = Validation.buildDefaultValidatorFactory();
        jakarta.validation.Validator jakartaValidator = factory.getValidator();
        validator = new SpringValidatorAdapter(jakartaValidator);

        handler = new SettlementQuoteDetailsHandler(useCase, validator, settlementQuoteDetailMapper);

        validRequest = SettlementQuoteDetailsRequestDto.builder()
                .data(SettlementQuoteDetailsRequestDto.RequestData.builder()
                        .accountNumber("123456789")
                        .organizationReference("ORG01")
                        .financingPlanReference("PLAN01")
                        .paymentSequenceNumber("1")
                        .cancellationDate("2025-12-31")
                        .repaymentAmount(100.00)
                        .paymentType(1)
                        .build())
                .build();
    }

    private AppContext createMockContext() {
        return new AppContext(
                "es", "test-app", "test-user", "Bearer token", "facade-test",
                "web", UUID.fromString("550e8400-e29b-41d4-a716-446655440000"), "HN01", "HN01", FIXED_DATE, "http://localhost"
        );
    }

    @Test
    void retrieveSettlementQuoteDetails_Success() {
        try (MockedStatic<AppTool> appToolMock = mockStatic(AppTool.class)) {
            appToolMock.when(AppTool::context).thenReturn(Mono.just(createMockContext()));

            SettlementQuoteDetails domainReq = SettlementQuoteDetails.builder()
                    .accountNumber("123456789")
                    .organizationReference("ORG01")
                    .financingPlanReference("PLAN01")
                    .paymentSequenceNumber("1")
                    .cancellationDate("2025-12-31")
                    .repaymentAmount(100.00)
                    .paymentType(1)
                    .build();

            when(settlementQuoteDetailMapper.toDomain(any(SettlementQuoteDetailsRequestDto.RequestData.class)))
                    .thenReturn(domainReq);

            SettlementQuoteDetailsModel.PlanData planData = SettlementQuoteDetailsModel.PlanData.builder()
                    .productReference("PROD001")
                    .productType("Credit")
                    .build();

            SettlementQuoteDetailsModel.SettlementQuoteInquiry inquiry = SettlementQuoteDetailsModel.SettlementQuoteInquiry.builder()
                    .accountNumber("123456789")
                    .organizationReference("ORG01")
                    .planData(planData)
                    .build();

            SettlementQuoteDetailsModel model = SettlementQuoteDetailsModel.builder()
                    .settlementQuoteInquiry(inquiry)
                    .build();

            when(useCase.retrieveSettlementQuoteDetails(any(SettlementQuoteDetails.class)))
                    .thenReturn(Mono.just(model));

            var responseDto = com.ficohsa.api.dto.settlementquotedetails.response.SettlementQuoteDetailsResponseDto.builder()
                    .accountNumber("123456789")
                    .organizationReference("ORG01")
                    .build();

            when(settlementQuoteDetailMapper.toResponse(any(SettlementQuoteDetailsModel.class)))
                    .thenReturn(responseDto);

            StepVerifier.create(handler.retrieveSettlementQuoteDetails(validRequest))
                    .expectNextMatches(response ->
                            response.accountNumber() != null &&
                                    "123456789".equals(response.accountNumber())
                    )
                    .verifyComplete();

            verify(useCase).retrieveSettlementQuoteDetails(argThat(req ->
                    "HN01".equals(req.getRegion()) &&
                            "facade-test".equals(req.getCallService()) &&
                            "123456789".equals(req.getAccountNumber())
            ));
        }
    }

    @Test
    void retrieveSettlementQuoteDetails_ValidationError() {
        SettlementQuoteDetailsRequestDto invalidRequest = SettlementQuoteDetailsRequestDto.builder()
                .data(SettlementQuoteDetailsRequestDto.RequestData.builder()
                        .accountNumber("")
                        .organizationReference("ORG01")
                        .financingPlanReference("PLAN01")
                        .paymentSequenceNumber("1")
                        .cancellationDate("2025-12-31")
                        .build())
                .build();

        StepVerifier.create(handler.retrieveSettlementQuoteDetails(invalidRequest))
                .expectError(BadRequestException.class)
                .verify();

        verifyNoInteractions(useCase);
    }

    @ParameterizedTest(name = "Should return 400 when {0} is {1}")
    @MethodSource("provideMandatoryFieldsInvalidScenarios")
    void retrieveSettlementQuoteDetails_MandatoryFieldInvalid_ShouldReturnBadRequest(
            String fieldName,
            String scenario,
            SettlementQuoteDetailsRequestDto request
    ) {
        StepVerifier.create(handler.retrieveSettlementQuoteDetails(request))
                .expectError(BadRequestException.class)
                .verify();

        verifyNoInteractions(useCase);
    }

    private static Stream<Arguments> provideMandatoryFieldsInvalidScenarios() {
        return Stream.concat(
            provideMandatoryFieldsNullScenarios(),
            provideMandatoryFieldsEmptyScenarios()
        );
    }

    private static Stream<Arguments> provideMandatoryFieldsNullScenarios() {
        return Stream.of(
            Arguments.of(
                "accountNumber",
                "NULL",
                SettlementQuoteDetailsRequestDto.builder()
                    .data(SettlementQuoteDetailsRequestDto.RequestData.builder()
                        .accountNumber(null)
                        .organizationReference("ORG01")
                        .financingPlanReference("PLAN01")
                        .paymentSequenceNumber("1")
                        .cancellationDate("2025-12-31")
                        .build())
                    .build()
            ),
            Arguments.of(
                "organizationReference",
                "NULL",
                SettlementQuoteDetailsRequestDto.builder()
                    .data(SettlementQuoteDetailsRequestDto.RequestData.builder()
                        .accountNumber("123456789")
                        .organizationReference(null)
                        .financingPlanReference("PLAN01")
                        .paymentSequenceNumber("1")
                        .cancellationDate("2025-12-31")
                        .build())
                    .build()
            ),
            Arguments.of(
                "financingPlanReference",
                "NULL",
                SettlementQuoteDetailsRequestDto.builder()
                    .data(SettlementQuoteDetailsRequestDto.RequestData.builder()
                        .accountNumber("123456789")
                        .organizationReference("ORG01")
                        .financingPlanReference(null)
                        .paymentSequenceNumber("1")
                        .cancellationDate("2025-12-31")
                        .build())
                    .build()
            ),
            Arguments.of(
                "paymentSequenceNumber",
                "NULL",
                SettlementQuoteDetailsRequestDto.builder()
                    .data(SettlementQuoteDetailsRequestDto.RequestData.builder()
                        .accountNumber("123456789")
                        .organizationReference("ORG01")
                        .financingPlanReference("PLAN01")
                        .paymentSequenceNumber(null)
                        .cancellationDate("2025-12-31")
                        .build())
                    .build()
            ),
            Arguments.of(
                "cancellationDate",
                "NULL",
                SettlementQuoteDetailsRequestDto.builder()
                    .data(SettlementQuoteDetailsRequestDto.RequestData.builder()
                        .accountNumber("123456789")
                        .organizationReference("ORG01")
                        .financingPlanReference("PLAN01")
                        .paymentSequenceNumber("1")
                        .cancellationDate(null)
                        .build())
                    .build()
            )
        );
    }

    private static Stream<Arguments> provideMandatoryFieldsEmptyScenarios() {
        return Stream.of(
            Arguments.of(
                "accountNumber",
                "EMPTY",
                SettlementQuoteDetailsRequestDto.builder()
                    .data(SettlementQuoteDetailsRequestDto.RequestData.builder()
                        .accountNumber("")
                        .organizationReference("ORG01")
                        .financingPlanReference("PLAN01")
                        .paymentSequenceNumber("1")
                        .cancellationDate("2025-12-31")
                        .build())
                    .build()
            ),
            Arguments.of(
                "organizationReference",
                "EMPTY",
                SettlementQuoteDetailsRequestDto.builder()
                    .data(SettlementQuoteDetailsRequestDto.RequestData.builder()
                        .accountNumber("123456789")
                        .organizationReference("")
                        .financingPlanReference("PLAN01")
                        .paymentSequenceNumber("1")
                        .cancellationDate("2025-12-31")
                        .build())
                    .build()
            ),
            Arguments.of(
                "financingPlanReference",
                "EMPTY",
                SettlementQuoteDetailsRequestDto.builder()
                    .data(SettlementQuoteDetailsRequestDto.RequestData.builder()
                        .accountNumber("123456789")
                        .organizationReference("ORG01")
                        .financingPlanReference("")
                        .paymentSequenceNumber("1")
                        .cancellationDate("2025-12-31")
                        .build())
                    .build()
            ),
            Arguments.of(
                "paymentSequenceNumber",
                "EMPTY",
                SettlementQuoteDetailsRequestDto.builder()
                    .data(SettlementQuoteDetailsRequestDto.RequestData.builder()
                        .accountNumber("123456789")
                        .organizationReference("ORG01")
                        .financingPlanReference("PLAN01")
                        .paymentSequenceNumber("")
                        .cancellationDate("2025-12-31")
                        .build())
                    .build()
            ),
            Arguments.of(
                "cancellationDate",
                "EMPTY",
                SettlementQuoteDetailsRequestDto.builder()
                    .data(SettlementQuoteDetailsRequestDto.RequestData.builder()
                        .accountNumber("123456789")
                        .organizationReference("ORG01")
                        .financingPlanReference("PLAN01")
                        .paymentSequenceNumber("1")
                        .cancellationDate("")
                        .build())
                    .build()
            ),
            Arguments.of(
                "accountNumber",
                "BLANK",
                SettlementQuoteDetailsRequestDto.builder()
                    .data(SettlementQuoteDetailsRequestDto.RequestData.builder()
                        .accountNumber("   ")
                        .organizationReference("ORG01")
                        .financingPlanReference("PLAN01")
                        .paymentSequenceNumber("1")
                        .cancellationDate("2025-12-31")
                        .build())
                    .build()
            )
        );
    }
}

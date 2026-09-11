package com.ficohsa.api.handlers;

import com.ficohsa.api.dto.DebitCardDetailsDto;
import com.ficohsa.api.mappers.DebitCardDetailsMapper;
import com.ficohsa.lib.core.dto.AppContext;
import com.ficohsa.lib.core.exception.BadRequestException;
import com.ficohsa.lib.core.utility.AppTool;
import com.ficohsa.model.debitcarddetails.DebitCardDetails;
import com.ficohsa.ports.IDebitCardDetails;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockedStatic;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.reactive.function.server.ServerRequest;
import reactor.core.publisher.Mono;
import reactor.test.StepVerifier;

import java.time.LocalDateTime;
import java.time.Month;
import java.util.UUID;

import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
class DebitCardDetailsHandlerTest {

    private static final LocalDateTime FIXED_DATE = LocalDateTime.of(2025, Month.JANUARY, 1, 0, 0);

    @Mock private IDebitCardDetails debitCardDetails;
    @Mock private DebitCardDetailsMapper debitCardDetailsMapper;
    @Mock private ServerRequest serverRequest;

    @InjectMocks
    private DebitCardDetailsHandler handler;

    @Test
    void handle_success() {
        AppContext ctx = new AppContext("es", "app", "user", "token", "caller",
                "web", UUID.fromString("550e8400-e29b-41d4-a716-446655440000"), "HN01", null, FIXED_DATE, null);
        DebitCardDetails details = new DebitCardDetails();
        DebitCardDetailsDto dto = DebitCardDetailsDto.builder().build();

        MultiValueMap<String, String> params = new LinkedMultiValueMap<>();
        params.add("accountstatustypevalues", "ACTIVE");

        when(serverRequest.queryParams()).thenReturn(params);
        when(serverRequest.pathVariable("customerIdentification")).thenReturn("0801199012345");
        when(debitCardDetails.getDebitCardDetails("0801199012345", "ACTIVE", null, "HN01"))
                .thenReturn(Mono.just(details));
        when(debitCardDetailsMapper.toDto(details)).thenReturn(dto);

        try (MockedStatic<AppTool> mocked = mockStatic(AppTool.class)) {
            mocked.when(AppTool::context).thenReturn(Mono.just(ctx));

            StepVerifier.create(handler.handle(serverRequest))
                    .expectNext(dto)
                    .verifyComplete();
        }
    }

    @Test
    void handle_missingAccountStatusType_throwsBadRequest() {
        AppContext ctx = new AppContext("es", "app", "user", "token", "caller",
                "web", UUID.fromString("550e8400-e29b-41d4-a716-446655440000"), "HN01", null, FIXED_DATE, null);

        MultiValueMap<String, String> params = new LinkedMultiValueMap<>();
        when(serverRequest.queryParams()).thenReturn(params);

        try (MockedStatic<AppTool> mocked = mockStatic(AppTool.class)) {
            mocked.when(AppTool::context).thenReturn(Mono.just(ctx));

            StepVerifier.create(handler.handle(serverRequest))
                    .expectError(BadRequestException.class)
                    .verify();
        }
    }

    @Test
    void handle_invalidAccountStatusType_throwsBadRequest() {
        AppContext ctx = new AppContext("es", "app", "user", "token", "caller",
                "web", UUID.fromString("550e8400-e29b-41d4-a716-446655440000"), "HN01", null, FIXED_DATE, null);

        MultiValueMap<String, String> params = new LinkedMultiValueMap<>();
        params.add("accountstatustypevalues", "INVALID_STATUS");
        when(serverRequest.queryParams()).thenReturn(params);

        try (MockedStatic<AppTool> mocked = mockStatic(AppTool.class)) {
            mocked.when(AppTool::context).thenReturn(Mono.just(ctx));

            StepVerifier.create(handler.handle(serverRequest))
                    .expectError(BadRequestException.class)
                    .verify();
        }
    }

    @Test
    void handle_invalidRegion_throwsUnprocessableEntity() {
        AppContext ctx = new AppContext("es", "app", "user", "token", "caller",
                "web", UUID.fromString("550e8400-e29b-41d4-a716-446655440000"), "XX99", null, FIXED_DATE, null);

        MultiValueMap<String, String> params = new LinkedMultiValueMap<>();
        params.add("accountstatustypevalues", "ACTIVE");
        lenient().when(serverRequest.queryParams()).thenReturn(params);

        try (MockedStatic<AppTool> mocked = mockStatic(AppTool.class)) {
            mocked.when(AppTool::context).thenReturn(Mono.just(ctx));

            StepVerifier.create(handler.handle(serverRequest))
                    .expectError(com.ficohsa.lib.core.exception.UnprocessableEntityException.class)
                    .verify();
        }
    }
}

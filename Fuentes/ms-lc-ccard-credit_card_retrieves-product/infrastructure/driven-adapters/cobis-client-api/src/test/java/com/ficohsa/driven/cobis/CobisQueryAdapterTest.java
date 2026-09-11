package com.ficohsa.driven.cobis;

import com.ficohsa.driven.cobis.config.CobisClientConfig;
import com.ficohsa.driven.cobis.dto.request.CobisSpRequest;
import com.ficohsa.driven.cobis.dto.response.CobisDataDto;
import com.ficohsa.driven.cobis.dto.response.CobisResponse;
import com.ficohsa.driven.cobis.dto.response.CobisSpResponse;
import com.ficohsa.driven.cobis.mapper.CobisMapper;
import com.ficohsa.lib.core.dto.AppContext;
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
import static org.mockito.Mockito.mockStatic;
import static org.mockito.Mockito.when;

@ExtendWith(MockitoExtension.class)
class CobisQueryAdapterTest {

    private static final LocalDateTime FIXED_DATE = LocalDateTime.of(2025, Month.JANUARY, 1, 0, 0);

    @Mock private CobisClientConfig cobisWebClient;
    @Mock private CobisMapper cobisMapper;
    @InjectMocks private CobisQueryAdapter adapter;

    private AppContext ctx;

    @BeforeEach
    void setUp() {
        ctx = new AppContext("es", "app", "user", "Bearer token", "caller", "web",
                UUID.fromString("550e8400-e29b-41d4-a716-446655440000"), "HN01", null, FIXED_DATE, null);
    }

    @Test
    void key_returnsNI01() {
        assertEquals("NI01", adapter.key());
    }

    // ===== retrieveDebitBasicInformation =====

    @Test
    void retrieveDebitBasicInformation_success() {
        var cobisResponse = buildSuccessCobisResponse("0");
        var expected = new DebitBasicInformation("cust1", "name", "cat", "ACTIVE",
                new LinkedAccounts(Collections.emptyList(), Collections.emptyList()));

        try (MockedStatic<AppTool> m = mockStatic(AppTool.class)) {
            m.when(AppTool::context).thenReturn(Mono.just(ctx));
            when(cobisWebClient.executeOperation(any(), any(), any())).thenReturn(Mono.just(cobisResponse));
            when(cobisMapper.mapToDebitBasicInformation(any(CobisResponse.class))).thenReturn(expected);

            StepVerifier.create(adapter.retrieveDebitBasicInformation("12345"))
                    .expectNext(expected)
                    .verifyComplete();
        }
    }

    @Test
    void retrieveDebitBasicInformation_businessError_throwsNotFoundException() {
        var cobisResponse = buildSuccessCobisResponse("1");

        try (MockedStatic<AppTool> m = mockStatic(AppTool.class)) {
            m.when(AppTool::context).thenReturn(Mono.just(ctx));
            when(cobisWebClient.executeOperation(any(), any(), any())).thenReturn(Mono.just(cobisResponse));

            StepVerifier.create(adapter.retrieveDebitBasicInformation("12345"))
                    .expectError(NotFoundException.class)
                    .verify();
        }
    }

    @Test
    void retrieveDebitBasicInformation_webClientError_propagates() {
        try (MockedStatic<AppTool> m = mockStatic(AppTool.class)) {
            m.when(AppTool::context).thenReturn(Mono.just(ctx));
            when(cobisWebClient.executeOperation(any(), any(), any()))
                    .thenReturn(Mono.error(new RuntimeException("connection error")));

            StepVerifier.create(adapter.retrieveDebitBasicInformation("12345"))
                    .expectError(RuntimeException.class)
                    .verify();
        }
    }

    // ===== retrieveDebitCardDetails =====

    @Test
    void retrieveDebitCardDetails_success() {
        var spResponse = new CobisSpResponse();
        var expected = new DebitCardDetails();
        expected.setCustomerInquiry(new CustomerInquiry());
        expected.setDebitCardInquiry(List.of(new DebitCardInquiry()));

        try (MockedStatic<AppTool> m = mockStatic(AppTool.class)) {
            m.when(AppTool::context).thenReturn(Mono.just(ctx));
            when(cobisWebClient.executeSpOperation(any(CobisSpRequest.class), any(AppContext.class)))
                    .thenReturn(Mono.just(spResponse));
            when(cobisMapper.mapToDebitCardDetails(any(CobisSpResponse.class), any(CobisSpRequest.class)))
                    .thenReturn(expected);

            StepVerifier.create(adapter.retrieveDebitCardDetails("CUST123", "ACTIVE", "ACC001"))
                    .expectNext(expected)
                    .verifyComplete();
        }
    }

    @Test
    void retrieveDebitCardDetails_error_propagates() {
        try (MockedStatic<AppTool> m = mockStatic(AppTool.class)) {
            m.when(AppTool::context).thenReturn(Mono.just(ctx));
            when(cobisWebClient.executeSpOperation(any(CobisSpRequest.class), any(AppContext.class)))
                    .thenReturn(Mono.error(new RuntimeException("SP error")));

            StepVerifier.create(adapter.retrieveDebitCardDetails("CUST123", "ACTIVE", "ACC001"))
                    .expectError(RuntimeException.class)
                    .verify();
        }
    }

    // ===== Helpers =====

    private CobisResponse buildSuccessCobisResponse(String codTipoRespuesta) {
        var contextoRespuesta = CobisDataDto.ContextoRespuestaDto.builder()
                .codTipoRespuesta(codTipoRespuesta)
                .valDescripcionRespuesta("OK")
                .build();
        var tarjeta = CobisDataDto.TarjetaDto.builder()
                .idCliente("cust1").nombreTarjeta("name")
                .categoriaTarjeta("cat").estadoTarjeta("ACTIVE")
                .build();
        var opRespuesta = CobisDataDto.OpConsultaTarjetaDebitoRespuestaDto.builder()
                .contextoRespuesta(contextoRespuesta)
                .tarjeta(tarjeta)
                .cuentaPrincipal(CobisDataDto.CuentaPrincipalDto.builder().numCuenta("123").moneda("HNL").build())
                .cuentaSecundaria(CobisDataDto.CuentaSecundariaDto.builder().numCuenta("456").moneda("USD").build())
                .build();
        var body = CobisDataDto.BodyDto.builder()
                .opConsultaTarjetaDebitoRespuesta(opRespuesta)
                .build();
        var data = CobisDataDto.builder().body(body).build();
        return CobisResponse.builder().data(data).build();
    }
}

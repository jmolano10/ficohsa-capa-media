package com.ficohsa.helper;

import com.ficohsa.lib.core.exception.UnprocessableEntityException;
import com.ficohsa.model.RegionStatusModel;
import com.ficohsa.model.settlementquotedetails.RegionModel;
import com.ficohsa.ports.IDebitBasicInformationGateway;
import com.ficohsa.ports.IDebitCardDetailsGateway;
import com.ficohsa.ports.ISettlementQuoteDetailsGateway;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import reactor.test.StepVerifier;

import java.util.List;
import java.util.Map;

@ExtendWith(MockitoExtension.class)
class CertificateDepositInfoResolverTest {

    @Mock
    private IDebitBasicInformationGateway basicGateway;
    @Mock
    private IDebitCardDetailsGateway detailsGateway;
    @Mock
    private ISettlementQuoteDetailsGateway settlementGateway;

    private CertificateDepositInfoResolver resolver;

    @BeforeEach
    void setUp() {
        resolver = new CertificateDepositInfoResolver(
                Map.of("HN01", basicGateway),
                Map.of("HN01", detailsGateway),
                Map.of("HN01VP", settlementGateway)
        );
    }

    // --- resolveWrapper ---

    @Test
    void resolveWrapper_success() {
        RegionStatusModel params = buildRegionStatus("HN01-enabled", true);

        StepVerifier.create(resolver.resolveWrapper("HN01", params))
                .expectNext(basicGateway)
                .verifyComplete();
    }

    @Test
    void resolveWrapper_regionNotFound_throwsUnprocessable() {
        RegionStatusModel params = buildRegionStatus("GT01-enabled", true);

        StepVerifier.create(resolver.resolveWrapper("HN01", params))
                .expectError(UnprocessableEntityException.class)
                .verify();
    }

    @Test
    void resolveWrapper_regionDisabled_throwsUnprocessable() {
        RegionStatusModel params = buildRegionStatus("HN01-disabled", false);

        StepVerifier.create(resolver.resolveWrapper("HN01", params))
                .expectError(UnprocessableEntityException.class)
                .verify();
    }

    @Test
    void resolveWrapper_strategyNull_throwsUnprocessable() {
        var resolverNoStrategy = new CertificateDepositInfoResolver(
                Map.of(), Map.of("HN01", detailsGateway), Map.of("HN01VP", settlementGateway));
        RegionStatusModel params = buildRegionStatus("HN01-enabled", true);

        StepVerifier.create(resolverNoStrategy.resolveWrapper("HN01", params))
                .expectError(UnprocessableEntityException.class)
                .verify();
    }

    // --- resolveDebitCardDetailsWrapper ---

    @Test
    void resolveDebitCardDetailsWrapper_success() {
        RegionStatusModel params = buildRegionStatus("HN01-enabled", true);

        StepVerifier.create(resolver.resolveDebitCardDetailsWrapper("HN01", params))
                .expectNext(detailsGateway)
                .verifyComplete();
    }

    @Test
    void resolveDebitCardDetailsWrapper_regionNotFound_throwsUnprocessable() {
        RegionStatusModel params = buildRegionStatus("GT01-enabled", true);

        StepVerifier.create(resolver.resolveDebitCardDetailsWrapper("HN01", params))
                .expectError(UnprocessableEntityException.class)
                .verify();
    }

    @Test
    void resolveDebitCardDetailsWrapper_regionDisabled_throwsUnprocessable() {
        RegionStatusModel params = buildRegionStatus("HN01-disabled", false);

        StepVerifier.create(resolver.resolveDebitCardDetailsWrapper("HN01", params))
                .expectError(UnprocessableEntityException.class)
                .verify();
    }

    @Test
    void resolveDebitCardDetailsWrapper_strategyNull_throwsUnprocessable() {
        var resolverNoStrategy = new CertificateDepositInfoResolver(
                Map.of("HN01", basicGateway), Map.of(), Map.of("HN01VP", settlementGateway));
        RegionStatusModel params = buildRegionStatus("HN01-enabled", true);

        StepVerifier.create(resolverNoStrategy.resolveDebitCardDetailsWrapper("HN01", params))
                .expectError(UnprocessableEntityException.class)
                .verify();
    }

    // --- resolveSettlementQuoteDetailsWrapper ---

    @Test
    void resolveSettlementQuoteDetailsWrapper_success() {
        RegionModel params = buildRegionModel("HN01-enabled", true);

        StepVerifier.create(resolver.resolveSettlementQuoteDetailsWrapper("HN01", params))
                .expectNext(settlementGateway)
                .verifyComplete();
    }

    @Test
    void resolveSettlementQuoteDetailsWrapper_regionNotFound_throwsUnprocessable() {
        RegionModel params = buildRegionModel("GT01-enabled", true);

        StepVerifier.create(resolver.resolveSettlementQuoteDetailsWrapper("HN01", params))
                .expectError(UnprocessableEntityException.class)
                .verify();
    }

    @Test
    void resolveSettlementQuoteDetailsWrapper_regionDisabled_throwsUnprocessable() {
        RegionModel params = buildRegionModel("HN01-disabled", false);

        StepVerifier.create(resolver.resolveSettlementQuoteDetailsWrapper("HN01", params))
                .expectError(UnprocessableEntityException.class)
                .verify();
    }

    @Test
    void resolveSettlementQuoteDetailsWrapper_strategyNull_throwsUnprocessable() {
        var resolverNoStrategy = new CertificateDepositInfoResolver(
                Map.of("HN01", basicGateway), Map.of("HN01", detailsGateway), Map.of());
        RegionModel params = buildRegionModel("HN01-enabled", true);

        StepVerifier.create(resolverNoStrategy.resolveSettlementQuoteDetailsWrapper("HN01", params))
                .expectError(UnprocessableEntityException.class)
                .verify();
    }

    // --- helpers ---

    private RegionStatusModel buildRegionStatus(String region, boolean enabled) {
        return RegionStatusModel.builder()
                .regionStatusRetrieve(RegionStatusModel.RegionStatusRetrieve.builder()
                        .regionStates(List.of(RegionStatusModel.RegionState.builder()
                                .region(region).enabled(enabled).build()))
                        .build())
                .build();
    }

    private RegionModel buildRegionModel(String region, boolean enabled) {
        return RegionModel.builder()
                .regions(List.of(RegionModel.RegionConfig.builder()
                        .region(region).enabled(enabled).build()))
                .build();
    }
}

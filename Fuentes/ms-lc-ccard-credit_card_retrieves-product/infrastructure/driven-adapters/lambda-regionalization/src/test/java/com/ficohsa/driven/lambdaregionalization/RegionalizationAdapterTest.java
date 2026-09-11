package com.ficohsa.driven.lambdaregionalization;

import com.ficohsa.helper.config.*;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import reactor.core.publisher.Mono;
import reactor.test.StepVerifier;

import static org.junit.jupiter.api.Assertions.assertThrows;
import static org.mockito.ArgumentMatchers.anyString;
import static org.mockito.Mockito.when;

@ExtendWith(MockitoExtension.class)
class RegionalizationAdapterTest {

    @Mock private RegionalizationComponentPort regionalizationComponent;

    private RegionalizationAdapter adapter;

    @BeforeEach
    void setUp() {
        var cardPositionProps = new CardPositionRetrieveProperties();
        cardPositionProps.setMethod("card-position");
        cardPositionProps.setCountry("XRS");
        cardPositionProps.setDomain("CREDIT_CARD");

        var debitBasicInfoProps = new DebitBasicInformationProperties();
        debitBasicInfoProps.setMethod("debit-basic-info");
        debitBasicInfoProps.setCountry("XRS");
        debitBasicInfoProps.setDomain("CREDIT_CARD");

        var debitCardDetailsProps = new DebitCardDetailsProperties();
        debitCardDetailsProps.setMethod("debit-card-details");
        debitCardDetailsProps.setCountry("XRS");
        debitCardDetailsProps.setDomain("CREDIT_CARD");

        var settlementQuoteProps = new SettlementQuoteDetailsProperties();
        settlementQuoteProps.setMethod("settlement-quote");
        settlementQuoteProps.setCountry("XRS");
        settlementQuoteProps.setDomain("CREDIT_CARD");

        var associatedActiveCardsProps = new AssociatedActiveCardsProperties();
        associatedActiveCardsProps.setMethod("associated-active-cards");
        associatedActiveCardsProps.setCountry("XRS");
        associatedActiveCardsProps.setDomain("CREDIT_CARD");

        adapter = new RegionalizationAdapter(regionalizationComponent, cardPositionProps, debitBasicInfoProps, debitCardDetailsProps, settlementQuoteProps, associatedActiveCardsProps);
        adapter.init();
    }

    @Test
    void validateRegion_success() {
        when(regionalizationComponent.validateRegionEnabled(anyString(), anyString(), anyString(), anyString(), anyString(), anyString()))
                .thenReturn(Mono.empty());

        StepVerifier.create(adapter.validateRegion("card-position", "HN01", "HN01"))
                .verifyComplete();
    }

    @Test
    void validateRegion_error_propagates() {
        when(regionalizationComponent.validateRegionEnabled(anyString(), anyString(), anyString(), anyString(), anyString(), anyString()))
                .thenReturn(Mono.error(new RuntimeException("disabled")));

        StepVerifier.create(adapter.validateRegion("card-position", "HN01", "HN01"))
                .expectError(RuntimeException.class)
                .verify();
    }

    @Test
    void validateRegion_unknownMethod_throws() {
        assertThrows(IllegalArgumentException.class,
                () -> adapter.validateRegion("unknown", "HN01", "HN01"));
    }
}

package com.ficohsa.usecase.service;

import com.ficohsa.helper.RegionMappingService;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.params.ParameterizedTest;
import org.junit.jupiter.params.provider.CsvSource;

import java.time.LocalDateTime;

import static org.junit.jupiter.api.Assertions.assertEquals;

class RegionMappingServiceTest {

    private RegionMappingService regionMappingService;

    @BeforeEach
    void setUp() {
        regionMappingService = new RegionMappingService();
    }

    @ParameterizedTest
    @CsvSource({
        "PA01, PAN",
        "GT01, GTM", 
        "NI01, NIC",
        "HN01, HND",
        "XX01, HND",
        "'', HND"
    })
    void shouldReturnCorrectCountryCodeByRegion(String region, String expectedCountryCode) {
        // When
        String result = regionMappingService.getCountryCodeByRegion(region);

        // Then
        assertEquals(expectedCountryCode, result);
    }

    @Test
    void shouldReturnDefaultCountryCodeForNullRegion() {
        // When
        String result = regionMappingService.getCountryCodeByRegion(null);

        // Then
        assertEquals("HND", result);
    }

    @ParameterizedTest
    @CsvSource({
        "4123456789012345, VISA",
        "5123456789012345, MASTER CARD",
        "3123456789012345, AMERICAN EXPRESS",
        "6123456789012345, OTRA",
        "1123456789012345, OTRA",
        "0123456789012345, OTRA"
    })
    void shouldReturnCorrectCardBrandByFirstDigit(String creditCardId, String expectedBrand) {
        // When
        String result = regionMappingService.getCardBrand(creditCardId);

        // Then
        assertEquals(expectedBrand, result);
    }

    @Test
    void shouldReturnOtraForNullCreditCardId() {
        // When
        String result = regionMappingService.getCardBrand(null);

        // Then
        assertEquals("OTRA", result);
    }

    @Test
    void shouldReturnOtraForEmptyCreditCardId() {
        // When
        String result = regionMappingService.getCardBrand("");

        // Then
        assertEquals("OTRA", result);
    }

    @Test
    @SuppressWarnings("java:S5976") // Tests cover distinct null-handling scenarios not suitable for parameterization
    void shouldFormatCardEffectiveDateCorrectly() {
        LocalDateTime date = LocalDateTime.of(2023, 12, 25, 10, 30, 45);

        assertEquals("20231225", regionMappingService.formatCardEffectiveDate("HN01", date));
        assertEquals("", regionMappingService.formatCardEffectiveDate("PA01", date));
        assertEquals("", regionMappingService.formatCardEffectiveDate("HN01", null));
        assertEquals("", regionMappingService.formatCardEffectiveDate(null, date));
    }
}

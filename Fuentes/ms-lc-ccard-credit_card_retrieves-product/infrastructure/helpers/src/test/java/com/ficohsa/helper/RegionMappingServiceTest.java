package com.ficohsa.helper;

import org.junit.jupiter.api.Test;

import java.time.LocalDateTime;

import static org.junit.jupiter.api.Assertions.assertEquals;

class RegionMappingServiceTest {

    private final RegionMappingService service = new RegionMappingService();

    @Test
    void getCountryCodeByRegion_returnsCorrectCodes() {
        assertEquals("PAN", service.getCountryCodeByRegion("PA01"));
        assertEquals("GTM", service.getCountryCodeByRegion("GT01"));
        assertEquals("NIC", service.getCountryCodeByRegion("NI01"));
        assertEquals("HND", service.getCountryCodeByRegion("HN01"));
        assertEquals("HND", service.getCountryCodeByRegion(null));
    }

    @Test
    void getCardBrand_returnsCorrectBrands() {
        assertEquals("VISA", service.getCardBrand("4111111111111111"));
        assertEquals("MASTER CARD", service.getCardBrand("5111111111111111"));
        assertEquals("AMERICAN EXPRESS", service.getCardBrand("3111111111111111"));
        assertEquals("OTRA", service.getCardBrand("6111111111111111"));
        assertEquals("OTRA", service.getCardBrand(null));
        assertEquals("OTRA", service.getCardBrand(""));
    }

    @Test
    void formatCardEffectiveDate_formatsCorrectly() {
        LocalDateTime date = LocalDateTime.of(2024, 1, 15, 10, 0);
        assertEquals("20240115", service.formatCardEffectiveDate("HN01", date));
        assertEquals("", service.formatCardEffectiveDate("PA01", date));
        assertEquals("", service.formatCardEffectiveDate("HN01", null));
    }
}

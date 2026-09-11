package com.ficohsa.helper;

import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNull;

class RegionUtilsTest {

    @Test
    void toISO03_returnsCorrectCodes() {
        assertEquals("GTM", RegionUtils.toISO03("GT01-GT01"));
        assertEquals("HND", RegionUtils.toISO03("HN01-HN01"));
        assertEquals("NIC", RegionUtils.toISO03("NI01-NI01"));
        assertEquals("PAN", RegionUtils.toISO03("PA01-PA01"));
        assertNull(RegionUtils.toISO03("XX01-XX01"));
    }

    @Test
    void getLocalCurrency_returnsCorrectCurrencies() {
        assertEquals("GTQ", RegionUtils.getLocalCurrency("GT01-GT01"));
        assertEquals("HNL", RegionUtils.getLocalCurrency("HN01-HN01"));
        assertEquals("NIO", RegionUtils.getLocalCurrency("NI01-NI01"));
        assertEquals("PAB", RegionUtils.getLocalCurrency("PA01-PA01"));
        assertNull(RegionUtils.getLocalCurrency("XX01-XX01"));
    }
}

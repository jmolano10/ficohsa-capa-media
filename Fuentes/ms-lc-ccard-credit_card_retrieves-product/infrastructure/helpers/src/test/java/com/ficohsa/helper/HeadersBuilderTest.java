package com.ficohsa.helper;

import com.ficohsa.lib.core.dto.AppContext;
import org.junit.jupiter.api.Test;

import java.time.LocalDateTime;
import java.time.Month;
import java.util.Map;
import java.util.UUID;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNull;

class HeadersBuilderTest {

    private static final LocalDateTime FIXED_DATE = LocalDateTime.of(2025, Month.JANUARY, 1, 0, 0);

    @Test
    void fromContext_populatesAllHeaders() {
        UUID correlationId = UUID.fromString("550e8400-e29b-41d4-a716-446655440000");
        AppContext context = new AppContext("es", "app-id", "user", "Bearer token", "caller-svc",
                "web", correlationId, "HN01", "GT01", FIXED_DATE, null);

        Map<String, String> headers = HeadersBuilder.fromContext(context);

        assertEquals(correlationId.toString(), headers.get("Correlation-Id"));
        assertEquals("app-id", headers.get("Application-Id"));
        assertEquals("Bearer token", headers.get("Authorization"));
        assertEquals("HN01", headers.get("Source-Bank"));
        assertEquals("GT01", headers.get("Destination-Bank"));
        assertEquals("web", headers.get("Channel"));
        assertEquals("caller-svc", headers.get("Caller-Service"));
        assertEquals("es", headers.get("Accept-Language"));
    }

    @Test
    void fromContext_skipsNullValues() {
        AppContext context = new AppContext(null, null, null, null, null,
                null, null, "HN01", null, null, null);

        Map<String, String> headers = HeadersBuilder.fromContext(context);

        assertEquals("HN01", headers.get("Source-Bank"));
        assertNull(headers.get("Correlation-Id"));
        assertNull(headers.get("Application-Id"));
        assertNull(headers.get("Authorization"));
        assertNull(headers.get("Destination-Bank"));
        assertNull(headers.get("Channel"));
        assertNull(headers.get("Caller-Service"));
        assertNull(headers.get("Accept-Language"));
    }
}

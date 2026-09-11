package com.ficohsa.helper;

import com.ficohsa.lib.core.dto.AppContext;
import lombok.AccessLevel;
import lombok.NoArgsConstructor;

import java.util.HashMap;
import java.util.Map;

@NoArgsConstructor(access = AccessLevel.PRIVATE)
public class HeadersBuilder {

    public static Map<String, String> fromContext(AppContext context) {
        Map<String, String> headers = new HashMap<>();
        if (context.correlationId() != null) {
            headers.put("Correlation-Id", context.correlationId().toString());
        }
        if (context.applicationId() != null) {
            headers.put("Application-Id", context.applicationId());
        }
        if (context.authorization() != null) {
            headers.put("Authorization", context.authorization());
        }
        if (context.sourceBank() != null) {
            headers.put("Source-Bank", context.sourceBank());
        }
        if (context.destinationBank() != null) {
            headers.put("Destination-Bank", context.destinationBank());
        }
        if (context.channel() != null) {
            headers.put("Channel", context.channel());
        }
        if (context.callerService() != null) {
            headers.put("Caller-Service", context.callerService());
        }
        if (context.acceptLanguage() != null) {
            headers.put("Accept-Language", context.acceptLanguage());
        }
        return headers;
    }
}

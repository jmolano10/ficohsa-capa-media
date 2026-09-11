package com.ficohsa.driven.creditcard.datawarehouse.config;

import org.springframework.boot.context.properties.ConfigurationProperties;

@ConfigurationProperties(prefix = "ficohsa.external-apis.ms-dwh-wrapper")
public record ExternalServicePropsConfig(
    String baseUrl,
    int connectTimeoutMs,
    int readTimeoutMs,
    int retryAttempts
) {
    public ExternalServicePropsConfig {
        if (connectTimeoutMs == 0) connectTimeoutMs = 3000;
        if (readTimeoutMs == 0) readTimeoutMs = 5000;
        if (retryAttempts == 0) retryAttempts = 1;
    }

    public int getConnectTimeoutMs() {
        return connectTimeoutMs;
    }

    public int getReadTimeoutMs() {
        return readTimeoutMs;
    }
}

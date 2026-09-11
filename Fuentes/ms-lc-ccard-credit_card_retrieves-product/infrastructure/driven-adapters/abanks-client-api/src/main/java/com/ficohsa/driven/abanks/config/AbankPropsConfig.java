package com.ficohsa.driven.abanks.config;

import org.springframework.boot.context.properties.ConfigurationProperties;

@ConfigurationProperties(prefix = "ficohsa.external-apis.ms-abanks-wrapper")
public record AbankPropsConfig(
    String baseUrl,
    long connectTimeoutMs,
    long readTimeoutMs,
    int retryAttempts
) {
}

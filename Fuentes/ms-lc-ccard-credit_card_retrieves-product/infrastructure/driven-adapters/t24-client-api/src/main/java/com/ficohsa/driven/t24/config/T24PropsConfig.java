package com.ficohsa.driven.t24.config;

import org.springframework.boot.context.properties.ConfigurationProperties;

@ConfigurationProperties(prefix = "ficohsa.external-apis.ms-t24-wrapper")
public record T24PropsConfig(
    String baseUrl,
    String path
) {
    public String getBaseUrl() {
        return baseUrl;
    }

    public String getPath() {
        return path;
    }
}

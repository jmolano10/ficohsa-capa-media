package com.ficohsa.driven.cobis.config;

import org.springframework.boot.context.properties.ConfigurationProperties;

@ConfigurationProperties(prefix = "ficohsa.external-apis.ms-cobis-wrapper")
public record CobisPropsConfig(
    String baseUrl,
    String path,
    String spPath,
    String spBaseUrl
) {
    public String getBaseUrl() {
        return baseUrl;
    }

    public String getPath() {
        return path;
    }

    public String getSpPath() {
        return spPath;
    }

    public String getSpBaseUrl() {
        return spBaseUrl;
    }
}

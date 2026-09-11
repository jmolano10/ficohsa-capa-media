package com.ficohsa.driven.creditcard.r2dbc.config;

import org.springframework.boot.context.properties.ConfigurationProperties;

import java.util.Map;

@ConfigurationProperties(prefix = "ficohsa.database")
public record DatabasePropsConfig(
    Map<String, String> secretsManager,
    Map<String, String> parameterStore,
    int connectionTimeoutSeconds,
    int queryTimeoutSeconds
) {
    public DatabasePropsConfig {
        if (connectionTimeoutSeconds == 0) connectionTimeoutSeconds = 30;
        if (queryTimeoutSeconds == 0) queryTimeoutSeconds = 30;
    }

    public String getSecretsManagerKey(String region) {
        return secretsManager.get(region.toLowerCase());
    }

    public String getParameterStoreKey(String region) {
        return parameterStore.get(region.toLowerCase());
    }

    public int getConnectionTimeoutSeconds() {
        return connectionTimeoutSeconds;
    }

    public int getQueryTimeoutSeconds() {
        return queryTimeoutSeconds;
    }
}

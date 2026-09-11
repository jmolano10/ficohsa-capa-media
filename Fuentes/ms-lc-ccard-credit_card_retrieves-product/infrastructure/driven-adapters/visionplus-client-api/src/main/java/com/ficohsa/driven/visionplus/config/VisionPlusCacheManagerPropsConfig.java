package com.ficohsa.driven.visionplus.config;

import org.springframework.boot.context.properties.ConfigurationProperties;

@ConfigurationProperties(prefix = "ficohsa.external-apis.ms-vps-cache-manager")
public record VisionPlusCacheManagerPropsConfig(
    String baseUrl,
    String path,
    long connectTimeoutMs,
    long readTimeoutMs,
    int retryAttempts,
    String cacheTtl,
    String settlementQuoteInquiryL8v1Operation,
    String settlementQuoteInquiryL8v1ParamName,
    String settlementQuoteInquiryL8v2Operation,
    String settlementQuoteInquiryL8v2ParamName,
    String settlementQuoteInquiryCallerService
) {
    private static final String PATH_SEPARATOR = "/";

    public String getSettlementQuoteInquiryL8v1Operation() {
        return settlementQuoteInquiryL8v1Operation;
    }

    public String getSettlementQuoteInquiryL8v1ParamName() {
        return settlementQuoteInquiryL8v1ParamName;
    }

    public String getSettlementQuoteInquiryL8v2Operation() {
        return settlementQuoteInquiryL8v2Operation;
    }

    public String getSettlementQuoteInquiryL8v2ParamName() {
        return settlementQuoteInquiryL8v2ParamName;
    }

    public String getSettlementQuoteInquiryCallerService() {
        return settlementQuoteInquiryCallerService;
    }

    public String getCacheTtl() {
        return cacheTtl;
    }

    public String getSettlementQuoteInquiryL8v1Endpoint() {
        return buildEndpoint();
    }

    public String getSettlementQuoteInquiryL8v2Endpoint() {
        return buildEndpoint();
    }

    private String buildEndpoint() {
        String sanitizedBase = baseUrl.endsWith(PATH_SEPARATOR) ? baseUrl.substring(0, baseUrl.length() - 1) : baseUrl;
        String sanitizedPath = path.startsWith(PATH_SEPARATOR) ? path : PATH_SEPARATOR + path;
        String sanitizedPathFinal = sanitizedPath.endsWith(PATH_SEPARATOR) ? sanitizedPath.substring(0, sanitizedPath.length() - 1) : sanitizedPath;
        return sanitizedBase + sanitizedPathFinal;
    }
}
